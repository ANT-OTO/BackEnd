using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public class ProductUpdateManager
    {
        public static DataModel.ResultPageResult getItemPackageList(ParaDataModel.ParaItemPackageSearch search, int UserId, int CompanyId, int SystemLanguageId)
        {
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
            int? Page = search.Page;
            int? Total = 0;
            int? TotalPages = 0;
            int? NextPage = 0;
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_ItemPackageGetByManager(search.SearchWord, search.ItemPackageStatusCodeId,
                CompanyId, UserId, SystemLanguageId, search.PageSize, ref Page, ref Total, ref TotalPages);

            if (list != null)
            {
                NextPage = Page < TotalPages ? Page + 1 : TotalPages;
                foreach (var item in list)
                {
                    if (result.records == null)
                    {
                        result.records = new List<object>();
                    }

                    var current = new DataModel.ResultItemPackage
                    {
                        ItemId = item.ItemId,
                        WizardSessionId = item.WizardSessionId,
                        IsUpdate = item.SourceTable == "ItemUpdatePackage" ? true : false,
                        ItemSubmitPackageId = item.SourceTable == "ItemUpdatePackage" ? 0 : item.SourceId,
                        ItemUpdatePackageId = item.SourceTable == "ItemUpdatePackage" ? item.SourceId : 0,
                        UPC = item.UPC,
                        Price = item.Price,
                        CurrencyId = item.CurrencyId,
                        Currency = item.Currency,
                        ProductName = item.ProductName,
                        Weight = item.Weight,
                        SaleTitle = item.SaleTitle,
                        SalePlace = item.SalePlace,
                        DiscountDescription = item.DiscountDescription,
                        SizeRange = item.SizeRange,
                        ColorRange = item.ColorRange,
                        ItemPackageStatusCodeId = item.ItemPackageStatusCodeId,
                        ItemPackageStatus = item.ItemPackageStatus,
                        ImageList = getResourceListFromItemPackage(item.SourceTable, item.SourceId)
                    };
                    result.records.Add(current);

                }
                result.TotalPage = TotalPages;
                result.TotalRecords = Total;
                result.CurrentPage = Page;
                result.NextPage = NextPage;
            }
            return result;
        }


        public static List<WizardForm.WizardInputFile> getResourceListFromItemPackage(string SourceTable, int SourceId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            List<WizardForm.WizardInputFile> result = new List<WizardForm.WizardInputFile>();
            var list = db.tfnItemPackageResourceListGet(SourceTable, SourceId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    var temp = AntotoFile.getFileFromId(item.FileId);
                    result.Add(temp);
                }
            }
            return result;
        }

        public static int setResourceForItemPackage(string SourceTable, int SourceId, WizardForm.WizardInputFile file, int UserId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? result = 0;
            db.sp_ItemPackageResourceInsert(SourceId, SourceTable, file.FileId, 1, file.FileDescription, UserId, ref result);
            return result == null ? 0 : result.Value;
        }
        
        public static WizardForm.WizardSessionForm getProductFromUPC (string UPC, int UserId, int CompanyId, int SystemLanguageId)
        {
            var result = new WizardForm.WizardSessionForm();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnItemGetByUPC(UPC, CompanyId, UserId);
            if(list!=null && list.Count() > 0)
            {
                foreach(var item in list)
                {
                    var ItemId = item.ItemId;
                    var WizardSessionId = item.WizardSessionId;

                    result = WizardForm.getWizardForm(WizardSessionId, UserId, SystemLanguageId, CompanyId);
                    result.SourceId = ItemId;
                    result.SourceTable = "Item";
                    ParaDataModel.ParaWizardSessionItem temp = new ParaDataModel.ParaWizardSessionItem();
                    temp.WizardSessionId = WizardSessionId;
                    result.VariationProduct = ProductManager.getProductVariationInfoList(temp, UserId, SystemLanguageId, CompanyId);
                    break;
                }
            }
            return result;
        }

        public static int SubmitItemPackage(ParaDataModel.ParaProductSubmitPackage submitPackage, int UserId, int CompanyId, int SystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? result = 0;
            db.sp_ItemPackageSubmit(submitPackage.UPC, submitPackage.Price, submitPackage.CurrencyId,
                submitPackage.ProductName, submitPackage.Weight, submitPackage.SaleTitle, submitPackage.SalePlace,
                submitPackage.DiscountDescription, submitPackage.SizeRange, submitPackage.ColorRange,
                UserId, CompanyId, ref result);
            if(submitPackage.ImageList != null && result!=null && result > 0)
            {
                foreach(var item in submitPackage.ImageList)
                {
                    setResourceForItemPackage("ItemSubmitPackage", result.Value, item, UserId);
                }
            }

            return result == null ? 0 : result.Value;
        }


        public static int UpdateItemPackage(ParaDataModel.ParaProductUpdatePackage updatePackage, int UserId, int CompanyId, int SystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? result = 0;

            db.sp_ItemPackageUpdate(updatePackage.UPC, updatePackage.Price, updatePackage.CurrencyId,
                updatePackage.Weight, updatePackage.SaleTitle, updatePackage.SalePlace,
                updatePackage.DiscountDescription, updatePackage.SizeRange, updatePackage.ColorRange,
                UserId, CompanyId, ref result);
            if (updatePackage.ImageList != null && result != null && result > 0)
            {
                foreach (var item in updatePackage.ImageList)
                {
                    setResourceForItemPackage("ItemUpdatePackage", result.Value, item, UserId);
                }
            }
            return result == null ? 0 : result.Value;
        }
        
        public static DataModel.ResultPageResult getUserItemPackageListHistory(ParaDataModel.ParaItemPackageSearch search, int UserId, int CompanyId, int SystemLanguageId)
        {
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
            int? Page = search.Page;
            int? Total = 0;
            int? TotalPages = 0;
            int? NextPage = 0;
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_ItemPackageGetByUserId(search.SearchWord,search.ItemPackageStatusCodeId,
                CompanyId, UserId, SystemLanguageId, search.PageSize, ref Page, ref Total, ref TotalPages);

            if (list != null)
            {
                NextPage = Page < TotalPages ? Page + 1 : TotalPages;
                foreach (var item in list)
                {
                    if (result.records == null)
                    {
                        result.records = new List<object>();
                    }

                    var current = new DataModel.ResultItemPackage
                    {
                        ItemId = item.ItemId,
                        WizardSessionId = item.WizardSessionId,
                        IsUpdate = item.SourceTable == "ItemUpdatePackage" ? true : false,
                        ItemSubmitPackageId = item.SourceTable == "ItemUpdatePackage" ? 0 : item.SourceId,
                        ItemUpdatePackageId = item.SourceTable == "ItemUpdatePackage" ? item.SourceId : 0,
                        UPC = item.UPC,
                        Price = item.Price,
                        CurrencyId = item.CurrencyId,
                        Currency = item.Currency,
                        ProductName = item.ProductName,
                        Weight = item.Weight,
                        SaleTitle = item.SaleTitle,
                        SalePlace = item.SalePlace,
                        DiscountDescription = item.DiscountDescription,
                        SizeRange = item.SizeRange,
                        ColorRange = item.ColorRange,
                        ItemPackageStatusCodeId = item.ItemPackageStatusCodeId,
                        ItemPackageStatus = item.ItemPackageStatus,
                        ImageList = getResourceListFromItemPackage(item.SourceTable, item.SourceId)
                    };
                    result.records.Add(current);

                }
                result.TotalPage = TotalPages;
                result.TotalRecords = Total;
                result.CurrentPage = Page;
                result.NextPage = NextPage;
            }
            return result;
        }

        public static DataModel.ResultItemPackage updateItemPackage(DataModel.ResultItemPackage package, int UserId, int CompanyId, int SystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? ItemSubmitPackageId = package.ItemSubmitPackageId;
            int? ItemUpdatePackageId = package.ItemUpdatePackageId;
            db.sp_ItemPackageUpdateAfter(ref ItemSubmitPackageId, ref ItemUpdatePackageId, package.Price, package.CurrencyId,
                package.ProductName, package.Weight, package.SaleTitle, package.SalePlace, package.DiscountDescription,
                package.SizeRange, package.ColorRange, UserId, CompanyId);
            int? SourceId = 0;
            string SourceTable = "";
            if(ItemSubmitPackageId!=null && ItemSubmitPackageId > 0)
            {
                SourceId = ItemSubmitPackageId;
                SourceTable = "ItemSubmitPackage";
            }
            if(ItemUpdatePackageId != null && ItemUpdatePackageId > 0)
            {
                SourceId = ItemUpdatePackageId;
                SourceTable = "ItemUpdatePackage";
            }
            db.sp_ItemPackageResourceClear(SourceId, SourceTable, UserId);
            int? ItemPackageResourceId = 0;
            if (package.ImageList != null)
            {
                foreach(var image in package.ImageList)
                {
                    db.sp_ItemPackageResourceInsert(SourceId, SourceTable, image.FileId, 1, image.FileDescription, UserId, ref ItemPackageResourceId);
                }
            }
            return getItemPackage(SourceId, SourceTable, CompanyId, UserId, SystemLanguageId);
        }

        public static WizardForm.WizardSessionForm appoveItemPackage(ParaDataModel.ParaItemPackage itemPackage, int UserId, int CompanyId, int SystemLanguageId)
        {
            WizardForm.WizardSessionForm result = new WizardForm.WizardSessionForm();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? ProductId = 0;
            int? WizardSessionId = 0;
            db.sp_ItemPackageApprove(itemPackage.ItemSubmitPackageId, itemPackage.CategoryId, itemPackage.BrandId, CompanyId, UserId, itemPackage.ItemUpdatePackageId,
                ref ProductId, ref WizardSessionId);
            if(WizardSessionId != null && WizardSessionId > 0)
            {
                result = ANTOTOLib.WizardForm.getWizardForm(WizardSessionId, UserId, SystemLanguageId, CompanyId);
                result.SourceId = ProductId;
                result.SourceTable = "Item";
                ParaDataModel.ParaWizardSessionItem item = new ParaDataModel.ParaWizardSessionItem();
                item.WizardSessionId = WizardSessionId;
                result.VariationProduct = ANTOTOLib.ProductManager.getProductVariationInfoList(item, UserId, SystemLanguageId, CompanyId);
                if(itemPackage.PutOnMarket != null && itemPackage.PutOnMarket.Value)
                {
                    //Push to Buffer and On Sale
                    int bufferId = ProductOnSaleManager.ItemPackagePutInToBuffer(itemPackage, UserId, CompanyId);
                    if(bufferId > 0)
                    {
                        ParaDataModel.ParaItemOnSaleRequest onsalerequest = new ParaDataModel.ParaItemOnSaleRequest();
                        onsalerequest.ItemId = null;
                        onsalerequest.ItemOnSaleRequestTempBufferId = bufferId;
                        onsalerequest.PlatformList = itemPackage.PlatformList;
                        onsalerequest.Price = itemPackage.Price;
                        onsalerequest.CurrencyId = itemPackage.CurrencyId;
                        onsalerequest.Description = itemPackage.OnSaleMemo;
                        ProductOnSaleManager.CreateOnSaleRequest(onsalerequest, UserId, CompanyId, SystemLanguageId);
                    }
                }
            }
            return result;
        }

        public static int CancelItemPackageByUserId (ParaDataModel.ParaItemPackage itemPackage, int UserId, int CompanyId, int SystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? ItemSubmitPackageId = itemPackage.ItemSubmitPackageId;
            int? ItemUpdatePackageId = itemPackage.ItemUpdatePackageId;
            db.sp_ItemPackageCancel(ref ItemSubmitPackageId, CompanyId, UserId, ref ItemUpdatePackageId);
            if(ItemSubmitPackageId !=null && ItemSubmitPackageId > 0)
            {
                return 1;
            }
            if(ItemUpdatePackageId != null && ItemUpdatePackageId > 0)
            {
                return 1;
            }
            return 0;
        }


        public static int RejectItemPackageByManager(ParaDataModel.ParaItemPackage itemPackage, int UserId, int CompanyId, int SystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? ItemSubmitPackageId = itemPackage.ItemSubmitPackageId;
            int? ItemUpdatePackageId = itemPackage.ItemUpdatePackageId;
            db.sp_ItemPackageReject(ref ItemSubmitPackageId, CompanyId, UserId, ref ItemUpdatePackageId);
            if (ItemSubmitPackageId != null && ItemSubmitPackageId > 0)
            {
                return 1;
            }
            if (ItemUpdatePackageId != null && ItemUpdatePackageId > 0)
            {
                return 1;
            }
            return 0;
        }
        
        public static int ItemPackagePushToOnSaleBuffer(ParaDataModel.ParaItemPackagePushToBuffer itemPackage, int UserId, int CompanyId, int SystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? SourceId = 0;
            string SourceTable = "";
            if(itemPackage.ItemSubmitPackageId!=null && itemPackage.ItemSubmitPackageId > 0)
            {
                SourceId = itemPackage.ItemSubmitPackageId;
                SourceTable = "ItemSubmitPackage";
            }
            if (itemPackage.ItemUpdatePackageId != null && itemPackage.ItemUpdatePackageId > 0)
            {
                SourceId = itemPackage.ItemUpdatePackageId;
                SourceTable = "ItemUpdatePackage";
            }
            int? ItemOnSaleRequestTempBufferId = 0;
            db.sp_ItemPackageInsertBuffer(SourceId, SourceTable, UserId, itemPackage.Price,
                itemPackage.CurrencyId, itemPackage.Description, ref ItemOnSaleRequestTempBufferId);

            return ItemOnSaleRequestTempBufferId == null ? 0 : ItemOnSaleRequestTempBufferId.Value;
        }


        public static DataModel.ResultItemPackage getItemPackage(int? SourceId, string SourceTable, int pCompanyId, int pUserId, int pSystemLanguageId)
        {
            DataModel.ResultItemPackage result = new DataModel.ResultItemPackage();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_ItemPackageGetBySourceId(SourceId, SourceTable, pCompanyId, pUserId, pSystemLanguageId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    result = new DataModel.ResultItemPackage
                    {
                        ItemId = item.ItemId,
                        WizardSessionId = item.WizardSessionId,
                        IsUpdate = item.SourceTable == "ItemUpdatePackage" ? true : false,
                        ItemSubmitPackageId = item.SourceTable == "ItemUpdatePackage" ? 0 : item.SourceId,
                        ItemUpdatePackageId = item.SourceTable == "ItemUpdatePackage" ? item.SourceId : 0,
                        UPC = item.UPC,
                        Price = item.Price,
                        CurrencyId = item.CurrencyId,
                        Currency = item.Currency,
                        ProductName = item.ProductName,
                        Weight = item.Weight,
                        SaleTitle = item.SaleTitle,
                        SalePlace = item.SalePlace,
                        DiscountDescription = item.DiscountDescription,
                        SizeRange = item.SizeRange,
                        ColorRange = item.ColorRange,
                        ItemPackageStatusCodeId = item.ItemPackageStatusCodeId,
                        ItemPackageStatus = item.ItemPackageStatus,
                        ImageList = getResourceListFromItemPackage(item.SourceTable, item.SourceId)
                    };
                    break;
                }
            }
            return result;
        }
    }
}
