using ExcelDataReader;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Web.Http;
using System.Net;

namespace ANTOTOLib
{
    public class ShippingOrderProfileValidate
    {
        public static void ShippingOrderProfileSFValidate (int? ShippingOrderId)
        {
            var shippingOrder = ShippingOrder.GetShippingOrder(ShippingOrderId);

            if (shippingOrder != null)
            {
                var ToAddress = shippingOrder.ToShippingAddress;
                if (ToAddress != null)
                {
                    var FirstName = ToAddress.ContactFirstName;
                    var LastName = ToAddress.ContactLastName;
                    var PhoneNumber = ToAddress.ContactPhone;

                    SFExpressHandler.CheckIDPost post = new SFExpressHandler.CheckIDPost();
                    post.CheckCeteria = new SFExpressHandler.CheckCeteria();
                    post.CheckCeteria.PersonName = LastName + "" + FirstName;
                    post.CheckCeteria.TelePhone = PhoneNumber;
                    var result = SFExpressHandler.CheckIDResultGetByName(post);
                    if(result != null)
                    {
                        var data = result.Data;
                        if (data != null && data.Result!=null)
                        {
                            if(data.Result == true)
                            {
                                //validate update profile
                                antoto_dbDataContext db = new antoto_dbDataContext();
                                db.sp_ShippingOrderProfileSFValidateUpdate(ShippingOrderId, true);
                            }
                        }
                    }
                }
            }
        }
        
        public static void ShippingOrderProfileGenerate(int? ShippingOrderId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            db.sp_ShippingOrderProfileGenerate(ShippingOrderId);
        }

        public static void ShippingOrderProfileGenerateProcess()
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnShippingOrderProfileNeedGenerate();
            if (list != null)
            {
                foreach(var item in list)
                {
                    ShippingOrderProfileGenerate(item.ShippingOrderId);
                }
            }
        }

        public static void ShippingOrderProfileSFValidateProcess()
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnShippingOrderProfileNeedSFValidate();
            if (list != null)
            {
                foreach(var item in list)
                {
                    try
                    {
                        ShippingOrderProfileSFValidate(item.ShippingOrderId);
                    }catch(Exception ex)
                    {
                        ErrorLog.Insert(ex.Message);
                    }
                    
                }
            }
        }

        

        public static void ShippingOrderLabelGenerateProcess()
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnShippingOrderLabelNeedGenerate();
            if (list != null)
            {
                foreach (var item in list)
                {
                    try
                    {
                        ParaDataModel.ParaShippingOrderPackage tt = new ParaDataModel.ParaShippingOrderPackage();
                        tt.ShippingOrderId = item.ShippingOrderId;
                        ShippingOrderAction.ShippingOrderGenerateLabel(tt, 1, 0);
                        ShippingOrderProfileGenerate(item.ShippingOrderId);
                    }
                    catch (Exception ex)
                    {
                        ErrorLog.Insert(ex.Message);
                    }
                    
                }
            }
        }



        public static void ShippingOrderLabelPdfFileGenerateProcess()
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnShippingOrderLabelNeedHtmlConvertPdf();
            if (list != null)
            {
                foreach (var item in list)
                {
                    try
                    {
                        String guid = Guid.NewGuid().ToString();
                        string Path = "C:/Work/FileManagement/PdfFile/" + guid + ".pdf";
                        string FilePublicUrl = "https://www.oto-ant.com/PdfFiles/" + guid + ".pdf";
                        int tempresult = AntotoFile.UploadFileConfirm(guid, ".pdf", Path, FilePublicUrl, FilePublicUrl, FilePublicUrl, 1, 1);
                        var file = ANTOTOLib.AntotoFile.getFileFromId(tempresult);
                        var LabelFile = ANTOTOLib.AntotoFile.getFileFromId(item.FileId.Value);
                        PDFHandler.storePdf(LabelFile.FileLink, Path);
                        int? ShippingOrderLabelPdfFileId = 0;
                        db.sp_ShippingOrderLabelPdfInsert(item.ShippingOrderLabelId, tempresult, ref ShippingOrderLabelPdfFileId);

                    }
                    catch (Exception ex)
                    {
                        ErrorLog.Insert(ex.Message);
                    }

                }
            }
        }

    }

    


    
}
