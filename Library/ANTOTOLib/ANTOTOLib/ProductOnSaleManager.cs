using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public class ProductOnSaleManager
    {
        //public DataModel.ResultPageResult getUnhandledItemOnSaleRequestBufferListGet(ParaDataModel.ParaItemOnSaleTempBufferSearch search, int UserId, int CompanyId, int SystemLanguageId)
        //{
        //    DataModel.ResultPageResult result = new DataModel.ResultPageResult();
        //    int? Page = search.Page;
        //    int? Total = 0;
        //    int? TotalPages = 0;
        //    int? NextPage = 0;
        //    antoto_dbDataContext db = new antoto_dbDataContext();
        //    var list = db.sp_ItemOnSaleRequestTempBufferGet(CompanyId, UserId, SystemLanguageId, search.PageSize,
        //        ref Page, ref Total, ref TotalPages);
        //    if (list != null)
        //    {
        //        NextPage = Page < TotalPages ? Page + 1 : TotalPages;
        //        foreach (var item in list)
        //        {
        //            if (result.records == null)
        //            {
        //                result.records = new List<object>();
        //            }

        //            var current = new DataModel.ResultItemOnSaleRequestTempBuffer
        //            {
        //                ItemOnSaleRequestTempBufferId = item.ItemOnSaleRequestTempBufferId,
        //                Description = item.Description,
        //                Price = item.Price,
        //                CurrencyId = item.CurrencyId,
        //                Product = null,
        //                ItemPackage = ProductUpdateManager.getItemPackage(item.SourceId, item.SourceTable, CompanyId, UserId, SystemLanguageId)
        //            };
        //            result.records.Add(current);

        //        }
        //        result.TotalPage = TotalPages;
        //        result.TotalRecords = Total;
        //        result.CurrentPage = Page;
        //        result.NextPage = NextPage;
        //    }
        //    return result;
        //}

        

        public static int ItemPackagePutInToBuffer(ParaDataModel.ParaItemPackage itemPackage, int UserId, int CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? SourceId = 0;
            string SourceTable = "";
            if(itemPackage.ItemSubmitPackageId != null)
            {
                SourceId = itemPackage.ItemSubmitPackageId;
                SourceTable = "ItemSubmitPackage";
            }
            if(itemPackage.ItemUpdatePackageId != null)
            {
                SourceId = itemPackage.ItemUpdatePackageId;
                SourceTable = "ItemUpdatePackage";
            }
            int? ItemOnSaleRequestTempBufferId = 0;
            db.sp_ItemPackageInsertBuffer(SourceId, SourceTable, UserId, itemPackage.Price, itemPackage.CurrencyId, itemPackage.OnSaleMemo, ref ItemOnSaleRequestTempBufferId);
            return ItemOnSaleRequestTempBufferId == null ? 0 : ItemOnSaleRequestTempBufferId.Value;
        }

        public static DataModel.ResultItemOnSaleRequest CreateOnSaleRequest(ParaDataModel.ParaItemOnSaleRequest itemOnSaleRequest, int UserId, int CompanyId, int SystemLanguageId)
        {
            int? result = 0;
            antoto_dbDataContext db = new antoto_dbDataContext();
            db.sp_ItemOnSaleRequestCreate(itemOnSaleRequest.ItemOnSaleRequestTempBufferId, itemOnSaleRequest.ItemId, itemOnSaleRequest.Price,
                itemOnSaleRequest.CurrencyId, itemOnSaleRequest.Description, ref result, itemOnSaleRequest.ItemSubmitPackageId, itemOnSaleRequest.ItemUpdatePackageId, UserId);
            if(result!=null && result.Value > 0)
            {
                if (itemOnSaleRequest.PlatformList != null)
                {
                    foreach(var platform in itemOnSaleRequest.PlatformList)
                    {
                        int? temp = 0;
                        db.sp_ItemOnSaleRequestPlatformInsert(result.Value, platform.PlatformName, UserId, ref temp);
                    }
                }
            }

            if(result == null)
            {
                return null;
            }
            else
            {
                return GetItemOnSaleRequest(result.Value, CompanyId, UserId, SystemLanguageId);
            }
        }
        public static DataModel.ResultItemOnSaleRequest GetItemOnSaleRequest(int ItemOnSaleRequestId, int CompanyId, int UserId, int SystemLanguageId)
        {
            DataModel.ResultItemOnSaleRequest result = new DataModel.ResultItemOnSaleRequest();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_ItemOnSaleRequestGetById(ItemOnSaleRequestId, UserId, SystemLanguageId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    var current = new DataModel.ResultItemOnSaleRequest
                    {
                        Product = ProductManager.getProductFromItemId(item.ItemId, CompanyId, SystemLanguageId),
                        ItemOnSaleRequestId = item.ItemOnSaleRequestId,
                        Description = item.Description,
                        Price = item.UpdatedPrice,
                        CurrencyId = item.UpdatedCurrencyId,
                        Currency = item.UpdatedCurrency,
                        PlatformList = PlatformInfoGet(item.ItemOnSaleRequestId)
                    };
                    result = current;
                    break;
                }
            }
            return result;
        }

        public static List<DataModel.ResultPlatform> PlatformInfoGet(int ItemOnSaleRequestId)
        {
            List<DataModel.ResultPlatform> result = new List<DataModel.ResultPlatform>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnItemOnSalePlatformListGet(ItemOnSaleRequestId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    DataModel.ResultPlatform temp = new DataModel.ResultPlatform();
                    temp.ItemOnSaleRequestPlatformInfoId = item.ItemOnSaleRequestPlatformInfoId;
                    temp.PlatformName = item.PlatformName;
                    result.Add(temp);
                }
            }
            return result;
        }
        public static DataModel.ResultPageResult getAllItemOnSaleRequest(ParaDataModel.ParaItemOnSaleSearch search, int UserId, int CompanyId, int SystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
            int? Page = search.Page;
            int? Total = 0;
            int? TotalPages = 0;
            int? NextPage = 0;
            var list = db.sp_ItemOnSaleRequestGet(search.ItemOnSaleRequestStatusCodeId, CompanyId, UserId, SystemLanguageId, search.PageSize,
                ref Page, ref Total, ref TotalPages);
            if (list != null)
            {
                NextPage = Page < TotalPages ? Page + 1 : TotalPages;
                foreach (var item in list)
                {
                    if (result.records == null)
                    {
                        result.records = new List<object>();
                    }

                    var current = new DataModel.ResultItemOnSaleRequest
                    {
                        Product = ProductManager.getProductFromItemId(item.ItemId, CompanyId, SystemLanguageId),
                        ItemOnSaleRequestId = item.ItemOnSaleRequestId,
                        Description = item.Description,
                        Price = item.UpdatedPrice,
                        CurrencyId = item.UpdatedCurrencyId,
                        Currency = item.UpdatedCurrency,
                        PlatformList = PlatformInfoGet(item.ItemOnSaleRequestId)
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


        public static int ItemOnSaleRequestStartWork(DataModel.ResultItemOnSaleRequest request, int UserId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? itemOnSaleRequestId = request.ItemOnSaleRequestId;
            db.sp_ItemOnSaleRequestWorkOn(ref itemOnSaleRequestId, UserId);
            return itemOnSaleRequestId == null ? 0 : itemOnSaleRequestId.Value;
        }

        public static int ItemOnSaleRequestFinish(DataModel.ResultItemOnSaleRequest request, int UserId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? itemOnSaleRequestId = request.ItemOnSaleRequestId;
            db.sp_ItemOnSaleRequestFinish(ref itemOnSaleRequestId, UserId);
            return itemOnSaleRequestId == null ? 0 : itemOnSaleRequestId.Value;
        }

        public static int ItemOnSaleRequestCancel(DataModel.ResultItemOnSaleRequest request, int UserId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? itemOnSaleRequestId = request.ItemOnSaleRequestId;
            db.sp_ItemOnSaleRequestCancel(ref itemOnSaleRequestId, UserId);
            return itemOnSaleRequestId == null ? 0 : itemOnSaleRequestId.Value;
        }

        public static DataModel.ItemOnSaleDetail getItemOnSale(DataModel.ItemOnSaleDetail detail, int UserId, int CompanyId, int SystemLanguageId) 
        {
            DataModel.ItemOnSaleDetail result = new DataModel.ItemOnSaleDetail();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnItemOnSaleInfoGet(detail.ItemOnSaleId, detail.ItemId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    result.ItemId = item.ItemId;
                    result.ItemOnSaleId = item.ItemOnSaleId;
                    result.ItemTitle = item.Title;
                    result.CurrencyId = item.CurrencyId;
                    result.ItemDescription = item.Description;
                    result.OnMarket = item.OnMarket;
                    result.Price = item.Price;
                    result.VariationTitle = item.VariationTitle;
                    
                    var imageList = db.tfnItemOnSaleResourceInfoGet(result.ItemOnSaleId, result.ItemId);
                    if(imageList != null)
                    {
                        result.ImageList = new List<WizardForm.WizardInputFile>();
                        foreach(var image in imageList)
                        {
                            if (image.isMain)
                            {
                                result.MainImage = AntotoFile.getFileFromId(image.FileId);
                                result.MainImage.Selected = image.Selected;
                            }
                            else
                            {
                                var temp = AntotoFile.getFileFromId(image.FileId);
                                temp.Selected = image.Selected;
                                result.ImageList.Add(temp);
                            }
                        }
                    }

                    var BulletPointList = db.tfnItemOnSaleBulletPointInfoGet(result.ItemOnSaleId, result.ItemId);
                    if (BulletPointList != null)
                    {
                        result.BulletPointList = new List<string>();
                        foreach(var bullet in BulletPointList)
                        {
                            result.BulletPointList.Add(bullet.BulletPoint);
                        }
                    }

                    var relatedlist = db.sp_ItemRelatedListGet(0, result.ItemId, SystemLanguageId);
                    if(relatedlist != null)
                    {
                        result.RelatedItemList = new List<DataModel.ItemOnSaleDetailRelated>();
                        foreach(var related in relatedlist)
                        {
                            if(related.Selected != "Y")
                            {
                                DataModel.ItemOnSaleDetailRelated temp = new DataModel.ItemOnSaleDetailRelated();
                                temp.ItemId = related.ItemId;
                                var tempItemOnSale = db.tfnItemOnSaleInfoGet(0, related.ItemId);
                                if (tempItemOnSale != null)
                                {
                                    foreach(var temp1 in tempItemOnSale)
                                    {
                                        temp.ItemOnSaleId = temp1.ItemOnSaleId;
                                        temp.OnMarket = temp1.OnMarket;
                                        temp.VariationTitle = temp1.VariationTitle;
                                        break;
                                    }
                                }
                                temp.ItemOnSaleId = 0;
                                if (String.IsNullOrEmpty(temp.VariationTitle))
                                {
                                    temp.VariationTitle = related.VariationTitle;
                                }
                                

                                result.RelatedItemList.Add(temp);
                            }
                        }
                    }
                    break;
                }
            }
            return result;
        }

        public static DataModel.ItemOnSaleDetail getItemOnSaleByItemId(int ItemId, int SystemLanguageId)
        {
            DataModel.ItemOnSaleDetail result = new DataModel.ItemOnSaleDetail();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnItemOnSaleInfoGet(null, ItemId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    result.ItemId = item.ItemId;
                    result.ItemOnSaleId = item.ItemOnSaleId;
                    result.ItemTitle = item.Title;
                    result.CurrencyId = item.CurrencyId;
                    result.ItemDescription = item.Description;
                    result.OnMarket = item.OnMarket;
                    result.Price = item.Price;
                    result.VariationTitle = item.VariationTitle;

                    var imageList = db.tfnItemOnSaleResourceInfoGet(result.ItemOnSaleId, result.ItemId);
                    if (imageList != null)
                    {
                        result.ImageList = new List<WizardForm.WizardInputFile>();
                        foreach (var image in imageList)
                        {
                            if (image.isMain)
                            {
                                result.MainImage = AntotoFile.getFileFromId(image.FileId);
                                result.MainImage.Selected = image.Selected;
                            }
                            else
                            {
                                var temp = AntotoFile.getFileFromId(image.FileId);
                                temp.Selected = image.Selected;
                                result.ImageList.Add(temp);
                            }
                        }
                    }

                    var BulletPointList = db.tfnItemOnSaleBulletPointInfoGet(result.ItemOnSaleId, result.ItemId);
                    if (BulletPointList != null)
                    {
                        result.BulletPointList = new List<string>();
                        foreach (var bullet in BulletPointList)
                        {
                            result.BulletPointList.Add(bullet.BulletPoint);
                        }
                    }

                    var relatedlist = db.sp_ItemRelatedListGet(0, result.ItemId, SystemLanguageId);
                    if (relatedlist != null)
                    {
                        result.RelatedItemList = new List<DataModel.ItemOnSaleDetailRelated>();
                        foreach (var related in relatedlist)
                        {
                            if (related.Selected != "Y")
                            {
                                DataModel.ItemOnSaleDetailRelated temp = new DataModel.ItemOnSaleDetailRelated();
                                temp.ItemId = related.ItemId;
                                var tempItemOnSale = db.tfnItemOnSaleInfoGet(0, related.ItemId);
                                if (tempItemOnSale != null)
                                {
                                    foreach (var temp1 in tempItemOnSale)
                                    {
                                        temp.ItemOnSaleId = temp1.ItemOnSaleId;
                                        temp.OnMarket = temp1.OnMarket;
                                        temp.VariationTitle = temp1.VariationTitle;
                                        break;
                                    }
                                }
                                temp.ItemOnSaleId = 0;
                                if (String.IsNullOrEmpty(temp.VariationTitle))
                                {
                                    temp.VariationTitle = related.VariationTitle;
                                }


                                result.RelatedItemList.Add(temp);
                            }
                        }
                    }
                    break;
                }
            }
            return result;
        }


        public static DataModel.ItemOnSaleDetail submitorupdateItemOnSale(DataModel.ItemOnSaleDetail detail, int UserId, int CompanyId, int SystemLanguageId)
        {
            DataModel.ItemOnSaleDetail result = new DataModel.ItemOnSaleDetail();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? itemOnSaleId = detail.ItemOnSaleId;
            db.sp_ItemOnSale_Create(detail.ItemId, detail.ItemTitle, detail.ItemDescription, detail.VariationTitle,
                detail.Price, detail.CurrencyId, detail.ItemTitle, UserId, ref itemOnSaleId);
            if(itemOnSaleId!=null && itemOnSaleId > 0)
            {
                detail.ItemOnSaleId = itemOnSaleId;
                db.sp_ItemOnSaleBulletPointClear(itemOnSaleId, UserId);
                db.sp_ItemOnSaleResourceClear(itemOnSaleId, UserId);
                if(detail.MainImage != null && detail.MainImage.Selected == true)
                {
                    int? itemOnSaleDetailId = 0;
                    db.sp_ItemOnSaleResourceUpdate(itemOnSaleId, 1, detail.MainImage.FileId, true,
                        0, "", "", UserId, ref itemOnSaleDetailId);
                }

                if (detail.ImageList != null)
                {
                    int i = 1;
                    foreach( var image in detail.ImageList)
                    {
                        if(image.Selected == true)
                        {
                            int? itemOnSaleDetailId = 0;
                            db.sp_ItemOnSaleResourceUpdate(itemOnSaleId, 1, image.FileId, false,
                            i, "", "", UserId, ref itemOnSaleDetailId);
                            i++;
                        }
                        
                    }
                }

                if (detail.BulletPointList != null)
                {
                    int i = 1;
                    foreach(var point in detail.BulletPointList)
                    {
                        int? itemOnSaleDetailId = 0;
                        db.sp_ItemOnSaleBulletPointUpdate(itemOnSaleId, point, i, UserId, ref itemOnSaleDetailId);
                        i++;
                    }
                }

                if(detail.RelatedItemList != null)
                {
                    foreach( var relatedItem in detail.RelatedItemList)
                    {
                        if(relatedItem.OnMarket == true)
                        {
                            DataModel.ItemOnSaleDetail temp = new DataModel.ItemOnSaleDetail();
                            temp.ItemId = relatedItem.ItemId;
                            temp.ItemOnSaleId = relatedItem.ItemOnSaleId;
                            temp.VariationTitle = relatedItem.VariationTitle;
                            temp.ItemTitle = detail.ItemTitle;
                            temp.MainImage = detail.MainImage;
                            temp.OnMarket = detail.OnMarket;
                            temp.Price = detail.Price;
                            temp.ItemDescription = detail.ItemDescription;
                            temp.ImageList = detail.ImageList;
                            temp.CurrencyId = detail.CurrencyId;
                            temp.BulletPointList = detail.BulletPointList;
                            temp.RelatedItemList = null;
                            submitorupdateItemOnSale(temp, UserId, CompanyId, SystemLanguageId);
                        }
                        
                    }
                }
            }

            return getItemOnSale(detail, UserId, CompanyId, SystemLanguageId);
        }

        public static DataModel.ItemOnSaleDetail disableItemFromMarket(DataModel.ItemOnSaleDetail detail, int UserId, int CompanyId, int SystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            DataModel.ItemOnSaleDetail result = new DataModel.ItemOnSaleDetail();
            db.sp_ItemOnSale_Disable(detail.ItemId, UserId);
            

            if (detail.RelatedItemList != null)
            {
                foreach(var relatedItem in detail.RelatedItemList)
                {
                    if(relatedItem.OnMarket == false)
                    {
                        db.sp_ItemOnSale_Disable(relatedItem.ItemId, UserId);
                    }
                    
                }
            }

            result = getItemOnSale(detail, UserId, CompanyId, SystemLanguageId);
            result.ItemOnSaleId = 0;
            return result;
        }

        public static DataModel.ResultPageResult ItemOnSaleSearchByCustomer(ParaDataModel.ParaItemOnSaleCustomerSearch itemOnSaleCustomerSearch, int pCompanyId, int pSystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? total = 0;
            int? totalPage = 0;
            int? Page = itemOnSaleCustomerSearch.Page;
            int? NextPage = 0;
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
            var list = db.sp_Customer_ItemOnSaleSearch(itemOnSaleCustomerSearch.ProductName, itemOnSaleCustomerSearch.PriceStart,
                itemOnSaleCustomerSearch.PriceEnd, pCompanyId, pSystemLanguageId
                , itemOnSaleCustomerSearch.PageSize, ref Page, ref total, ref totalPage);
            if (list != null)
            {
                NextPage = Page < totalPage ? Page + 1 : totalPage;
                foreach (var item in list)
                {
                    var currentobject = getItemOnSaleByItemId(item.ItemId, pSystemLanguageId);
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


    }


}
