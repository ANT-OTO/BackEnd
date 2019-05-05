using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public class CustomerManager
    {
        public class Customer
        {
            public int? CustomerId { get; set; }
            public string FirstName { get; set; }
            public string LastName { get; set; }
            public string PhoneNumber { get; set; }
            public int? CountryId { get; set; }
            public string NickName { get; set; }
            public string LoginName { get; set; }
            public string Password { get; set; }
            public string Email { get; set; }
            public bool? Available { get; set; }
            public List<CustomerCompany> CompanyList { get; set; }
            public ThridPartyLoginInfo ThirdPartyInfo { get; set; }
            public List<CustomerAddress> AddressList { get; set; }
        }

        public class CustomerCompany
        {
            public int? CompanyId { get; set; }
            public string CompanyName { get; set; }
            public string CompanyCode { get; set; }
            public bool? IsDefault { get; set; }
        }

        public class IdentityImage
        {
            public int? FileId { get; set; }

            public string FileExt { get; set; }

            public string FileLink { get; set; }

            public string MFileLink { get; set; }

            public string SFileLink { get; set; }

            public string FileDescription { get; set; }
        }

        public class ThridPartyLoginInfo
        {
            public int? CustomerTypeCodeId { get; set; }
            public string ThirdPartyId { get; set; }
            public string NickName { get; set; }
            public string AvatarUrl { get; set; }
            public string Gender { get; set; }

        }

        public static DataModel.ResultToken CustomerLogin(ParaDataModel.ParaCustomerLogin loginInfo)
        {
            DataModel.ResultToken result = new DataModel.ResultToken();
            antoto_dbDataContext db = new antoto_dbDataContext();
            string wechatId = "";
            string alibabaId = "";
            if (loginInfo.CustomerTypeCodeId == 1)
            {
                alibabaId = loginInfo.OpenId;
            }
            if (loginInfo.CustomerTypeCodeId == 2)
            {
                wechatId = loginInfo.OpenId;
            }
            int? CustomerSessionId = 0;
            string Token = "";
            db.sp_CustomerLogin(loginInfo.LoginName, StringCipher.HashPassword(loginInfo.Password),
                wechatId, alibabaId, loginInfo.NickName, loginInfo.SystemLanguageId, 3600, loginInfo.CompanyCode, ref CustomerSessionId, ref Token);
            if (CustomerSessionId > 0)
            {
                result.Token = Token;

                return result;
            }
            else
            {
                return null;
            }
        }

        public class CustomerSesison
        {
            public int? CustomerId { get; set; }
            public int? CompanyId { get; set; }
            public int? SystemLanguageId { get; set; }
        }

        public static CustomerSesison getCustomerByToken(string Token)
        {
            CustomerSesison result = null;
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_CustomerSession_Validate(Token);
            if (list != null)
            {
                foreach (var item in list)
                {
                    if (result == null)
                    {
                        result = new CustomerSesison();
                    }
                    result.CustomerId = item.CustomerId;
                    result.CompanyId = item.CompanyId;
                    result.SystemLanguageId = item.SystemLanguageId;
                    break;
                }
            }
            return result;
        }

        public static Customer getCustomerById(int? CustomerId)
        {
            Customer result = new Customer();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_CustomerGet(CustomerId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    result.FirstName = item.FirstName;
                    result.LastName = item.LastName;
                    result.LoginName = item.LoginName;
                    result.NickName = item.NickName;
                    result.PhoneNumber = item.PhoneNumber;
                    result.CustomerId = item.Id;
                    result.CountryId = item.CountryId;
                    result.AddressList = GetCustomerAddressList(result.CustomerId.Value);
                    result.CompanyList = getCustomerCompanyList(result.CustomerId.Value);
                    break;
                }
            }
            if (result.CustomerId != null)
            {
                return result;
            }
            else
            {
                return null;
            }
        }

        public class CustomerAddress
        {
            public int? CustomerId { get; set; }
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
            public string IDNumber { get; set; }
            public bool? DefaultShipping { get; set; }
            public bool? Available { get; set; }
            public int? CustomerAddressId { get; set; }
            public List<IdentityImage> IDList { get; set; }
        }

        public static CustomerAddress submitUpdateCustomerAddress(CustomerAddress address, int? CustomerId, int? UserId, int? CompanyId)
        {
            CustomerAddress result = null;
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? CustomerAddressId = address.CustomerAddressId == null? 0 : address.CustomerAddressId;
            db.sp_CustomerAddressSubmitUpdate(CustomerId, address.ContactName, address.ContactLastName,
                address.ContactPhoneNumber, address.ContactPhoneCountryId, address.Address1,
                address.Address2, address.City, address.State, address.Zip, address.DefaultShipping,
                address.CountryId, address.Available, UserId, CompanyId, ref CustomerAddressId);
            if (CustomerAddressId > 0)
            {
                db.sp_CustomerAddressResourceClear(CustomerAddressId);
                if (address.IDList != null)
                {
                    foreach (var item in address.IDList)
                    {
                        int? CustomerAddressResourceId = 0;
                        db.sp_CustomerAddressResourceInsert(CustomerAddressId, item.FileId, ref CustomerAddressResourceId);
                    }
                }
                if (address.IDNumber != null)
                {
                    int? CustomerAddressIDId = 0;
                    db.sp_CustomerAddressIDUpdate(CustomerAddressId, address.IDNumber, ref CustomerAddressIDId);
                }
                result = GetCustomerAddressById(CustomerAddressId.Value);
            }


            return result;
        }

        public static List<CustomerAddress> GetCustomerAddressList(int CustomerId)
        {
            List<CustomerAddress> result = new List<CustomerAddress>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnCustomerAddressGet(CustomerId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    CustomerAddress temp = new CustomerAddress();
                    temp.CustomerAddressId = item.Customer_AddressId;
                    temp.CustomerId = item.CustomerId;
                    temp.DefaultShipping = item.DefaultShipping;
                    temp.State = item.State;
                    temp.Zip = item.Zip;
                    temp.CountryId = item.CountryId;
                    temp.ContactPhoneNumber = item.ContactPersonPhoneNumber;
                    temp.ContactPhoneCountryId = item.ContactPersonPhoneNumberCountryId;
                    temp.ContactName = item.ContactPersonFirstName;
                    temp.ContactLastName = item.ContactPersonLastName;
                    temp.IDNumber = item.IDNumber;
                    temp.City = item.City;
                    temp.IDList = getCustomerAddressResourceList(temp.CustomerAddressId.Value);
                    temp.Address2 = item.Address2;
                    temp.Address1 = item.Address1;
                    result.Add(temp);
                }
            }
            return result;
        }

        public static CustomerAddress GetCustomerAddressById(int CustomerAddressId)
        {
            CustomerAddress result = new CustomerAddress();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnCustomerAddressGetById(CustomerAddressId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    result.CustomerAddressId = item.Customer_AddressId;
                    result.CustomerId = item.CustomerId;
                    result.DefaultShipping = item.DefaultShipping;
                    result.State = item.State;
                    result.Zip = item.Zip;
                    result.CountryId = item.CountryId;
                    result.ContactPhoneNumber = item.ContactPersonPhoneNumber;
                    result.ContactPhoneCountryId = item.ContactPersonPhoneNumberCountryId;
                    result.ContactName = item.ContactPersonFirstName;
                    result.ContactLastName = item.ContactPersonLastName;
                    result.IDNumber = item.IDNumber;
                    result.City = item.City;
                    result.IDList = getCustomerAddressResourceList(CustomerAddressId);
                    result.Address2 = item.Address2;
                    result.Address1 = item.Address1;
                    break;
                }
            }
            return result;
        }

        public static List<IdentityImage> getCustomerAddressResourceList(int CustomerAddressId)
        {
            List<IdentityImage> result = new List<IdentityImage>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnCustomerAddressResourceGet(CustomerAddressId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    IdentityImage identityImage = new IdentityImage();
                    var file = AntotoFile.getFileFromId(item.FileId);
                    identityImage.FileId = file.FileId;
                    identityImage.FileLink = file.FileLink;
                    identityImage.MFileLink = file.MFileLink;
                    identityImage.SFileLink = file.SFileLink;
                    identityImage.FileExt = file.FileExt;
                    identityImage.FileDescription = file.FileDescription;
                    result.Add(identityImage);
                }
            }

            return result;
        }
        
        public static List<CustomerCompany> getCustomerCompanyList(int CustomerId)
        {
            List<CustomerCompany> result = new List<CustomerCompany>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_CustomerCompanyListGet(CustomerId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    CustomerCompany temp = new CustomerCompany();
                    temp.CompanyId = item.CompanyId;
                    temp.CompanyCode = item.CompanyCode;
                    temp.CompanyName = item.CompanyName;
                    temp.IsDefault = item.isDefault;
                    result.Add(temp);
                }
            }
            return result;
        }
        
        public static Customer CreateCustomer(Customer customer, int CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? CustomerId = 0;
            if (customer.ThirdPartyInfo != null && customer.ThirdPartyInfo.CustomerTypeCodeId != null)
            {
                db.sp_Customer_Create(customer.FirstName, customer.LastName, customer.PhoneNumber,
                    customer.CountryId, customer.ThirdPartyInfo.NickName, customer.Email, customer.ThirdPartyInfo.ThirdPartyId,
                    "", "", true, 1, CompanyId, customer.ThirdPartyInfo.ThirdPartyId, customer.ThirdPartyInfo.NickName,
                    customer.ThirdPartyInfo.CustomerTypeCodeId, customer.ThirdPartyInfo.AvatarUrl, customer.ThirdPartyInfo.Gender, ref CustomerId);
            }
            else
            {
                db.sp_Customer_Create(customer.FirstName, customer.LastName, customer.PhoneNumber,
                    customer.CountryId, customer.NickName, customer.Email, customer.LoginName,
                    StringCipher.HashPassword(customer.Password), "", true, 1, CompanyId, null, null,
                    null, null, null, ref CustomerId);
            }
            

            if (CustomerId > 0)
            {
                db.sp_ErrorLog_Insert("Customer Id : " + CustomerId.ToString(), "Debug");
                if (customer.AddressList != null && customer.AddressList.Count() > 0)
                {
                    foreach (var address in customer.AddressList)
                    {
                        db.sp_ErrorLog_Insert("Address : " + address.Address1, "Debug");
                        submitUpdateCustomerAddress(address, CustomerId, 1, CompanyId);
                    }
                }
                return getCustomerById(CustomerId);
            }
            else
            {
                return null;
            }
        }

        public static Customer UpdateCustomer(Customer customer, int CompanyId, int UserId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? CustomerId = customer.CustomerId;
            //db.sp_ErrorLog_Insert("Customer ID: " + CustomerId.ToString() + " CompanyId : " + CompanyId.ToString() + " Step 1", "Error");
            db.sp_Customer_Update(customer.FirstName, customer.LastName, customer.PhoneNumber, customer.CountryId, customer.NickName,
                    customer.Email, customer.LoginName, StringCipher.HashPassword(customer.Password), "", customer.Available,
                    UserId, CompanyId, ref CustomerId
                );
            //db.sp_ErrorLog_Insert("Customer ID: " + CustomerId.ToString() + " Step 2", "Error");
            if (CustomerId > 0)
            {
                return getCustomerById(CustomerId);
            }
            else
            {
                return null;
            }
        }

        public static int CustomerExistsInCompany(string LoginName, int CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? result = 0;
            result = db.sfnCustomerExistsInCompany(CompanyId, LoginName);
            return result == null ? 0 : result.Value;
        }
        
        public static DataModel.ResultPageResult getCustomerList(ParaDataModel.ParaCustomerSearch customerSearch, int pCompanyId, int pSystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? total = 0;
            int? totalPage = 0;
            int? Page = customerSearch.Page;
            int? NextPage = 0;
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
            var list = db.sp_CustomerSearch(customerSearch.SearchWord, customerSearch.CustomerTypeCodeId, pCompanyId, pSystemLanguageId
                , customerSearch.PageSize, ref Page, ref total, ref totalPage);
            if (list != null)
            {
                NextPage = Page < totalPage ? Page + 1 : totalPage;
                foreach (var item in list)
                {
                    var currentobject = new DataModel.ResultCustomer
                    {
                        FirstName = item.FirstName,
                        LastName = item.LastName,
                        CustomerId = item.Id,
                        LoginName = item.LoginName,
                        CountryId = item.CountryId,
                        AvatarUrl = item.AvatarUrl,
                        PhoneNumber = item.PhoneNumber,
                        Gender = item.Gender,
                        NickName = item.NickName
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

        public class CustomerShoppingCart
        {
            public int? CustomerId { get; set; }
            public List<CustomerShoppingCartItem> ItemList { get; set; }
            public int? Goods_Count { get; set; }
            public Decimal? Goods_Amount { get; set; }
        }

        public class CustomerShoppingCartItem
        {
            public DataModel.ItemOnSaleDetail Item { get; set; }

            public int? ItemId { get; set; }

            public int? Quantity { get; set; }

            public decimal? Price { get; set; }

            public decimal? TotalAmount { get; set; }

            public int? CustomerShoppingCartId { get; set; }
        }

        public static CustomerShoppingCart getShoppingCartContent(int CustomerId)
        {
            CustomerShoppingCart result = new CustomerShoppingCart();
            result.CustomerId = CustomerId;
            antoto_dbDataContext db = new antoto_dbDataContext();
            result.Goods_Amount = 0;
            result.Goods_Count = 0;
            var list = db.tfnCustomerShoppingCartContentGet(CustomerId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    if (result.ItemList == null)
                    {
                        result.ItemList = new List<CustomerShoppingCartItem>();
                    }
                    CustomerShoppingCartItem temp = new CustomerShoppingCartItem();
                    temp.Item = ProductOnSaleManager.getItemOnSaleByItemId(item.ItemId, 1);
                    temp.ItemId = item.ItemId;
                    temp.Quantity = item.Quantity;
                    temp.Price = item.UnitAmount;
                    temp.TotalAmount = item.TotalAmount;
                    temp.CustomerShoppingCartId = item.Customer_ShoppingCart_ItemsId;
                    result.ItemList.Add(temp);
                    result.Goods_Count = result.Goods_Count + temp.Quantity;
                    result.Goods_Amount = result.Goods_Amount + temp.TotalAmount;
                }
            }
            return result;
        }

        public static CustomerShoppingCart addUpdateItemIntoShoppingCart(CustomerShoppingCartItem paraShoppingCartEdit, int CustomerId)
        {
            CustomerShoppingCart result = new CustomerShoppingCart();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? Customer_ShoppingCart_ItemId = paraShoppingCartEdit.CustomerShoppingCartId;
            db.sp_Customer_ShoppingCartUpdate(CustomerId, paraShoppingCartEdit.ItemId, paraShoppingCartEdit.Quantity, 1, ref Customer_ShoppingCart_ItemId);
            result = getShoppingCartContent(CustomerId);
            return result;
        }

        public static CustomerShoppingCart clearItemInShoppingCart(int CustomerId)
        {
            CustomerShoppingCart result = new CustomerShoppingCart();
            antoto_dbDataContext db = new antoto_dbDataContext();
            db.sp_Customer_ShoppingCartClear(CustomerId);
            result = getShoppingCartContent(CustomerId);
            return result;
        }
        
    }
    

    
}
