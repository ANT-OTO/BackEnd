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
            int defaultCompanyId = 0;
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
                    result.DefaultCompanyId = item.CompanyId.Value;
                    if (item.isDefault.Value)
                    {
                        defaultCompanyId = item.CompanyId.Value;
                        break;
                    }
                }
                if(UserId > 0)
                {
                    result = GetUser(UserId, 0);
                    
                }
            }
            if(result== null)
            {
                list = db.sp_UserLogin(loginName, password);
                if (list != null)
                {
                    int UserId = 0;
                    foreach (var item in list)
                    {
                        if(result == null)
                        {
                            result = new User();
                        }
                        UserId = item.UserId.Value;
                        result.UserId = UserId;
                        result.DefaultCompanyId = item.CompanyId.Value;
                        if (item.isDefault.Value)
                        {
                            defaultCompanyId = item.CompanyId.Value;
                            break;
                        }
                    }
                    if (UserId > 0)
                    {
                        result = GetUser(UserId, 0);

                    }

                }
            }
            if(result == null || defaultCompanyId == 0)
            {
                return null;
            }

            var userSession =  UserSession.Create(result.UserId, defaultCompanyId, 60 * 60 * 30, SystemLanguageId);
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
        public static User GetUser(int pUserId, int pCompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            User result = new User();
            var list = db.tfnUserProfileGet(pUserId);
            if (list != null)
            {
                foreach (var item in list)
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
                    result.PhoneNumber.Number = item.PhoneNumber;
                    break;
                }
            }
            if (result.UserId != 0)
            {
                var list2 = db.tfnUserCompanyListGet(pUserId);
                if (list2 != null && list2.Count() > 0)
                {
                    result.companyList = new List<CompanyRole>();
                    foreach (var item in list2)
                    {
                        CompanyRole role = new CompanyRole();
                        role.CompanyId = item.CompanyId.Value;
                        role.CompanyName = item.CompanyName;
                        if (role.CompanyId == pCompanyId)
                        {
                            result.DefaultCompanyId = item.CompanyId.Value;
                        }
                        role.Role = CompanySecurity.getRoleDetail(item.RoleId.Value, item.CompanyId.Value, pUserId);
                        result.companyList.Add(role);
                    }
                }
            }
            return result;
        }
        public static DataModel.User GetUserOnlyInCompany(int pUserId, int pCompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            DataModel.User result = new DataModel.User();
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
                    result.PhoneNumber.CountryId = item.PhoneNumberCountryId;
                    result.PhoneNumber.PhoneNumberId = item.PhoneNumberId;
                    result.PhoneNumber.Number = item.PhoneNumber;
                    break;
                }
            }
            if(result.UserId != 0)
            {
                var list2 = db.tfnUserCompanyListGet(pUserId);
                if (list2 != null && list2.Count() > 0)
                {
                    result.companyList = new List<CompanyRole>();
                    foreach(var item in list2)
                    {
                        CompanyRole role = new CompanyRole();
                        role.CompanyId = item.CompanyId.Value;
                        role.CompanyName = item.CompanyName;
                        if (role.CompanyId == pCompanyId)
                        {
                            result.DefaultCompanyId = item.CompanyId.Value;
                        }
                        role.Role = CompanySecurity.getRoleDetail(item.RoleId.Value, item.CompanyId.Value, pUserId);
                        if(role.CompanyId == pCompanyId)
                        {
                            result.companyList.Add(role);
                            break;
                        }
                    }
                }
            }
            return result;
        }

        public static DataModel.User CreateUser(ParaDataModel.ParaUserCreateUpdate user, int pUpdateUserId, int pCompanyId, ref string pError)
        {
            if(user.UserId != null && user.UserId > 0)
            {
                return null;
            }
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? UserId = 0;
            db.sp_User_Create(ref UserId, user.RoleId, user.FirstName, user.LastName, user.Email,
                user.LoginName, String.IsNullOrEmpty(user.Password) ? null : StringCipher.HashPassword(user.Password),
                user.PhoneNumber, user.PhoneCountryId, user.Address1, user.Address2, user.City,
                user.State, user.Zip, user.CountryId, pUpdateUserId, pCompanyId, user.Available,
                ref pError);
            if(UserId != null && UserId > 0)
            {
                DataModel.User result = new User();
                result = GetUser(UserId.Value, pCompanyId);
                result.DefaultCompanyId = 0;
                result.companyList = null;
                return result;
            }
            else
            {
                return null;
            }
        }

        public static DataModel.User UpdateUser(ParaDataModel.ParaUserCreateUpdate user, int pUpdateUserId, int pCompanyId, ref string pError)
        {
            if (user.UserId == null || user.UserId == 0)
            {
                return null;
            }
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? UserId = user.UserId;
            db.sp_User_Create(ref UserId, user.RoleId, user.FirstName, user.LastName, user.Email,
                user.LoginName, String.IsNullOrEmpty(user.Password) ? null : StringCipher.HashPassword(user.Password),
                user.PhoneNumber, user.PhoneCountryId, user.Address1, user.Address2, user.City,
                user.State, user.Zip, user.CountryId, pUpdateUserId, pCompanyId, user.Available,
                ref pError);
            if (UserId != null && UserId > 0)
            {
                DataModel.User result = new User();
                result = GetUser(UserId.Value, pCompanyId);
                result.DefaultCompanyId = 0;
                result.companyList = null;
                return result;
            }
            else
            {
                return null;
            }
        }

        public static DataModel.ResultPageResult getUserList(DataModel.ParaUserSearch userSearch, int pCompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? total = 0;
            int? totalPage = 0;
            int? Page = userSearch.Page;
            int? NextPage = 0;
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
            var list = db.sp_User_Search(userSearch.FirstName, userSearch.LastName, userSearch.RoleId,
                            userSearch.Email, pCompanyId, userSearch.Available, userSearch.PageSize,
                            ref Page, ref total, ref totalPage);
            if (list != null)
            {
                NextPage = Page < totalPage ? Page + 1 : totalPage;
                foreach (var item in list)
                {
                    var currentobject = new DataModel.User
                    {
                        FirstName = item.FirstName,
                        LastName = item.LastName,
                        Email = item.Email,
                        UserId = item.Id,
                        LoginName = item.LoginName
                    };
                    if(result.records == null)
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
