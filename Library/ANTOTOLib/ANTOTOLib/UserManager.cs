using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static ANTOTOLib.DataModel;

namespace ANTOTOLib
{
    public class UserManager
    {
        public static ResultToken login(string loginName, string password, int SystemLanguageId)
        {
            DataModel.User result = null;
            antoto_dbDataContext db = new antoto_dbDataContext();
            string realPwd = StringCipher.HashPassword(password);
            var list = db.sp_UserLogin(loginName, realPwd);
            if(list!=null)
            {
                var companyList = new List<CompanyRole>();
                int UserId = 0;
                foreach(var item in list)
                {
                    if (result == null)
                    {
                        result = new User();
                    }
                    UserId = item.UserId.Value;
                    CompanyRole role = new CompanyRole();
                    role.CompanyId = item.CompanyId.Value;
                    role.CompanyName = item.CompanyName;
                    if (item.isDefault.Value)
                    {
                        result.DefaultCompanyId = item.CompanyId.Value;
                    }
                    role.Role = CompanySecurity.getRoleDetail(item.RoleId.Value, item.CompanyId.Value, item.UserId.Value);
                    companyList.Add(role);
                }
                if(UserId > 0)
                {
                    result = GetUser(UserId);
                    if(result!= null)
                    {
                        result.companyList = companyList;
                    }
                }
            }
            if(result== null)
            {
                list = db.sp_UserLogin(loginName, password);
                if (list != null)
                {
                    var companyList = new List<CompanyRole>();
                    int UserId = 0;
                    foreach (var item in list)
                    {
                        if(result == null)
                        {
                            result = new User();
                        }
                        UserId = item.UserId.Value;
                        CompanyRole role = new CompanyRole();
                        role.CompanyId = item.CompanyId.Value;
                        role.CompanyName = item.CompanyName;
                        if (item.isDefault.Value)
                        {
                            result.DefaultCompanyId = item.CompanyId.Value;
                        }
                        role.Role = CompanySecurity.getRoleDetail(item.RoleId.Value, item.CompanyId.Value, item.UserId.Value);
                        companyList.Add(role);
                    }
                    if (UserId > 0)
                    {
                        result = GetUser(UserId);
                        if (result != null)
                        {
                            result.companyList = companyList;
                        }
                    }
                }
            }
            if(result == null)
            {
                return null;
            }
            var userSession =  UserSession.Create(result.UserId, result.DefaultCompanyId, 60 * 60 * 30, SystemLanguageId);
            if(userSession != null)
            {
                ResultToken temp = new ResultToken();
                temp.Token = userSession.Token;
                return temp;
            }
            else
            {
                return null;
            }
        }

        public static User GetUser(int pUserId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            User result = new User();
            var list = db.tfnUserProfileGet(pUserId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    result.UserId = pUserId;
                    result.FirstName = item.FirstName;
                    result.LastName = item.LastName;
                    result.Email = item.Email;
                    result.LoginName = item.LoginName;
                    result.Password = "";
                    result.Available = item.Available;
                    result.Address = new UtilityClasses.Address();
                    result.Address.Address1 = item.Address1;
                    result.Address.Address2 = item.Address2;
                    result.Address.AddressId = item.AddressId;
                    result.Address.City = item.City;
                    result.Address.State = item.State;
                    result.Address.District = item.District;
                    result.Address.CountryId = item.CountryId;
                    result.Address.Zip = item.Zip;
                    result.PhoneNumber = new UtilityClasses.PhoneNumber();
                    result.PhoneNumber.CountryId = item.CountryId;
                    result.PhoneNumber.PhoneNumberId = item.PhoneNumberId;
                    result.PhoneNumber.Phonenumber = item.PhoneNumber;
                    break;
                }
            }
            return result;
        }
        
    }
}
