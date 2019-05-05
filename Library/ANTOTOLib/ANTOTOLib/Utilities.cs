using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using IronBarCode;
using System.IO;
using ExcelLibrary.SpreadSheet;
using System.Data;

namespace ANTOTOLib
{
    public class Utilities
    {
        /// <summary>
        /// Resize the image to the specified width and height.
        /// </summary>
        /// <param name="image">The image to resize.</param>
        /// <param name="width">The width to resize to.</param>
        /// <param name="height">The height to resize to.</param>
        /// <returns>The resized image.</returns>
        public static Bitmap ResizeImage(System.Drawing.Image image, int width, int height)
        {
            var destRect = new Rectangle(0, 0, width, height);
            var destImage = new Bitmap(width, height);

            destImage.SetResolution(image.HorizontalResolution, image.VerticalResolution);

            using (var graphics = Graphics.FromImage(destImage))
            {
                graphics.CompositingMode = CompositingMode.SourceCopy;
                graphics.CompositingQuality = CompositingQuality.HighQuality;
                graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
                graphics.SmoothingMode = SmoothingMode.HighQuality;
                graphics.PixelOffsetMode = PixelOffsetMode.HighQuality;

                using (var wrapMode = new ImageAttributes())
                {
                    wrapMode.SetWrapMode(WrapMode.TileFlipXY);
                    graphics.DrawImage(image, destRect, 0, 0, image.Width, image.Height, GraphicsUnit.Pixel, wrapMode);
                }
            }

            return destImage;
        }

        public static string HTMLFromBarCode(string barcode)
        {
            GeneratedBarcode MyBarCode = BarcodeWriter.CreateBarcode(barcode, BarcodeWriterEncoding.Code128);
            // Save as a stand-alone HTML file with no image assets required
            //MyBarCode.SaveAsHtmlFile("C:/Work/MyBarCode.html");
            // Save as a stand-alone HTML image tag which can be served in HTML files, ASPX or MVC Views.  No image assets required, the tag embeds the entire image in its Src contents
            MyBarCode.ResizeTo(700, 150);
            //string ImgTag = MyBarCode.ToHtmlTag();
            // Turn the image into an Html/CSS Data URI.  https://en.wikipedia.org/wiki/Data_URI_scheme
            string DataURI = MyBarCode.ToDataUrl();
            return DataURI;
        }

        public static string HTMLFromBarCodeAlt(string barcode)
        {
            string result = "";
            BarcodeLib.Barcode b = new BarcodeLib.Barcode();
            antoto_dbDataContext db = new antoto_dbDataContext();
            db.sp_ErrorLog_Insert(barcode, "Barcode");
            System.Drawing.Image img = b.Encode(BarcodeLib.TYPE.CODE128, barcode, Color.Black, Color.White, 290, 120);
            using (MemoryStream ms = new MemoryStream())
            {
                // Convert Image to byte[]
                img.Save(ms, ImageFormat.Png);
                byte[] imageBytes = ms.ToArray();

                // Convert byte[] to Base64 String
                result = "<img style = 'width:290px;height:120px' src=\"data:image/png;base64," + Convert.ToBase64String(imageBytes) + "\"/>";
            }
            return result;
        }
        
        public static DataModel.ResultShippingOrderLabel generateANTOTOShippingOrder(ParaDataModel.ParaShippingOrderPackage paraShippingOrder, int? UserId, int? CompanyId)
        {
            DataModel.ResultShippingOrderLabel result = new DataModel.ResultShippingOrderLabel();

            antoto_dbDataContext db = new antoto_dbDataContext();

            var File = generateShippingOrderFile(paraShippingOrder);
            ShippingOrder.ANTOTOShippingOrder shippingOrderAntoto = new ShippingOrder.ANTOTOShippingOrder();
            if (paraShippingOrder.ShippingOrderId != null)
            {
                shippingOrderAntoto = ShippingOrder.GetShippingOrder(paraShippingOrder.ShippingOrderId.Value);
            }
            if (paraShippingOrder.ShippingOrderCode != null)
            {
                shippingOrderAntoto = ShippingOrder.GetShippingOrderByCode(paraShippingOrder.ShippingOrderCode);
            }

            int? ShippingOrderLabelId = 0;
            db.sp_ShippingOrderLabelUpdate(shippingOrderAntoto.ShippingOrderId, shippingOrderAntoto.ShippingOrderCode,
                "ANTOTOLabel", File.FileId, 1, UserId, ref ShippingOrderLabelId);
            if(ShippingOrderLabelId > 0)
            {
                result = ShippingOrder.getShippingOrderLabel(ShippingOrderLabelId);
            }
            else
            {
                result = null;
            }


            return result;
        }

        public static WizardForm.WizardInputFile generateShippingOrderFile(ParaDataModel.ParaShippingOrderPackage paraShippingOrder)
        {
            WizardForm.WizardInputFile result = null;
            ShippingOrder.ANTOTOShippingOrder shippingOrderAntoto = new ShippingOrder.ANTOTOShippingOrder();
            if (paraShippingOrder.ShippingOrderId != null)
            {
                shippingOrderAntoto = ShippingOrder.GetShippingOrder(paraShippingOrder.ShippingOrderId.Value);
            }
            if(paraShippingOrder.ShippingOrderCode != null)
            {
                shippingOrderAntoto = ShippingOrder.GetShippingOrderByCode(paraShippingOrder.ShippingOrderCode);
            }
            string HTML = PackageHTMLGet(shippingOrderAntoto);
            //string CSS = PackageCSSGet(shippingOrderAntoto);
            var filePath = "C:/Work/FileManagement/LabelFile/";
            String guid = Guid.NewGuid().ToString();
            StreamWriter swXLS = new StreamWriter((filePath + guid + ".html"), true, Encoding.Unicode);
            swXLS.Write(HTML);
            swXLS.Close();
            //var str = PDFHandler.generatePdfDocumentFromHtml(HTML, CSS, filePath + guid + ".pdf");
            string FilePublicUrl = "https://www.oto-ant.com/LabelFile/" + guid + ".html";
            int tempresult = AntotoFile.UploadFileConfirm(guid, "html", filePath, FilePublicUrl, FilePublicUrl, FilePublicUrl, 1, 1);
            result = ANTOTOLib.AntotoFile.getFileFromId(tempresult);
            return result;
        }
        
        public static string PackageCSSGet(ShippingOrder.ANTOTOShippingOrder shippingOrder)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,");
            sb.Append("form, fieldset, input, textarea, p, blockquote {");
            sb.Append("padding: 0;margin: 0;}");
            sb.Append("body{ font: 26px;}");
            sb.Append(".main{");
            sb.Append("size: 4in 6in;");
            sb.Append("mso - header - margin: .5in;");
            sb.Append("mso - footer - margin: .5in;");
            sb.Append("mso - paper - source: 0;");
            sb.Append("padding: 50px; ");
            sb.Append("margin: auto}");
            sb.Append("table {width: 100 %;border - collapse: collapse;}");
            sb.Append("th, td {padding: 10px;}");
            sb.Append("table, th, td {border: 1px solid black;}");
            sb.Append("@media print {html, body { height: 100 %;margin: 0 !important;padding: 0 !important; overflow: hidden;}}");

            return sb.ToString();
        }
        
        public static string PackageHTMLGet(ShippingOrder.ANTOTOShippingOrder shippingOrder)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<!DOCTYPE html><html xmlns = 'http://www.w3.org/1999/xhtml'><head><style>");
            sb.Append(PackageCSSGet(shippingOrder));
            sb.Append("</style></head><body><div class='main'><h1><b>ANTOTO 运单</b></h1><form><table style = 'width:100%'><tr><td>渠道代码：</td>");
            sb.Append("<td>");
            if (shippingOrder.ShippingChannel != null)
            {
                sb.Append(shippingOrder.ShippingChannel.ShippingChannelCode);
            }
            sb.Append("</td></tr><tr><td style = 'width:25%' >运单号：</td><td>");
            sb.Append(shippingOrder.ShippingOrderCode);
            sb.Append("</td></tr><tr><td colspan = '2'>");
            var barcode = HTMLFromBarCodeAlt(shippingOrder.ShippingOrderCode);
            sb.Append(barcode);
            sb.Append("</td></tr><tr><td style = 'width:25%'>总重量：</td><td>");
            
            sb.Append((shippingOrder.TotalWeight == null? 0.0M : shippingOrder.TotalWeight).ToString() + " Lb");
            sb.Append("</td></tr>");
            sb.Append("<tr><td style = 'width:25%'>价格：</td><td>");
            sb.Append("$" + shippingOrder.Price == null ? 0.0M : shippingOrder.Price);
            sb.Append("</td></tr></table><table style = 'width:100%'><tr><td colspan = '5'>商品列表：</td></tr><tr><th>名称</th><th>个数</th><th>单位 </th><th>价格</th><th>税金</th></tr>");
            if (shippingOrder.ItemList != null)
            {
                foreach(var item in shippingOrder.ItemList)
                {
                    sb.Append("<tr>");
                    sb.Append("<td>");
                    sb.Append(item.ItemName);
                    sb.Append("</td>");
                    sb.Append("<td>");
                    sb.Append(item.Quantity);
                    sb.Append("</td>");
                    sb.Append("<td>");
                    sb.Append(item.Unit);
                    sb.Append("</td>");
                    sb.Append("<td>$");
                    sb.Append(item.Price);
                    sb.Append("</td>");
                    sb.Append("<td>$");
                    sb.Append(item.TaxPrice);
                    sb.Append("</td>");
                    sb.Append("</tr>");
                }
            }
            sb.Append("</table></form></div></body></html>");
            return sb.ToString();
        }
        
        public static string ReceiptHtmlGet(ShippingOrderBatchAction.ParaShippingOrderPriceChargeStep step)
        {

            StringBuilder stringBuilder = new StringBuilder();
            string ReceiptNumber = step.ReceiptNumber;
            var company = ANTOTOLib.Company.getCompanyInfoById(step.CustomerCompanyId.Value);
            string CustomerCompanyCode = company.CompanyCode;
            stringBuilder.Append("<link href =\"//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css\"");
            stringBuilder.Append("rel=\"stylesheet\" id=\"bootstrap-css\"><script src=\"//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js\">");
            stringBuilder.Append("</script><script src=\"//code.jquery.com/jquery-1.11.1.min.js\"></script>");
            stringBuilder.Append("<div class=\"container\"><div class=\"row\"><div class=\"well col-xs-10 col-sm-10 col-md-6 col-xs-offset-1 col-sm-offset-1 col-md-offset-3\">");
            stringBuilder.Append("<div class=\"row\"><div class=\"col-xs-6 col-sm-6 col-md-6\"><address><strong>ANT-OTO, Inc</strong>");
            stringBuilder.Append("<br>561 US-1, Unit 103<br>Edison, NJ 08817<br><abbr title=\"Phone\">Phone:</abbr> 908-208-6508</address></div>");
            stringBuilder.Append("<div class=\"col-xs-6 col-sm-6 col-md-6 text-right\">");
            stringBuilder.Append("<p><em>日期: ");
            stringBuilder.Append(DateTime.Now.ToString("dddd, dd MMMM yyyy"));
            stringBuilder.Append("</em></p>");
            stringBuilder.Append("<p><em>收据号 #: "+ ReceiptNumber + "</em>");
            stringBuilder.Append("</p><p><em>客户编号 #:" + CustomerCompanyCode + "</em></p>");
            stringBuilder.Append("</div></div><div class=\"row\"><div class=\"text-center\"><h4>运单收费详情</h4></div>");
            stringBuilder.Append("</span><table class=\"table table-hover\"><thead><tr><th class=\"text-center\">运单号</th><th class=\"text-center\">重量</th>");
            stringBuilder.Append("<th class=\"text-center\">价格</th><th class=\"text-center\">税费</th></tr></thead>");
            stringBuilder.Append("<tbody>");
            foreach(var item in step.ShippingOrderPriceInfoList)
            {
                stringBuilder.Append("<tr><td class=\"col-md-9\" style =\"text-align: center\">");
                stringBuilder.Append("<em>" + item.ShippingOrderCode + "</em>");
                stringBuilder.Append("</h4></td><td class=\"col-md-1\" style=\"text-align: center\">");
                stringBuilder.Append(item.Weight);
                stringBuilder.Append("</td>");
                stringBuilder.Append("<td class=\"col-md-1 text-center\">");
                stringBuilder.Append(item.Price.Value.ToString("#.##") + " " + item.Currency);
                stringBuilder.Append("</td><td class=\"col-md-1 text-center\">");
                stringBuilder.Append(item.TaxPrice.Value.ToString("#.##") + " " + item.TaxCurrency);
                stringBuilder.Append("</td></tr>");
            }
            stringBuilder.Append("<td></td><td></td><td></td>");
            stringBuilder.Append("<td></td></tr></tbody>");
            stringBuilder.Append("</table><div class=\"text-center\"><h4>客户余额</h4></div></span><table class=\"table table-hover\">");
            stringBuilder.Append("<thead><tr>");
            stringBuilder.Append("<th class=\"text-center\">账户货币</th>");
            stringBuilder.Append("<th class=\"text-center\">扣款前余额</th>");
            stringBuilder.Append("<th class=\"text-center\">扣款金额</th>");
            stringBuilder.Append("<th class=\"text-center\">付款金额</th>");
            stringBuilder.Append("<th class=\"text-center\">扣款后余额</th>");
            stringBuilder.Append("</tr></thead>");
            foreach(var item in step.CurrencyResultList)
            {
                stringBuilder.Append("<tbody><tr><td class=\"col-md-9\" style=\"text-align: center\"><em>");
                stringBuilder.Append(item.Currency);
                stringBuilder.Append("</em></td>");
                stringBuilder.Append("<td class=\"col-md-1\" style=\"text-align: center\">");
                stringBuilder.Append(item.CurrentBalance.Value.ToString("#.##"));
                stringBuilder.Append("</td>");
                stringBuilder.Append("<td class=\"col-md-1\" style=\"text-align: center\">");
                stringBuilder.Append(item.TotalNeedToCharge.Value.ToString("#.##"));
                stringBuilder.Append("</td>");
                stringBuilder.Append("<td class=\"col-md-1\" style=\"text-align: center\">");
                stringBuilder.Append(item.TotalPaid.Value.ToString("#.##"));
                stringBuilder.Append("</td>");
                stringBuilder.Append("<td class=\"col-md-1\" style=\"text-align: center\">");
                stringBuilder.Append(item.CurrentBalanceNew.Value.ToString("#.##"));
                stringBuilder.Append("</td>");
                stringBuilder.Append("</tr>");
            }
            stringBuilder.Append("<td></td><td></td><td></td><td></td><td></td></tr></tbody></table>");
            stringBuilder.Append("</div></div></div>");


            return stringBuilder.ToString();
            

        }

        public static WizardForm.WizardInputFile generateReceiptFile(ShippingOrderBatchAction.ParaShippingOrderPriceChargeStep step)
        {
            WizardForm.WizardInputFile result = null;
            
            string HTML = ReceiptHtmlGet(step);

            var filePath = "C:/Work/FileManagement/ReceiptFile/";

            String guid = Guid.NewGuid().ToString();

            StreamWriter swXLS = new StreamWriter((filePath + guid + ".html"), true, Encoding.Unicode);

            swXLS.Write(HTML);

            swXLS.Close();
            //var str = PDFHandler.generatePdfDocumentFromHtml(HTML, CSS, filePath + guid + ".pdf");
            string FilePublicUrl = "https://www.oto-ant.com/ReceiptFile/" + guid + ".html";

            int tempresult = AntotoFile.UploadFileConfirm(guid, "html", filePath, FilePublicUrl, FilePublicUrl, FilePublicUrl, 1, 1);

            result = ANTOTOLib.AntotoFile.getFileFromId(tempresult);

            return result;
        }

        public class BatchHandlerReceipt
        {
            public string ReferenceCode { get; set; }
            public string ShippingOrderCode { get; set; }
        }

        public static WizardForm.WizardInputFile generateBatchExcelReceiptFile(int BatchHandlerId)
        {
            WizardForm.WizardInputFile result = new WizardForm.WizardInputFile();
            var batchHandler = BatchHandler.GetBatchRequest(BatchHandlerId);
            List<BatchHandlerReceipt> tempList = new List<BatchHandlerReceipt>();
            if (batchHandler.RecordList != null)
            {
                foreach(var record in batchHandler.RecordList)
                {
                    if(record.DetailList != null)
                    {
                        foreach(var detail in record.DetailList)
                        {
                            if(detail.ColumnName == "运单关联编号")
                            {
                                BatchHandlerReceipt receipt = new BatchHandlerReceipt();
                                receipt.ReferenceCode = detail.BatchHandlerValue;
                                receipt.ShippingOrderCode = BatchHandler.BatchHandlerRecordPropertyValueGet(record.BatchHandlerRecordId.Value, "ShippingOrderCode");
                                tempList.Add(receipt);
                                break;
                            }
                        }
                    }
                }
            }


            // ... ...

            Workbook workbook = new Workbook();
            Worksheet worksheet = new Worksheet("Sheet 1");
            workbook.Worksheets.Add(worksheet);
            worksheet.Cells[0, 0] = new Cell("运单关联编号");
            worksheet.Cells[0, 1] = new Cell("ANTOTO运单号");
            // add rows
            int i = 1;
            foreach(var item in tempList)
            {
                worksheet.Cells[i, 0] = new Cell(item.ReferenceCode);
                worksheet.Cells[i, 1] = new Cell(item.ShippingOrderCode);
                i++;
            }
            var filePath = "C:/Work/FileManagement/ReceiptFile/";

            String guid = Guid.NewGuid().ToString();

            workbook.Save(filePath + guid + ".xls");

            string FilePublicUrl = "https://www.oto-ant.com/ReceiptFile/" + guid + ".xls";

            int tempresult = AntotoFile.UploadFileConfirm(guid, "xls", filePath, FilePublicUrl, FilePublicUrl, FilePublicUrl, 1, 1);

            result = ANTOTOLib.AntotoFile.getFileFromId(tempresult);

            return result;
        }

        public static string getBitmapCodeFromFile(int FileId)
        {
            string result = "";
            try
            {
                var File = AntotoFile.getFileFromIdInternal(FileId);
                if (File != null)
                {
                    Bitmap bitmap = new Bitmap(File.FilePath);
                    MemoryStream memoryStream = new MemoryStream();
                    if(File.FileExt.ToLower() == "jpg")
                    {
                        bitmap.Save(memoryStream, ImageFormat.Jpeg);
                    }
                    else if(File.FileExt.ToLower() == "png")
                    {
                        bitmap.Save(memoryStream, ImageFormat.Png);
                    }
                    else if (File.FileExt.ToLower() == "bmp")
                    {
                        bitmap.Save(memoryStream, ImageFormat.Bmp);
                    }
                    else
                    {
                        return "";
                    }
                    memoryStream.Position = 0;
                    byte[] byteBuffer = memoryStream.ToArray();
                    memoryStream.Close();
                    result = Convert.ToBase64String(byteBuffer);
                }
            }
            catch (Exception ex)
            {
                result = null;
            }
            
            return result;
        }
    }
}
