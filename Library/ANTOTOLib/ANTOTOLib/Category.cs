using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public partial class Category
    {
        public static int Insert(Category pNewItem)
        {
            if (pNewItem == null)
            {
                return 0;
            }

            antoto_dbDataContext db = new antoto_dbDataContext();

            pNewItem.CreateDate = DateTime.UtcNow;

            db.Categories.InsertOnSubmit(pNewItem);
            db.SubmitChanges();

            return pNewItem.Id;
        }

        public static Category GetEntityObj(int pId)
        {
            Category Result = null;

            antoto_dbDataContext db = new antoto_dbDataContext();

            Result = (from a in db.Categories
                      where a.Id == pId
                      select a).FirstOrDefault();

            return Result;
        }

        private static IQueryable<tfnCompanyCategoryListGetResult> GetCategoryList(int CompanyId, int ParentCategoryId, int SystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();

            var result = db.tfnCompanyCategoryListGet(CompanyId, ParentCategoryId, SystemLanguageId);
            return result;
        }

        public static List<DataModel.ResultCategory> GetCompanyCategoryList(int CompanyId, int ParentCategoryId, int SystemLanguageId)
        {
            List<DataModel.ResultCategory> result = new List<DataModel.ResultCategory>();
            var list = GetCategoryList(CompanyId, ParentCategoryId, SystemLanguageId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    DataModel.ResultCategory current = new DataModel.ResultCategory();
                    current.CategoryId = item.CategoryId;
                    current.CategoryName = item.Name;
                    current.CategoryLevel = item.Level;
                    current.Order = item.OrderCode;
                    current.ParentCategoryId = item.ParentCategoryId;
                    current.FinalLevel = item.FinalLevel;
                    result.Add(current);
                }
            }
            return result;
        }
        
        public static List<DataModel.ResultCategory> getCategoryIdListFromName(int CompanyId, string CategorySearch, int SystemLanguageId)
        {
            List<DataModel.ResultCategory> result = new List<DataModel.ResultCategory>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnCompanyCategoryListGetByName(CompanyId, CategorySearch, SystemLanguageId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    DataModel.ResultCategory current = new DataModel.ResultCategory();
                    current.CategoryName = item.Name;
                    result.Add(current);
                }
            }
            return result;
        }


        
    }
}
