using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public partial class Brand
    {
        public static int Insert(Brand pNewItem)
        {
            if (pNewItem == null)
            {
                return 0;
            }

            antoto_dbDataContext db = new antoto_dbDataContext();

            pNewItem.CreateDate = DateTime.UtcNow;

            db.Brands.InsertOnSubmit(pNewItem);
            db.SubmitChanges();

            return pNewItem.Id;
        }

        public static Brand GetEntityObj(int pId)
        {
            Brand Result = null;

            antoto_dbDataContext db = new antoto_dbDataContext();

            Result = (from a in db.Brands
                      where a.Id == pId
                      select a).FirstOrDefault();

            return Result;
        }

        public static Brand GetEntityObj(string BrandName)
        {
            Brand Result = null;

            antoto_dbDataContext db = new antoto_dbDataContext();

            Result = (from a in db.Brands
                      where a.BrandName == BrandName
                      select a).FirstOrDefault();

            return Result;
        }

        public static IQueryable<tfnCompanyBrandListGetResult> getCompanyBrandList(int CompanyId, int SystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            var result = db.tfnCompanyBrandListGet(CompanyId, SystemLanguageId);
            return result;
        }

        public static void getCompanyBrandRequestList(int CompanyId, int SystemLanguageId)
        {

        }

        public static void getCompanyBrandRequestInputTemplate(int CompanyId, int CompanyBrandRequestApplicationTypeId)
        {

        }

        public static void submitCompanyBrandRequest()
        {

        }

        public static List<Brand> getCompanyBrandListByName(int CompanyId)
        {
            return null;
        }

        public static DataModel.ResultBrand BrandCreate(ParaDataModel.ParaBrandCreate paraBrandCreate, int UserId, int CompanyId)
        {
            int? result1 = paraBrandCreate.BrandId;
            var result = new DataModel.ResultBrand();
            antoto_dbDataContext db = new antoto_dbDataContext();
            db.sp_Brand_Insert(paraBrandCreate.BrandName, paraBrandCreate.BrandDescription, paraBrandCreate.CategoryId,
                CompanyId, true, ref result1, UserId, 1);
            if(result1 != null&& result1 > 0)
            {
                result.BrandId = result1;
                result.BrandName = paraBrandCreate.BrandName;
                result.BrandDescription = paraBrandCreate.BrandDescription;
                return result;
            }
            else
            {
                return null;
            }
        }

        public static int BrandDelete(ParaDataModel.ParaBrandCreate paraBrandCreate, int UserId, int CompanyId)
        {
            int? result1 = paraBrandCreate.BrandId;
            var result = new DataModel.ResultBrand();
            antoto_dbDataContext db = new antoto_dbDataContext();
            db.sp_Brand_Insert(paraBrandCreate.BrandName, paraBrandCreate.BrandDescription, paraBrandCreate.CategoryId,
                CompanyId, false, ref result1, UserId, 1);
            if (result1 != null && result1 > 0)
            {
                return result1.Value;
            }
            else
            {
                return 0;
            }
        }

        public static DataModel.ResultPageResult BrandSearch(ParaDataModel.ParaBrandSearch search, int UserId, int CompanyId, int SystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? Page = search.Page;
            int? Total = 0;
            int? TotalPages = 0;
            int? NextPage = 0;
            var list = db.sp_BrandSearch(search.BrandSearchWord, CompanyId, SystemLanguageId,
                search.PageSize, ref Page, ref Total, ref TotalPages);
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();

            if (list != null)
            {
                NextPage = Page < TotalPages ? Page + 1 : TotalPages;
                foreach (var item in list)
                {
                    if (result.records == null)
                    {
                        result.records = new List<object>();
                    }

                    var current = new DataModel.ResultBrandSearchItem()
                    {
                        BrandId = item.Id,
                        Name = item.BrandName,
                        CategoryId = item.CategoryId,
                        CategoryName = item.CategoryName,
                        Description = item.BrandDescription,
                        SystemBrand = item.SystemBrand
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
    }
}
