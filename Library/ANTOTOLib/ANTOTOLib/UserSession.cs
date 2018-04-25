using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static ANTOTOLib.DataModel;

namespace ANTOTOLib
{
    public class UserSession
    {
        public int ExpireSeconds { get; set; }
        public int UserId { get; set; }
        public int SystemLanguageId { get; set; }
        public int CompanyId { get; set; }
        public string Token { get; set; }
        public static UserSession Create(int UserId, int CompanyId, int ExpireSeconds, int SystemLanguageId)
        {
            UserSession result = new UserSession();
            antoto_dbDataContext db = new antoto_dbDataContext();
            string pToken = "";
            int? UserSessionId = 0;
            db.sp_UserSession_Create(UserId, ExpireSeconds, SystemLanguageId, CompanyId, UserId, 1, ref UserSessionId, ref pToken);
            if (String.IsNullOrEmpty(pToken))
            {
                return null;
            }
            result.UserId = UserId;
            result.ExpireSeconds = ExpireSeconds;
            result.SystemLanguageId = SystemLanguageId;
            result.CompanyId = CompanyId;
            result.Token = pToken;
            return result;

        }

        public static UserSession Validate(string Token)
        {
            UserSession result = new UserSession();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_UserSession_Validate(Token);
            if (list != null)
            {
                foreach(var item in list)
                {
                    result.UserId = item.UserId;
                    result.CompanyId = item.CompanyId;
                    result.SystemLanguageId = item.SystemLanguageId;
                    break;
                }
            }
            if(result.UserId == 0)
            {
                return null;
            }
            else
            {
                return result;
            }
        }
    }
}
