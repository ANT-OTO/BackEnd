using System;
using System.IO;
using System.Reflection;
using System.Threading;
using System.Text;
using System.Net;
using System.Collections.Generic;

namespace ANTOTOLib
{
    public class SFExpressHandler
    {
        //public static string BaseUrl = "https://sit.api.sf-express-us.com/";
        //public static string UserName = "90000001";
        //public static string PassWord = "b9rVZekQqY2bv6ds";
        public static string BaseUrl = "https://usshipapi.sf-express.com/";
        public static string UserName = "90000037";
        public static string PassWord = "g+EQ`g&ev2*~>,5N";

        public class Item
        {
            public string GoodsCode { get; set; }
            public string Name { get; set; }
            public int Count { get; set; }
            public string Unit { get; set; }
            public double Amount { get; set; }
            public double Weight { get; set; }
            public string SourceArea { get; set; }
            public string Brand { get; set; }
            public string Specifications { get; set; }
            public string StateBarCode { get; set; }
        }

        public class Order
        {
            public string MailNo { get; set; }
            public string CneeContactName { get; set; }
            public string CneeCompany { get; set; }
            public string CneeAddress { get; set; }
            public string CneeCity { get; set; }
            public string CneeProvince { get; set; }
            public string CneeCountry { get; set; }
            public string CneePostCode { get; set; }
            public string CneePhone { get; set; }
            public string CneeEmail { get; set; }
            public string SenderContactName { get; set; }
            public string SenderPhone { get; set; }
            public string SenderAddress { get; set; }
            public string SenderCity { get; set; }
            public string SenderProvince { get; set; }
            public string SenderEmail { get; set; }
            public string SenderPostCode { get; set; }
            public string ReferenceNo1 { get; set; }
            public string ReferenceNo2 { get; set; }
            public string ExpressType { get; set; }
            public int ParcelQuantity { get; set; }
            public int PayMethod { get; set; }
            public int TaxPayType { get; set; }
            public string Currency { get; set; }
            public string TaxFee { get; set; }
            public string Freight { get; set; }
            public string DiscountAmount { get; set; }
            public string TransactionAmount { get; set; }
            public string PaymentTool { get; set; }
            public string PaymentNumber { get; set; }
            public string PaymentTime { get; set; }
            public string PromotionType { get; set; }
            public string BuyersNickName { get; set; }
            public int OrderCertType { get; set; }
            public string OrderCertNo { get; set; }
            public int PrintSize { get; set; }
            public List<Item> Items { get; set; }
        }

        public class PickUpOptions
        {
            public string PickUpDay { get; set; }
            public string ReadyTime { get; set; }
            public string CloseTime { get; set; }
        }

        public class NetworkCredential
        {
            public string UserName { get; set; }
            public string Password { get; set; }
        }

        public class SFExpressOrder
        {
            public Order Order { get; set; }
            public string GateWay { get; set; }
            public string FirstMileType { get; set; }
            public PickUpOptions PickUpOptions { get; set; }
            public NetworkCredential NetworkCredential { get; set; }
        }

        public class SFExpressOrderResult
        {
            public bool? Success { get; set; }
            public SFExpressOrderResultDetail Data { get; set; }
        }

        public class SFExpressOrderResultDetail
        {
            public string Code { get; set; }
            public string Message { get; set; }
            public string Result { get; set; }
            public string LabelToPrint { get; set; }
            public string InvoiceToPrint { get; set; }
            public int? FirstMileType { get; set; }
            public int? OrderId { get; set; }
            public string Hawbs { get; set; }
            public string OriginCode { get; set; }
            public string DestDistrictCode { get; set; }
        }

        public class SFExpressOrderSearch
        {
            public OrderSearch OrderSearch { get; set; }

            public NetworkCredential NetworkCredential { get; set; }
        }

        public class OrderSearch
        {
            public string OrderId { get; set; }
        }

        public class OrderParam
        {
            public string SfWaybillNo { get; set; }
            public string CancelType { get; set; }  //1. cancel order pickup only
                                                    //2. cancel whole order
        }

        public class Route
        {
            public string SfWaybillNo { get; set; }
            public int TrackingType { get; set; } //1. Tracking by S.F Waybill number
        }

        public class SFOrderRouteSearch
        {
            public List<Route> Routes { get; set; }
            public NetworkCredential NetworkCredential { get; set; }
        }

        public class Datum
        {
            public List<DatumRoute> Routes { get; set; }
            public string SfWaybillNo { get; set; }
            public bool Result { get; set; }
        }

        public class DatumRoute
        {
            public DateTime? AcceptTime { get; set; }
            public string AcceptAddress { get; set; }
            public string Remark { get; set; }
            public string OpCode { get; set; }
        }

        public class SFOrderRouteSearchResult
        {
            public bool Success { get; set; }
            public List<Datum> Data { get; set; }
        }

        public class SFOrderCancel
        {
            public OrderParam OrderParam { get; set; }
            public NetworkCredential NetworkCredential { get; set; }
        }

        public static NetworkCredential GetNetworkCredential()
        {
            NetworkCredential result = new NetworkCredential();
            result.UserName = UserName;
            result.Password = PassWord;
            return result;
        }

        public static SFExpressOrder getSFExpressOrder(ShippingOrder.ANTOTOShippingOrder shippingOrder)
        {
            SFExpressOrder result = new SFExpressOrder();
            result.FirstMileType = "2";
            result.GateWay = "JFK";
            result.NetworkCredential = GetNetworkCredential();
            result.Order = getSFExpressOrderOrder(shippingOrder);
            return result;
        } 

        public static Order getSFExpressOrderOrder(ShippingOrder.ANTOTOShippingOrder shippingOrder)
        {
            Order result = new Order();
            result.BuyersNickName = "";
            result.PrintSize = 1;
            result.CneeAddress = shippingOrder.ToShippingAddress.Address_1 + "" + shippingOrder.ToShippingAddress.Address_2;
            result.CneeCity = shippingOrder.ToShippingAddress.City;
            result.CneeCompany = shippingOrder.ToShippingAddress.Business_Address;
            result.CneeContactName = shippingOrder.ToShippingAddress.ContactLastName + "" + shippingOrder.ToShippingAddress.ContactFirstName;
            var CneeCountry = UtilityClasses.getCountryFromId(shippingOrder.ToShippingAddress.CountryId, 1);
            result.CneeCountry = CneeCountry.Abbreviation;
            result.CneeEmail = "";
            result.CneePhone = shippingOrder.ToShippingAddress.ContactPhone;
            result.CneePostCode = shippingOrder.ToShippingAddress.Zip;
            result.CneeProvince = shippingOrder.ToShippingAddress.State;
            var currency = UtilityClasses.GetCurrency(shippingOrder.CurrencyId.Value, 1);
            result.Currency = currency.CurrencyCode;
            result.ExpressType = String.IsNullOrEmpty(shippingOrder.ShippingChannel.SFExpressType)? "201" : shippingOrder.ShippingChannel.SFExpressType;
            result.Freight = "";
            result.TaxFee = "";
            result.OrderCertNo = shippingOrder.ShippingOrderIdentityProfile.IDNumber;
            result.OrderCertType = 1;
            result.ParcelQuantity = shippingOrder.PackageCount == null ? 1 : shippingOrder.PackageCount.Value;
            result.PaymentNumber = "";
            result.PaymentTime = null;
            result.PaymentTool = null;
            result.PayMethod = 1;
            result.PromotionType = "";
            result.ReferenceNo1 = shippingOrder.ShippingOrderCode;
            result.ReferenceNo2 = shippingOrder.ReferenceCode;
            result.SenderAddress = shippingOrder.FromShippingAddress.Address_1 + " " + shippingOrder.FromShippingAddress.Address_2;
            result.SenderCity = shippingOrder.FromShippingAddress.City;
            result.SenderContactName = shippingOrder.FromShippingAddress.ContactFirstName + "" + shippingOrder.FromShippingAddress.ContactLastName;
            result.SenderEmail = "";
            result.SenderPhone = shippingOrder.FromShippingAddress.ContactPhone;
            result.SenderPostCode = shippingOrder.FromShippingAddress.Zip;
            result.SenderProvince = shippingOrder.FromShippingAddress.State;
            result.TaxFee = "";
            if(shippingOrder.TaxPayment!=null && shippingOrder.TaxPayment.TaxPaymentMethod != null)
            {
                result.TaxPayType = shippingOrder.TaxPayment.TaxPaymentMethod.Value;
                
            }
            else
            {
                result.TaxPayType = 2;
            }
            ErrorLog.Insert("Tax: " + result.TaxPayType.ToString() + " " + shippingOrder.ShippingOrderCode, "SFExpress");
            //result.TaxPayType = shippingOrder.ShippingOrderPaymentStatusCodeId == null ? 1 : shippingOrder.ShippingOrderPaymentStatusCodeId.Value;
            result.Items = new List<Item>();
            Double transactionAmount = 0;
            if (shippingOrder.ItemList != null)
            {
                foreach(var item in shippingOrder.ItemList)
                {
                    Item temp = new Item();
                    temp.Amount = (double)item.Price;
                    temp.Brand = item.Brand;
                    temp.Count = item.Quantity.Value;
                    temp.GoodsCode = item.GoodCode;
                    if (!String.IsNullOrEmpty(item.Brand)){
                        temp.Name = item.Brand + "" + item.ItemName;
                    }
                    else
                    {
                        temp.Name = item.ItemName;
                    }
                    
                    temp.SourceArea = item.SourceArea;
                    temp.Specifications = item.Specifications;
                    temp.StateBarCode = item.StateBarCode;
                    temp.Unit = item.Unit;
                    result.Items.Add(temp);
                    transactionAmount += temp.Amount;
                }
            }
            result.DiscountAmount = "0.0";
            result.TransactionAmount = transactionAmount.ToString();
            return result;
        }

        public static SFExpressOrderResult SubmitSFExpressOrder(SFExpressOrder order)
        {
            SFExpressOrderResult result = new SFExpressOrderResult();
            order.NetworkCredential = GetNetworkCredential();
            ServicePointManager
   .ServerCertificateValidationCallback +=
   (sender, cert, chain, sslPolicyErrors) => true;
            string Url = BaseUrl + "api/orderservice/submitorder";
            string jsonBody = Newtonsoft.Json.JsonConvert.SerializeObject(order);
            System.Net.HttpWebRequest request = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(Url);
            request.Method = "POST";
            request.ContentType = "application/json";
            string postData = jsonBody;

            antoto_dbDataContext db = new antoto_dbDataContext();
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);
            request.ContentLength = byteArray.Length;
            Stream dataStream = request.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();
            WebResponse response = request.GetResponse();
            dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = reader.ReadToEnd();
            var strobject = Newtonsoft.Json.JsonConvert.DeserializeObject<SFExpressOrderResult>(responseFromServer);
            result = strobject;
            reader.Close();
            dataStream.Close();
            response.Close();
            return result;
        }

        public static SFExpressOrderResult CancelSFExpressOrder(SFOrderCancel orderCancel)
        {
            SFExpressOrderResult result = new SFExpressOrderResult();
            orderCancel.NetworkCredential = GetNetworkCredential();
            ServicePointManager
   .ServerCertificateValidationCallback +=
   (sender, cert, chain, sslPolicyErrors) => true;
            string Url = BaseUrl + "api/orderservice/cancelorder";
            string jsonBody = Newtonsoft.Json.JsonConvert.SerializeObject(orderCancel);
            System.Net.HttpWebRequest request = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(Url);
            request.Method = "POST";
            request.ContentType = "application/json";
            string postData = jsonBody;
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);
            request.ContentLength = byteArray.Length;
            Stream dataStream = request.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();
            WebResponse response = request.GetResponse();
            dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = reader.ReadToEnd();
            var strobject = Newtonsoft.Json.JsonConvert.DeserializeObject<SFExpressOrderResult>(responseFromServer);
            result = strobject;

            reader.Close();
            dataStream.Close();
            response.Close();
            return result;
        }

        public static SFExpressOrderResult SearchOrder(SFExpressOrderSearch order)
        {
            SFExpressOrderResult result = new SFExpressOrderResult();
            order.NetworkCredential = GetNetworkCredential();
            SFExpressOrderSearch JsonBody = new SFExpressOrderSearch();
            ServicePointManager
    .ServerCertificateValidationCallback +=
    (sender, cert, chain, sslPolicyErrors) => true;
            string Url = BaseUrl + "api/orderservice/searchorder";
            string jsonBody = Newtonsoft.Json.JsonConvert.SerializeObject(order);
            System.Net.HttpWebRequest request = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(Url);
            request.Method = "POST";
            request.ContentType = "application/json";
            string postData = jsonBody;
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);
            request.ContentLength = byteArray.Length;
            Stream dataStream = request.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();
            WebResponse response = request.GetResponse();
            dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = reader.ReadToEnd();
            var strobject = Newtonsoft.Json.JsonConvert.DeserializeObject<SFExpressOrderResult>(responseFromServer);
            result = strobject;
            
            reader.Close();
            dataStream.Close();
            response.Close();
            return result;
        }

        public static SFOrderRouteSearchResult GetSFExpressOrderRouting(SFOrderRouteSearch search)
        {
            SFOrderRouteSearchResult result = new SFOrderRouteSearchResult();
            search.NetworkCredential = GetNetworkCredential();
            ServicePointManager
   .ServerCertificateValidationCallback +=
   (sender, cert, chain, sslPolicyErrors) => true;
            string Url = BaseUrl + "api/routeservice/query";
            string jsonBody = Newtonsoft.Json.JsonConvert.SerializeObject(search);
            System.Net.HttpWebRequest request = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(Url);
            request.Method = "POST";
            request.ContentType = "application/json";
            string postData = jsonBody;
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);
            request.ContentLength = byteArray.Length;
            Stream dataStream = request.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();
            WebResponse response = request.GetResponse();
            dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = reader.ReadToEnd();
            try
            {
                var strobject = Newtonsoft.Json.JsonConvert.DeserializeObject<SFOrderRouteSearchResult>(responseFromServer);
                result = strobject;
            
                reader.Close();
                dataStream.Close();
                response.Close();
            }
            catch (Exception ex)
            {
                return null;
            }
            return result;
        }

        public class IdentityFile
        {
            public string Name { get; set; }
            public string Phone { get; set; }
            public string CardId { get; set; }
            public string SfWaybillNo { get; set; }
            public List<string> Images { get; set; }
        }

        public class IDSubmit
        {
            public IdentityFile IdentityFile { get; set; }
            public NetworkCredential NetworkCredential { get; set; }
        }

        public class IDData
        {
            public string Code { get; set; }
            public string Message { get; set; }
            public bool? Result { get; set; }
        }

        public class IDSubmitResult
        {
            public bool Success { get; set; }
            public IDData Data { get; set; }
        }

        public static IDSubmitResult IDSubmitCreate(IDSubmit search)
        {
            IDSubmitResult result = new IDSubmitResult();
            search.NetworkCredential = GetNetworkCredential();
            ServicePointManager
   .ServerCertificateValidationCallback +=
   (sender, cert, chain, sslPolicyErrors) => true;
            string Url = BaseUrl + "api/uploadservice/idupload";
            string jsonBody = Newtonsoft.Json.JsonConvert.SerializeObject(search);
            System.Net.HttpWebRequest request = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(Url);
            request.Method = "POST";
            request.ContentType = "application/json";
            string postData = jsonBody;
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);
            request.ContentLength = byteArray.Length;
            Stream dataStream = request.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();
            WebResponse response = request.GetResponse();
            dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = reader.ReadToEnd();
            var strobject = Newtonsoft.Json.JsonConvert.DeserializeObject<IDSubmitResult>(responseFromServer);
            result = strobject;

            reader.Close();
            dataStream.Close();
            response.Close();
            return result;
        }

        public class CheckCeteria
        {
            public string CardNo { get; set; }
            public string PersonName { get; set; }
            public string TelePhone { get; set; } 
        }

        public class CheckIDPost
        {
            public CheckCeteria CheckCeteria { get; set; }
            public NetworkCredential NetworkCredential { get; set; }
        }

        public class CheckIDResult
        {
            public bool Success { get; set; }
            public IDData Data { get; set; }
        }

        public static CheckIDResult CheckIDResultGet(CheckIDPost checkIDPost)
        {
            CheckIDResult result = new CheckIDResult();
            checkIDPost.NetworkCredential = GetNetworkCredential();
            ServicePointManager
   .ServerCertificateValidationCallback +=
   (sender, cert, chain, sslPolicyErrors) => true;
            string Url = BaseUrl + "api/uploadservice/idcheckbycardno";
            string jsonBody = Newtonsoft.Json.JsonConvert.SerializeObject(checkIDPost);
            System.Net.HttpWebRequest request = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(Url);
            request.Method = "POST";
            request.ContentType = "application/json";
            string postData = jsonBody;
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);
            request.ContentLength = byteArray.Length;
            Stream dataStream = request.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();
            WebResponse response = request.GetResponse();
            dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = reader.ReadToEnd();
            var strobject = Newtonsoft.Json.JsonConvert.DeserializeObject<CheckIDResult>(responseFromServer);
            result = strobject;

            reader.Close();
            dataStream.Close();
            response.Close();
            return result;
        }

        public static CheckIDResult CheckIDResultGetByName(CheckIDPost checkIDPost)
        {
            CheckIDResult result = new CheckIDResult();
            checkIDPost.NetworkCredential = GetNetworkCredential();
            ServicePointManager
   .ServerCertificateValidationCallback +=
   (sender, cert, chain, sslPolicyErrors) => true;
            string Url = BaseUrl + "api/uploadservice/idcheckbynamephone";
            string jsonBody = Newtonsoft.Json.JsonConvert.SerializeObject(checkIDPost);
            System.Net.HttpWebRequest request = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(Url);
            request.Method = "POST";
            request.ContentType = "application/json";
            string postData = jsonBody;
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);
            request.ContentLength = byteArray.Length;
            Stream dataStream = request.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();
            WebResponse response = request.GetResponse();
            dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = reader.ReadToEnd();
            var strobject = Newtonsoft.Json.JsonConvert.DeserializeObject<CheckIDResult>(responseFromServer);
            result = strobject;

            reader.Close();
            dataStream.Close();
            response.Close();
            return result;
        }

        public class UploadImage
        {
            public string CustomerReferenceId { get; set; }
            public string SfWaybillNo { get; set; }
            public string ImageType { get; set; }
            public string FileName { get; set; }
            public string ScanTime { get; set; }
            public string ContentBase64 { get; set; }
        }

        public class SFUploadDocument
        {
            public UploadImage UploadImage { get; set; }
            public NetworkCredential NetworkCredential { get; set; }
        }

        public class SFUploadDocumentResult
        {
            public bool Success { get; set; }
            public IDData Data { get; set; }
        }

        public static SFUploadDocumentResult SFUploadDocumentResultGet(SFUploadDocument SFUploadDocument)
        {
            SFUploadDocumentResult result = new SFUploadDocumentResult();
            SFUploadDocument.NetworkCredential = GetNetworkCredential();
            ServicePointManager
   .ServerCertificateValidationCallback +=
   (sender, cert, chain, sslPolicyErrors) => true;
            string Url = BaseUrl + "api/uploadservice/imageupload";
            string jsonBody = Newtonsoft.Json.JsonConvert.SerializeObject(SFUploadDocument);
            System.Net.HttpWebRequest request = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(Url);
            request.Method = "POST";
            request.ContentType = "application/json";
            string postData = jsonBody;
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);
            request.ContentLength = byteArray.Length;
            Stream dataStream = request.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();
            WebResponse response = request.GetResponse();
            dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = reader.ReadToEnd();
            var strobject = Newtonsoft.Json.JsonConvert.DeserializeObject<SFUploadDocumentResult>(responseFromServer);
            result = strobject;

            reader.Close();
            dataStream.Close();
            response.Close();
            return result;
        }

        public class OrderPrint
        {
            public string SfWaybillNo { get; set; }
            public string PrintType { get; set; }
        }

        public class SFOrderPrint
        {
            public OrderPrint OrderPrint { get; set; }
            public NetworkCredential NetworkCredential { get; set; }
        }

        public class SFOrderPrintData
        {
            public string Url { get; set; }
            public bool Result { get; set; }
        }

        public class SFOrderPrintResult
        {
            public bool Success { get; set; }
            public SFOrderPrintData Data { get; set; }
        }

        public static SFOrderPrintResult SFOrderPrintResultGet(SFOrderPrint SFOrderPrint)
        {
            SFOrderPrintResult result = new SFOrderPrintResult();
            SFOrderPrint.NetworkCredential = GetNetworkCredential();
            ServicePointManager
   .ServerCertificateValidationCallback +=
   (sender, cert, chain, sslPolicyErrors) => true;
            string Url = BaseUrl + "api/orderservice/printorder";
            string jsonBody = Newtonsoft.Json.JsonConvert.SerializeObject(SFOrderPrint);
            System.Net.HttpWebRequest request = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(Url);
            request.Method = "POST";
            request.ContentType = "application/json";
            string postData = jsonBody;
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);
            request.ContentLength = byteArray.Length;
            Stream dataStream = request.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();
            WebResponse response = request.GetResponse();
            dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = reader.ReadToEnd();
            var strobject = Newtonsoft.Json.JsonConvert.DeserializeObject<SFOrderPrintResult>(responseFromServer);
            result = strobject;

            reader.Close();
            dataStream.Close();
            response.Close();
            return result;
        }

        public class SFTaxInquiry
        {
            public string ProductCode { get; set; }
            public int CustomClearanceChannel { get; set; }
            public NetworkCredential NetworkCredential { get; set; }
        }

        public class SFTaxInquiryData
        {
            public double TaxRate { get; set; }
            public string Code { get; set; }
            public string Message { get; set; }
            public bool? Result { get; set; }  
        }

        public class SFTaxInquiryResult
        {
            public bool Success { get; set; }
            public SFTaxInquiryData Data { get; set; }
        }

        public static SFTaxInquiryResult SFTaxInquiryResultGet(SFTaxInquiry SFTaxInquiry)
        {
            SFTaxInquiryResult result = new SFTaxInquiryResult();
            SFTaxInquiry.NetworkCredential = GetNetworkCredential();
            ServicePointManager
   .ServerCertificateValidationCallback +=
   (sender, cert, chain, sslPolicyErrors) => true;
            string Url = BaseUrl + "api/orderservice/printorder";
            string jsonBody = Newtonsoft.Json.JsonConvert.SerializeObject(SFTaxInquiry);
            System.Net.HttpWebRequest request = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(Url);
            request.Method = "POST";
            request.ContentType = "application/json";
            string postData = jsonBody;
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);
            request.ContentLength = byteArray.Length;
            Stream dataStream = request.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();
            WebResponse response = request.GetResponse();
            dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = reader.ReadToEnd();
            var strobject = Newtonsoft.Json.JsonConvert.DeserializeObject<SFTaxInquiryResult>(responseFromServer);
            result = strobject;

            reader.Close();
            dataStream.Close();
            response.Close();
            return result;
        }

    }
}
