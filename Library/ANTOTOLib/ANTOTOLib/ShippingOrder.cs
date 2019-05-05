using ExcelDataReader;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace ANTOTOLib
{
    public class ShippingOrder
    {
        public class ShippingChannel
        {
            public string ShippingChannelName { get; set; }
            public int? ShippingChannelId { get; set; }
            public int? ShippingChannelCompanyId { get; set; }
            public int? SourceCompanyId { get; set; }
            public int? HandlerCompanyId { get; set; }
            public string ShippingChannelCode { get; set; }
            public Decimal? TaxRate { get; set; }
            public Decimal? PriceFirstRate { get; set; }
            public Decimal? PriceAdditionRate { get; set; }
            public int? WeightUnit { get; set; }
            public int? WeightFirst { get; set; }
            public Decimal? UnitPriceFirst { get; set; }
            public Decimal? UnitPriceAdditional { get; set; }
            public bool? JumpToInt { get; set; }
            public bool? TaxPaymentMethodAvailable { get; set; }
            public bool? Available { get; set; }
            public bool? DisplayAvailable { get; set; }
            public List<ShippingChannelService> ServiceList { get; set; }
            public bool? IDCheckBeforeShipping { get; set; }
            public bool? IDCheckDuplicateBeforeShipping { get; set; }
            public int? IDDuplicateNumberLimitation { get; set; }
            public string SFExpressType { get; set; }
            public bool? Granted { get; set; }
            public int? ShippingChannelTypeCodeId { get; set; }
            public List<ShippingChannelPriceRange> PriceRangeList { get; set; } 
        }

        public class ShippingChannelPriceRange
        {
            public int? CompanyId { get; set; }
            public int? ShippingChannelCompanyId { get; set; }
            public int? ShippingChannelId { get; set; }
            public int? CurrencyId { get; set; }
            public int? ShippingChannelPriceRangeId { get; set; }
            public Decimal? WeightMin { get; set; }
            public Decimal? WeightMax { get; set; }
            public Decimal? Price { get; set; }
            public bool? Available { get; set; }
            public bool? Customized { get; set; }
        }

        public class LogisticCompany
        {
            public string CompanyName { get; set; }
            public int? CompanyId { get; set; }
            public string Description { get; set; }
        }

        public class ShippingChannelService
        {
            public int? ShippingChannelServiceId { get; set; }

            public string ServiceName { get; set; }

            public Decimal? ServicePrice { get; set; }

            public int? CurrencyId { get; set; }

            public bool? Optional { get; set; } 

            public bool? Available { get; set; }
        }

        //public static List<ShippingChannel> getAvailableChannelShippingChannels(int CompanyId)
        //{
        //    List<ShippingChannel> result = new List<ShippingChannel>();
        //    antoto_dbDataContext db = new antoto_dbDataContext();
        //    var list = db.tfnCompanyShippingChannelListGet(CompanyId);
        //    if (list != null)
        //    {
        //        foreach(var item in list)
        //        {
        //            ShippingChannel temp = new ShippingChannel();
        //            temp.ShippingChannelId = item.ShippingChannelId;
        //            temp.ShippingChannelCompanyId = item.ShippingChannelCompanyId;
        //            temp.ShippingChannelName = item.ShippingChannelName;
        //            temp.ShippingChannelCode = item.ShippingChannelCode;
        //            temp.UnitPriceAdditional = item.UnitPriceAdditional;
        //            temp.UnitPriceFirst = item.UnitPriceFirst;
        //            temp.WeightFirst = item.WeightFirst;
        //            temp.WeightUnit = item.WeightUnit;
        //            temp.JumpToInt = item.JumpToInt;
        //            temp.PriceAdditionRate = item.PriceAdditionRate;
        //            temp.PriceFirstRate = item.PriceFirstRate;
        //            temp.TaxRate = item.TaxRate;
        //            temp.IDCheckBeforeShipping = item.IDCheckBeforeShipping;
        //            temp.IDCheckDuplicateBeforeShipping = item.IDCheckDuplicateBeforeShipping;
        //            temp.IDDuplicateNumberLimitation = item.IDDuplicateNumberLimitation;
        //            temp.TaxPaymentMethodAvailable = item.TaxPaymentMethodAvailable;
        //            if (temp.ServiceList == null)
        //            {
        //                temp.ServiceList = new List<ShippingChannelService>();
        //            }
        //            var ServiceList = db.tfnShippingChannelIncrementListGet(temp.ShippingChannelId);
        //            if (ServiceList != null)
        //            {
        //                foreach(var service in ServiceList)
        //                {
        //                    ShippingChannelService tempService = new ShippingChannelService();
        //                    tempService.ShippingChannelServiceId = service.ShippingChannelIncrementServiceId;
        //                    tempService.ServicePrice = service.ServicePrice;
        //                    tempService.ServiceName = service.ServiceName;
        //                    tempService.Optional = service.Optional;
        //                    tempService.CurrencyId = service.CurrencyId;
        //                    tempService.Available = service.Available;
        //                    temp.ServiceList.Add(tempService);
        //                }
        //            }
        //            result.Add(temp);
        //        }
        //    }
        //    return result;
        //}

        public static List<ShippingChannel> getAvailableChannelShippingChannelsWithSecurity(int CompanyId, int UserId)
        {
            List<ShippingChannel> result = new List<ShippingChannel>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnCompanyShippingChannelListGetNew(CompanyId, UserId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    ShippingChannel temp = new ShippingChannel();
                    temp.ShippingChannelId = item.ShippingChannelId;
                    temp.SourceCompanyId = CompanyId;
                    temp.ShippingChannelCompanyId = item.ShippingChannelCompanyId;
                    temp.ShippingChannelName = item.ShippingChannelName;
                    temp.ShippingChannelCode = item.ShippingChannelCode;
                    temp.UnitPriceAdditional = item.UnitPriceAdditional;
                    temp.UnitPriceFirst = item.UnitPriceFirst;
                    temp.WeightFirst = item.WeightFirst;
                    temp.WeightUnit = item.WeightUnit;
                    temp.JumpToInt = item.JumpToInt;
                    temp.PriceAdditionRate = item.PriceAdditionRate;
                    temp.PriceFirstRate = item.PriceFirstRate;
                    temp.TaxRate = item.TaxRate;
                    temp.IDCheckBeforeShipping = item.IDCheckBeforeShipping;
                    temp.IDCheckDuplicateBeforeShipping = item.IDCheckDuplicateBeforeShipping;
                    temp.IDDuplicateNumberLimitation = item.IDDuplicateNumberLimitation;
                    temp.TaxPaymentMethodAvailable = item.TaxPaymentMethodAvailable;
                    temp.Granted = item.Granted;
                    temp.ShippingChannelTypeCodeId = item.ShippingChannelTypeCodeId;
                    if (temp.ServiceList == null)
                    {
                        temp.ServiceList = new List<ShippingChannelService>();
                    }
                    var ServiceList = db.tfnShippingChannelIncrementListGet(temp.ShippingChannelId);
                    if (ServiceList != null)
                    {
                        foreach (var service in ServiceList)
                        {
                            ShippingChannelService tempService = new ShippingChannelService();
                            tempService.ShippingChannelServiceId = service.ShippingChannelIncrementServiceId;
                            tempService.ServicePrice = service.ServicePrice;
                            tempService.ServiceName = service.ServiceName;
                            tempService.Optional = service.Optional;
                            tempService.CurrencyId = service.CurrencyId;
                            tempService.Available = service.Available;
                            temp.ServiceList.Add(tempService);
                        }
                    }
                    result.Add(temp);
                }
            }
            return result;
        }

        public static ShippingChannel setShippingChannelGrant(ParaDataModel.ParaShippingChannelRightGrant paraShippingChannelRightGrant, int UserId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            db.sp_ShippingChannelCustomerCompanyGrantRight(paraShippingChannelRightGrant.CustomerCompanyId,
                paraShippingChannelRightGrant.ShippingChannelId, paraShippingChannelRightGrant.Granted,
                UserId, UserId, 1);
            return getShippingChannel(paraShippingChannelRightGrant.ShippingChannelId.Value, paraShippingChannelRightGrant.CustomerCompanyId.Value);
        }

        public static ShippingChannel getShippingChannel(int ShippingChannelId, int CompanyId)
        {
            ShippingChannel result = new ShippingChannel();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnShippingChannelGetById(ShippingChannelId, CompanyId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    ShippingChannel temp = new ShippingChannel();
                    temp.ShippingChannelId = item.ShippingChannelId;
                    temp.ShippingChannelCompanyId = item.ShippingChannelCompanyId;
                    temp.SourceCompanyId = CompanyId;
                    temp.ShippingChannelName = item.ShippingChannelName;
                    temp.ShippingChannelCode = item.ShippingChannelCode;
                    temp.UnitPriceAdditional = item.UnitPriceAdditional;
                    temp.UnitPriceFirst = item.UnitPriceFirst;
                    temp.WeightFirst = item.WeightFirst;
                    temp.WeightUnit = item.WeightUnit;
                    temp.JumpToInt = item.JumpToInt;
                    temp.PriceAdditionRate = item.PriceAdditionRate;
                    temp.PriceFirstRate = item.PriceFirstRate;
                    temp.TaxRate = item.TaxRate;
                    temp.TaxPaymentMethodAvailable = item.TaxPaymentMethodAvailable;
                    temp.IDCheckBeforeShipping = item.IDCheckBeforeShipping;
                    temp.IDCheckDuplicateBeforeShipping = item.IDCheckDuplicateBeforeShipping;
                    temp.IDDuplicateNumberLimitation = item.IDDuplicateNumberLimitation;
                    temp.SFExpressType = item.SFExpressType;
                    temp.ShippingChannelTypeCodeId = item.ShippingChannelTypeCodeId;
                    if (temp.ServiceList == null)
                    {
                        temp.ServiceList = new List<ShippingChannelService>();
                    }
                    var ServiceList = db.tfnShippingChannelIncrementListGet(temp.ShippingChannelId);
                    if (ServiceList != null)
                    {
                        foreach (var service in ServiceList)
                        {
                            ShippingChannelService tempService = new ShippingChannelService();
                            tempService.ShippingChannelServiceId = service.ShippingChannelIncrementServiceId;
                            tempService.ServicePrice = service.ServicePrice;
                            tempService.ServiceName = service.ServiceName;
                            tempService.Optional = service.Optional;
                            tempService.CurrencyId = service.CurrencyId;
                            tempService.Available = service.Available;
                            temp.ServiceList.Add(tempService);
                        }
                    }
                    temp.PriceRangeList = PriceRangeListGetByShippingChannelId(ShippingChannelId, CompanyId);
                    result = temp;
                    break;
                }
            }
            return result;
        }

        public static List<ShippingChannelPriceRange> PriceRangeListGetByShippingChannelId(int? ShippingChannelId, int? CompanyId)
        {
            List<ShippingChannelPriceRange> result = new List<ShippingChannelPriceRange>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnShippingChannelPriceRangeListGet(ShippingChannelId, CompanyId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    ShippingChannelPriceRange temp = new ShippingChannelPriceRange();
                    temp.ShippingChannelId = ShippingChannelId;
                    temp.ShippingChannelPriceRangeId = item.ShippingChannelPriceRangeId;
                    temp.WeightMin = item.WeightMin;
                    temp.WeightMax = item.WeightMax;
                    temp.Price = item.Price;
                    temp.CurrencyId = item.CurrencyId;
                    temp.Customized = item.Customized;
                    temp.Available = true;
                    temp.ShippingChannelCompanyId = item.ShippingChannelCompanyId;
                    temp.CompanyId = CompanyId;
                    result.Add(temp);
                }
            }
            return result;
        }

        public class ANTOTOShippingOrder
        {
            public int? ShippingOrderId { get; set; }

            public string ReferenceCode { get; set; }

            public CustomerManager.Customer Customer { get; set; }
            
	        public CustomerOrder.CustomerOrderDetail CustomerOrder { get; set; }

            public ParaDataModel.ParaShippingOrderAddress FromShippingAddress { get; set; }

            public ParaDataModel.ParaShippingOrderAddress ToShippingAddress { get; set; }

            public ShippingChannel ShippingChannel { get; set; }

            public int? PackageCount { get; set; }

            public int? ShippingOrderPaymentStatusCodeId { get; set; }

            public string ShippingOrderPaymentStatusCode { get; set; }

            public int? ShippingOrderTaxPaymentTypeCodeId { get; set; }

            public string ShippingOrderTaxPaymentType { get; set; }
            
            public Decimal? Price { get; set; }

            public int? CurrencyId { get; set; }

            public Decimal? TotalWeight { get; set; }

            public int? WeightUnitId { get; set; } //1 lb 2 g 3 kg

            public int? ShippingOrderStatusCodeId { get; set; }

            public string ShippingOrderCode { get; set; }

            public List<ANTOTOShippingItem> ItemList { get; set; }

            public Decimal? Width { get; set; }

            public Decimal? Length { get; set; }

            public Decimal? Height { get; set; }

            public int? DimensionUnitId { get; set; }

            public int? SourceCompanyId { get; set; }

            public int? HandlerCompanyId { get; set; }

            public ANTOTOShippingOrderTaxPayment TaxPayment { get; set; }

            public DataModel.ResultShippingOrderIdentityProfile ShippingOrderIdentityProfile { get; set; }
            
            public List<DataModel.ResultShippingOrderLabel> LabelList { get; set; }

            public string CustomTax { get; set; }
        }

        public class ANTOTOShippingOrderTaxPayment
        {
            public int? ShippingOrderId { get; set; }
            public int? ShippingOrderTaxPaymentId { get; set; }
            public Decimal? TaxPrice { get; set; }
            public int? TaxPaymentMethod { get; set; } // --shipper, receiver 1, 2
	        public int? CurrencyId { get; set; }
        }

        public class ANTOTOShippingItem
        {
            public int? ShippingOrderItemId { get; set; }
            public int? ItemId { get; set; }
            public int? Quantity { get; set; }
            public string Brand { get; set; }
            public string Category { get; set; }
            public string ItemName { get; set; }
            public Decimal? Price { get; set; }
            public int? CurrencyId { get; set; }
            public Decimal? TaxPrice { get; set; }
            public string Description { get; set; }
            public int? StockItemId { get; set; }
            public string Unit { get; set; }
            public Decimal? Weight { get; set; }
            public int? WeightUnit { get; set; }
            public string SourceArea { get; set; }
            public string GoodCode { get; set; }
            public string StateBarCode { get; set; }
            public string Specifications { get; set; }
        }

        public static ParaDataModel.ParaShippingOrderAddress CreateShippingAddress(ParaDataModel.ParaShippingOrderAddress address)
        {
            ParaDataModel.ParaShippingOrderAddress result = address;
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? ShippingAddressId = 0;
            db.sp_ShippingAddressCreate(address.ContactFirstName, address.ContactLastName, address.ContactPhone,
                address.ContactPhoneCountryId, address.Address_1, address.Address_2, address.City, address.State,
                address.Zip, address.CountryId, ref ShippingAddressId);

            if(ShippingAddressId > 0)
            {
                result.ShippingAddressId = ShippingAddressId;
                return result;
            }
            else
            {
                return null;
            }
        }

        public static ParaDataModel.ParaShippingOrderAddress UpdateShippingAddress(ParaDataModel.ParaShippingOrderAddress address)
        {
            ParaDataModel.ParaShippingOrderAddress result = address;
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? ShippingAddressId = address.ShippingAddressId;
            db.sp_ShippingAddressUpdate(address.ContactFirstName, address.ContactLastName, address.ContactPhone,
                address.ContactPhoneCountryId, address.Address_1, address.Address_2, address.City, address.State,
                address.Zip, address.CountryId, ref ShippingAddressId);

            if (ShippingAddressId > 0)
            {
                result.ShippingAddressId = ShippingAddressId;
                return result;
            }
            else
            {
                return null;
            }
        }

        public static ParaDataModel.ParaShippingOrderAddress GetShippingAddressById(int ShippingAddressId)
        {
            ParaDataModel.ParaShippingOrderAddress result = new ParaDataModel.ParaShippingOrderAddress();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnShippingAddressGetById(ShippingAddressId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    result.ShippingAddressId = item.ShippingAddressId;
                    result.State = item.State;
                    result.Zip = item.Zip;
                    result.CountryId = item.CountryId;
                    result.ContactPhone = item.ContactPersonPhoneNumber;
                    result.ContactPhoneCountryId = item.ContactPersonPhoneNumberCountryId;
                    result.ContactFirstName = item.ContactPersonFirstName;
                    result.ContactLastName = item.ContactPersonLastName;
                    result.City = item.City;
                    result.Address_2 = item.Address2;
                    result.Address_1 = item.Address1;
                    break;
                }
            }
            return result;
        }

        public static ANTOTOShippingOrder CreateShippingOrder(ParaDataModel.ParaShippingOrder paraShippingOrder, int CompanyId, int UserId)
        {
            ANTOTOShippingOrder result = new ANTOTOShippingOrder();

            antoto_dbDataContext db = new antoto_dbDataContext();

            int? ShippingOrderId = 0;
            
            var FromAddress = CreateShippingAddress(paraShippingOrder.ShipperAddress);
            var ToAddress = CreateShippingAddress(paraShippingOrder.ReceiverAddress);
            if (FromAddress == null || ToAddress == null)
            {
                return null;
            }
            if(paraShippingOrder.ShipperAddressAddToCompanyFromAddress == true)
            {
                Company.CompanyFromAddress address = new Company.CompanyFromAddress();
                address.CompanyId = CompanyId;
                if (paraShippingOrder.ShipperAddress != null)
                {
                    address.Address1 = paraShippingOrder.ShipperAddress.Address_1;
                    address.Address2 = paraShippingOrder.ShipperAddress.Address_2;
                    address.City = paraShippingOrder.ShipperAddress.City;
                    address.CompanyId = CompanyId;
                    address.ContactLastName = paraShippingOrder.ShipperAddress.ContactLastName;
                    address.ContactName = paraShippingOrder.ShipperAddress.ContactFirstName;
                    address.ContactPhoneCountryId = paraShippingOrder.ShipperAddress.ContactPhoneCountryId;
                    address.ContactPhoneNumber = paraShippingOrder.ShipperAddress.ContactPhone;
                    address.CountryId = paraShippingOrder.ShipperAddress.CountryId;
                    address.State = paraShippingOrder.ShipperAddress.State;
                    address.Zip = paraShippingOrder.ShipperAddress.Zip;
                    address.Available = true;
                }
                Company.companyFromAddressCreateUpdate(address, CompanyId, UserId);
            }

            if(paraShippingOrder.ReceiverAddressAddCustomer == true)
            {
                CustomerManager.Customer customer = new CustomerManager.Customer();
                customer.FirstName = paraShippingOrder.ReceiverAddress.ContactFirstName;
                customer.LastName = paraShippingOrder.ReceiverAddress.ContactLastName;
                customer.NickName = paraShippingOrder.ReceiverAddress.ContactFirstName;
                customer.Password = "abcdefg";
                customer.PhoneNumber = paraShippingOrder.ReceiverAddress.ContactPhone;
                customer.CountryId = 37;
                customer.LoginName = paraShippingOrder.ReceiverAddress.ContactFirstName + "@ant-oto.com";
                customer.Email = customer.LoginName;
                customer.AddressList = new List<CustomerManager.CustomerAddress>();
                CustomerManager.CustomerAddress customerAddress = new CustomerManager.CustomerAddress();
                customerAddress.Address1 = paraShippingOrder.ReceiverAddress.Address_1;
                customerAddress.Address2 = paraShippingOrder.ReceiverAddress.Address_2;
                customerAddress.City = paraShippingOrder.ReceiverAddress.City;
                customerAddress.ContactLastName = paraShippingOrder.ReceiverAddress.ContactLastName;
                customerAddress.ContactName = paraShippingOrder.ReceiverAddress.ContactFirstName;
                customerAddress.ContactPhoneCountryId = paraShippingOrder.ReceiverAddress.ContactPhoneCountryId;
                customerAddress.ContactPhoneNumber = paraShippingOrder.ReceiverAddress.ContactPhone;
                customerAddress.CountryId = paraShippingOrder.ReceiverAddress.CountryId;
                customerAddress.State = paraShippingOrder.ReceiverAddress.State;
                customerAddress.Zip = paraShippingOrder.ReceiverAddress.Zip;
                customerAddress.DefaultShipping = true;
                customer.AddressList.Add(customerAddress);
                CustomerManager.CreateCustomer(customer, CompanyId);
            }

            //Package Count
            
            if(paraShippingOrder.PackageCount == null)
            {
                paraShippingOrder.PackageCount = 1;
            }

            if (!String.IsNullOrEmpty(paraShippingOrder.ReferenceCode))
            {
                paraShippingOrder.ReferenceCode = paraShippingOrder.ReferenceCode.Replace(" ", "");
                string[] words = paraShippingOrder.ReferenceCode.Split(',');
                if (words.Length != paraShippingOrder.PackageCount.Value)
                {
                    return null;
                }
            }
            else
            {
                paraShippingOrder.ReferenceCode = "";
            }

            db.sp_ANTOTOShippingOrderQuickCreate(paraShippingOrder.CustomerId,
                paraShippingOrder.ReferenceThirdPartyId, FromAddress.ShippingAddressId,
                ToAddress.ShippingAddressId, paraShippingOrder.ShippingChannelId,
                0.0m, paraShippingOrder.CurrencyId, paraShippingOrder.TotalWeight,
                paraShippingOrder.WeightUnitId, 1, UserId, CompanyId,
                paraShippingOrder.HanlderCompanyId, ref ShippingOrderId);

            if(ShippingOrderId > 0)
            {
                int? ShippingOrderAdditionalInfoId = 0;
                db.sp_ANTOTOShippingOrderAdditionalInfoSet(ShippingOrderId, paraShippingOrder.PackageCount == null? 1: paraShippingOrder.PackageCount.Value,
                    paraShippingOrder.ShippingOrderTaxPaymentTypeCodeId == null? 2: paraShippingOrder.ShippingOrderTaxPaymentTypeCodeId.Value, ref ShippingOrderAdditionalInfoId);
                if(paraShippingOrder.ItemList != null && paraShippingOrder.ItemList.Count > 0)
                {
                    foreach(var item in paraShippingOrder.ItemList)
                    {
                        int? ShippingOrderItemId = 0;
                        if (item.TaxPrice != null && item.TaxPrice > 0)
                        {
                            db.sp_ANTOTOShippingOrderItemInsert(ShippingOrderId, item.ItemId, item.StockItemId,
                            item.ItemName, item.Quantity, item.Unit, item.Weight, item.WeightUnit, item.Price,
                            item.CurrencyId, item.TaxPrice, item.SourceArea, item.GoodCode, item.StateBarCode, item.Brand,
                            item.Specifications, UserId, 1, ref ShippingOrderItemId);
                        }
                        else
                        {
                            db.sp_ANTOTOShippingOrderItemInsert(ShippingOrderId, item.ItemId, item.StockItemId,
                            item.ItemName, item.Quantity, item.Unit, item.Weight, item.WeightUnit, item.Price,
                            item.CurrencyId, -1.0m, item.SourceArea, item.GoodCode, item.StateBarCode, item.Brand,
                            item.Specifications, UserId, 1, ref ShippingOrderItemId);
                        }
                        //db.sp_ANTOTOShippingOrderItemInsert(ShippingOrderId, item.ItemId, item.StockItemId,
                        //    item.ItemName, item.Quantity, item.Unit, item.Weight, item.WeightUnit, item.Price,
                        //    item.CurrencyId, 0.0m, item.SourceArea, item.GoodCode, item.StateBarCode, item.Brand,
                        //    item.Specifications, UserId, 1, ref ShippingOrderItemId);
                    }
                }
                if(paraShippingOrder.ShippingChannelId > 0)
                {
                    db.sp_ANTOTOShippingOrderPriceCalculate(ShippingOrderId);
                }
                ParaDataModel.ParaShippingOrderPackage tt = new ParaDataModel.ParaShippingOrderPackage();
                tt.ShippingOrderId = ShippingOrderId;
                ShippingOrderAction.ShippingOrderGenerateLabel(tt, UserId, CompanyId);
                result = GetShippingOrder(ShippingOrderId);
            }
            else
            {
                result = null;
            }

            return result;
        }

        public static ANTOTOShippingOrder CreateShippingOrderQuick(ParaDataModel.ParaShippingQuickOrder paraShippingOrder, int CompanyId, int UserId)
        {
            ANTOTOShippingOrder result = new ANTOTOShippingOrder();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? ShippingOrderId = 0;
            var FromAddress = CreateShippingAddress(paraShippingOrder.ShipperAddress);
            var ToAddress = CreateShippingAddress(paraShippingOrder.ReceiverAddress);
            if(FromAddress==null || ToAddress == null)
            {
                return null;
            }
            if (!String.IsNullOrEmpty(paraShippingOrder.ReferenceCode))
            {
                paraShippingOrder.ReferenceCode = paraShippingOrder.ReferenceCode.Replace(" ", "");
                string[] words = paraShippingOrder.ReferenceCode.Split(',');
                if (words.Length != paraShippingOrder.PackageCount.Value)
                {
                    return null;
                }
            }
            if (paraShippingOrder.ShipperAddressAddToCompanyFromAddress == true)
            {
                Company.CompanyFromAddress address = new Company.CompanyFromAddress();
                address.CompanyId = CompanyId;
                if (paraShippingOrder.ShipperAddress != null)
                {
                    address.Address1 = paraShippingOrder.ShipperAddress.Address_1;
                    address.Address2 = paraShippingOrder.ShipperAddress.Address_2;
                    address.City = paraShippingOrder.ShipperAddress.City;
                    address.CompanyId = CompanyId;
                    address.ContactLastName = paraShippingOrder.ShipperAddress.ContactLastName;
                    address.ContactName = paraShippingOrder.ShipperAddress.ContactFirstName;
                    address.ContactPhoneCountryId = paraShippingOrder.ShipperAddress.ContactPhoneCountryId;
                    address.ContactPhoneNumber = paraShippingOrder.ShipperAddress.ContactPhone;
                    address.CountryId = paraShippingOrder.ShipperAddress.CountryId;
                    address.State = paraShippingOrder.ShipperAddress.State;
                    address.Zip = paraShippingOrder.ShipperAddress.Zip;
                    address.Available = true;
                }
                Company.companyFromAddressCreateUpdate(address, CompanyId, UserId);
            }

            if (paraShippingOrder.ReceiverAddressAddCustomer == true)
            {
                CustomerManager.Customer customer = new CustomerManager.Customer();
                customer.FirstName = paraShippingOrder.ReceiverAddress.ContactFirstName;
                customer.LastName = paraShippingOrder.ReceiverAddress.ContactLastName;
                customer.NickName = paraShippingOrder.ReceiverAddress.ContactFirstName;
                customer.Password = "abcdefg";
                customer.PhoneNumber = paraShippingOrder.ReceiverAddress.ContactPhone;
                customer.CountryId = 37;
                customer.LoginName = paraShippingOrder.ReceiverAddress.ContactFirstName + "@ant-oto.com";
                customer.Email = customer.LoginName;
                customer.AddressList = new List<CustomerManager.CustomerAddress>();
                CustomerManager.CustomerAddress customerAddress = new CustomerManager.CustomerAddress();
                customerAddress.Address1 = paraShippingOrder.ReceiverAddress.Address_1;
                customerAddress.Address2 = paraShippingOrder.ReceiverAddress.Address_2;
                customerAddress.City = paraShippingOrder.ReceiverAddress.City;
                customerAddress.ContactLastName = paraShippingOrder.ReceiverAddress.ContactLastName;
                customerAddress.ContactName = paraShippingOrder.ReceiverAddress.ContactFirstName;
                customerAddress.ContactPhoneCountryId = paraShippingOrder.ReceiverAddress.ContactPhoneCountryId;
                customerAddress.ContactPhoneNumber = paraShippingOrder.ReceiverAddress.ContactPhone;
                customerAddress.CountryId = paraShippingOrder.ReceiverAddress.CountryId;
                customerAddress.State = paraShippingOrder.ReceiverAddress.State;
                customerAddress.Zip = paraShippingOrder.ReceiverAddress.Zip;
                customerAddress.DefaultShipping = true;
                customer.AddressList.Add(customerAddress);
                CustomerManager.CreateCustomer(customer, CompanyId);
            }

            db.sp_ANTOTOShippingOrderQuickCreate(paraShippingOrder.CustomerId, 
                paraShippingOrder.ReferenceThirdPartyId, FromAddress.ShippingAddressId,
                ToAddress.ShippingAddressId, paraShippingOrder.ShippingChannelId,
                0.0m, paraShippingOrder.CurrencyId, paraShippingOrder.TotalWeight,
                paraShippingOrder.WeightUnitId, 1, UserId, CompanyId, 
                paraShippingOrder.HanlderCompanyId, ref ShippingOrderId);

            if (ShippingOrderId > 0)
            {
                int? ShippingOrderAdditionalInfoId = 0;
                db.sp_ANTOTOShippingOrderAdditionalInfoSet(ShippingOrderId, paraShippingOrder.PackageCount == null ? 1 : paraShippingOrder.PackageCount.Value,
                    paraShippingOrder.ShippingOrderTaxPaymentTypeCodeId == null ? 2 : paraShippingOrder.ShippingOrderTaxPaymentTypeCodeId.Value, ref ShippingOrderAdditionalInfoId);
                if (paraShippingOrder.ItemList != null && paraShippingOrder.ItemList.Count > 0)
                {
                    foreach (var item in paraShippingOrder.ItemList)
                    {
                        int? ShippingOrderItemId = 0;
                        if(item.TaxPrice!=null && item.TaxPrice > 0)
                        {
                            db.sp_ANTOTOShippingOrderItemInsert(ShippingOrderId, item.ItemId, item.StockItemId,
                            item.ItemName, item.Quantity, item.Unit, item.Weight, item.WeightUnit, item.Price,
                            item.CurrencyId, item.TaxPrice, item.SourceArea, item.GoodCode, item.StateBarCode, item.Brand,
                            item.Specifications, UserId, 1, ref ShippingOrderItemId);
                        }
                        else
                        {
                            db.sp_ANTOTOShippingOrderItemInsert(ShippingOrderId, item.ItemId, item.StockItemId,
                            item.ItemName, item.Quantity, item.Unit, item.Weight, item.WeightUnit, item.Price,
                            item.CurrencyId, -1.0m, item.SourceArea, item.GoodCode, item.StateBarCode, item.Brand,
                            item.Specifications, UserId, 1, ref ShippingOrderItemId);
                        }
                        //db.sp_ANTOTOShippingOrderItemInsert(ShippingOrderId, item.ItemId, item.StockItemId,
                        //    item.ItemName, item.Quantity, item.Unit, item.Weight, item.WeightUnit, item.Price,
                        //    item.CurrencyId, 0.0m, item.SourceArea, item.GoodCode, item.StateBarCode, item.Brand,
                        //    item.Specifications, UserId, 1, ref ShippingOrderItemId);
                    }
                }
                if (paraShippingOrder.ShippingChannelId > 0)
                {
                    db.sp_ANTOTOShippingOrderPriceCalculate(ShippingOrderId);
                }
                //generate labels
                ParaDataModel.ParaShippingOrderPackage tt = new ParaDataModel.ParaShippingOrderPackage();
                tt.ShippingOrderId = ShippingOrderId;
                ShippingOrderAction.ShippingOrderGenerateLabel(tt, UserId, CompanyId);
                
                result = GetShippingOrder(ShippingOrderId);
            }
            else
            {
                result = null;
            }
            return result;
        }

        public static List<ANTOTOShippingItem> GetShippingOrderItemList(int? ShippingOrderId)
        {
            List<ANTOTOShippingItem> result = new List<ANTOTOShippingItem>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnShippingOrderItemsGet(ShippingOrderId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    ANTOTOShippingItem temp = new ANTOTOShippingItem();
                    temp.Brand = item.Brand;
                    temp.ItemId = item.ItemId;
                    temp.ItemName = item.ItemName;
                    temp.Price = item.Price;
                    temp.Quantity = item.Quantity;
                    temp.ShippingOrderItemId = item.ShippingOrderItemId;
                    temp.TaxPrice = item.TaxPrice;
                    temp.Category = item.Specifications;
                    temp.CurrencyId = item.CurrencyId;
                    temp.GoodCode = item.GoodCode;
                    temp.SourceArea = item.SourceArea;
                    temp.StateBarCode = item.StateBarCode;
                    temp.StockItemId = item.StockItemId;
                    temp.Unit = item.Unit;
                    temp.Weight = item.Weight;
                    temp.WeightUnit = item.WeightUnit;
                    result.Add(temp);
                }
            }
            return result;
        }

        public static ANTOTOShippingOrder GetShippingOrder(int? ShippingOrderId)
        {
            ANTOTOShippingOrder result = new ANTOTOShippingOrder();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnShippingOrderGet(ShippingOrderId, null);
            if (list != null)
            {
                foreach(var order in list)
                {
                    result.Customer = CustomerManager.getCustomerById(order.CustomerId);
                    result.FromShippingAddress = GetShippingAddressById(order.FromShippingAddressId);
                    result.ToShippingAddress = GetShippingAddressById(order.ToShippingAddressId);
                    if(order.CustomerOrderId != null)
                    {
                        result.CustomerOrder = CustomerOrder.GetCustomerOrder(order.CustomerOrderId.Value);
                    }
                    result.CurrencyId = order.CurrencyId;
                    if (order.ShippingChannelId != null)
                    {
                        result.ShippingChannel = getShippingChannel(order.ShippingChannelId.Value, order.SourceCompanyId);
                    }
                    result.ReferenceCode = order.ReferenceOrderCode;
                    result.SourceCompanyId = order.SourceCompanyId;
                    result.HandlerCompanyId = order.HandlerCompanyId;
                    result.ItemList = GetShippingOrderItemList(ShippingOrderId);
                    result.ShippingOrderId = ShippingOrderId;
                    result.ShippingOrderStatusCodeId = order.ShippingOrderStatusCodeId;
                    result.TotalWeight = order.TotalWeight;
                    result.WeightUnitId = order.WeightUnitId;
                    result.Price = order.Price;
                    result.ShippingOrderCode = order.ShippingOrderCode;
                    result.ShippingOrderIdentityProfile = getShippingOrderIDProfile(order.ShippingOrderId, "");
                    result.LabelList = getShippingOrderLabelList(order.ShippingOrderId);
                    var tempList = db.tfnShippingOrderAdditionalInfoGet(ShippingOrderId, null);
                    if(tempList != null)
                    {
                        foreach(var temp in tempList)
                        {
                            result.PackageCount = temp.PackageCount;
                            result.ShippingOrderTaxPaymentTypeCodeId = temp.ShippingOrderTaxPaymentTypeCodeId;
                            result.ShippingOrderTaxPaymentType = temp.ShippingOrderTaxPaymentType;
                            break;
                        }
                    }
                    result.TaxPayment = GetTaxPayment(ShippingOrderId);
                    
                    break;
                }
            }
            return result;
        }

        public static ANTOTOShippingOrder GetShippingOrderByCode(string ShippingOrderCode)
        {
            ANTOTOShippingOrder result = new ANTOTOShippingOrder();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnShippingOrderGet(null, ShippingOrderCode);
            if (list != null)
            {
                foreach (var order in list)
                {
                    result.Customer = CustomerManager.getCustomerById(order.CustomerId);
                    result.FromShippingAddress = GetShippingAddressById(order.FromShippingAddressId);
                    result.ToShippingAddress = GetShippingAddressById(order.ToShippingAddressId);
                    if (order.CustomerOrderId != null)
                    {
                        result.CustomerOrder = CustomerOrder.GetCustomerOrder(order.CustomerOrderId.Value);
                    }
                    result.CurrencyId = order.CurrencyId;
                    if (order.ShippingChannelId != null)
                    {
                        result.ShippingChannel = getShippingChannel(order.ShippingChannelId.Value, order.SourceCompanyId);
                    }
                    result.SourceCompanyId = order.SourceCompanyId;
                    result.HandlerCompanyId = order.HandlerCompanyId;
                    result.ItemList = GetShippingOrderItemList(order.ShippingOrderId);
                    result.ShippingOrderId = order.ShippingOrderId;
                    result.ShippingOrderStatusCodeId = order.ShippingOrderStatusCodeId;
                    result.TotalWeight = order.TotalWeight;
                    result.WeightUnitId = order.WeightUnitId;
                    result.Price = order.Price;
                    result.ReferenceCode = order.ReferenceOrderCode;
                    result.ShippingOrderCode = order.ShippingOrderCode;
                    result.ShippingOrderIdentityProfile = getShippingOrderIDProfile(order.ShippingOrderId, "");
                    result.LabelList = getShippingOrderLabelList(order.ShippingOrderId);
                    var tempList = db.tfnShippingOrderAdditionalInfoGet(order.ShippingOrderId, null);
                    if (tempList != null)
                    {
                        foreach (var temp in tempList)
                        {
                            result.PackageCount = temp.PackageCount;
                            result.ShippingOrderTaxPaymentTypeCodeId = temp.ShippingOrderTaxPaymentTypeCodeId;
                            result.ShippingOrderTaxPaymentType = temp.ShippingOrderTaxPaymentType;
                            break;
                        }
                    }
                    result.TaxPayment = GetTaxPayment(order.ShippingOrderId);
                    break;
                }
            }
            return result;
        }

        public static ANTOTOShippingOrderTaxPayment SetTaxPayment(ANTOTOShippingOrderTaxPayment taxPayment)
        {
            ANTOTOShippingOrderTaxPayment result = new ANTOTOShippingOrderTaxPayment();
            int? taxPaymentId = 0;
            antoto_dbDataContext db = new antoto_dbDataContext();
            db.sp_ANTOTOShippingOrderTaxPaymentSet(taxPayment.ShippingOrderId, taxPayment.TaxPaymentMethod, taxPayment.TaxPrice,
                taxPayment.CurrencyId, ref taxPaymentId);
            if(taxPaymentId > 0)
            {
                result = GetTaxPayment(taxPayment.ShippingOrderId);
            }
            else
            {
                result = null;
            }
            return result;
        }

        public static ANTOTOShippingOrderTaxPayment GetTaxPayment(int? ShippingOrderId)
        {
            ANTOTOShippingOrderTaxPayment result = new ANTOTOShippingOrderTaxPayment();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnShippingOrderTaxPaymentGet(ShippingOrderId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    result.ShippingOrderId = item.ShippingOrderId;
                    result.ShippingOrderTaxPaymentId = item.ShippingOrderTaxPaymentId;
                    result.TaxPaymentMethod = item.TaxPaymentMethod;
                    result.TaxPrice = item.TaxPrice;
                    result.CurrencyId = item.CurrencyId;
                    break;
                }
            }
            return result;
        }

        public static ANTOTOShippingOrder updateShippingChannel(int? ShippingOrderId, int? ShippingChannelId, int? UserId, int? CompanyId)
        {
            ANTOTOShippingOrder result = new ANTOTOShippingOrder();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? shippingOrderId = ShippingOrderId;
            db.sp_ANTOTOShippingOrderShippingChannelUpdate(ref shippingOrderId, ShippingChannelId, UserId, UserId, 1);
            if(shippingOrderId !=null && shippingOrderId > 0)
            {
                db.sp_ANTOTOShippingOrderPriceCalculate(shippingOrderId);
            }
            else
            {
                return null;
            }

            
            return GetShippingOrder(shippingOrderId);
        }

        public static List<LogisticCompany> getAllLogisticsCompanyList(int CompanyId)
        {
            List<LogisticCompany> result = new List<LogisticCompany>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnLogisticCompanyInfoGet(CompanyId);
            if (list != null && list.Count() > 0)
            {
                foreach(var item in list)
                {
                    LogisticCompany temp = new LogisticCompany();
                    temp.CompanyId = item.CompanyId;
                    temp.CompanyName = item.CompanyCode;
                    temp.Description = item.State;

                    result.Add(temp);
                }
            }
            return result;
        }

        public static ShippingChannel ShippingChannelSetLogistic(ShippingChannel shippingChannel, int? HandlerCompanyId, int? UserId)
        {
            ShippingChannel result = new ShippingChannel();

            antoto_dbDataContext db = new antoto_dbDataContext();

            int? ShippingChannelId = shippingChannel.ShippingChannelId == null? 0: shippingChannel.ShippingChannelId;

            db.sp_ShippingChannelLogisticCompany_Set(HandlerCompanyId, shippingChannel.ShippingChannelName,
                shippingChannel.ShippingChannelCode, shippingChannel.ShippingChannelTypeCodeId, shippingChannel.TaxRate, shippingChannel.PriceFirstRate,
                shippingChannel.PriceAdditionRate, shippingChannel.WeightUnit, shippingChannel.WeightFirst,
                shippingChannel.UnitPriceFirst, shippingChannel.UnitPriceAdditional, shippingChannel.JumpToInt,
                shippingChannel.TaxPaymentMethodAvailable, shippingChannel.Available, shippingChannel.IDCheckBeforeShipping, 
                shippingChannel.IDCheckDuplicateBeforeShipping, shippingChannel.IDDuplicateNumberLimitation,ref ShippingChannelId, UserId, 1);

            if(ShippingChannelId > 0)
            {
                if (shippingChannel.ServiceList != null)
                {
                    db.sp_ShippingChannelServiceClear(ShippingChannelId, UserId, 1);
                    foreach (var item in shippingChannel.ServiceList)
                    {
                        int? ShippingChannelServiceId = 0;
                        db.sp_ShippingChannelServiceUpdate(ShippingChannelId, item.ServiceName, item.ServicePrice,
                            item.CurrencyId, item.Optional, item.Available, UserId, 1, ref ShippingChannelServiceId);
                    }
                }
                result = getShippingChannel(ShippingChannelId.Value, HandlerCompanyId.Value);
            }
            else
            {
                result = null;
            }

            return result;
        }

        public static ShippingChannel ShippingChannelSetCompany(ShippingChannel shippingChannel, int? SourceCompanyId, int? UserId)
        {
            ShippingChannel result = new ShippingChannel();

            antoto_dbDataContext db = new antoto_dbDataContext();

            int? ShippingChannelCompanyId = shippingChannel.ShippingChannelCompanyId == null ? 0 : shippingChannel.ShippingChannelCompanyId;

            


            db.sp_ShippingChannelCompany_Set(shippingChannel.SourceCompanyId, shippingChannel.ShippingChannelId, shippingChannel.TaxRate,
                shippingChannel.PriceFirstRate, shippingChannel.PriceAdditionRate, shippingChannel.WeightUnit, shippingChannel.WeightFirst,
                shippingChannel.UnitPriceFirst, shippingChannel.UnitPriceAdditional, shippingChannel.JumpToInt, shippingChannel.TaxPaymentMethodAvailable,
                shippingChannel.Available, ref ShippingChannelCompanyId, UserId, 1);

            if(ShippingChannelCompanyId > 0)
            {
                result = getShippingChannel(shippingChannel.ShippingChannelId.Value, SourceCompanyId.Value);
            }
            else
            {
                result = null;
            }

            return result;
        }

        public static ShippingChannel ShippingChannelSetLogisticPriceRangeAdd(ShippingChannelPriceRange shippingChannelPriceRange, int? CompanyId, int? UserId)
        {
            ShippingChannel result = null;
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? pShippingChannelPriceRangeId = 0;
            db.sp_ShippingChannelPriceRangeEdit(shippingChannelPriceRange.ShippingChannelId, shippingChannelPriceRange.CurrencyId, shippingChannelPriceRange.WeightMax,
                ref pShippingChannelPriceRangeId, shippingChannelPriceRange.Price, UserId, 1);
            if(pShippingChannelPriceRangeId > 0)
            {
                result = getShippingChannel(shippingChannelPriceRange.ShippingChannelId.Value, CompanyId.Value);
            }
            
            return result;
        }

        public static ShippingChannel ShippingChannelSetCompanyPriceRangeAdd(ShippingChannelPriceRange shippingChannelPriceRange, int? CompanyId, int? UserId)
        {
            ShippingChannel result = null;
            antoto_dbDataContext db = new antoto_dbDataContext();
            db.sp_ShippingChannelPriceRangeCompanySet(shippingChannelPriceRange.ShippingChannelId, CompanyId, shippingChannelPriceRange.ShippingChannelPriceRangeId, shippingChannelPriceRange.Price,
                UserId, 1);
            result = getShippingChannel(shippingChannelPriceRange.ShippingChannelId.Value, CompanyId.Value);
            

            return result;
        }

        public static ShippingChannel ShippingChannelSetCompanyPriceRangeDelete(ShippingChannelPriceRange shippingChannelPriceRange, int? CompanyId, int? UserId)
        {
            ShippingChannel result = null;
            antoto_dbDataContext db = new antoto_dbDataContext();
            db.sp_ShippingChannelPriceRangeCompanyDelete(shippingChannelPriceRange.ShippingChannelId, CompanyId, shippingChannelPriceRange.ShippingChannelPriceRangeId, shippingChannelPriceRange.Price,
                UserId, 1);
            result = getShippingChannel(shippingChannelPriceRange.ShippingChannelId.Value, CompanyId.Value);


            return result;
        }

        public static ShippingChannel ShippingChannelSetLogisticPriceRangeEdit(ShippingChannelPriceRange shippingChannelPriceRange, int? CompanyId, int? UserId)
        {
            ShippingChannel result = null;
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? pShippingChannelPriceRangeId = shippingChannelPriceRange.ShippingChannelPriceRangeId;
            db.sp_ShippingChannelPriceRangeEdit(shippingChannelPriceRange.ShippingChannelId, shippingChannelPriceRange.CurrencyId, shippingChannelPriceRange.WeightMax,
                ref pShippingChannelPriceRangeId, shippingChannelPriceRange.Price, UserId, 1);
            if (pShippingChannelPriceRangeId > 0)
            {
                result = getShippingChannel(shippingChannelPriceRange.ShippingChannelId.Value, CompanyId.Value);
            }

            return result;
        }

        public static ShippingChannel ShippingChannelSetLogisticPriceRangeDelete(ShippingChannelPriceRange shippingChannelPriceRange, int? CompanyId, int? UserId)
        {
            ShippingChannel result = null;
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? pShippingChannelPriceRangeId = shippingChannelPriceRange.ShippingChannelPriceRangeId;
            db.sp_ShippingChannelPriceRangeDelete(ref pShippingChannelPriceRangeId, CompanyId, UserId, 1);
            if (pShippingChannelPriceRangeId > 0)
            {
                result = getShippingChannel(shippingChannelPriceRange.ShippingChannelId.Value, CompanyId.Value);
            }

            return result;
        }


        public static DataModel.ResultShippingOrderIdentityProfile getShippingOrderIDProfile(int? ShippingOrderId, string ShippingOrderCode)
        {
            DataModel.ResultShippingOrderIdentityProfile result = new DataModel.ResultShippingOrderIdentityProfile();
            antoto_dbDataContext db = new antoto_dbDataContext();

            var list = db.tfnShippingOrderIdentityProfileGet(ShippingOrderId, ShippingOrderCode);
            if (list != null)
            {
                foreach (var item in list)
                {
                    result.ShippingOrderIdentityProfileId = item.ShippingOrderIdentityProfileId;
                    result.PhoneNumber = item.PhoneNumber;
                    result.Name = item.Name;
                    result.ShippingOrderId = item.ShippingOrderId;
                    result.IDNumber = item.IdentityNumber;
                    result.FileList = ShippingOrderIdentityProfileFileListGet(item.ShippingOrderIdentityProfileId);
                    break;
                }
            }
            return result;
        }

        public static List<WizardForm.WizardInputFile> ShippingOrderIdentityProfileFileListGet(int? ShippingOrderIdentityProfileId)
        {
            List<WizardForm.WizardInputFile> result = new List<WizardForm.WizardInputFile>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnShippingOrderIdentityProfileFileGet(ShippingOrderIdentityProfileId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    WizardForm.WizardInputFile temp = new WizardForm.WizardInputFile();
                    temp = AntotoFile.getFileFromId(item.FileId);
                    result.Add(temp);
                }
            }
            return result;
        }
        
        public static List<DataModel.ResultShippingOrderLabel> getShippingOrderLabelList(int? ShippingOrderId)
        {
            List<DataModel.ResultShippingOrderLabel> result = new List<DataModel.ResultShippingOrderLabel>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnShippingOrderLabelListGet(ShippingOrderId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    DataModel.ResultShippingOrderLabel temp = new DataModel.ResultShippingOrderLabel();
                    temp.ShippingOrderLabelId = item.ShippingOrderLabelId;
                    temp.Order = item.Order;
                    temp.LabelName = item.LabelName;
                    temp.File = AntotoFile.getFileFromId(item.FileId);
                    result.Add(temp);
                }
            }
            //if(result.Count == 0)
            //{
            //    ParaDataModel.ParaShippingOrderPackage tt = new ParaDataModel.ParaShippingOrderPackage();
            //    tt.ShippingOrderId = ShippingOrderId;
            //    ShippingOrderAction.ShippingOrderGenerateLabel(tt, 1, 0);
            //}
            //var list1 = db.tfnShippingOrderLabelListGet(ShippingOrderId);
            //if (list1 != null)
            //{
            //    foreach (var item in list1)
            //    {
            //        DataModel.ResultShippingOrderLabel temp = new DataModel.ResultShippingOrderLabel();
            //        temp.ShippingOrderLabelId = item.ShippingOrderLabelId;
            //        temp.Order = item.Order;
            //        temp.LabelName = item.LabelName;
            //        temp.File = AntotoFile.getFileFromId(item.FileId);
            //        result.Add(temp);
            //    }
            //}

            return result;
        }

        public static DataModel.ResultShippingOrderLabel getShippingOrderLabel(int? ShippingOrderLabelId)
        {
            DataModel.ResultShippingOrderLabel result = new DataModel.ResultShippingOrderLabel();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnShippingOrderLabelGet(ShippingOrderLabelId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    DataModel.ResultShippingOrderLabel temp = new DataModel.ResultShippingOrderLabel();
                    temp.ShippingOrderLabelId = item.ShippingOrderLabelId;
                    temp.Order = item.Order;
                    temp.LabelName = item.LabelName;
                    temp.File = AntotoFile.getFileFromId(item.FileId);
                    result = temp;
                    break;
                }
            }
            return result;
        }

        public static DataModel.ResultPageResult ShippingOrderSearch(ParaDataModel.ParaShippingOrderSearch shippingOrderSearch, int pCompanyId, int pSystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? total = 0;
            int? totalPage = 0;
            int? Page = shippingOrderSearch.Page;
            int? NextPage = 0;
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
            var list = db.sp_ShippingOrderSearch(shippingOrderSearch.ShippingOrderCode, shippingOrderSearch.ReferenceOrderCode,
                shippingOrderSearch.SearchCustomerName, shippingOrderSearch.CountryNameText, shippingOrderSearch.PhoneNumber,
                shippingOrderSearch.ShippingOrderStatusCodeId, shippingOrderSearch.Address,
                shippingOrderSearch.SourceCompanyId, pCompanyId, shippingOrderSearch.IDReady, shippingOrderSearch.IDNumber,
                shippingOrderSearch.BatchRecordNumber, shippingOrderSearch.LabelReady, shippingOrderSearch.ProductName,
                shippingOrderSearch.BeginUtcDate, shippingOrderSearch.EndUtcDate
                , shippingOrderSearch.PageSize, ref Page, ref total, ref totalPage);
            if (list != null)
            {
                NextPage = Page < totalPage ? Page + 1 : totalPage;
                foreach (var item in list)
                {
                    string SFOrderCode = "";
                    db.sp_ShippingOrderSFOrderNumberGet(item.ShippingOrderId, ref SFOrderCode);
                    var currentobject = new DataModel.ResultShippingOrder
                    {
                        ShippingOrderId = item.ShippingOrderId,
                        Customer = CustomerManager.getCustomerById(item.CustomerId),
                        CustomerOrder = CustomerOrder.GetCustomerOrder(item.CustomerOrderId == null ? 0 : item.CustomerOrderId.Value),
                        ReferenceOrderCode = item.ReferenceOrderCode,
                        BatchHandlerNumber = item.BatchHandlerNumber,
                        ShippingFromAddress = ShippingOrder.GetShippingAddressById(item.ShippingFromAddressId),
                        ShippingToAddress = ShippingOrder.GetShippingAddressById(item.ShippingToAddressId),
                        ShippingChannel = ShippingOrder.getShippingChannel(item.ShippingChannelId == null ? 0 : item.ShippingChannelId.Value, item.SourceCompanyId),
                        Price = item.Price,
                        CurrencyId = item.CurrencyId,
                        TotalWeight = item.TotalWeight,
                        WeightUnitId = item.WeightUnitId,
                        ShippingOrderStatusCodeId = item.ShippingOrderStatusCodeId,
                        ShippingOrderStatus = item.ShippingOrderStatus,
                        ShippingOrderCode = item.ShippingOrderCode,
                        UserId = item.UserId,
                        CreateDate = item.CreateDate,
                        LastUpdate = item.LastUpdate,
                        ShippingOrderIdentityProfile = getShippingOrderIDProfile(item.ShippingOrderId, ""),
                        LabelReady = item.LabelReady,
                        LabelList = getShippingOrderLabelList(item.ShippingOrderId),
                        TaxPayment = GetTaxPayment(item.ShippingOrderId),
                        PaidPrice = item.Price - db.sfnShippingOrderUnPaidPrice(item.ShippingOrderId, null),
                        SFOrderCode = SFOrderCode
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
        
        public static DataModel.ResultPageResult ShippingOrderSearchByCustomer(ParaDataModel.ParaShippingOrderSearch shippingOrderSearch, int pCompanyId, int pSystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? total = 0;
            int? totalPage = 0;
            int? Page = shippingOrderSearch.Page;
            int? NextPage = 0;
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
            var list = db.sp_ShippingOrderSearch(shippingOrderSearch.ShippingOrderCode, shippingOrderSearch.ReferenceOrderCode,
                shippingOrderSearch.SearchCustomerName, shippingOrderSearch.CountryNameText, shippingOrderSearch.PhoneNumber,
                shippingOrderSearch.ShippingOrderStatusCodeId, shippingOrderSearch.Address,
                pCompanyId, null, shippingOrderSearch.IDReady, shippingOrderSearch.IDNumber,
                shippingOrderSearch. BatchRecordNumber, shippingOrderSearch.LabelReady, shippingOrderSearch.ProductName,
                shippingOrderSearch.BeginUtcDate, shippingOrderSearch.EndUtcDate
                , shippingOrderSearch.PageSize, ref Page, ref total, ref totalPage);
            if (list != null)
            {
                NextPage = Page < totalPage ? Page + 1 : totalPage;
                foreach (var item in list)
                {
                    string SFOrderCode = "";
                    db.sp_ShippingOrderSFOrderNumberGet(item.ShippingOrderId, ref SFOrderCode);
                    var currentobject = new DataModel.ResultShippingOrder
                    {
                        ShippingOrderId = item.ShippingOrderId,
                        Customer = CustomerManager.getCustomerById(item.CustomerId),
                        CustomerOrder = CustomerOrder.GetCustomerOrder(item.CustomerOrderId == null ? 0 : item.CustomerOrderId.Value),
                        ReferenceOrderCode = item.ReferenceOrderCode,
                        BatchHandlerNumber = item.BatchHandlerNumber,
                        ShippingFromAddress = ShippingOrder.GetShippingAddressById(item.ShippingFromAddressId),
                        ShippingToAddress = ShippingOrder.GetShippingAddressById(item.ShippingToAddressId),
                        ShippingChannel = ShippingOrder.getShippingChannel(item.ShippingChannelId == null ? 0 : item.ShippingChannelId.Value, item.SourceCompanyId),
                        Price = item.Price,
                        CurrencyId = item.CurrencyId,
                        TotalWeight = item.TotalWeight,
                        WeightUnitId = item.WeightUnitId,
                        ShippingOrderStatusCodeId = item.ShippingOrderStatusCodeId,
                        ShippingOrderStatus = item.ShippingOrderStatus,
                        ShippingOrderCode = item.ShippingOrderCode,
                        UserId = item.UserId,
                        CreateDate = item.CreateDate,
                        LastUpdate = item.LastUpdate,
                        ShippingOrderIdentityProfile = getShippingOrderIDProfile(item.ShippingOrderId, ""),
                        LabelReady = item.LabelReady,
                        LabelList = getShippingOrderLabelList(item.ShippingOrderId),
                        TaxPayment = GetTaxPayment(item.ShippingOrderId),
                        PaidPrice = item.Price - db.sfnShippingOrderUnPaidPrice(item.ShippingOrderId, null),
                        SFOrderCode = SFOrderCode
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

        public static List<DataModel.ResultShippingOrderCompanyTransaction> getTransactionListForShippingOrder(int? ShippingOrderId)
        {
            List<DataModel.ResultShippingOrderCompanyTransaction> result = new List<DataModel.ResultShippingOrderCompanyTransaction>();

            antoto_dbDataContext db = new antoto_dbDataContext();

            var list = db.tfnShippingOrderCompanyTransactionListGet(ShippingOrderId);

            if (list != null)
            {
                foreach(var item in list)
                {
                    DataModel.ResultShippingOrderCompanyTransaction temp = new DataModel.ResultShippingOrderCompanyTransaction();
                    temp.CompanyTransactionId = item.CompanyTransactionId;
                    temp.CompanyId = item.CompanyId;
                    temp.CompanyName = item.CompanyName;
                    temp.Currency = item.Currency;
                    temp.CurrencyId = item.CurrencyId;
                    temp.Description = item.Description;
                    temp.IsSourceCompany = item.isSourceCompany;
                    temp.TransactionType = item.TransactionTypeCode;
                    temp.TransactionTypeCodeId = item.TransactionTypeCodeId;
                    temp.UserId = item.UserId;
                    temp.UserName = item.UserName;
                    temp.Amount = item.Amount;
                    result.Add(temp);
                }
            }

            return result;
        }

        public static List<DataModel.ResultShippingOrderSubOrder> getSubOrderList(ParaDataModel.ParaShippingOrderPackage paraShippingOrderPackage)
        {
            List<DataModel.ResultShippingOrderSubOrder> result = new List<DataModel.ResultShippingOrderSubOrder>();

            antoto_dbDataContext db = new antoto_dbDataContext();

            var list = db.tfnShippingOrderSubOrderListGet(paraShippingOrderPackage.ShippingOrderId, paraShippingOrderPackage.ShippingOrderCode);

            if (list != null)
            {
                foreach (var item in list)
                {
                    SubOrderRoutingTrack(item.ShippingOrderSubOrderId);
                    DataModel.ResultShippingOrderSubOrder temp = new DataModel.ResultShippingOrderSubOrder();
                    temp.ShippingOrderId = item.ShippingOrderId;
                    temp.ShippingOrderSubOrderId = item.ShippingOrderSubOrderId;
                    temp.SubOrderCode = item.SubOrderCode;
                    temp.SubOrderType = item.SubOrderType;
                    temp.SubOrderTypeCodeId = item.SubOrderTypeCodeId;
                    temp.SubOrderDescription = item.SubOrderDescription;
                    temp.RoutingTransactionList = getRoutingTransactionList(item.ShippingOrderSubOrderId);
                    result.Add(temp);
                }
            }

            return result;
        }

        public static List<DataModel.ResultShippingOrderSubOrder> getSubOrderListByOrderId(int? ShippingOrderId)
        {
            List<DataModel.ResultShippingOrderSubOrder> result = new List<DataModel.ResultShippingOrderSubOrder>();

            antoto_dbDataContext db = new antoto_dbDataContext();

            var list = db.tfnShippingOrderSubOrderListGet(ShippingOrderId, null);

            if (list != null)
            {
                foreach (var item in list)
                {
                    SubOrderRoutingTrack(item.ShippingOrderSubOrderId);
                    DataModel.ResultShippingOrderSubOrder temp = new DataModel.ResultShippingOrderSubOrder();
                    temp.ShippingOrderId = item.ShippingOrderId;
                    temp.ShippingOrderSubOrderId = item.ShippingOrderSubOrderId;
                    temp.SubOrderCode = item.SubOrderCode;
                    temp.SubOrderType = item.SubOrderType;
                    temp.SubOrderTypeCodeId = item.SubOrderTypeCodeId;
                    temp.SubOrderDescription = item.SubOrderDescription;
                    temp.RoutingTransactionList = getRoutingTransactionList(item.ShippingOrderSubOrderId);
                    result.Add(temp);
                }
            }

            return result;
        }

        public static DataModel.ResultShippingOrderSubOrder getSubOrder(int? SubOrderId, string SubOrderCode)
        {
            DataModel.ResultShippingOrderSubOrder result = new DataModel.ResultShippingOrderSubOrder();

            antoto_dbDataContext db = new antoto_dbDataContext();

            var list = db.tfnShippingOrderSubOrderGet(SubOrderId, SubOrderCode);

            if (list != null)
            {
                foreach (var item in list)
                {
                    DataModel.ResultShippingOrderSubOrder temp = new DataModel.ResultShippingOrderSubOrder();
                    temp.ShippingOrderId = item.ShippingOrderId;
                    temp.ShippingOrderSubOrderId = item.ShippingOrderSubOrderId;
                    temp.SubOrderCode = item.SubOrderCode;
                    temp.SubOrderType = item.SubOrderType;
                    temp.SubOrderTypeCodeId = item.SubOrderTypeCodeId;
                    temp.SubOrderDescription = item.SubOrderDescription;
                    temp.RoutingTransactionList = getRoutingTransactionList(item.ShippingOrderSubOrderId);
                    result = temp;
                    break;
                }
            }

            return result;
        }

        public static List<DataModel.ResultShippingOrderRoutingTransaction> getRoutingTransactionList(int? ShippingOrderSubOrderId)
        {
            List<DataModel.ResultShippingOrderRoutingTransaction> result = new List<DataModel.ResultShippingOrderRoutingTransaction>();

            antoto_dbDataContext db = new antoto_dbDataContext();

            var list = db.tfnShippingOrderSubOrderRoutingTransactionListGet(ShippingOrderSubOrderId);

            if (list != null)
            {
                foreach(var item in list)
                {
                    DataModel.ResultShippingOrderRoutingTransaction temp = new DataModel.ResultShippingOrderRoutingTransaction();
                    temp.ShippingOrderSubOrderId = item.ShippingOrderSubOrderId;
                    temp.ShippingOrderOrderRoutingTransactionId = item.ShippingOrderSubOrderRoutingTrackId;
                    temp.SourceId = item.SourceId;
                    temp.SourceTable = item.SourceTable;
                    temp.UserId = item.UserId;
                    temp.UserName = item.UserName;
                    temp.AcceptedAddress = item.AcceptedAddress;
                    temp.AcceptTime = item.AcceptTime;
                    temp.OpCode = item.OpCode;
                    temp.RemarkDetail = item.RemarkDetail;
                    result.Add(temp);
                }
            }

            return result;
        }

        public static DataModel.ResultShippingOrderSubOrder ShippingOrderSubOrderCreate(DataModel.ResultShippingOrderSubOrder subOrder, int? UserId, int? CompanyId)
        {
            DataModel.ResultShippingOrderSubOrder result = new DataModel.ResultShippingOrderSubOrder();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? ShippingOrderSubOrderId = 0;
            db.sp_ShippingOrderSubOrderInsert(subOrder.ShippingOrderId, subOrder.SubOrderTypeCodeId, subOrder.SubOrderCode, subOrder.SubOrderDescription, UserId, UserId, 1, ref ShippingOrderSubOrderId);
            if(ShippingOrderSubOrderId > 0)
            {
                if (subOrder.RoutingTransactionList != null)
                {
                    foreach(var item in subOrder.RoutingTransactionList)
                    {
                        ShippingOrderSubOrderRoutingTrack(item, UserId, CompanyId);
                    }
                }
                result = getSubOrder(ShippingOrderSubOrderId, null);
            }
            else
            {
                result = null;
            }
            return result;
        }

        public static bool ShippingOrderSubOrderDelete(DataModel.ResultShippingOrderSubOrder subOrder, int? UserId, int? CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? ShippingOrderSubOrderId = subOrder.ShippingOrderSubOrderId;
            db.sp_ShippingOrderSubOrderDelete(subOrder.ShippingOrderSubOrderId);
            
            return true;
        }
        
        public static DataModel.ResultShippingOrderSubOrder ShippingOrderSubOrderRoutingTrack(DataModel.ResultShippingOrderRoutingTransaction track, int? UserId, int? CompanyId)
        {
            DataModel.ResultShippingOrderSubOrder result = new DataModel.ResultShippingOrderSubOrder();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? ShippingOrderSubOrderRoutingTrackId = track.ShippingOrderOrderRoutingTransactionId == null ? 0 :track.ShippingOrderOrderRoutingTransactionId;
            db.sp_ShippingOrderSubOrderTrackRecordInsert(track.ShippingOrderSubOrderId, track.AcceptedAddress,
                track.OpCode, track.RemarkDetail, track.AcceptTime == null ? DateTime.UtcNow : track.AcceptTime, track.SourceId, track.SourceTable,
                UserId, true, ref ShippingOrderSubOrderRoutingTrackId);
            
            if (ShippingOrderSubOrderRoutingTrackId > 0)
            {
                result = getSubOrder(track.ShippingOrderSubOrderId, null);
            }
            else
            {
                result = null;
            }

            return result;
        }

        public static DataModel.ResultShippingOrderSubOrder ShippingOrderSubOrderRoutingTrackDelete(DataModel.ResultShippingOrderRoutingTransaction track, int? UserId, int? CompanyId)
        {
            DataModel.ResultShippingOrderSubOrder result = new DataModel.ResultShippingOrderSubOrder();
            antoto_dbDataContext db = new antoto_dbDataContext();

            int? ShippingOrderSubOrderRoutingTrackId = track.ShippingOrderOrderRoutingTransactionId;
            db.sp_ShippingOrderSubOrderTrackRecordInsert(track.ShippingOrderSubOrderId, track.AcceptedAddress,
                track.OpCode, track.RemarkDetail, track.AcceptTime == null ? DateTime.UtcNow : track.AcceptTime, track.SourceId, track.SourceTable,
                UserId, false, ref ShippingOrderSubOrderRoutingTrackId);

            if (ShippingOrderSubOrderRoutingTrackId > 0)
            {
                result = getSubOrder(track.ShippingOrderSubOrderId, null);
            }
            else
            {
                result = null;
            }
            return result;
        }
        
        public static void SubOrderRoutingTrack(int? ShippingOrderSubOrderId)
        {
                DataModel.ResultShippingOrderSubOrder subOrder = getSubOrder(ShippingOrderSubOrderId, null);
                antoto_dbDataContext db = new antoto_dbDataContext();
                if (subOrder != null)
                {
                    if (subOrder.SubOrderTypeCodeId == 1)
                    {

                    }
                    else if (subOrder.SubOrderTypeCodeId == 2)
                    {

                    }
                    else if (subOrder.SubOrderTypeCodeId == 3)
                    {

                    }
                    else if (subOrder.SubOrderTypeCodeId == 4)
                    {
                        //SFExpress
                        SFExpressHandler.SFOrderRouteSearch search = new SFExpressHandler.SFOrderRouteSearch();
                        search.Routes = new List<SFExpressHandler.Route>();
                        SFExpressHandler.Route route = new SFExpressHandler.Route();
                        route.SfWaybillNo = subOrder.SubOrderCode.Replace("SF","");
                        route.TrackingType = 1;
                        search.Routes.Add(route);
                        var temp = SFExpressHandler.GetSFExpressOrderRouting(search);
                        if (temp != null)
                        {
                            if (temp.Success == true)
                            {
                                if (temp.Data != null)
                                {
                                    foreach (var item in temp.Data)
                                    {
                                        var RouteList = item.Routes;
                                        if (RouteList != null && RouteList.Count > 0)
                                        {
                                            //db.sp_ShippingOrderSubOrderTrackRecordClear(subOrder.ShippingOrderSubOrderId);
                                            foreach (var routeItem in RouteList)
                                            {
                                                DataModel.ResultShippingOrderRoutingTransaction transaction = new DataModel.ResultShippingOrderRoutingTransaction();
                                                transaction.ShippingOrderSubOrderId = subOrder.ShippingOrderSubOrderId;
                                                transaction.ShippingOrderOrderRoutingTransactionId = 0;
                                                transaction.RemarkDetail = routeItem.Remark;
                                                transaction.OpCode = routeItem.OpCode;
                                                transaction.AcceptedAddress = routeItem.AcceptAddress;
                                                transaction.AcceptTime = routeItem.AcceptTime;
                                                var tempResult = ShippingOrderSubOrderRoutingTrack(transaction, 1, 0);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else if (subOrder.SubOrderTypeCodeId == 5)
                    {

                    }
                    else
                    {

                    }
                }
        }

        public static void SFShippingOrderTrackProcess()
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnSFShippingOrderNeedTrack();
            if(list!= null)
            {
                foreach(var item in list)
                {
                    SubOrderRoutingTrack(item.ShippingOrderSubOrderId);
                }
            }
        }

        


        public static string ShippingOrderCreatePreCheck(ParaDataModel.ParaShippingOrder paraShippingOrder, int CompanyId, int UserId)
        {
            string result = "";
            if(paraShippingOrder == null)
            {
                result = "没有提交任何包裹数据";
                return result;
            }
            else
            {
                if(paraShippingOrder.HanlderCompanyId == null || paraShippingOrder.HanlderCompanyId <= 0)
                {
                    result = "未选择门店";
                    return result;
                }

                if(paraShippingOrder.PackageCount == null || paraShippingOrder.PackageCount <= 0)
                {
                    result = "包裹数无效 请填写1以上整数";
                    return result;
                }

                if(paraShippingOrder.ShippingChannelId == null || paraShippingOrder.ShippingChannelId <= 0)
                {
                    result = "未选择渠道";
                    return result;
                }

                if(paraShippingOrder.ShippingOrderTaxPaymentTypeCodeId == null || paraShippingOrder.ShippingOrderTaxPaymentTypeCodeId <= 0)
                {
                    result = "未选择付税方";
                    return result;
                }

                if(paraShippingOrder.CurrencyId == null || paraShippingOrder.CurrencyId <= 0)
                {
                    result = "未选择货币种类";
                    return result;
                }

                if(paraShippingOrder.ItemList == null || paraShippingOrder.ItemList.Count <= 0)
                {
                    result = "未填加任何商品";
                    return result;
                }

                if(paraShippingOrder.ItemList != null)
                {
                    foreach(var item in paraShippingOrder.ItemList)
                    {
                        if (String.IsNullOrEmpty(item.ItemName))
                        {
                            result = "请填写商品名称";
                            return result;
                        }
                        if (String.IsNullOrEmpty(item.Brand))
                        {
                            result = "请填写 " + item.ItemName + "的品牌";
                            return result;
                        }
                        if(item.Price == null || item.Price <= 0)
                        {
                            result = "请填写 " + item.ItemName + "的申报价格";
                            return result;
                        }
                        if(item.Quantity == null || item.Quantity <= 0)
                        {
                            result = "请填写 " + item.ItemName + "的数量";
                            return result;
                        }
                        if (String.IsNullOrEmpty(item.SourceArea))
                        {
                            result = "请填写 " + item.ItemName + "的产地，默认可填写US";
                            return result;
                        }
                        if (String.IsNullOrEmpty(item.Unit))
                        {
                            result = "请填写 " + item.ItemName + "的单位，默认可填写 ‘件’";
                            return result;
                        }
                    }
                }

                if(paraShippingOrder.ShipperAddress == null)
                {
                    result = "请输入寄件方地址";
                    return result;
                }
                else
                {
                    if (String.IsNullOrEmpty(paraShippingOrder.ShipperAddress.ContactFirstName))
                    {
                        result = "请填写寄件方名";
                        return result;
                    }

                    if (String.IsNullOrEmpty(paraShippingOrder.ShipperAddress.ContactLastName))
                    {
                        result = "请填写寄件方姓";
                        return result;
                    }

                    if (String.IsNullOrEmpty(paraShippingOrder.ShipperAddress.ContactPhone))
                    {
                        result = "请填写寄件方电话号码";
                        return result;
                    }

                    if (paraShippingOrder.ShipperAddress.ContactPhoneCountryId == null || paraShippingOrder.ShipperAddress.ContactPhoneCountryId <= 0)
                    {
                        result = "请选择寄件方电话号码地区";
                        return result;
                    }

                    if (String.IsNullOrEmpty(paraShippingOrder.ShipperAddress.Address_1))
                    {
                        result = "请填写寄件方地址1";
                        return result;
                    }

                    if (String.IsNullOrEmpty(paraShippingOrder.ShipperAddress.City))
                    {
                        result = "请填写寄件方地址城市";
                        return result;
                    }

                    if (String.IsNullOrEmpty(paraShippingOrder.ShipperAddress.State))
                    {
                        result = "请填写寄件方地址省份或州";
                        return result;
                    }

                    if (String.IsNullOrEmpty(paraShippingOrder.ShipperAddress.Zip))
                    {
                        result = "请填写寄件方邮编";
                        return result;
                    }

                    if (paraShippingOrder.ShipperAddress.CountryId == null || paraShippingOrder.ShipperAddress.CountryId <= 0)
                    {
                        result = "请选择寄件方地址所在地区或国家";
                        return result;
                    }
                }

                if (paraShippingOrder.ReceiverAddress == null)
                {
                    result = "请输入收件方地址";
                    return result;
                }
                else
                {
                    if (String.IsNullOrEmpty(paraShippingOrder.ReceiverAddress.ContactFirstName))
                    {
                        result = "请填写收件方名";
                        return result;
                    }

                    if (String.IsNullOrEmpty(paraShippingOrder.ReceiverAddress.ContactLastName))
                    {
                        result = "请填写收件方姓";
                        return result;
                    }

                    if (String.IsNullOrEmpty(paraShippingOrder.ReceiverAddress.ContactPhone))
                    {
                        result = "请填写收件方电话号码";
                        return result;
                    }

                    if (paraShippingOrder.ReceiverAddress.ContactPhoneCountryId == null || paraShippingOrder.ReceiverAddress.ContactPhoneCountryId <= 0)
                    {
                        result = "请选择收件方电话号码地区";
                        return result;
                    }

                    if (String.IsNullOrEmpty(paraShippingOrder.ReceiverAddress.Address_1))
                    {
                        result = "请填写收件方地址1";
                        return result;
                    }

                    if (String.IsNullOrEmpty(paraShippingOrder.ReceiverAddress.City))
                    {
                        result = "请填写收件方地址城市";
                        return result;
                    }

                    if (String.IsNullOrEmpty(paraShippingOrder.ReceiverAddress.State))
                    {
                        result = "请填写收件方地址省份或州";
                        return result;
                    }

                    if (String.IsNullOrEmpty(paraShippingOrder.ReceiverAddress.Zip))
                    {
                        result = "请填写收件方邮编";
                        return result;
                    }

                    if (paraShippingOrder.ReceiverAddress.CountryId == null || paraShippingOrder.ReceiverAddress.CountryId <= 0)
                    {
                        result = "请选择收件方地址所在地区或国家";
                        return result;
                    }
                }
            }
            return result;
        }

        
    }

    


    
}
