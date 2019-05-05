using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public class PurchaseManager
    {
        public class PurchasePoolCompany
        {
            public int? CompanyId { get; set; }
            public List<PurchaseCategory> PurchaseDetail { get; set; }
            public DateTime? LastGenerateDate { get; set; }
        }

        public class PurchaseCategory
        {
            public string PurchasePlace { get; set; }
            public List<PurchasePoolItem> PurchasePoolItemList { get; set; }
        }

        public class PurchasePoolItem
        {
            public int? ItemId { get; set; }
            public int? WizardSessionId { get; set; }
            public int? PurchasePoolItemId { get; set; }
            public int? QuantityNeeded { get; set; }
            public Decimal? ItemPrice { get; set; }
            public string DiscountDetail { get; set; }
            public int? CurrencyId { get; set; }
            public string PurchasePlace { get; set; }
            public DataModel.ItemOnSaleDetail Item { get; set; }
        }

        public class PurchasePoolTask
        {
            public int? PurchasePoolItemId { get; set; }
            public int? PurchasePoolTaskId { get; set; }
            public int? QuantityMarked { get; set; }
            public int? QuantityUpdated { get; set; }
            public int? UserId { get; set; }
            public int? ItemPurchaseStatusCodeId { get; set; }
            public string ItemPurchaseStatus { get; set; }
            public string DiscountDetail { get; set; }
            public int? CurrencyId { get; set; }
            public string PurchasePlace { get; set; }
            public int? ItemId { get; set; }
            public int? WizardSessionId { get; set; }
            public string UserName { get; set; }
            public List<WizardForm.WizardInputFile> ReceiptImages { get; set; }
            public DataModel.ItemOnSaleDetail Item { get; set; }
        }

        public static DataModel.ResultPageResult PurchasePoolTaskListSearch(ParaDataModel.ParaPurchasePoolTaskSearch paraPurchasePoolTaskSearch, int? UserId, int? CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? total = 0;
            int? totalPage = 0;
            int? Page = paraPurchasePoolTaskSearch.Page;
            int? NextPage = 0;
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
            var list = db.sp_PurchasePoolTaskSearch(paraPurchasePoolTaskSearch.ItemPurchaseStatusCodeId, paraPurchasePoolTaskSearch.PurchasePlaceSearch,
                paraPurchasePoolTaskSearch.CreateDateFrom, paraPurchasePoolTaskSearch.CreateDateTo, paraPurchasePoolTaskSearch.UserId, CompanyId,
                paraPurchasePoolTaskSearch.PageSize, ref Page, ref total, ref totalPage);
            if (list != null)
            {
                NextPage = Page < totalPage ? Page + 1 : totalPage;
                foreach (var item in list)
                {
                    var currentobject = new PurchasePoolTask()
                    {
                        PurchasePoolItemId = item.PurchasePoolItemId,
                        QuantityMarked = item.QuantityMarked,
                        UserId = item.UserId,
                        PurchasePoolTaskId = item.ItemPurchaseTaskId,
                        ItemPurchaseStatusCodeId = item.ItemPurchaseStatusCodeId,
                        ItemPurchaseStatus = item.ItemPurchaseStatus,
                        DiscountDetail = item.DiscountDetail,
                        CurrencyId = item.CurrencyId,
                        PurchasePlace = item.PurchasePlace,
                        ItemId = item.ItemId,
                        Item = ProductOnSaleManager.getItemOnSaleByItemId(item.ItemId, 1)
                    };
                    var ItemDetail = ProductManager.getProductFromItemId(currentobject.ItemId.Value, CompanyId.Value, 1);
                    currentobject.WizardSessionId = ItemDetail.WizardSessionId;

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


        public static DataModel.ResultPageResult PurchasePoolTaskListActiveSearch(ParaDataModel.ParaPurchasePoolActiveTaskSearch paraPurchasePoolTaskSearch, int? UserId, int? CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? total = 0;
            int? totalPage = 0;
            int? Page = paraPurchasePoolTaskSearch.Page;
            int? NextPage = 0;
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
            var list = db.sp_PurchasePoolTaskActiveSearchByUPC(paraPurchasePoolTaskSearch.UPC, paraPurchasePoolTaskSearch.UserId, CompanyId,
                paraPurchasePoolTaskSearch.PageSize, ref Page, ref total, ref totalPage);
            if (list != null)
            {
                NextPage = Page < totalPage ? Page + 1 : totalPage;
                foreach (var item in list)
                {
                    var currentobject = new PurchasePoolTask()
                    {
                        PurchasePoolItemId = item.PurchasePoolItemId,
                        QuantityMarked = item.QuantityMarked,
                        UserId = item.UserId,
                        PurchasePoolTaskId = item.ItemPurchaseTaskId,
                        ItemPurchaseStatusCodeId = item.ItemPurchaseStatusCodeId,
                        ItemPurchaseStatus = item.ItemPurchaseStatus,
                        DiscountDetail = item.DiscountDetail,
                        CurrencyId = item.CurrencyId,
                        PurchasePlace = item.PurchasePlace,
                        ItemId = item.ItemId,
                        Item = ProductOnSaleManager.getItemOnSaleByItemId(item.ItemId, 1)
                    };
                    var ItemDetail = ProductManager.getProductFromItemId(currentobject.ItemId.Value, CompanyId.Value, 1);
                    currentobject.WizardSessionId = ItemDetail.WizardSessionId;

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

        public static PurchasePoolCompany PurchasePoolCompanyGet(int? UserId, int? CompanyId)
        {
            PurchasePoolCompany result = null;
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnPurchasePoolItemCompanyPurchasePlaceGet(CompanyId);
            if (list != null)
            { 
                result = new PurchasePoolCompany();
                result.CompanyId = CompanyId;
                result.PurchaseDetail = new List<PurchaseCategory>();
                foreach (var item in list)
                {
                    var tempCategory = new PurchaseCategory();
                    bool existsCategory = false;
                    foreach (var category in result.PurchaseDetail)
                    {
                        if(category.PurchasePlace == item.PurchasePlace)
                        {
                            existsCategory = true;
                            tempCategory = category;
                            break;
                        }
                    }
                    if (tempCategory.PurchasePoolItemList == null)
                    {
                        tempCategory.PurchasePoolItemList = new List<PurchasePoolItem>();
                    }
                    
                    if (String.IsNullOrEmpty(tempCategory.PurchasePlace))
                    {
                        tempCategory.PurchasePlace = item.PurchasePlace;
                    }
                    PurchasePoolItem tempItem = new PurchasePoolItem();
                    tempItem.CurrencyId = item.CurrencyId;
                    tempItem.DiscountDetail = item.PurchaseDetail;
                    tempItem.Item = ProductOnSaleManager.getItemOnSaleByItemId(item.ItemId, 1);
                    tempItem.ItemId = item.ItemId;
                    tempItem.ItemPrice = item.PurchasePrice;
                    tempItem.PurchasePlace = item.PurchasePlace;
                    tempItem.QuantityNeeded = item.Quantity;
                    tempItem.PurchasePoolItemId = item.ItemPurchasePoolId;
                    var tempItemDetail = ProductManager.getProductFromItemId(item.ItemId, CompanyId.Value, 1);
                    tempItem.WizardSessionId = tempItemDetail.WizardSessionId;



                    tempCategory.PurchasePoolItemList.Add(tempItem);
                    if (!existsCategory)
                    {
                        result.PurchaseDetail.Add(tempCategory);
                    }
                   
                }
            }
            return result;

        }

        public static PurchasePoolCompany PurchasePoolCompanyGenerate(int? UserId, int? CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? PurchasePoolCompanyId = 0;
            db.sp_ItemPurchasePoolGenerate(CompanyId, ref PurchasePoolCompanyId);
            if(PurchasePoolCompanyId > 0)
            {
                return PurchasePoolCompanyGet(UserId, CompanyId);
            }
            else
            {
                return null;
            }
        }

        public static PurchasePoolTask purchasePoolTaskAccept(ParaDataModel.ParaPurchaseTaskAccept paraPurchaseTaskAccept, int? UserId, int? CompanyId)
        {
            PurchasePoolTask result = new PurchasePoolTask();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? ItemPurchaseTaskId = 0;
            db.sp_PurchasePoolTaskAccept(paraPurchaseTaskAccept.PurchasePoolItemId, paraPurchaseTaskAccept.ItemId,
                paraPurchaseTaskAccept.Quantity, UserId, ref ItemPurchaseTaskId);
            if(ItemPurchaseTaskId > 0)
            {
                result = getPurchasePoolTask(ItemPurchaseTaskId, CompanyId.Value);
                return result;
            }
            else
            {
                return null;
            }
        }

        public static PurchasePoolTask purchasePoolTaskChange(ParaDataModel.ParaPurchaseTaskChange paraPurchaseTaskChange, int? UserId, int? CompanyId)
        {
            PurchasePoolTask result = new PurchasePoolTask();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? ItemPurchaseTaskId = paraPurchaseTaskChange.ItemPurchaseTaskId;
            db.sp_PurchasePoolTaskChange(paraPurchaseTaskChange.ItemId, paraPurchaseTaskChange.UpdatedQuantity, UserId, ref ItemPurchaseTaskId);
            if (ItemPurchaseTaskId > 0)
            {
                result = getPurchasePoolTask(ItemPurchaseTaskId, CompanyId.Value);
                return result;
            }
            else
            {
                return null;
            }
        }

        public static PurchasePoolTask purchasePoolTaskCancel(ParaDataModel.ParaPurchaseTaskDeny paraPurchaseTaskCancel, int? UserId, int? CompanyId)
        {
            PurchasePoolTask result = new PurchasePoolTask();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? ItemPurchaseTaskId = paraPurchaseTaskCancel.ItemPurchaseTaskId;
            db.sp_PurchasePoolTaskCancel(paraPurchaseTaskCancel.Reason, ref ItemPurchaseTaskId);
            if (ItemPurchaseTaskId > 0)
            {
                result = getPurchasePoolTask(ItemPurchaseTaskId, CompanyId.Value);
                return result;
            }
            else
            {
                return null;
            }
        }

        public static PurchasePoolTask purchasePoolTaskFinish(ParaDataModel.ParaPurchaseTaskFinish paraPurchaseTaskFinish, int? UserId, int? CompanyId)
        {
            PurchasePoolTask result = new PurchasePoolTask();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? ItemPurchaseTaskId = paraPurchaseTaskFinish.ItemPurchaseTaskId;
            db.sp_PurchasePoolTaskFinish(UserId, paraPurchaseTaskFinish.FinalUnitPrice, paraPurchaseTaskFinish.FinalTotalPrice, 
                paraPurchaseTaskFinish.Reason, ref ItemPurchaseTaskId);

            if (ItemPurchaseTaskId > 0)
            {
                if(paraPurchaseTaskFinish.ReceiptImages != null)
                {
                    db.sp_ItemPurchaseTaskResourceClear(ItemPurchaseTaskId, UserId);
                    int i = 0;
                    foreach(var image in paraPurchaseTaskFinish.ReceiptImages)
                    {
                        int? ItemPurchaseTaskResourceId = 0;
                        db.sp_ItemPurchaseTaskResourceUpdate(ItemPurchaseTaskId, image.FileId, 1,
                            i, "", "", UserId, ref ItemPurchaseTaskResourceId);
                        i++;
                    }
                }
                result = getPurchasePoolTask(ItemPurchaseTaskId, CompanyId.Value);
                return result;
            }
            else
            {
                return null;
            }
        }

        public static PurchasePoolTask getPurchasePoolTask(int? ItemPurchaseTaskId, int CompanyId)
        {
            PurchasePoolTask result = new PurchasePoolTask();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnItemPurchaseTaskGet(ItemPurchaseTaskId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    result.CurrencyId = item.CurrencyId;
                    result.DiscountDetail = item.Reason;
                    result.Item = ProductOnSaleManager.getItemOnSaleByItemId(item.ItemId, 1);
                    result.ItemId = item.ItemId;
                    var tempItemDetail = ProductManager.getProductFromItemId(item.ItemId, CompanyId, 1);
                    result.WizardSessionId = tempItemDetail.WizardSessionId;
                    result.ItemPurchaseStatus = item.ItemPurchaseStatus;
                    result.ItemPurchaseStatusCodeId = item.ItemPurchaseStatusCodeId;
                    result.PurchasePlace = item.PurchasePlace;
                    result.PurchasePoolItemId = item.ItemPurchasePoolId;
                    result.QuantityMarked = item.Quantity;
                    result.QuantityUpdated = item.UpdateQuantity;
                    result.UserId = item.UserId;
                    result.UserName = item.UserName;
                    result.ReceiptImages = getItemPurchaseTaskResource(ItemPurchaseTaskId);
                    break;
                }
            }
            return result;
        } 

        public static List<WizardForm.WizardInputFile> getItemPurchaseTaskResource(int? ItemPurchaseTaskId)
        {
            List<WizardForm.WizardInputFile> result = new List<WizardForm.WizardInputFile>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnItemPurchaseTaskResourceGet(ItemPurchaseTaskId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    WizardForm.WizardInputFile temp = AntotoFile.getFileFromId(item.FileId);
                    result.Add(temp);
                }
            }
            return result;
        }
    }

    
}
