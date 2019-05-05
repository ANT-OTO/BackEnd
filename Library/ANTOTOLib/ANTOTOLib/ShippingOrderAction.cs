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
    public class ShippingOrderAction
    {
        public static ShippingOrder.ANTOTOShippingOrder ShippingOrderUpdateWeight(ParaDataModel.ParaShippingOrderWeightUpdate weightPackage)
        {
            ShippingOrder.ANTOTOShippingOrder result = new ShippingOrder.ANTOTOShippingOrder();

            antoto_dbDataContext db = new antoto_dbDataContext();

            result = ShippingOrder.GetShippingOrder(weightPackage.ShippingOrderId);

            return result;
        }

        public static ShippingOrder.ANTOTOShippingOrder ShippingOrderUpdate(ShippingOrder.ANTOTOShippingOrder shippingOrder, int? UserId)
        {
            ShippingOrder.ANTOTOShippingOrder result = new ShippingOrder.ANTOTOShippingOrder();

            antoto_dbDataContext db = new antoto_dbDataContext();
            ShippingOrder.UpdateShippingAddress(shippingOrder.FromShippingAddress);
            ShippingOrder.UpdateShippingAddress(shippingOrder.ToShippingAddress);
            int? ShippingOrderId = shippingOrder.ShippingOrderId;
            int? ShippingChannelId = shippingOrder.ShippingChannel == null ? 0 : shippingOrder.ShippingChannel.ShippingChannelId;
            db.sp_ANTOTOShippingOrderUpdate(null, shippingOrder.ReferenceCode, shippingOrder.FromShippingAddress.ShippingAddressId,
                shippingOrder.ToShippingAddress.ShippingAddressId, shippingOrder.ShippingChannel.ShippingChannelId, 
                shippingOrder.TotalWeight, shippingOrder.WeightUnitId, shippingOrder.ShippingOrderStatusCodeId,
                UserId, shippingOrder.SourceCompanyId, shippingOrder.HandlerCompanyId, ref ShippingOrderId);

            if(ShippingOrderId != null && ShippingOrderId > 0)
            {
                //Item
                int? ShippingOrderAdditionalInfoId = 0;
                db.sp_ANTOTOShippingOrderAdditionalInfoSet(ShippingOrderId, shippingOrder.PackageCount == null ? 1 : shippingOrder.PackageCount.Value,
                    shippingOrder.ShippingOrderTaxPaymentTypeCodeId == null ? 2 : shippingOrder.ShippingOrderTaxPaymentTypeCodeId.Value, ref ShippingOrderAdditionalInfoId);
                db.sp_ANTOTOShippingOrderItemClear(ShippingOrderId);
                if (shippingOrder.ItemList != null)
                {
                    foreach(var item in shippingOrder.ItemList)
                    {
                        int? ShippingOrderItemId = 0;
                        if(item.TaxPrice!=null && item.TaxPrice > 0)
                        {
                            db.sp_ANTOTOShippingOrderItemInsert(ShippingOrderId, item.ItemId, item.StockItemId,
                            item.ItemName, item.Quantity, item.Unit, item.Weight, item.WeightUnit, item.Price,
                            item.CurrencyId, item.TaxPrice, item.SourceArea, item.GoodCode, item.StateBarCode, item.Brand,
                            item.Specifications, UserId, 1, ref ShippingOrderItemId);
                        }
                        else
                        {
                            db.sp_ANTOTOShippingOrderItemInsert(ShippingOrderId, item.ItemId, item.StockItemId,
                            item.ItemName, item.Quantity, item.Unit, item.Weight, item.WeightUnit, item.Price,
                            item.CurrencyId, -1.0m, item.SourceArea, item.GoodCode, item.StateBarCode, item.Brand,
                            item.Specifications, UserId, 1, ref ShippingOrderItemId);
                        }
                        
                    }
                }

                db.sp_ANTOTOShippingOrderPriceCalculate(ShippingOrderId);
                result = ShippingOrder.GetShippingOrder(ShippingOrderId);
            }
            else
            {
                result = null;
            }

            return result;
        }

        public static ShippingOrder.ANTOTOShippingOrder ShippingOrderPriceCalculate(ParaDataModel.ParaShippingOrderPriceCalculate pricePackage)
        {
            ShippingOrder.ANTOTOShippingOrder result = new ShippingOrder.ANTOTOShippingOrder();

            antoto_dbDataContext db = new antoto_dbDataContext();

            db.sp_ANTOTOShippingOrderPriceCalculate(pricePackage.ShippingOrderId);

            result = ShippingOrder.GetShippingOrder(pricePackage.ShippingOrderId);

            return result;
        }

        public static ShippingOrder.ANTOTOShippingOrder ShippingOrderPriceCharge(ParaDataModel.ParaShippingOrderPriceCharge priceCharge, int? UserId)
        {
            ShippingOrder.ANTOTOShippingOrder result = new ShippingOrder.ANTOTOShippingOrder();

            antoto_dbDataContext db = new antoto_dbDataContext();

            db.sp_ShippingOrderPriceCharge(priceCharge.ShippingOrderId, UserId);

            result = ShippingOrder.GetShippingOrder(priceCharge.ShippingOrderId);

            return result;
        }

        public static ShippingOrder.ANTOTOShippingOrder ShippingOrderReviewStart(ParaDataModel.ParaShippingOrderReview shippingOrderReview, int? UserId)
        {
            ShippingOrder.ANTOTOShippingOrder result = new ShippingOrder.ANTOTOShippingOrder();

            antoto_dbDataContext db = new antoto_dbDataContext();

            int? ShippingOrderId = shippingOrderReview.ShippingOrderId;

            db.sp_ANTOTOShippingOrderStartReview(UserId, ref ShippingOrderId);

            result = ShippingOrder.GetShippingOrder(shippingOrderReview.ShippingOrderId);

            return result;
        }

        public static ShippingOrder.ANTOTOShippingOrder ShippingOrderReviewComplete(ParaDataModel.ParaShippingOrderReviewComplete shippingOrderReview, int? UserId)
        {
            ShippingOrder.ANTOTOShippingOrder result = new ShippingOrder.ANTOTOShippingOrder();

            antoto_dbDataContext db = new antoto_dbDataContext();

            int? ShippingOrderId = shippingOrderReview.ShippingOrderId;

            db.sp_ANTOTOShippingOrderFinishReview(UserId, ref ShippingOrderId);

            ParaDataModel.ParaShippingOrderPackage temp = new ParaDataModel.ParaShippingOrderPackage();

            temp.ShippingOrderId = ShippingOrderId;

            ShippingOrderGenerateLabel(temp, UserId, 0);

            try
            {
                generateSFExpressShippingOrder(temp, UserId, 0);
            }
            catch(Exception ex)
            {
                throw ex;
            }
            result = ShippingOrder.GetShippingOrder(shippingOrderReview.ShippingOrderId);

            return result;
        }

        public static ShippingOrder.ANTOTOShippingOrder ShippingOrderReviewCompleteAndChangeSFOrder(ParaDataModel.ParaShippingOrderReviewComplete shippingOrderReview, int? UserId)
        {
            ShippingOrder.ANTOTOShippingOrder result = new ShippingOrder.ANTOTOShippingOrder();

            antoto_dbDataContext db = new antoto_dbDataContext();

            int? ShippingOrderId = shippingOrderReview.ShippingOrderId;

            db.sp_ANTOTOShippingOrderFinishReview(UserId, ref ShippingOrderId);

            ParaDataModel.ParaShippingOrderPackage temp = new ParaDataModel.ParaShippingOrderPackage();

            temp.ShippingOrderId = ShippingOrderId;

            ShippingOrderGenerateLabel(temp, UserId, 0);
            var list = ShippingOrder.getSubOrderListByOrderId(ShippingOrderId);

            try
            {
                if (list != null)
                {
                    foreach (var item in list)
                    {
                        if (item.SubOrderTypeCodeId == 4)
                        {
                            //SFExpressOrder
                            SFExpressHandler.SFOrderCancel cancel = new SFExpressHandler.SFOrderCancel();
                            cancel.OrderParam = new SFExpressHandler.OrderParam();
                            cancel.OrderParam.SfWaybillNo = item.SubOrderCode;
                            cancel.OrderParam.CancelType = "2";
                            SFExpressHandler.CancelSFExpressOrder(cancel);
                            db.sp_ShippingOrderSubOrderDelete(item.ShippingOrderSubOrderId);
                        }
                    }
                    generateSFExpressShippingOrder(temp, UserId, 0);
                }
            }
            catch (Exception ex)
            {
                throw new Exception("运单部分取消， 顺丰方错误： " + ex.Message);
            }
            
            result = ShippingOrder.GetShippingOrder(shippingOrderReview.ShippingOrderId);

            return result;
        }

        public static ShippingOrder.ANTOTOShippingOrder ShippingOrderReviewCancel(ParaDataModel.ParaShippingOrderReviewCancel shippingOrderReview, int? UserId)
        {
            ShippingOrder.ANTOTOShippingOrder result = new ShippingOrder.ANTOTOShippingOrder();

            antoto_dbDataContext db = new antoto_dbDataContext();

            int? ShippingOrderId = shippingOrderReview.ShippingOrderId;

            db.sp_ANTOTOShippingOrderCancelReview(UserId, ref ShippingOrderId);

            result = ShippingOrder.GetShippingOrder(shippingOrderReview.ShippingOrderId);

            return result;
        }
        
        public static ShippingOrder.ANTOTOShippingOrder ShippingOrderGenerateLabel(ParaDataModel.ParaShippingOrderPackage paraShippingOrder, int? UserId, int? CompanyId)
        {
            Utilities.generateANTOTOShippingOrder(paraShippingOrder, UserId, CompanyId);
            ShippingOrder.ANTOTOShippingOrder result = null;
            if (paraShippingOrder.ShippingOrderId != null)
            {
                result = ShippingOrder.GetShippingOrder(paraShippingOrder.ShippingOrderId.Value);
            }
            if (paraShippingOrder.ShippingOrderCode != null)
            {
                result = ShippingOrder.GetShippingOrderByCode(paraShippingOrder.ShippingOrderCode);
            }
            return result;
        }

        public static ShippingOrder.ANTOTOShippingOrder generateSFExpressShippingOrder(ParaDataModel.ParaShippingOrderPackage paraShippingOrder, int? UserId, int? CompanyId)
        {
            ShippingOrder.ANTOTOShippingOrder result = null;
            if (paraShippingOrder.ShippingOrderId != null)
            {
                result = ShippingOrder.GetShippingOrder(paraShippingOrder.ShippingOrderId.Value);
            }
            if (paraShippingOrder.ShippingOrderCode != null)
            {
                result = ShippingOrder.GetShippingOrderByCode(paraShippingOrder.ShippingOrderCode);
            }
            var tempSFExpressOrder = ANTOTOLib.SFExpressHandler.getSFExpressOrder(result);
            var SFExpressOrder = ANTOTOLib.SFExpressHandler.SubmitSFExpressOrder(tempSFExpressOrder);
            if (SFExpressOrder != null)
            {
                antoto_dbDataContext db = new antoto_dbDataContext();
                //db.sp_ErrorLog_Insert(Newtonsoft.Json.JsonConvert.SerializeObject(SFExpressOrder), "Error");
                if (SFExpressOrder.Success == true)
                {
                    if (!String.IsNullOrEmpty(SFExpressOrder.Data.Hawbs))
                    {
                        var billwayno = SFExpressOrder.Data.Hawbs;
                        string[] words = billwayno.Split(',');
                        if (words != null && words.Length > 0)
                        {
                            for (int i = 0; i < words.Length; i++)
                            {
                                string billwn = words[i];
                                DataModel.ResultShippingOrderSubOrder subOrder = new DataModel.ResultShippingOrderSubOrder();
                                subOrder.SubOrderTypeCodeId = 4;
                                subOrder.SubOrderCode = billwn;
                                subOrder.SubOrderDescription = "顺丰子运单";
                                subOrder.ShippingOrderId = result.ShippingOrderId;
                                ShippingOrder.ShippingOrderSubOrderCreate(subOrder, UserId, CompanyId);
                            }
                        }
                        if (!String.IsNullOrEmpty(SFExpressOrder.Data.LabelToPrint))
                        {
                            var filePath = "C:/Work/FileManagement/LabelFile/";
                            String guid = Guid.NewGuid().ToString();
                            filePath = filePath + guid + ".pdf";
                            PDFHandler.DownloadPdfFile(SFExpressOrder.Data.LabelToPrint, filePath);
                            //var str = PDFHandler.generatePdfDocumentFromHtml(HTML, CSS, filePath + guid + ".pdf");
                            string FilePublicUrl = "https://www.oto-ant.com/LabelFile/" + guid + ".pdf";
                            int tempresult = AntotoFile.UploadFileConfirm(guid, "pdf", filePath, FilePublicUrl, FilePublicUrl, FilePublicUrl, 1, 1);
                            var tempFile = ANTOTOLib.AntotoFile.getFileFromId(tempresult);
                            int? ShippingOrderLabelId = 0;
                            db.sp_ShippingOrderLabelUpdate(result.ShippingOrderId, result.ShippingOrderCode,
                                "SFExpressLabel", tempFile.FileId, 1, UserId, ref ShippingOrderLabelId);
                        }
                        if (!String.IsNullOrEmpty(SFExpressOrder.Data.InvoiceToPrint))
                        {
                            var filePath = "C:/Work/FileManagement/SFInvoiceFile/";
                            String guid = Guid.NewGuid().ToString();
                            filePath = filePath + guid + ".pdf";
                            PDFHandler.DownloadPdfFile(SFExpressOrder.Data.InvoiceToPrint, filePath);
                            //var str = PDFHandler.generatePdfDocumentFromHtml(HTML, CSS, filePath + guid + ".pdf");
                            string FilePublicUrl = "https://www.oto-ant.com/SFInvoiceFile/" + guid + ".pdf";
                            int tempresult = AntotoFile.UploadFileConfirm(guid, "pdf", filePath, FilePublicUrl, FilePublicUrl, FilePublicUrl, 1, 1);
                            var tempFile = ANTOTOLib.AntotoFile.getFileFromId(tempresult);
                            int? ShippingOrderLabelId = 0;
                            db.sp_ShippingOrderLabelUpdate(result.ShippingOrderId, result.ShippingOrderCode,
                                "SFExpressInvoice", tempFile.FileId, 1, UserId, ref ShippingOrderLabelId);
                        }
                    }
                    else
                    {
                        //Error
                        
                        throw new Exception("创建失败");
                    }
                }
                else
                {
                    //Error
                    string ErrorInfo = "ID: " + SFExpressOrder.Data.Code + " Message: " + SFExpressOrder.Data.Message;
                    throw new Exception(ErrorInfo);
                }
            }
            result = ShippingOrder.GetShippingOrder(paraShippingOrder.ShippingOrderId);
            return result;
        }

        public static ShippingOrder.ANTOTOShippingOrder ShippingOrderCancel(ParaDataModel.ParaShippingOrderCancel shippingOrderCancel, int? UserId)
        {
            ShippingOrder.ANTOTOShippingOrder result = new ShippingOrder.ANTOTOShippingOrder();

            antoto_dbDataContext db = new antoto_dbDataContext();

            int? ShippingOrderId = shippingOrderCancel.ShippingOrderId;

            db.sp_ANTOTOShippingOrderCancel(UserId, ref ShippingOrderId); 
            
            result = ShippingOrder.GetShippingOrder(shippingOrderCancel.ShippingOrderId);

            var list = ShippingOrder.getSubOrderListByOrderId(shippingOrderCancel.ShippingOrderId);

            try
            {
                if (list != null)
                {
                    foreach (var item in list)
                    {
                        if (item.SubOrderTypeCodeId == 4)
                        {
                            //SFExpressOrder
                            SFExpressHandler.SFOrderCancel cancel = new SFExpressHandler.SFOrderCancel();
                            cancel.OrderParam = new SFExpressHandler.OrderParam();
                            cancel.OrderParam.SfWaybillNo = item.SubOrderCode;
                            cancel.OrderParam.CancelType = "2";
                            SFExpressHandler.CancelSFExpressOrder(cancel);
                            db.sp_ShippingOrderSubOrderDelete(item.ShippingOrderSubOrderId);
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                throw new Exception("运单部分取消， 顺丰方错误： " + ex.Message);
            }
            return result;
        }

        public static DataModel.ResultShippingOrderIdentityProfile ShippingOrderIDUpdate(ParaDataModel.ParaShippingOrderIDUpload paraShippingOrderIDUpload)
        {
            DataModel.ResultShippingOrderIdentityProfile result = new DataModel.ResultShippingOrderIdentityProfile();
            
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? ShippingOrderIdentityProfileId = 0;
            db.sp_ShippingOrderIDUpload(paraShippingOrderIDUpload.ShippingOrderId, paraShippingOrderIDUpload.ShippingOrderCode,
                 paraShippingOrderIDUpload.IDNumber, paraShippingOrderIDUpload.Name,
                paraShippingOrderIDUpload.PhoneNumber, ref ShippingOrderIdentityProfileId);

            if(ShippingOrderIdentityProfileId > 0)
            {
                db.sp_ShippingOrderIDFileClear(ShippingOrderIdentityProfileId);
                if (paraShippingOrderIDUpload.FileList != null)
                {
                    foreach(var item in paraShippingOrderIDUpload.FileList)
                    {
                        int? ShippingOrderIdentityProfileFileId = 0;
                        db.sp_ShippingOrderIDFileUpload(item.FileId, ShippingOrderIdentityProfileId, ref ShippingOrderIdentityProfileFileId);
                    }
                }
            }
            result = ShippingOrder.getShippingOrderIDProfile(paraShippingOrderIDUpload.ShippingOrderId, paraShippingOrderIDUpload.ShippingOrderCode);
            return result;
        }

        public static DataModel.ResultShippingOrderBatchActionPackage BatchShippingOrderBatchAction(ParaDataModel.ParaShippingOrderBatchUpdate paraShippingOrderBatchUpdate, int? UserId, int? CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();

            DataModel.ResultShippingOrderBatchActionPackage result = new DataModel.ResultShippingOrderBatchActionPackage();

            List<DataModel.ResultShippingOrderLabel> PrintLabelList = new List<DataModel.ResultShippingOrderLabel>(); 

            if(paraShippingOrderBatchUpdate!=null && paraShippingOrderBatchUpdate.ShippingOrderIdList != null)
            {
                int i = 0;
                foreach(var item in paraShippingOrderBatchUpdate.ShippingOrderIdList)
                {
                    DataModel.ResultShippingOrderBatchAction temp = new DataModel.ResultShippingOrderBatchAction();
                    //Shipping Order
                    temp.ShippingOrderId = item.Value;
                    temp.ResultCode = "Fail";
                    var ShippingOrder_1 = ShippingOrder.GetShippingOrder(item.Value);
                    temp.ShippingOrderCode = ShippingOrder_1.ShippingOrderCode;
                    if (paraShippingOrderBatchUpdate.ActionType == "UpdateWeight")
                    {
                        var shippingUpdateAction = paraShippingOrderBatchUpdate.WeightList[i];
                        if (shippingUpdateAction != null && shippingUpdateAction.Weight != null && shippingUpdateAction.Weight > 0)
                        {
                            int? ShippingOrderId = item.Value;
                            db.sp_ANTOTOShippingOrderWeightUpdate(paraShippingOrderBatchUpdate.WeightList[i].Weight, paraShippingOrderBatchUpdate.WeightList[i].WeightUnit,
                                UserId, ref ShippingOrderId);

                            db.sp_ANTOTOShippingOrderPriceCalculate(ShippingOrderId);
                            temp.ResultCode = "Success";
                        }
                    }

                    if(paraShippingOrderBatchUpdate.ActionType == "PriceCalculate")
                    {
                        int? ShippingOrderId = item.Value;

                        db.sp_ANTOTOShippingOrderPriceCalculate(ShippingOrderId);
                        temp.ResultCode = "Success";
                    }

                    if (paraShippingOrderBatchUpdate.ActionType == "PriceCharge")
                    {
                        int? ShippingOrderId = item.Value;

                        //db.sp_ANTOTOShippingOrderPriceCalculate(ShippingOrderId);
                        db.sp_ShippingOrderPriceCharge(ShippingOrderId, UserId);
                        temp.ResultCode = "Success";
                    }

                    if (paraShippingOrderBatchUpdate.ActionType == "Print")
                    {
                        var LabelList = ShippingOrder.getShippingOrderLabelList(item.Value);
                        if (LabelList != null)
                        {
                            foreach (var label in LabelList)
                            {
                                PrintLabelList.Add(label);
                            }
                            temp.ResultCode = "Success";
                        }
                        
                    }
                    if(paraShippingOrderBatchUpdate.ActionType == "ReviewFinish")
                    {
                        int? ShippingOrderId = item.Value;
                        db.sp_ANTOTOShippingOrderFinishReview(UserId, ref ShippingOrderId);
                        if (ShippingOrderId != null && ShippingOrderId > 0)
                        {
                            temp.ResultCode = "Success";
                        }
                    }

                    if(paraShippingOrderBatchUpdate.ActionType == "SentOut")
                    {
                        int? ShippingOrderId = item.Value;
                        db.sp_ANTOTOShippingOrderSent(UserId, ref ShippingOrderId);
                        if(ShippingOrderId != null && ShippingOrderId > 0)
                        {
                            temp.ResultCode = "Success";
                        }
                    }

                    if (result.ResultList == null)
                    {
                        result.ResultList = new List<DataModel.ResultShippingOrderBatchAction>();
                    }
                    result.ResultList.Add(temp);
                }
            }

            //PrintLabel Handler
            if(PrintLabelList!=null&&PrintLabelList.Count > 0)
            {
                List<string> LabelList = new List<string>();
                foreach(var item in PrintLabelList)
                {
                    if(item.LabelName == "ANTOTOLabel")
                    {
                        var File = AntotoFile.getFileFromIdInternal(item.File.FileId.Value);
                        if(File.FileExt == ".pdf")
                        {
                            LabelList.Add(File.FilePath);
                        }
                    }
                    if(item.LabelName == "SFExpressLabel" || item.LabelName == "SFExpressInvoice")
                    {
                        var File = AntotoFile.getFileFromIdInternal(item.File.FileId.Value);
                        LabelList.Add(File.FilePath);
                    }

                }
                if (LabelList.Count > 0)
                {
                    result.PrintFile = PDFHandler.PDFHandlerCombine(LabelList, UserId);
                }
            }
            return result;
        }

        public static DataModel.ResultShippingOrderIdentityProfile ChinaIdentityProfileUpload(ParaDataModel.ParaShippingOrderIDUpload paraShippingOrderIDUpload)
        {
            DataModel.ResultShippingOrderIdentityProfile result = new DataModel.ResultShippingOrderIdentityProfile();
            
            antoto_dbDataContext db = new antoto_dbDataContext();

            int FrontFileId = 0;
            int BackFileId = 0;

            if(paraShippingOrderIDUpload.frontImage != null)
            {
                FrontFileId = paraShippingOrderIDUpload.frontImage.FileId.Value;
            }

            if(paraShippingOrderIDUpload.backImage != null)
            {
                BackFileId = paraShippingOrderIDUpload.backImage.FileId.Value;
            }

            int? ChinaIdentityProfileId = 0;
            db.sp_ChinaIdentifyProfile_Update(paraShippingOrderIDUpload.Name, paraShippingOrderIDUpload.PhoneNumber,
                paraShippingOrderIDUpload.IDNumber, FrontFileId, BackFileId, ref ChinaIdentityProfileId);

            if(ChinaIdentityProfileId > 0)
            {


                result = getChinaIdentityProfile(paraShippingOrderIDUpload.Name, paraShippingOrderIDUpload.PhoneNumber);
                db.sp_ShippingOrderIdentityProfileMatchBack(ChinaIdentityProfileId);
                try
                {
                    string FrontImageStr = Utilities.getBitmapCodeFromFile(FrontFileId);
                    string BackImageStr = Utilities.getBitmapCodeFromFile(BackFileId);

                    var checkIdPost = new SFExpressHandler.CheckIDPost();

                    checkIdPost.CheckCeteria = new SFExpressHandler.CheckCeteria();
                    checkIdPost.CheckCeteria.CardNo = result.IDNumber;

                    var checkIdResult = SFExpressHandler.CheckIDResultGet(checkIdPost);
                    if (checkIdResult != null && checkIdResult.Success == true)
                    {
                        if (checkIdResult.Data != null && checkIdResult.Data.Result == true)
                        {
                            return result;
                        }
                    }
                    string SFExpressOrderCode = db.sfnSFExpressOrderCodeGetByNameAndPhoneNumber(result.Name, result.PhoneNumber);
                    if (!String.IsNullOrEmpty(SFExpressOrderCode))
                    {
                        var postIDBody = new SFExpressHandler.IDSubmit();
                        postIDBody.IdentityFile = new SFExpressHandler.IdentityFile();
                        postIDBody.IdentityFile.Name = result.Name;
                        postIDBody.IdentityFile.Phone = result.PhoneNumber;
                        postIDBody.IdentityFile.SfWaybillNo = SFExpressOrderCode;
                        postIDBody.IdentityFile.Images = new List<string>();
                        postIDBody.IdentityFile.Images.Add(FrontImageStr);
                        postIDBody.IdentityFile.Images.Add(BackImageStr);
                        postIDBody.IdentityFile.CardId = result.IDNumber;
                        var SubmitResult = SFExpressHandler.IDSubmitCreate(postIDBody);
                    }
                }
                catch(Exception ex)
                {
                    ErrorLog.Insert(ex.Message, "SFExpress");
                }
            }
            else
            {
                result = null;
            }

            return result;
        }

        public static DataModel.ResultShippingOrderIdentityProfile getChinaIdentityProfile(string Name, string PhoneNumber)
        {
            DataModel.ResultShippingOrderIdentityProfile result = new DataModel.ResultShippingOrderIdentityProfile();

            antoto_dbDataContext db = new antoto_dbDataContext();

            var list = db.tfnChinaIdentityProfileGet(Name, PhoneNumber);

            if (list != null)
            {
                foreach(var item in list)
                {
                    result.Name = item.Name;
                    result.IDNumber = item.IdentityNumber;
                    result.PhoneNumber = item.PhoneNumber;
                    result.FileList = new List<WizardForm.WizardInputFile>();
                    WizardForm.WizardInputFile frontFile = AntotoFile.getFileFromId(item.FrontFileId.Value);
                    WizardForm.WizardInputFile backFile = AntotoFile.getFileFromId(item.BackFileId.Value);
                    result.FileList.Add(frontFile);
                    result.FileList.Add(backFile);
                    break;
                }
            }
            return result;
        }
        
    }

    


    
}
