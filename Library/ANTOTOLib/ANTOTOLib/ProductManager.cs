using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public class ProductManager
    {

        public static WizardForm.WizardSessionForm ProductCreateFromScrach(int pCategoryId, int pBrandId, int pCompanyId, int pUserId, int pSystemLanguageId, int CompanyId)
        {
            WizardForm.WizardSessionForm result = new WizardForm.WizardSessionForm();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? WizardSessionId = 0;
            db.sp_WizardSessionCreateForProductNew(ref WizardSessionId, pCategoryId, pBrandId, pUserId, pCompanyId);
            if(WizardSessionId != null && WizardSessionId > 0)
            {
                result = WizardForm.getWizardForm(WizardSessionId, pUserId, pSystemLanguageId, CompanyId);
            }
            else
            {
                result = null;
            }


            return result;
        }
        public static WizardForm.WizardSessionForm ProductPublish(int WizardSessionId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            WizardForm.WizardSessionForm result = new WizardForm.WizardSessionForm();
            result.SourceTable = "Item";
            int? itemId = 0;
            string Error = "";
            db.sp_WizardSessionItemPublish(WizardSessionId, ref itemId, ref Error);
            result.SourceId = itemId;
            if(itemId !=null && itemId > 0)
            {
                return result;
            }else
            {
                return null;
            }

        }
        public static DataModel.ResultProduct getProductFromWizardSessionId(int WizardSessionId, int CompanyId, int SystemLanguageId)
        {
            DataModel.ResultProduct result = new DataModel.ResultProduct();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_Item_GetFromWizardSessionId(WizardSessionId, CompanyId, SystemLanguageId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    result = new DataModel.ResultProduct
                    {
                        ProductId = item.ItemId,
                        WizardSessionId = item.WizardSessionId,
                        ProductName = item.ItemName,
                        Category = item.Category,
                        Brand = item.Brand,
                        ProductStatusCodeId = item.ItemStatusCodeId,
                        ProductStatus = item.ItemStatusCode,
                        ProductCode = item.ProductCode,
                        MainImage = item.MainImageFileId == null ? null : AntotoFile.getFileFromId(item.MainImageFileId.Value),
                        SKU = item.SKU,
                        ProductDescription = item.ProductDescription,
                        SupplierSKU = item.SupplierSKU,
                        ModelNumber = item.ModelNumber
                    };
                    break;
                }
            }
            return result;
        }

        public static DataModel.ResultProduct getProductFromItemId(int ItemId, int CompanyId, int SystemLanguageId)
        {
            DataModel.ResultProduct result = new DataModel.ResultProduct();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_Item_GetFromItemId(ItemId, CompanyId, SystemLanguageId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    result = new DataModel.ResultProduct
                    {
                        ProductId = item.ItemId,
                        WizardSessionId = item.WizardSessionId,
                        ProductName = item.ItemName,
                        Category = item.Category,
                        Brand = item.Brand,
                        ProductStatusCodeId = item.ItemStatusCodeId,
                        ProductStatus = item.ItemStatusCode,
                        ProductCode = item.ProductCode,
                        MainImage = item.MainImageFileId == null ? null : AntotoFile.getFileFromId(item.MainImageFileId.Value),
                        SKU = item.SKU,
                        ProductDescription = item.ProductDescription,
                        SupplierSKU = item.SupplierSKU,
                        ModelNumber = item.ModelNumber
                    };
                    break;
                }
            }
            return result;
        }

        public static DataModel.ResultPageResult ProductSearch(ParaDataModel.ParaProductSearch productSearch, int SystemLanguageId, int CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? Page = productSearch.Page;
            int? Total = 0;
            int? TotalPages = 0;
            int? NextPage = 0;
            var list = db.sp_Item_Search(CompanyId, productSearch.SKU, productSearch.ProductCode, productSearch.ProductName,
                productSearch.itemStatusCodeId, productSearch.Category, productSearch.Brand,
                productSearch.FileId, productSearch.ProductDescription, productSearch.ModelNumber, 
                productSearch.SupplierSKU, productSearch.PageSize,
                ref Page, ref Total, ref TotalPages, SystemLanguageId);
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
           
            if (list != null)
            {
                NextPage = Page < TotalPages ? Page + 1 : TotalPages;
                foreach (var item in list)
                {
                    if(result.records == null)
                    {
                        result.records = new List<object>();
                    }

                    var current = new DataModel.ResultProduct
                    {
                        ProductId = item.ItemId,
                        WizardSessionId = item.WizardSessionId,
                        ProductName = item.ItemName,
                        Category = item.Category,
                        Brand = item.Brand,
                        ProductStatusCodeId = item.ItemStatusCodeId,
                        ProductStatus = item.ItemStatusCode,
                        ProductCode = item.ProductCode,
                        MainImage = item.MainImageFileId == null ? null : AntotoFile.getFileFromId(item.MainImageFileId.Value),
                        SKU = item.SKU,
                        ProductDescription = item.ProductDescription,
                        SupplierSKU = item.SupplierSKU,
                        ModelNumber = item.ModelNumber
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

        public static string deleteProduct(int itemId, int CompanyId, int UserId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            string result = "";
            db.sp_Item_Delete(CompanyId, itemId, ref result, UserId, 1);
            return result;
        }

        public static List<DataModel.ResultProduct> RelatedUPCProductSearch(ParaDataModel.ParaWizardSessionItem info, int UserId, int CompanyId, int SystemLanguageId)
        {
            List<DataModel.ResultProduct> result = new List<DataModel.ResultProduct>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_ItemRelatedListGet(info.WizardSessionId, info.ItemId, SystemLanguageId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    var current = new DataModel.ResultProduct
                    {
                        ProductId = item.ItemId,
                        WizardSessionId = item.WizardSessionId,
                        ProductName = item.ItemName,
                        Category = item.Category,
                        Brand = item.Brand,
                        ProductStatusCodeId = item.ItemStatusCodeId,
                        ProductStatus = item.ItemStatusCode,
                        ProductCode = item.ProductCode,
                        MainImage = item.MainImageFileId == null ? null : AntotoFile.getFileFromId(item.MainImageFileId.Value),
                        SKU = item.SKU,
                        ProductDescription = item.ProductDescription,
                        SupplierSKU = item.SupplierSKU,
                        ModelNumber = item.ModelNumber,
                        VariationTitle = item.VariationTitle,
                        VariationReasonCodeId = item.VariationReasonCodeId,
                        VariationCompleted = !String.IsNullOrEmpty(item.VariationTitle),
                        IsSelf = item.Selected == "Y" ? true : false
                    };
                    current.WizardSession = WizardForm.getWizardForm2(current.WizardSessionId, UserId, SystemLanguageId, CompanyId);
                    result.Add(current);

                }
            }

            return result;
        }

        public static DataModel.ResultItemFinalPage ProductSetVariationTitle(ParaDataModel.ParaVariationInfo info, int UserId, int SystemLanguageId, int CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? result = 0;
            db.sp_ItemVariationTitleSet(info.ItemId, info.WizardSessionId, info.VariationTitle, info.VariationReasonCodeId, UserId, 1, ref result);
            ParaDataModel.ParaWizardSessionItem temp = new ParaDataModel.ParaWizardSessionItem();
            temp.ItemId = info.ItemId;
            temp.WizardSessionId = info.WizardSessionId;
            return getProductVariationInfoList(temp, UserId, SystemLanguageId, CompanyId);
        }

        public static DataModel.ResultItemFinalPage ProductAddVariation(ParaDataModel.ParaVariationInfo info, int UserId, int SystemLanguageId, int CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? ItemId = 0;
            int? WizardSessionId = 0;
            db.sp_Item_VariationCopy(info.WizardSessionId, info.ItemId, info.VariationReasonCodeId.ToString(), info.VariationTitle, ref ItemId, ref WizardSessionId, UserId);
            if(ItemId == null || ItemId == 0)
            {
                return null;
            }
            ParaDataModel.ParaWizardSessionItem temp = new ParaDataModel.ParaWizardSessionItem();
            temp.ItemId = info.ItemId;
            temp.WizardSessionId = info.WizardSessionId;
            return getProductVariationInfoList(temp, UserId, SystemLanguageId, CompanyId);
        }

        public static DataModel.ResultItemFinalPage getProductVariationInfoList(ParaDataModel.ParaWizardSessionItem item, int UserId, int SystemLanguageId, int CompanyId)
        {
            DataModel.ResultItemFinalPage result = new DataModel.ResultItemFinalPage();
            var tempProduct = getProductFromWizardSessionId(item.WizardSessionId.Value, CompanyId, SystemLanguageId);
            if(tempProduct.SKU != null)
            {
                result.SKU = tempProduct.SKU;
            }
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnItemVariationInfoGet(item.ItemId, item.WizardSessionId);
            if (list != null)
            {
                foreach(var item1 in list)
                {
                    result.VariationTitle = item1.VariationTitle;
                    result.VariationReasonCodeId = item1.VariationReasonCodeId;
                    result.VariationCompleted = !String.IsNullOrEmpty(item1.VariationTitle);
                    break;
                }
                result.RelatedUPCProductList = RelatedUPCProductSearch(item, UserId, CompanyId, SystemLanguageId);
                return result;
            }
            else
            {
                return result;
            }

        }
    }
}
