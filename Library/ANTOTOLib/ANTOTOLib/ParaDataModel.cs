using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public static class ParaDataModel
    {
        public class ParaUserLogin
        {
            ///<Summary>
            /// Login Name
            ///</Summary>
            public string LoginName { get; set; }

            ///<Summary>
            /// Password
            ///</Summary>
            public string Password { get; set; }

            ///<Summary>
            /// System Language Id
            ///</Summary>
            public int SystemLanguageId { get; set; }
        }

        public class ParaRoleCreate
        {
            ///<Summary>
            /// RoleName
            ///</Summary>
            public string RoleName { get; set; }
            ///<Summary>
            /// ParentRoleId
            ///</Summary>
            public int ParentRoleId { get; set; }
            ///<Summary>
            /// CopyRoleId
            ///</Summary>
            public int CopyRoleId { get; set; }
            ///<Summary>
            /// SystemRole
            ///</Summary>
            public bool SystemRole { get; set; }
        }

        public class ParaRoleGrantFunction
        {
            ///<Summary>
            /// RoleId
            ///</Summary>
            public int RoleId { get; set; }
            ///<Summary>
            /// FunctionId
            ///</Summary>
            public int FunctionId { get; set; }
            ///<Summary>
            /// granted
            ///</Summary>
            public bool granted { get; set; }
            ///<Summary>
            /// ActionForSubRole
            ///</Summary>
            public bool ActionForSubRole { get; set; }
            ///<Summary>
            /// ActionForSubFunction
            ///</Summary>
            public bool ActionForSubFunction { get; set; }
        }

        public class ParaUserCreateUpdate
        {
            public int? UserId { get; set; }

            public string FirstName { get; set; }

            public string LastName { get; set; }

            public string LoginName { get; set; }

            public string Email { get; set; }

            public int? RoleId { get; set; }

            public string Address1 { get; set; }

            public string Address2 { get; set; }

            public string City { get; set; }

            public string Zip { get; set; }

            public string State { get; set; }

            public int? CountryId { get; set; }

            public int? PhoneCountryId { get; set; }

            public string PhoneNumber { get; set; }

            public string Password { get; set; }

            public bool? Available { get; set; }
        }

        public class ParaProductCreate
        {
            public int? CategoryId { get; set; }

            public int? BrandId { get; set; }
        }

        public class ParaProductSearch
        {
            public string SKU { get; set; }
            public string ProductCode { get; set; }
            public string ProductName { get; set; }
            public string ModelNumber { get; set; }
            public string SupplierSKU { get; set; }
            public string ProductDescription { get; set; }
            public int? itemStatusCodeId { get; set; }
            public int? FileId { get; set; }
            public string Category { get; set; }
            public string Brand { get; set; }
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ParaBrandCreate
        {
            public int? BrandId { get; set; }
            public int? CategoryId { get; set; }
            public string BrandName { get; set; }
            public string BrandDescription { get; set; }
        }

        public class ParaCategorySearch
        {
            public string CategorySearchWord { get; set; }
        }

        public class ParaBrandSearch
        {
            public string BrandSearchWord { get; set; }
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ParaVariationInfo
        {
            public int? WizardSessionId { get; set; }
            public int? ItemId { get; set; }
            public string VariationTitle { get; set; }
            public int? VariationReasonCodeId { get; set; }
        }

        public class ParaWizardSessionItem
        {
            public int? WizardSessionId { get; set; }
            public int? ItemId { get; set; }
        }

        public class ParaProductUPC
        {
            public string UPC { get; set; }
        }

        public class ParaProductSubmitPackage
        {
            public string UPC { get; set; }
            public string Price { get; set; }
            public int CurrencyId { get; set; }
            public string ProductName { get; set; }
            public string Weight { get; set; }
            public string SaleTitle { get; set; }
            public string SalePlace { get; set; }
            public string DiscountDescription { get; set; }
            public string SizeRange { get; set; }
            public string ColorRange { get; set; }
            public List<WizardForm.WizardInputFile> ImageList { get; set; }
        }

        public class ParaProductUpdatePackage
        {
            public string UPC { get; set; }
            public string Price { get; set; }
            public int CurrencyId { get; set; }
            public string ProductName { get; set; }
            public string Weight { get; set; }
            public string SaleTitle { get; set; }
            public string SalePlace { get; set; }
            public string DiscountDescription { get; set; }
            public string SizeRange { get; set; }
            public string ColorRange { get; set; }
            public List<WizardForm.WizardInputFile> ImageList { get; set; }
        }

        public class ParaItemPackageSearch
        {
            public string SearchWord { get; set; }
            public int? ItemPackageStatusCodeId { get; set; }
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ParaItemPackage
        {
            public int? ItemSubmitPackageId { get; set; }
            public int? ItemUpdatePackageId { get; set; }
            public int? CategoryId { get; set; }
            public int? BrandId { get; set; }
            public bool? PutOnMarket { get; set; }
            public List<DataModel.ResultPlatform> PlatformList { get; set; }
            public string Price { get; set; }
            public int? CurrencyId { get; set; }
            public string OnSaleMemo { get; set; }
        }

        public class ParaItemPackagePushToBuffer
        {
            public int? ItemSubmitPackageId { get; set; }
            public int? ItemUpdatePackageId { get; set; }
            public string Price { get; set; }
            public int? CurrencyId { get; set; }
            public string Description { get; set; }
            public List<DataModel.ResultPlatform> PlatformList { get; set; }
        }

        public class ParaItemOnSaleTempBufferSearch
        {
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ParaItemOnSaleSearch
        {
            public int? ItemOnSaleRequestStatusCodeId { get; set; }
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ParaItemOnSaleRequest
        {
            public int? ItemId { get; set; }
            public int? ItemOnSaleRequestTempBufferId { get; set; }
            public string Price { get; set; }
            public int? CurrencyId { get; set; }
            public string Description { get; set; }
            public List<DataModel.ResultPlatform> PlatformList { get; set; }
            public int? ItemSubmitPackageId { get; set; }
            public int? ItemUpdatePackageId { get; set; }
        }

        public class ParaCustomerLogin
        {
            ///<Summary>
            /// Login Name
            ///</Summary>
            public string LoginName { get; set; }

            ///<Summary>
            /// Password
            ///</Summary>
            public string Password { get; set; }

            public string CompanyCode { get; set; }

            public int? CustomerTypeCodeId { get; set; }

            public string OpenId { get; set; }

            public string NickName { get; set; }

            ///<Summary>
            /// System Language Id
            ///</Summary>
            public int SystemLanguageId { get; set; }
        }

        public class ParaCustomerSearch
        {
            public int? SourceCompanyId { get; set; }
            public string SearchWord { get; set; }
            public int? CustomerTypeCodeId { get; set; }
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ParaOrderCreate
        {
            public int? CustomerId { get; set; }
            public int? CustomerAddressId { get; set; }
            public List<ParaOrderCreateItem> ItemList { get; set; }
            public string DiscountCode { get; set; }
        }

        public class ParaOrderCreateItem
        {
            public int? ItemId { get; set; }
            public int? Quantity { get; set; }
            public int? CurrencyId { get; set; }
            public Decimal? Price { get; set; }
        }

        public class ParaCustomerOrderSearch
        {
            public string ProductName { get; set; }
            public string CustomerName { get; set; }
            public string CustomerThirdPartyId { get; set; }
            public int? CustomerTypeCodeId { get; set; }
            public DateTime? DateStart { get; set; }
            public DateTime? DateEnd { get; set; }
            public bool? Paided { get; set; }
            public int? CustomerOrderStatusCodeId { get; set; }
            public string AddressSearchWord { get; set; }
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ParaCustomerOrderSearchByCustomer
        {
            public string ProductName { get; set; }
            public DateTime? DateStart { get; set; }
            public DateTime? DateEnd { get; set; }
            public bool? Paided { get; set; }
            public int? CustomerOrderStatusCodeId { get; set; }
            public string AddressSearchWord { get; set; }
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ParaItemOnSaleCustomerSearch
        {
            public string ProductName { get; set; }
            public decimal? PriceStart { get; set; }
            public decimal? PriceEnd { get; set; }
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ParaPurchasePoolTaskSearch
        {
            public int? ItemPurchaseStatusCodeId { get; set; }
            public int? UserId { get; set; }
            public string PurchasePlaceSearch { get; set; }
            public DateTime? CreateDateFrom { get; set; }
            public DateTime? CreateDateTo { get; set; }
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ParaPurchasePoolActiveTaskSearch
        {
            public string UPC { get; set; }
            public int? UserId { get; set; }
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ParaPurchaseTaskAccept
        {
            public int? PurchasePoolItemId { get; set; }
            public int? ItemId { get; set; }
            public int? Quantity { get; set; }
        }

        public class ParaPurchaseTaskDeny
        {
            public int? ItemPurchaseTaskId { get; set; }
            public string Reason { get; set; }
        }

        public class ParaPurchaseTaskChange
        {
            public int? ItemPurchaseTaskId { get; set; }
            public int? ItemId { get; set; }
            public int? UpdatedQuantity { get; set; }
        }

        public class ParaPurchaseTaskFinish
        {
            public int? ItemPurchaseTaskId { get; set; }
            public int? ItemId { get; set; }
            public List<WizardForm.WizardInputFile> ReceiptImages { get; set; }
            public Decimal? FinalUnitPrice { get; set; }
            public Decimal? FinalTotalPrice { get; set; }
            public string Reason { get; set; }
        }

        public class ParaShippingOrderAddress
        {
            public int? ShippingAddressId { get; set; }
            public string ContactFirstName { get; set; }
            public string ContactLastName { get; set; }
            public string ContactPhone { get; set; }
            public int? ContactPhoneCountryId { get; set; }
            public string Address_1 { get; set; }
            public string Address_2 { get; set; }
            public string Business_Address { get; set; }
            public string State { get; set; }
            public string City { get; set; }
            public int? CountryId { get; set; }
            public string Zip { get; set; }
        }

        public class ParaShippingQuickOrder
        {
            public int? CustomerCompanyId { get; set; }
            public int? CustomerId { get; set; }
            public string ReferenceCode { get; set; }
            public ParaShippingOrderAddress ShipperAddress { get; set; }
            public ParaShippingOrderAddress ReceiverAddress { get; set; }
            public bool? ShipperAddressAddToCompanyFromAddress { get; set; }

            public bool? ReceiverAddressAddCustomer { get; set; }
            public int? ShippingChannelId { get; set; }

            public int? ShippingOrderTaxPaymentTypeCodeId { get; set; }

            public Decimal? TotalWeight { get; set; }

            public int? WeightUnitId { get; set; }

            public int? CurrencyId { get; set; }

            public string ReferenceThirdPartyId { get; set; }

            public int? SourceCompanyId { get; set; }

            public int? HanlderCompanyId { get; set; }

            public List<ParaShippingOrderItem> ItemList { get; set; }

            public int? PackageCount { get; set; }

            public string ParentShippingOrderCode { get; set; }
        }    

        public class ParaShippingOrder
        {
            public int? CustomerId { get; set; }

            public int? CustomerOrderId { get; set; }

            public int? CustomerAddressId { get; set; }

            public int? CompanyFromAddressId { get; set; }

            public ParaShippingOrderAddress ShipperAddress { get; set; }

            public ParaShippingOrderAddress ReceiverAddress { get; set; }

            public bool? ShipperAddressAddToCompanyFromAddress { get; set; }

            public bool? ReceiverAddressAddCustomer { get; set; }

            public int? PackageCount { get; set; }

            public string ReferenceCode { get; set; }

            public int? ShippingChannelId { get; set; }

            public int? ShippingOrderTaxPaymentTypeCodeId { get; set; }

            public string ShippingOrderTaxPaymentType { get; set; }

            public Decimal? TotalWeight { get; set; }

            public int? WeightUnitId { get; set; }

            public int? CurrencyId { get; set; }

            public string ReferenceThirdPartyId { get; set; }

            public int? SourceCompanyId { get; set; }

            public int? HanlderCompanyId { get; set; }

            public List<ParaShippingOrderItem> ItemList { get; set; }
        }

        public class ParaShippingOrderItem
        {
            public int? ItemId { get; set; }

            public int? StockItemId { get; set; }

            public string ItemName { get; set; }

            public int? Quantity { get; set; }

            public string Unit { get; set; }

            public Decimal? Weight { get; set; }

            public int? WeightUnit { get; set; }

            public Decimal? Price { get; set; }

            public int? CurrencyId { get; set; }

            public Decimal? TaxPrice { get; set; }

            public string SourceArea { get; set; }

            public string GoodCode { get; set; }

            public string StateBarCode { get; set; }

            public string Brand { get; set; }

            public string Specifications { get; set; }
        }

        public class ParaShippingOrderSearch
        {
            public string ShippingOrderCode { get; set; }
            public string ReferenceOrderCode { get; set; }
            public string SearchCustomerName { get; set; }
            public string PhoneNumber { get; set; }
            public string CountryNameText { get; set; }
            public int? ShippingOrderStatusCodeId { get; set; } 
            public string Address { get; set; }
            public string Country { get; set; }
            public int? ShippingOrderPaymentStatusCodeId { get; set; }
            public int? SourceCompanyId { get; set; }
            public bool? IDReady { get; set; }
            public string IDNumber { get; set; }
            public string BatchRecordNumber { get; set; }
            public bool? LabelReady { get; set; }
            public string ProductName { get; set; }
            public DateTime? BeginUtcDate { get; set; }
            public DateTime? EndUtcDate { get; set; }
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ParaShippingOrderBatchHandlerSearch
        {
            public string ShippingOrderCode { get; set; }
            public string BatchHandlerCode { get; set; }
            public int? ShippingOrderActionTypeCodeId { get; set; }
            public int? BatchHandlerStatusCodeId { get; set; }
            public DateTime? BeginUtcDate { get; set; }
            public DateTime? EndUtcDate { get; set; }
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ParaLogisticCompanySearch
        {
            public string Name { get; set; }
	        public string CustomerCode { get; set; }
	        public string Email { get; set; }
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ParaLogisticCompany
        {
            public int? CompanyId { get; set; }

            public string CompanyName { get; set; }

            public string CustomerCode { get; set; }

            public string Email { get; set; }

            public string FirstName { get; set; }

            public string LastName { get; set; }

            public string LoginName { get; set; }

            public string PhoneNumber { get; set; }

            public int? PhoneNumberCountryId { get; set; }

            public string Fax { get; set; }

            public string Address1 { get; set; }

            public string Address2 { get; set; }

            public string City { get; set; }

            public string District { get; set; }

            public string State { get; set; }

            public string Zip { get; set; }

            public bool? Available { get; set; }

            public string Password { get; set; }

            public int? CountryId { get; set; }
            
        }

        public class ParaBatchRequestSetup
        {
            public int? FileId { get; set; }

            public int? BatchTemplateId { get; set; }

            public int? HandlerCompanyId { get; set; }
        }

        public class ParaShippingOrderBatchUpdate
        {
            public List<int?> ShippingOrderIdList { get; set; }
            public string ActionType { get; set; } 
            public List<ParaShippingOrderWeightUpdate> WeightList { get; set; }
            public List<ParaShippingOrderPriceCalculate> PriceCalculateList { get; set; }
            public List<ParaShippingOrderCancel> CancelReasonList { get; set; }
        }

        public class ParaShippingOrderWeightUpdate
        {
            public int? ShippingOrderId { get; set; }
            public Decimal? Weight { get; set; }
            public int? WeightUnit { get; set; }
            public bool? AutoCalculatePrice { get; set; }
        }

        public class ParaShippingOrderPriceCalculate
        {
            public int? ShippingOrderId { get; set; }
            public string CouponCode { get; set; }
        }

        public class ParaShippingOrderPriceCharge
        {
            public int? ShippingOrderId { get; set; }
        }

        public class ParaShippingOrderCancel
        {
            public int? ShippingOrderId { get; set; }
            public string Reason { get; set; }
        }

        public class ParaShippingOrderReview
        {
            public int? ShippingOrderId { get; set; }
        }

        public class ParaShippingOrderReviewComplete
        {
            public int? ShippingOrderId { get; set; }
        }

        public class ParaShippingChannelRightGrant
        {
            public int? ShippingChannelId { get; set; }
            public int? CustomerCompanyId { get; set; }
            public bool? Granted { get; set; }
        }

        public class ParaShippingOrderReviewCancel
        {
            public int? ShippingOrderId { get; set; }
        }

        public class ParaShippingOrderPrint
        {
            public int? ShippingOrderId { get; set; }
        }

        public class ParaShippingOrderIDUpload
        {
            public int? ShippingOrderId { get; set; }
            public string ShippingOrderCode { get; set; }
            public string IDNumber { get; set; }
            public List<WizardForm.WizardInputFile> FileList { get; set; }
            public WizardForm.WizardInputFile FrontFile { get; set; }
            public WizardForm.WizardInputFile BackFile { get; set; }
            public WizardForm.WizardInputFile frontImage { get; set; }
            public WizardForm.WizardInputFile backImage { get; set; }
            public int? FrontFileId { get; set; }
            public int? BackFileId { get; set; }
            public string Name { get; set; }
            public string PhoneNumber { get; set; }
        }
        
        public class ParaCompanyTransactionSearch
        {
	        public DateTime? BeginDate { get; set; }
            public DateTime? EndDate { get; set; }
            public string DescriptionSearch { get; set; }
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ParaCustomerCompanyTransactionSearch
        {
            public int? SourceCompanyId { get; set; }
            public DateTime? BeginDate { get; set; }
            public DateTime? EndDate { get; set; }
            public string DescriptionSearch { get; set; }
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ParaCompanyTransactionRequestSearch
        {
            public DateTime? BeginDate { get; set; }
            public DateTime? EndDate { get; set; }
            public int? CompanyTransactionRequestStatusCodeId { get; set; }
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ParaCompanyTransactionRecharge
        {
            public Decimal? Amount { get; set; }
            public int? CustomerCompanyId { get; set; }
            public string Description { get; set; }
        }

        public class ParaCompanyTransactionRefund
        {
            public Decimal? Amount { get; set; }
            public int? CustomerCompanyId { get; set; }
            public string Description { get; set; }
        }

        public class ParaShippingOrderPackage
        {
            public int? ShippingOrderId { get; set; }
            public string ShippingOrderCode { get; set; }
        }

        public class ParaCompanyTransactionSet
        {
            public int? CustomerCompanyId { get; set; }
            public int? TransactionTypeCodeId { get; set; }
            public string Description { get; set; }
            public Decimal? Price { get; set; }
            public int? CurrencyId { get; set; }
        }


        



    }
}
