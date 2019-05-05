using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public partial class CategoryBrand
    {
        public static int Insert(CategoryBrand pNewItem)
        {
            if (pNewItem == null)
            {
                return 0;
            }

            antoto_dbDataContext db = new antoto_dbDataContext();

            pNewItem.CreateDate = DateTime.UtcNow;

            db.CategoryBrands.InsertOnSubmit(pNewItem);
            db.SubmitChanges();

            return pNewItem.Id;
        }

        public static CategoryBrand GetEntityObj(int pId)
        {
            CategoryBrand Result = null;

            antoto_dbDataContext db = new antoto_dbDataContext();

            Result = (from a in db.CategoryBrands
                      where a.Id == pId
                      select a).FirstOrDefault();

            return Result;
        }

        public static List<CategoryBrand> GetEntityObjListByCategoryId(int CategoryId)
        {
            List<CategoryBrand> Result = null;

            antoto_dbDataContext db = new antoto_dbDataContext();

            Result = (from a in db.CategoryBrands
                      where a.CategoryId == CategoryId
                      && a.Available == true
                      select a).ToList();

            return Result;
        }

        public static List<CategoryBrand> GetEntityObjListByBrandId(int BrandId)
        {
            List<CategoryBrand> Result = null;

            antoto_dbDataContext db = new antoto_dbDataContext();

            Result = (from a in db.CategoryBrands
                      where a.BrandId == BrandId
                      && a.Available == true
                      select a).ToList();

            return Result;
        }

        public static IQueryable<tfnCompanyCategoryBrandRelationListGetResult> GetCompanyCategoryBrandList(int SystemLanguageId, int CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            var result = db.tfnCompanyCategoryBrandRelationListGet(CompanyId, 0, 0, SystemLanguageId);
            return result;
        }

        private static IQueryable<tfnCompanyCategoryBrandRelationListGetResult> GetCompanyBrandListFromCategoryId(int CompanyId, int CategoryId, int SystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            var result = db.tfnCompanyCategoryBrandRelationListGet(CompanyId, CategoryId, 0, SystemLanguageId);
            return result;
        }

        public static IQueryable<tfnCompanyCategoryBrandRelationListGetResult> GetCompanyCategoryListFromBrandId(int SystemLanguageId, int CompanyId, int BrandId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            var result = db.tfnCompanyCategoryBrandRelationListGet(CompanyId, 0, BrandId, SystemLanguageId);
            return result;
        }

        public static List<DataModel.ResultBrand> getBrandListByCategoryId(int CompanyId, int CategoryId, int SystemLanguageId)
        {
            List<DataModel.ResultBrand> result = new List<DataModel.ResultBrand>();
            var list = GetCompanyBrandListFromCategoryId(CompanyId, CategoryId, SystemLanguageId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    DataModel.ResultBrand brand = new DataModel.ResultBrand();
                    brand.BrandId = item.BrandId;
                    brand.BrandName = item.BrandName;
                    brand.BrandDescription = item.BrandDescription;
                    result.Add(brand);
                }
            }
            return result;
        }

        public static DataModel.ResultCategorySearchList getCategorySearch(ParaDataModel.ParaCategorySearch paraCategorySearch, int SystemLanguageId, int CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            DataModel.ResultCategorySearchList result = new DataModel.ResultCategorySearchList();
            int? page = 0;
            int? total = 0;
            int? totalpage = 0;
            var list = db.sp_CategorySearch(paraCategorySearch.CategorySearchWord, CompanyId, SystemLanguageId, 10, ref page, ref total, ref totalpage);
            if( total > 0 && list != null )
            {
                foreach(var item in list)
                {
                    if(result.records == null)
                    {
                        result.records = new List<DataModel.ResultCategorySearch>();
                    }
                    DataModel.ResultCategorySearch temp = new DataModel.ResultCategorySearch();
                    temp.FinalCategory = new DataModel.ResultCategory();
                    temp.FinalCategory.CategoryId = item.Id;
                    temp.FinalCategory.CategoryName = item.Name;
                    var tempList = db.tfnCompanyCategoryListGetByCategoryId(CompanyId, item.Id, SystemLanguageId);
                    if (tempList != null)
                    {
                        var categoryList = new List<DataModel.ResultCategory>();
                        foreach( var item2 in tempList)
                        {
                            if(item2.Selected == true)
                            {
                                var temp2 = new DataModel.ResultCategory();
                                temp2.CategoryId = item2.CategoryId;
                                temp2.CategoryLevel = item2.Level;
                                temp2.CategoryName = item2.Name;
                                temp2.FinalLevel = item2.FinalLevel;
                                temp2.Order = item2.OrderCode;
                                temp2.ParentCategoryId = item2.ParentCategoryId;
                                categoryList.Add(temp2);
                            }
                        }
                        temp.CategoryTraceList = categoryList.OrderBy(o => o.CategoryLevel).ToList();
                    }
                    result.records.Add(temp);
                }
                
            }
            return result;
        }

        

        
    }
}
