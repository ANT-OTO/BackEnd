using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static ANTOTOLib.DataModel;

namespace ANTOTOLib
{
    public partial class Company
    {
        public class CompanyInfo
        {
            public int? CompanyId { get; set; }

            public string CompanyCode { get; set; }

            public string CompanyName { get; set; }

            public string CompanyDescription { get; set; }
        }

        public static CompanyInfo getCompanyInfoByCode(string CompanyCode)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            CompanyInfo result = null;
            var list = db.tfnCompanyGetByCode(CompanyCode);
            if (list != null)
            {
                foreach(var item in list)
                {
                    result = new CompanyInfo();
                    result.CompanyId = item.CompanyId;
                    result.CompanyCode = item.CompanyCode;
                    result.CompanyName = item.CompanyName;
                    result.CompanyDescription = item.CompanyDescription;
                    break;
                }
            }
            return result;
        }

        public static CompanyInfo getCompanyInfoById (int CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            CompanyInfo result = null;
            var list = db.tfnCompanyGetById(CompanyId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    result = new CompanyInfo();
                    result.CompanyId = item.CompanyId;
                    result.CompanyCode = item.CompanyCode;
                    result.CompanyName = item.CompanyName;
                    result.CompanyDescription = item.CompanyDescription;
                    break;
                }
            }
            return result;
        }

        public class CompanyFromAddress
        {
            public string ContactName { get; set; }
            public string ContactLastName { get; set; }
            public string ContactPhoneNumber { get; set; }
            public int? ContactPhoneCountryId { get; set; }
            public string Address1 { get; set; }
            public string Address2 { get; set; }
            public string City { get; set; }
            public string State { get; set; }
            public string Zip { get; set; }
            public int? CountryId { get; set; }
            public bool? DefaultShipping { get; set; }
            public bool? Available { get; set; }
            public int? CompanyFromAddressId { get; set; }
            public int? CompanyId { get; set; }
        }

        public static List<CompanyFromAddress> GetCompanyFromAddressList(int CompanyId)
        {
            List<CompanyFromAddress> result = new List<CompanyFromAddress>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnCompanyAddressGet(CompanyId);
            if (list != null) 
            {
                foreach (var item in list)
                {
                    CompanyFromAddress temp = new CompanyFromAddress();
                    temp.CompanyFromAddressId = item.CompanyFromAddressId;
                    temp.CompanyId = item.CompanyId;
                    temp.State = item.State;
                    temp.Zip = item.Zip;
                    temp.CountryId = item.CountryId;
                    temp.ContactPhoneNumber = item.ContactPersonPhoneNumber;
                    temp.ContactPhoneCountryId = item.ContactPersonPhoneNumberCountryId;
                    temp.ContactName = item.ContactPersonFirstName;
                    temp.ContactLastName = item.ContactPersonLastName;
                    temp.City = item.City;
                    temp.Address2 = item.Address2;
                    temp.Address1 = item.Address1;
                    temp.DefaultShipping = item.DefaultShipping;
                    result.Add(temp);
                }
            }
            return result;
        }

        public static CompanyFromAddress GetCompanyFromAddressById(int CustomerAddressId)
        {
            CompanyFromAddress result = new CompanyFromAddress();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnCompanyAddressGetById(CustomerAddressId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    result.CompanyFromAddressId = item.CompanyFromAddressId;
                    result.CompanyId = item.CompanyId;
                    result.State = item.State;
                    result.Zip = item.Zip;
                    result.CountryId = item.CountryId;
                    result.ContactPhoneNumber = item.ContactPersonPhoneNumber;
                    result.ContactPhoneCountryId = item.ContactPersonPhoneNumberCountryId;
                    result.ContactName = item.ContactPersonFirstName;
                    result.ContactLastName = item.ContactPersonLastName;
                    result.City = item.City;
                    result.Address2 = item.Address2;
                    result.Address1 = item.Address1;
                    result.DefaultShipping = item.DefaultShipping;
                    break;
                }
            }
            return result;
        }

        public static CompanyFromAddress companyFromAddressCreateUpdate(CompanyFromAddress companyFromAddress, int? CompanyId, int? UserId)
        {
            CompanyFromAddress result = null;
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? CompanyFromAddressId = companyFromAddress.CompanyFromAddressId == null ? 0 : companyFromAddress.CompanyFromAddressId;
            db.sp_CompanyFromAddressSubmitUpdate(CompanyId, companyFromAddress.ContactName, companyFromAddress.ContactLastName,
                companyFromAddress.ContactPhoneNumber, companyFromAddress.ContactPhoneCountryId, companyFromAddress.Address1,
                companyFromAddress.Address2, companyFromAddress.City, companyFromAddress.State, companyFromAddress.Zip,
                companyFromAddress.CountryId, companyFromAddress.DefaultShipping, companyFromAddress.Available, UserId, ref CompanyFromAddressId);
            if (CompanyFromAddressId > 0)
            {
                result = GetCompanyFromAddressById(CompanyFromAddressId.Value);
            }
            return result;

        }

        public static List<ShippingOrder.ShippingChannel> getAvailableShippingChannelList(int CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            List<ShippingOrder.ShippingChannel> result = new List<ShippingOrder.ShippingChannel>();
            var list = db.tfnCompanyShippingChannelListGet(CompanyId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    ShippingOrder.ShippingChannel temp = new ShippingOrder.ShippingChannel();
                    temp.ShippingChannelId = item.ShippingChannelId;
                    temp.ShippingChannelName = item.ShippingChannelName;
                    temp.ShippingChannelCode = item.ShippingChannelCode;
                    result.Add(temp);
                }
            }
            return result;
        }

        public static ParaDataModel.ParaLogisticCompany LogisticCustomerCompanySetup(ParaDataModel.ParaLogisticCompany CompanyUser, int? CompanyId, int? UserId)
        {
            ParaDataModel.ParaLogisticCompany result = new ParaDataModel.ParaLogisticCompany();

            antoto_dbDataContext db = new antoto_dbDataContext();

            int? CustomerCompanyId = 0;

            db.sp_LogisticCompanyUserCreate(CompanyId, CompanyUser.CompanyName, CompanyUser.FirstName, CompanyUser.LastName,
                CompanyUser.CustomerCode, CompanyUser.PhoneNumber, CompanyUser.PhoneNumberCountryId, CompanyUser.Email, CompanyUser.Fax,
                CompanyUser.Address1, CompanyUser.Address2, CompanyUser.City, CompanyUser.District, CompanyUser.State,
                CompanyUser.Zip, CompanyUser.CountryId, CompanyUser.LoginName, StringCipher.HashPassword(CompanyUser.Password),
                ref CustomerCompanyId, UserId);

            result = GetLogisticCompanyInfo(CustomerCompanyId);
            
            return result;
        }

        public static ParaDataModel.ParaLogisticCompany LogisticCustomerCompanyUpdate(ParaDataModel.ParaLogisticCompany CompanyUser, int? CompanyId, int? UserId)
        {
            ParaDataModel.ParaLogisticCompany result = new ParaDataModel.ParaLogisticCompany();

            antoto_dbDataContext db = new antoto_dbDataContext();

            int? CustomerCompanyId = CompanyUser.CompanyId;

            db.sp_LogisticCompanyUserUpdate(CompanyId, CompanyUser.CompanyName, CompanyUser.FirstName, CompanyUser.LastName,
                CompanyUser.CustomerCode, CompanyUser.PhoneNumber, CompanyUser.PhoneNumberCountryId, CompanyUser.Email, CompanyUser.Fax,
                CompanyUser.Address1, CompanyUser.Address2, CompanyUser.City, CompanyUser.District, CompanyUser.State,
                CompanyUser.Zip, CompanyUser.CountryId, CompanyUser.LoginName, StringCipher.HashPassword(CompanyUser.Password), CompanyUser.Available,
                ref CustomerCompanyId, UserId);

            result = GetLogisticCompanyInfo(CustomerCompanyId);

            return result;
        }

        public static ParaDataModel.ParaLogisticCompany GetLogisticCompanyInfo(int? CompanyId)
        {
            ParaDataModel.ParaLogisticCompany result = new ParaDataModel.ParaLogisticCompany();

            antoto_dbDataContext db = new antoto_dbDataContext();

            var list = db.tfnLogisticCompanyInfoGet(CompanyId);

            if (list != null)
            {
                foreach(var item in list)
                {
                    result.CompanyId = item.CompanyId;
                    result.CompanyName = item.CompanyName;
                    result.CustomerCode = item.CompanyCode;
                    result.City = item.City;
                    result.Address1 = item.Address1;
                    result.Address2 = item.Address2;
                    result.CountryId = item.CountryId;
                    result.District = item.District;
                    result.Email = item.Email;
                    result.Fax = item.Fax;
                    result.FirstName = item.ContactFirstName;
                    result.LastName = item.ContactLastName;
                    result.LoginName = item.UserLoginName;
                    result.PhoneNumber = item.PhoneNumber;
                    result.PhoneNumberCountryId = item.PhoneNumberCountryId;
                    result.State = item.State;
                    result.Zip = item.Zip;
                    break;
                }
            }

            return result;
        }

        public static ResultPageResult LogisticCompanyListSearch(ParaDataModel.ParaLogisticCompanySearch CompanySearch, int? CompanyId, int? UserId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? total = 0;
            int? totalPage = 0;
            int? Page = CompanySearch.Page;
            int? NextPage = 0;
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
            var list = db.sp_CompanyLogisticCompanySearch(CompanySearch.Name, CompanySearch.CustomerCode, CompanySearch.Email,
                UserId, CompanyId, CompanySearch.PageSize, ref Page, ref total, ref totalPage);
            if (list != null)
            {
                NextPage = Page < totalPage ? Page + 1 : totalPage;
                foreach (var item in list)
                {
                    var currentobject = new ParaDataModel.ParaLogisticCompany
                    {
                        CompanyId = item.CompanyId,
                        CompanyName = item.CompanyName,
                        CustomerCode = item.CompanyCode,
                        City = item.City,
                        Address1 = item.Address1,
                        Address2 = item.Address2,
                        CountryId = item.CountryId,
                        District = item.District,
                        Email = item.Email,
                        Fax = item.Fax,
                        FirstName = item.ContactFirstName,
                        LastName = item.ContactLastName,
                        LoginName = item.UserLoginName,
                        PhoneNumber = item.PhoneNumber,
                        PhoneNumberCountryId = item.PhoneNumberCountryId,
                        State = item.State,
                        Zip = item.Zip,
                        Available = item.Available
                    };
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
        
        public static ParaDataModel.ParaLogisticCompany LogisticCompanyListSearchOne(string CompanyCode, int? CompanyId, int? UserId)
        {
            ParaDataModel.ParaLogisticCompany result = new ParaDataModel.ParaLogisticCompany();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? total = 0;
            int? totalPage = 0;
            int? Page = 1;
            int? NextPage = 0;
            var list = db.sp_CompanyLogisticCompanySearch("", CompanyCode, "",
                UserId, CompanyId, 1, ref Page, ref total, ref totalPage);
            if (list != null)
            {
                NextPage = Page < totalPage ? Page + 1 : totalPage;
                foreach (var item in list)
                {
                    var currentobject = new ParaDataModel.ParaLogisticCompany
                    {
                        CompanyId = item.CompanyId,
                        CompanyName = item.CompanyName,
                        CustomerCode = item.CompanyCode,
                        City = item.City,
                        Address1 = item.Address1,
                        Address2 = item.Address2,
                        CountryId = item.CountryId,
                        District = item.District,
                        Email = item.Email,
                        Fax = item.Fax,
                        FirstName = item.ContactFirstName,
                        LastName = item.ContactLastName,
                        LoginName = item.UserLoginName,
                        PhoneNumber = item.PhoneNumber,
                        PhoneNumberCountryId = item.PhoneNumberCountryId,
                        State = item.State,
                        Zip = item.Zip,
                        Available = item.Available
                    };
                    result = currentobject;
                    break;
                }
            }
            return result;
        }
    }
}
