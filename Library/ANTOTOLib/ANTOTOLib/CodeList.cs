using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public partial class CodeList
    {
        

        private static tfnCodeListResult GetEntityObject(int pSystemLanguageId, string pCategory, int pCodeId, bool pCached)
        {
            tfnCodeListResult result = null;
            antoto_dbDataContext db = new antoto_dbDataContext();
            var query = from a in db.tfnCodeList(pSystemLanguageId, pCategory)
                        orderby a.SortOrder
                        where a.CodeId == pCodeId
                        select a;
            foreach (var item in query)
            {
                result = item;
                break;
            }

            return result;
        }

        public static tfnCodeListResult GetEntityObject(int pSystemLanguageId, string pCategory, int pCodeId)
        {
            tfnCodeListResult result = GetEntityObject(pSystemLanguageId, pCategory, pCodeId, false);

            return result;
        }
        public static IQueryable<tfnCodeListResult> CodeListGet(int pSystemLanguageId, string pCategory)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();

            IQueryable<tfnCodeListResult> list = from a in db.tfnCodeList(pSystemLanguageId, pCategory)
                                                 orderby a.SortOrder
                                                 where a.CodeId > 0
                                                    && a.Available == true
                                                 select a;

            return list;
        }

        public static IQueryable<tfnCodeListResult> CodeListGet_All(int pSystemLanguageId, string pCategory)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();

            IQueryable<tfnCodeListResult> list = from a in db.tfnCodeList(pSystemLanguageId, pCategory)
                                                 orderby a.SortOrder
                                                 select a;

            return list;
        }

        public static bool Validate(string pCategory, int pCodeId)
        {
            bool result = false;

            antoto_dbDataContext db = new antoto_dbDataContext();

            IQueryable<tfnCodeListResult> list = from a in db.tfnCodeList(1, pCategory)
                                                 where a.Available == true && a.CodeId == pCodeId
                                                 select a;

            if (list.Count<tfnCodeListResult>() > 0)
            {
                result = true;
            }

            return result;
        }
    }


}
