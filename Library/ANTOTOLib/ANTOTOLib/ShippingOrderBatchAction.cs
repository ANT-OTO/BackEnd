using ExcelDataReader;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace ANTOTOLib
{
    public class ShippingOrderBatchAction
    {
        public class ShippingOrderBatchHandler
        {
            public int? ShippingOrderBatchHandlerId { get; set; }

            public string BatchHandlerCode { get; set; }

            public int? CompanyId { get; set; }

            public int? ShippingChannelId { get; set; }

            public string ShippingChannelName { get; set; }

            public int? BatchHandlerStatusCodeId { get; set; }

            public string BatchHandlerStatus { get; set; }

            public int? ShippingOrderActionTypeCodeId { get; set; }

            public string ShippingOrderActionType { get; set; }

            public int? UserId { get; set; }

            public string UserName { get; set; }

            public DateTime? CreateDate { get; set; }

            public DateTime? LastUpdate { get; set; }
            
            public List<ShippingOrderBatchHandlerDetail> RecordList { get; set; }

            public ShippingOrderBatchHandlerOutWareHouseActionDetail ActionDetail { get; set; }

            public ShippingOrderBatchHandlerDetailActionResult ActionResult { get; set; }
        }

        public class ShippingOrderBatchHandlerDetailActionResult
        {
            public string ErrorMsg { get; set; }
            public bool? IsError { get; set; }
        }

        public class ShippingOrderBatchHandlerOutWareHouseActionDetail
        {
            public int? ShippingOrderBatchHandlerId { get; set; }
            public int? SubOrderTypeCodeId { get; set; }
            public string SubOrderType { get; set; }
            public string SubOrderCode { get; set; }
            public string SubOrderDescription { get; set; }
        }

        public class ShippingOrderBatchHandlerDetail
        {
            public int? ShippingOrderBatchHandlerId { get; set; }
            public int? ShippingOrderId { get; set; }

            public string ShippingOrderCode { get; set; }

            public int? ShippingOrderBatchHandlerDetailId { get; set; }

            public bool? Available { get; set; }
        }

        public static ShippingOrderBatchHandler shippingOrderBatchHandlerCreate(ShippingOrderBatchHandler batchHandler, int? CompanyId, int? UserId)
        {
            ShippingOrderBatchHandler result = new ShippingOrderBatchHandler();

            antoto_dbDataContext db = new antoto_dbDataContext();

            int? ShippingOrderBatchHandlerId = 0;
            db.sp_ShippingOrderBatchHandlerCreate(CompanyId, UserId, batchHandler.ShippingChannelId, batchHandler.ShippingOrderActionTypeCodeId, ref ShippingOrderBatchHandlerId);

            if(ShippingOrderBatchHandlerId > 0)
            {
                result = GetBatchHandler(ShippingOrderBatchHandlerId);
            }
            else
            {
                result = null;
            }

            return result;
        }

        public static ShippingOrderBatchHandler shippingOrderAddToBatchHandler(ShippingOrderBatchHandlerDetail batchHandlerDetail, int? UserId)
        {
            ShippingOrderBatchHandler result = new ShippingOrderBatchHandler();

            antoto_dbDataContext db = new antoto_dbDataContext();

            string Error = "";

            db.sp_ShippingOrderBatchHandlerDetailPreUpdate(batchHandlerDetail.ShippingOrderCode, batchHandlerDetail.ShippingOrderBatchHandlerId, ref Error);

            if (String.IsNullOrEmpty(Error))
            {
                int? ShippingOrderBatchHandlerDetailId = 0;
                db.sp_ShippingOrderBatchHandlerDetailUpdate(batchHandlerDetail.ShippingOrderCode, batchHandlerDetail.ShippingOrderBatchHandlerId, true, UserId, ref ShippingOrderBatchHandlerDetailId);
                result = GetBatchHandler(batchHandlerDetail.ShippingOrderBatchHandlerId);
                result.ActionResult = new ShippingOrderBatchHandlerDetailActionResult();
                result.ActionResult.ErrorMsg = "";
                result.ActionResult.IsError = false;
            }
            else
            {
                result = GetBatchHandler(batchHandlerDetail.ShippingOrderBatchHandlerId);
                result.ActionResult = new ShippingOrderBatchHandlerDetailActionResult();
                result.ActionResult.ErrorMsg = Error;
                result.ActionResult.IsError = true;
            }

            return result;
        }

        public static ShippingOrderBatchHandler shippingOrderRemoveBatchHandler(ShippingOrderBatchHandlerDetail batchHandlerDetail, int? UserId)
        {
            ShippingOrderBatchHandler result = new ShippingOrderBatchHandler();

            antoto_dbDataContext db = new antoto_dbDataContext();

            int? ShippingOrderBatchHandlerDetailId = batchHandlerDetail.ShippingOrderBatchHandlerDetailId;
            db.sp_ShippingOrderBatchHandlerDetailUpdate(batchHandlerDetail.ShippingOrderCode, batchHandlerDetail.ShippingOrderBatchHandlerId, false, UserId, ref ShippingOrderBatchHandlerDetailId);

            if(ShippingOrderBatchHandlerDetailId > 0)
            {
                result = GetBatchHandler(batchHandlerDetail.ShippingOrderBatchHandlerId);
            }
            else
            {
                result = null;
            }

            return result;
        }

        public static ShippingOrderBatchHandler ShippingOrderBatchHandlerCancel(ShippingOrderBatchHandler batchHandler, int? UserId)
        {
            ShippingOrderBatchHandler result = new ShippingOrderBatchHandler();

            antoto_dbDataContext db = new antoto_dbDataContext();

            db.sp_ShippingOrderBatchHandlerStatusUpdate(batchHandler.ShippingOrderBatchHandlerId, 2, UserId);

            result = GetBatchHandler(batchHandler.ShippingOrderBatchHandlerId);

            return result;
        }

        public static ShippingOrderBatchHandler ShippingOrderBatchHandlerActionComplete(ShippingOrderBatchHandler batchHandler, int? UserId, int? CompanyId)
        {
            ShippingOrderBatchHandler result = new ShippingOrderBatchHandler();
            antoto_dbDataContext db = new antoto_dbDataContext();
            if(batchHandler.ShippingOrderActionTypeCodeId == 1)
            {
                if(batchHandler.ActionDetail != null)
                {
                    var temp = GetBatchHandler(batchHandler.ShippingOrderBatchHandlerId);
                    if(temp.RecordList != null)
                    {
                        db.sp_ShippingOrderBatchHandlerActionUpdate(batchHandler.ShippingOrderBatchHandlerId,
                            batchHandler.ActionDetail.SubOrderTypeCodeId, batchHandler.ActionDetail.SubOrderCode,
                            batchHandler.ActionDetail.SubOrderDescription);
                        foreach(var item in temp.RecordList)
                        {
                            var shippingOrder = ShippingOrder.GetShippingOrder(item.ShippingOrderId);
                            if(shippingOrder!= null)
                            {
                                DataModel.ResultShippingOrderSubOrder subOrder = new DataModel.ResultShippingOrderSubOrder();
                                subOrder.ShippingOrderId = item.ShippingOrderId;
                                subOrder.SubOrderTypeCodeId = batchHandler.ActionDetail.SubOrderTypeCodeId;
                                subOrder.SubOrderDescription = batchHandler.ActionDetail.SubOrderDescription;
                                subOrder.SubOrderCode = batchHandler.ActionDetail.SubOrderCode;
                                if(subOrder.SubOrderTypeCodeId == 99)
                                {
                                    //Other
                                    DataModel.ResultShippingOrderRoutingTransaction transaction = new DataModel.ResultShippingOrderRoutingTransaction();
                                    transaction.OpCode = "ANTOTO门店";
                                    transaction.AcceptTime = DateTime.UtcNow;
                                    transaction.AcceptedAddress = "ANTOTO门店";
                                    transaction.RemarkDetail = "门店出库 批次号：" + batchHandler.BatchHandlerCode;
                                    transaction.UserId = UserId;
                                    subOrder.RoutingTransactionList = new List<DataModel.ResultShippingOrderRoutingTransaction>();
                                    subOrder.RoutingTransactionList.Add(transaction);
                                }
                                ShippingOrder.ShippingOrderSubOrderCreate(subOrder, UserId, CompanyId);
                            }
                        }
                    }
                    else
                    {
                        result.ActionResult = new ShippingOrderBatchHandlerDetailActionResult();
                        result.ActionResult.ErrorMsg = "批次中不存在运单号";
                        result.ActionResult.IsError = false;
                    }
                }
                else
                {
                    result.ActionResult = new ShippingOrderBatchHandlerDetailActionResult();
                    result.ActionResult.ErrorMsg = "批量发货缺少子运单信息";
                    result.ActionResult.IsError = false;
                }
            }
            else
            {
                result.ActionResult = new ShippingOrderBatchHandlerDetailActionResult();
                result.ActionResult.ErrorMsg = "批量发货缺少子运单信息";
                result.ActionResult.IsError = false;
            }
            if(result.ActionResult == null)
            {
                db.sp_ShippingOrderBatchHandlerStatusUpdate(batchHandler.ShippingOrderBatchHandlerId, 3, UserId);
            }
            var temp1 = GetBatchHandler(batchHandler.ShippingOrderBatchHandlerId);
            if (temp1 != null)
            {
                temp1.ActionResult = result.ActionResult;
            }
            
            return temp1;
        }

        public static ShippingOrderBatchHandler GetBatchHandler(int? ShippingOrderBatchHandlerId)
        {
            ShippingOrderBatchHandler result = new ShippingOrderBatchHandler();
            antoto_dbDataContext db = new antoto_dbDataContext();

            var list = db.tfnShippingOrderBatchHandlerGet(ShippingOrderBatchHandlerId);

            if (list != null)
            {
                foreach(var item in list)
                {
                    result.ShippingOrderBatchHandlerId = item.ShippingOrderBatchHandlerId;
                    result.UserId = item.UserId;
                    result.UserName = item.UserName;
                    result.ShippingChannelName = item.ShippingChannelName;
                    result.ShippingChannelId = item.ShippingChannelId;
                    result.CompanyId = item.CompanyId;
                    result.BatchHandlerStatusCodeId = item.BatchHandlerStatusCodeId;
                    result.BatchHandlerStatus = item.BatchHandlerStatus;
                    result.BatchHandlerCode = item.BatchHandlerCode;
                    result.LastUpdate = item.LastUpdate;
                    result.CreateDate = item.CreateDate;
                    result.ShippingOrderActionTypeCodeId = item.ShippingOrderActionTypeCodeId;
                    result.ShippingOrderActionType = item.ShippingOrderActionType;
                    result.ActionDetail = GetActionDetail(item.ShippingOrderBatchHandlerId);
                    result.RecordList = GetBatchHandlerDetailList(item.ShippingOrderBatchHandlerId);
                    break;
                }
            }

            return result;
        }

        public static ShippingOrderBatchHandlerOutWareHouseActionDetail GetActionDetail(int? ShippingOrderBatchHandlerId)
        {
            ShippingOrderBatchHandlerOutWareHouseActionDetail result = new ShippingOrderBatchHandlerOutWareHouseActionDetail();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnShippingOrderBatchHandlerActionGet(ShippingOrderBatchHandlerId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    result.ShippingOrderBatchHandlerId = item.ShippingOrderBatchHandlerId;
                    result.SubOrderCode = item.SubOrderCode;
                    result.SubOrderDescription = item.SubOrderDescription;
                    result.SubOrderType = item.SubOrderType;
                    result.SubOrderTypeCodeId = item.SubOrderTypeCodeId;
                    break;
                }
            }
            return result;
        }

        public static List<ShippingOrderBatchHandlerDetail> GetBatchHandlerDetailList(int? ShippingOrderBatchHandlerId)
        {
            List<ShippingOrderBatchHandlerDetail> result = new List<ShippingOrderBatchHandlerDetail>();
            antoto_dbDataContext db = new antoto_dbDataContext();

            var list = db.tfnShippingOrderBatchHandlerDetailListGet(ShippingOrderBatchHandlerId);

            if (list != null)
            {
                foreach(var item in list)
                {
                    ShippingOrderBatchHandlerDetail temp = new ShippingOrderBatchHandlerDetail();
                    temp.ShippingOrderBatchHandlerDetailId = item.ShippingOrderBatchHandlerDetailId;
                    temp.ShippingOrderBatchHandlerId = item.ShippingOrderBatchHandlerId;
                    temp.ShippingOrderCode = item.ShippingOrderCode;
                    temp.ShippingOrderId = item.ShippingOrderId;
                    temp.Available = item.Available;
                    result.Add(temp);
                }
            }
            return result;
        }

        public static DataModel.ResultPageResult ShippingOrderBatchHandlerSearch(ParaDataModel.ParaShippingOrderBatchHandlerSearch batchHandlerSearch, int pCompanyId, int pSystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? total = 0;
            int? totalPage = 0;
            int? Page = batchHandlerSearch.Page;
            int? NextPage = 0;
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
            var list = db.sp_ShippingOrderBatchHandlerSearch(pCompanyId, batchHandlerSearch.ShippingOrderCode, 
                batchHandlerSearch.BatchHandlerCode, batchHandlerSearch.ShippingOrderActionTypeCodeId,
                batchHandlerSearch.BatchHandlerStatusCodeId, batchHandlerSearch.BeginUtcDate, 
                batchHandlerSearch.EndUtcDate, batchHandlerSearch.PageSize, ref Page, ref total, ref totalPage);
            if (list != null)
            {
                NextPage = Page < totalPage ? Page + 1 : totalPage;
                foreach (var item in list)
                {
                    var currentobject = GetBatchHandler(item.ShippingOrderBatchHandlerId);
                    if (result.records == null)
                    {
                        result.records = new List<Object>();
                    }
                    result.records.Add(currentobject);
                }
                result.TotalPage = totalPage;
                result.TotalRecords = total;
                result.CurrentPage = Page;
                result.NextPage = NextPage;
            }
            return result;
        }

        public class ParaShippingOrderPriceChargePackage
        {
            public int? CustomerCompanyId { get; set; }
            public List<int?> ShippingOrderIdList { get; set; }
        }

        public class ParaShippingOrderPriceChargeStep
        {
            public string ErrorCode { get; set; }
            public bool? Success { get; set; }
            public int? ShippingOrderBatchReceiptId { get; set; }
            public int? CustomerCompanyId { get; set; }
            public string ReceiptNumber { get; set; }
            public List<ParaShippingOrderPriceChargeSubmit> CurrencyResultList { get; set; }
            public List<int?> ShippingOrderIdList { get; set; }
            public List<ParaShippingOrderPriceInfo> ShippingOrderPriceInfoList { get; set; }
        }

        public class ParaShippingOrderPriceChargeSubmit
        {
            public int? CurrencyId { get; set; }
            public string Currency { get; set; }
            public Decimal? CurrentBalance { get; set; }
            public Decimal? TotalNeedToCharge { get; set; }
            public Decimal? TotalPaid { get; set; }
            public Decimal? CurrentBalanceNew { get; set; }
        }

        public class ParaShippingOrderPriceInfo
        {
            public int? ShippingOrderId { get; set; }
            public string Weight { get; set; }
            public int? CurrencyId { get; set; }
            public string Currency { get; set; }
            public Decimal? Price { get; set; }
            public int? TaxCurrencyId { get; set; }
            public string TaxCurrency { get; set; }
            public Decimal? TaxPrice { get; set; }
            public string ShippingOrderCode { get; set; }
        }

        public class ParaShippingOrderPriceChargeResult
        {
            public bool? Success { get; set; }
            public WizardForm.WizardInputFile InvoiceToPrint { get; set; }
            public string ErrorCode { get; set; }
        }

        public static ParaShippingOrderPriceChargeStep getPreChargeInformation(ParaShippingOrderPriceChargePackage package, int? UserId, int? CustomerCompanyId)
        {
            ParaShippingOrderPriceChargeStep result = new ParaShippingOrderPriceChargeStep();

            //Check ShippingOrder Eligibility

            CustomerCompanyId = 0;
            
            antoto_dbDataContext db = new antoto_dbDataContext();
            string Error = "";
            if(package.ShippingOrderIdList != null && package.ShippingOrderIdList.Count > 0)
            {
                foreach(var shippingOrder in package.ShippingOrderIdList)
                {
                    //Checking
                    var Order = ShippingOrder.GetShippingOrder(shippingOrder);
                    if(CustomerCompanyId == 0)
                    {
                        CustomerCompanyId = Order.SourceCompanyId;
                    }
                    Error = db.sfnShippingOrderCheckForPrecharge(shippingOrder, null, CustomerCompanyId);
                    if (!String.IsNullOrEmpty(Error))
                    {
                        break;
                    }
                }
            }
            else
            {
                Error = "未选中任何包裹";
            }

            package.CustomerCompanyId = CustomerCompanyId;
            if (String.IsNullOrEmpty(Error))
            {
                int? ShippingOrderBatchReceiptId = 0;
                string ReceiptNumber = "";
                db.sp_ShippingOrderReceiptUpdate(ref ShippingOrderBatchReceiptId, ref ReceiptNumber, package.CustomerCompanyId);
                result.ShippingOrderBatchReceiptId = ShippingOrderBatchReceiptId;
                result.ReceiptNumber = ReceiptNumber;
                result.ShippingOrderPriceInfoList = new List<ParaShippingOrderPriceInfo>();
                result.CustomerCompanyId = package.CustomerCompanyId;
                result.CurrencyResultList = new List<ParaShippingOrderPriceChargeSubmit>();
                result.ShippingOrderIdList = package.ShippingOrderIdList;
                foreach( var shippingOrderId in package.ShippingOrderIdList)
                {
                    var shippingOrder = ShippingOrder.GetShippingOrder(shippingOrderId);
                    ParaShippingOrderPriceInfo priceInfo = new ParaShippingOrderPriceInfo();
                    priceInfo.ShippingOrderId = shippingOrder.ShippingOrderId;
                    priceInfo.ShippingOrderCode = shippingOrder.ShippingOrderCode;
                    priceInfo.CurrencyId = shippingOrder.CurrencyId;
                    priceInfo.Currency = UtilityClasses.GetCurrency(priceInfo.CurrencyId.Value, 1).CurrencyCode;
                    priceInfo.Price = shippingOrder.Price;
                    if (shippingOrder.TaxPayment != null)
                    {
                        priceInfo.TaxCurrencyId = shippingOrder.TaxPayment.CurrencyId;
                        priceInfo.TaxCurrency = UtilityClasses.GetCurrency(shippingOrder.TaxPayment.CurrencyId.Value, 1).CurrencyCode;
                        priceInfo.TaxPrice = shippingOrder.TaxPayment.TaxPrice;
                    }
                    else
                    {
                        priceInfo.TaxCurrency = "";
                        priceInfo.TaxPrice = 0.0m;
                    }
                    
                    priceInfo.Weight = shippingOrder.TotalWeight.ToString() + " LB";
                    result.ShippingOrderPriceInfoList.Add(priceInfo);
                    var currency = getSubmitPackage(result.CurrencyResultList, shippingOrder.CurrencyId.Value);
                    
                    if (currency == null)
                    {
                        ParaShippingOrderPriceChargeSubmit temp = new ParaShippingOrderPriceChargeSubmit();
                        temp.CurrencyId = shippingOrder.CurrencyId;
                        temp.Currency = UtilityClasses.GetCurrency(temp.CurrencyId.Value, 1).CurrencyCode;
                        temp.CurrentBalance = db.sfnCompanyCurrentBalanceGet(CustomerCompanyId, temp.CurrencyId);
                        temp.TotalNeedToCharge = db.sfnShippingOrderUnPaidPrice(shippingOrder.ShippingOrderId, null);
                        temp.TotalPaid = 0.0m;
                        result.CurrencyResultList.Add(temp);
                    }
                    else
                    {
                        currency.TotalNeedToCharge = currency.TotalNeedToCharge + db.sfnShippingOrderUnPaidPrice(shippingOrder.ShippingOrderId, null);
                    }
                    if(shippingOrder.TaxPayment != null && shippingOrder.TaxPayment.CurrencyId != null)
                    {
                        currency = getSubmitPackage(result.CurrencyResultList, shippingOrder.TaxPayment.CurrencyId.Value);
                        if (currency == null)
                        {
                            ParaShippingOrderPriceChargeSubmit temp = new ParaShippingOrderPriceChargeSubmit();
                            temp.CurrencyId = shippingOrder.CurrencyId;
                            temp.Currency = UtilityClasses.GetCurrency(temp.CurrencyId.Value, 1).CurrencyCode;
                            temp.CurrentBalance = db.sfnCompanyCurrentBalanceGet(CustomerCompanyId, temp.CurrencyId);
                            temp.TotalNeedToCharge = db.sfnShippingOrderUnPaidTaxPrice(shippingOrder.ShippingOrderId, null);
                            temp.TotalPaid = 0.0m;
                            result.CurrencyResultList.Add(temp);
                        }
                        else
                        {
                            currency.TotalNeedToCharge = currency.TotalNeedToCharge + db.sfnShippingOrderUnPaidTaxPrice(shippingOrder.ShippingOrderId, null);
                        }
                    }
                }
                foreach(var item in result.CurrencyResultList)
                {
                    db.sp_ShippingOrderReceiptCurrencyAmountUpdate(ref ShippingOrderBatchReceiptId, item.CurrencyId, item.TotalNeedToCharge, item.TotalPaid);
                }

                foreach(var item in result.ShippingOrderIdList)
                {
                    db.sp_ShippingOrderReceiptShippingOrderUpdate(ref ShippingOrderBatchReceiptId, item);
                }

                result.ShippingOrderIdList = package.ShippingOrderIdList;
                result.ShippingOrderBatchReceiptId = ShippingOrderBatchReceiptId;
                result.Success = true;
                result.ErrorCode = "";
            }
            else
            {
                result.Success = false;
                result.ErrorCode = Error;
            }



            return result;
        }
        
        private static ParaShippingOrderPriceChargeSubmit getSubmitPackage(List<ParaShippingOrderPriceChargeSubmit> list, int CurrencyId)
        {
            ParaShippingOrderPriceChargeSubmit result = null;
            foreach(var item in list)
            {
                if(item.CurrencyId == CurrencyId)
                {
                    result = item;
                    break;
                }
            }
            return result;


        }

        public static ParaShippingOrderPriceChargeResult submitPayment (ParaShippingOrderPriceChargeStep submit, int? UserId, int? CompanyId)
        {
            ParaShippingOrderPriceChargeResult result = new ParaShippingOrderPriceChargeResult();
            //install payment
            string Error = "";

            foreach(var currency in submit.CurrencyResultList)
            {
                if(currency.CurrentBalance == null)
                {
                    currency.CurrentBalance = 0.0m;
                }
                if(currency.TotalNeedToCharge == null)
                {
                    currency.TotalNeedToCharge = 0.0m;
                }
                if(currency.TotalPaid == null)
                {
                    currency.TotalPaid = 0.0m;
                }
                if(currency.CurrentBalance + currency.TotalPaid < currency.TotalNeedToCharge)
                {
                    Error = "账户余额不足";
                    break;
                }
            }

            if (!String.IsNullOrEmpty(Error))
            {
                result.Success = false;
                result.ErrorCode = Error;
                return result;
            }

            antoto_dbDataContext db = new antoto_dbDataContext();

            foreach (var currency in submit.CurrencyResultList)
            {
                if (currency.TotalPaid != null && currency.TotalPaid > 0)
                {
                    ParaDataModel.ParaCompanyTransactionSet temp = new ParaDataModel.ParaCompanyTransactionSet();
                    temp.CurrencyId = currency.CurrencyId;
                    temp.CustomerCompanyId = submit.CustomerCompanyId;
                    temp.Description = "ANT-OTO 充值 收据号 " + submit.ReceiptNumber;
                    temp.Price = currency.TotalPaid;
                    temp.TransactionTypeCodeId = 2;
                    CompanyTransaction.CustomerCompanyTransactionSet(temp, UserId, CompanyId);
                }
            }

            foreach(var item in submit.ShippingOrderIdList)
            {
                ParaDataModel.ParaShippingOrderPriceCharge charge = new ParaDataModel.ParaShippingOrderPriceCharge();
                charge.ShippingOrderId = item;
                ShippingOrderAction.ShippingOrderPriceCharge(charge, UserId);
            }

            foreach(var currency in submit.CurrencyResultList)
            {
                currency.CurrentBalanceNew = db.sfnCompanyCurrentBalanceGet(submit.CustomerCompanyId, currency.CurrencyId);
            }

            result.Success = true;

            result.InvoiceToPrint = Utilities.generateReceiptFile(submit);

            if(result.InvoiceToPrint != null)
            {
                int? tempId = submit.ShippingOrderBatchReceiptId;
                db.sp_ShippingOrderReceiptUpdateFile(ref tempId, result.InvoiceToPrint.FileId);
            }

            result.ErrorCode = "";

            return result;
        }
        
    }





}
