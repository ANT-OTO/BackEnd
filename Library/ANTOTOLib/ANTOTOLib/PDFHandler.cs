using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PdfSharp;
using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.tool.xml;
using System.IO;
using iTextSharp.text.html.simpleparser;
using System.Net;
using HiQPdf;

namespace ANTOTOLib
{
    public class PDFHandler
    {
        public static WizardForm.WizardInputFile PDFHandlerCombine(List<string> OriginalList, int? UserId)
        {
            string Path = "";
            WizardForm.WizardInputFile result = null;
            List <PdfSharp.Pdf.PdfDocument> fileList = new List<PdfSharp.Pdf.PdfDocument>();
            if (OriginalList != null)
            {
                foreach(var item in OriginalList)
                {
                    PdfSharp.Pdf.PdfDocument pdfDocument = new PdfSharp.Pdf.PdfDocument();
                    pdfDocument = PdfSharp.Pdf.IO.PdfReader.Open(item, PdfDocumentOpenMode.Import);
                    fileList.Add(pdfDocument);
                }
                using (PdfSharp.Pdf.PdfDocument outPdf = new PdfSharp.Pdf.PdfDocument())
                {
                    foreach (var item1 in fileList)
                    {
                        CopyPages(item1, outPdf);
                    }
                    String guid = Guid.NewGuid().ToString();
                    Path = "C:/Work/FileManagement/PdfFile/" + guid + ".pdf";
                    string FilePublicUrl = "https://www.oto-ant.com/PdfFiles/" + guid + ".pdf";
                    int tempresult = AntotoFile.UploadFileConfirm(guid, ".pdf", Path, FilePublicUrl, FilePublicUrl, FilePublicUrl, 1, UserId.Value);
                    result = ANTOTOLib.AntotoFile.getFileFromId(tempresult);
                    outPdf.Save(Path);
                }
            }
            return result;
        }

        public static void CopyPages(PdfSharp.Pdf.PdfDocument from, PdfSharp.Pdf.PdfDocument to)
        {
            for (int i = 0; i < from.PageCount; i++)
            {
                to.AddPage(from.Pages[i]);
            }
        }

        public static string generatePdfDocumentFromHtml(string Html,string Css, string Path)
        {
            byte[] pdf; // result will be here
            antoto_dbDataContext db = new antoto_dbDataContext();
            //db.sp_ErrorLog_Insert(Html, "Html");
            //db.sp_ErrorLog_Insert(Css, "CSS");
            var cssText = Css;
            var html = Html;

            using (var memoryStream = new MemoryStream())
            {
                var document = new Document(iTextSharp.text.PageSize.A4, 50, 50, 60, 60);
                var writer = PdfWriter.GetInstance(document, memoryStream);
                document.Open();

                using (var cssMemoryStream = new MemoryStream(System.Text.Encoding.UTF8.GetBytes(cssText)))
                {
                    using (var htmlMemoryStream = new MemoryStream(System.Text.Encoding.UTF8.GetBytes(html)))
                    {
                        XMLWorkerHelper.GetInstance().ParseXHtml(writer, document, htmlMemoryStream, cssMemoryStream, Encoding.UTF8);
                    }
                }

                document.Close();

                pdf = memoryStream.ToArray();

                File.WriteAllBytes(Path, pdf);

            }
            return Path;
        }


        public static void saveHtml(string HtmlStr, string Path)
        {
            //We'll store our final PDF in this
            byte[] bytes;

            //Read our HTML as a .Net stream
            using (var sr = new StringReader(HtmlStr))
            {

                //Standard PDF setup using a MemoryStream, nothing special
                using (var ms = new MemoryStream())
                {
                    using (var pdfDoc = new Document(iTextSharp.text.PageSize.A4, 10f, 10f, 100f, 0f))
                    {

                        //Bind a parser to our PDF document
                        using (var htmlparser = new HTMLWorker(pdfDoc))
                        {

                            //Bind the writer to our document and our final stream
                            using (var w = PdfWriter.GetInstance(pdfDoc, ms))
                            {

                                pdfDoc.Open();

                                //Parse the HTML directly into the document
                                htmlparser.Parse(sr);

                                pdfDoc.Close();

                                //Grab the bytes from the stream before closing it
                                bytes = ms.ToArray();

                                File.WriteAllBytes(Path, bytes);
                            }
                        }
                    }
                }
            }
        }

        public static void DownloadPdfFile(string Url, string Path)
        {
            if(!String.IsNullOrEmpty(Url)&&!String.IsNullOrEmpty(Path))
            using (WebClient client = new WebClient())
            {
                client.DownloadFile(Url, Path);
            }
        }

        public static void storePdf(string url, string Path)
        {
            // create the HTML to PDF converter
            HtmlToPdf htmlToPdfConverter = new HtmlToPdf();

            // set browser width
            htmlToPdfConverter.BrowserWidth = 1200;

            // set browser height if specified, otherwise use the default

            // set HTML Load timeout
            htmlToPdfConverter.HtmlLoadedTimeout = 120;

            // set PDF page size and orientation
            htmlToPdfConverter.Document.PageSize = PdfPageSize.A4;
            htmlToPdfConverter.Document.PageOrientation = PdfPageOrientation.Portrait;

            // set the PDF standard used by the document
            //htmlToPdfConverter.Document.PdfStandard = checkBoxPdfA.Checked ? PdfStandard.PdfA : PdfStandard.Pdf;
            htmlToPdfConverter.Document.FitPageWidth = true;
            // set PDF page margins
            htmlToPdfConverter.Document.Margins = new PdfMargins(5);

            // set triggering mode; for WaitTime mode set the wait time before convert
            //switch (dropDownListTriggeringMode.SelectedValue)
            //{
            //    case "Auto":
            //        htmlToPdfConverter.TriggerMode = ConversionTriggerMode.Auto;
            //        break;
            //case "WaitTime":
            //htmlToPdfConverter.TriggerMode = ConversionTriggerMode.WaitTime;
            //htmlToPdfConverter.WaitBeforeConvert = int.Parse(textBoxWaitTime.Text);
            //        //break;
            //    case "Manual":
            //        htmlToPdfConverter.TriggerMode = ConversionTriggerMode.Manual;
            //        break;
            //    default:
            //        htmlToPdfConverter.TriggerMode = ConversionTriggerMode.Auto;
            //        break;
            //}

            // set header and footer
            //SetHeader(htmlToPdfConverter.Document);
            //SetFooter(htmlToPdfConverter.Document);

            htmlToPdfConverter.ConvertUrlToFile(url, Path);
        }
        
    }


}
