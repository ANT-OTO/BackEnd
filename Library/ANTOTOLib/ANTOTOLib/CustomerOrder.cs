using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public class CustomerOrder
    {
        public class CustomerOrderDetail
        {
            public string CustomerOrderCode { get; set; }
            public int? Customer_OrderId { get; set; }
            public List<CustomerOrderItem> ItemList { get; set; }
            public CustomerManager.CustomerAddress ShippingAddress { get; set; }
            public CustomerManager.Customer BuyerInfo { get; set; }
            public List<OrderPaymentDetail> PaymentInfoList { get; set; }
            public decimal? TotalAmount { get; set; }
            public DateTime? CreateDate { get; set; }
        }

        public class OrderPaymentDetail
        {
            public string PaymentDetail { get; set; }
            public string PaymentMethodCode { get; set; }
            public decimal? Amount { get; set; }
            public int? CurrencyId { get; set; }
            public DateTime? CreateDate { get; set; }
        }

        public class CustomerOrderItem
        {
            public DataModel.ItemOnSaleDetail Item { get; set; }

            public int? Quantity { get; set; }

            public decimal? Price { get; set; }

            public decimal? TotalAmount { get; set; }

        }

        public static CustomerOrderDetail createOrderFromShoppingCart(int CustomerId, int CustomerAddressId, string DiscountCode, int CompanyId)
        {
            CustomerOrderDetail result = null;
            var list = CustomerManager.getShoppingCartContent(CustomerId);
            if(list!=null && list.ItemList !=null && list.ItemList.Count > 0)
            {
                antoto_dbDataContext db = new antoto_dbDataContext();
                int? Customer_OrderId = 0;
                db.sp_Customer_OrderCreate(CustomerId, CustomerAddressId, DiscountCode, CompanyId, 1, ref Customer_OrderId);
                if (Customer_OrderId > 0)
                {
                    foreach(var item in list.ItemList)
                    {
                        int? Customer_Order_ItemId = 0;
                        db.sp_Customer_OrderItemInsert(Customer_OrderId, item.Item.ItemId,
                            item.Price, item.Quantity, item.Item.CurrencyId, 1, ref Customer_Order_ItemId);
                    }

                    db.sp_Customer_OrderPriceCalculate(Customer_OrderId, DiscountCode);
                    result = GetCustomerOrder(Customer_OrderId.Value);
                    CustomerManager.clearItemInShoppingCart(CustomerId);
                    return result;
                }
                else
                {
                    return null;
                }
            }
            else
            {
                return null;
            }
            
            
        }

        public static CustomerOrderDetail GetCustomerOrder(int CustomerOrderId)
        {
            CustomerOrderDetail result = new CustomerOrderDetail();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnCustomer_OrderGet(CustomerOrderId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    result.Customer_OrderId = item.Customer_OrderId;
                    result.CustomerOrderCode = item.OrderCode;
                    result.CreateDate = item.Date_Placed;
                    result.BuyerInfo = CustomerManager.getCustomerById(item.CustomerId);
                    result.ItemList = getCustomerOrderItems(CustomerOrderId);
                    var paymentList = db.tfnCustomer_OrderPaymentGet(CustomerOrderId);
                    if (paymentList != null)
                    {
                        foreach(var payment in paymentList)
                        {
                            if(result.PaymentInfoList == null)
                            {
                                result.PaymentInfoList = new List<OrderPaymentDetail>();
                            }
                            OrderPaymentDetail temp = new OrderPaymentDetail();
                            temp.PaymentMethodCode = payment.Customer_Order_PaymentMethodCode;
                            temp.Amount = payment.TotalAmount;
                            temp.CreateDate = payment.CreateDate;
                            temp.CurrencyId = payment.CurrencyId;
                            temp.PaymentDetail = payment.Detail;
                            result.PaymentInfoList.Add(temp);
                        }
                    }
                    result.ShippingAddress = CustomerManager.GetCustomerAddressById(item.CustomerAddressId);
                    result.TotalAmount = item.TotalPriceAmount;
                    break;
                }
            }
            return result;
        }

        public static List<CustomerOrderItem> getCustomerOrderItems(int CustomerOrderId)
        {
            List<CustomerOrderItem> result = new List<CustomerOrderItem>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnCustomer_OrderItemsGet(CustomerOrderId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    CustomerOrderItem temp = new CustomerOrderItem();
                    temp.Item = ProductOnSaleManager.getItemOnSaleByItemId(item.ItemId, 1);
                    temp.Price = item.UnitAmount;
                    temp.Quantity = item.Quantity;
                    temp.TotalAmount = item.TotalAmount;
                    result.Add(temp);
                }
            }
            return result;
        }

        public static CustomerOrderDetail createOrderFromScatch(ParaDataModel.ParaOrderCreate package ,int UserId, int CompanyId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            CustomerOrderDetail result = null;
            int? Customer_OrderId = 0;
            db.sp_Customer_OrderCreate(package.CustomerId, package.CustomerId, package.DiscountCode, CompanyId, UserId, ref Customer_OrderId);
            if (Customer_OrderId > 0)
            {
                foreach (var item in package.ItemList)
                {
                    int? Customer_Order_ItemId = 0;
                    db.sp_Customer_OrderItemInsert(Customer_OrderId, item.ItemId,
                        item.Price, item.Quantity, item.CurrencyId, 1, ref Customer_Order_ItemId);
                }

                db.sp_Customer_OrderPriceCalculate(Customer_OrderId, package.DiscountCode);
                result = GetCustomerOrder(Customer_OrderId.Value);
                return result;
            }
            else
            {
                return null;
            }
        }

        public static DataModel.ResultPageResult CustomerOrderSearch(ParaDataModel.ParaCustomerOrderSearch customerOrderSearch, int pCompanyId, int pSystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? total = 0;
            int? totalPage = 0;
            int? Page = customerOrderSearch.Page;
            int? NextPage = 0;
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
            var list = db.sp_Customer_OrderSearch(customerOrderSearch.ProductName, customerOrderSearch.CustomerName,
                customerOrderSearch.CustomerThirdPartyId, customerOrderSearch.CustomerTypeCodeId,
                customerOrderSearch.DateStart, customerOrderSearch.DateEnd, customerOrderSearch.CustomerOrderStatusCodeId,
                customerOrderSearch.Paided, customerOrderSearch.AddressSearchWord, pCompanyId, pSystemLanguageId
                , customerOrderSearch.PageSize, ref Page, ref total, ref totalPage);
            if (list != null)
            {
                NextPage = Page < totalPage ? Page + 1 : totalPage;
                foreach (var item in list)
                {
                    var currentobject = CustomerOrder.GetCustomerOrder(item.Customer_OrderId);
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

        public static DataModel.ResultPageResult CustomerOrderSearchByCustomer(ParaDataModel.ParaCustomerOrderSearchByCustomer customerOrderSearch, int CustomerId, int pCompanyId, int pSystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? total = 0;
            int? totalPage = 0;
            int? Page = customerOrderSearch.Page;
            int? NextPage = 0;
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
            var list = db.sp_Customer_OrderSearchByCustomer(customerOrderSearch.ProductName, CustomerId,
                customerOrderSearch.DateStart, customerOrderSearch.DateEnd, customerOrderSearch.CustomerOrderStatusCodeId,
                customerOrderSearch.Paided, customerOrderSearch.AddressSearchWord, pCompanyId, pSystemLanguageId
                , customerOrderSearch.PageSize, ref Page, ref total, ref totalPage);
            if (list != null)
            {
                NextPage = Page < totalPage ? Page + 1 : totalPage;
                foreach (var item in list)
                {
                    var currentobject = CustomerOrder.GetCustomerOrder(item.Customer_OrderId);
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
        
    }

    
}
