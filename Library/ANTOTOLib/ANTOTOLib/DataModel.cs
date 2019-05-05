using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public static class DataModel
    {
        ///<Summary>
        /// User Info
        ///</Summary>
        public class User
        {
            ///<Summary>
            /// UserId
            ///</Summary>
            public int UserId { get; set; }

            ///<Summary>
            /// First Name
            ///</Summary>
            public string FirstName { get; set; }

            ///<Summary>
            /// Last Name
            ///</Summary>
            public string LastName { get; set; }

            ///<Summary>
            /// Password , will not return
            ///</Summary>
            public string Password { get; set; }

            ///<Summary>
            /// Address
            ///</Summary>
            public UtilityClasses.Address Address { get; set; }

            ///<Summary>
            /// PhoneNumber
            ///</Summary>
            public UtilityClasses.PhoneNumber PhoneNumber { get; set; }

            ///<Summary>
            /// Login Name
            ///</Summary>
            public string LoginName { get; set; }

            ///<Summary>
            /// Email
            ///</Summary>
            public string Email { get; set; }

            ///<Summary>
            /// Available
            ///</Summary>
            public bool Available { get; set; }

            ///<Summary>
            ///Company List
            ///</Summary>
            public List<CompanyRole> companyList { get; set; }

            ///<Summary>
            /// Current Company Id
            ///</Summary>
            public int DefaultCompanyId { get; set; }
        }

        

        public class CompanyRole
        {
            ///<Summary>
            /// Company Id
            ///</Summary>
            public int CompanyId { get; set; }

            ///<Summary>
            /// Company Name
            ///</Summary>
            public string CompanyName { get; set; }

            ///<Summary>
            /// User Role in this company
            ///</Summary>
            public Role Role { get; set; }
        }



        public class Role
        {
            ///<Summary>
            /// Role Id
            ///</Summary>
            public int? RoleId { get; set; }

            ///<Summary>
            /// Sub Role List
            ///</Summary>
            public List<Role> ChildRoleList { get; set; }

            ///<Summary>
            /// Accessability List
            ///</Summary>
            public List<Function> FunctionList { get; set; }

            ///<Summary>
            /// Role Name
            ///</Summary>
            public string RoleName { get; set; }

            ///<Summary>
            /// Whether user could edit this role or not
            ///</Summary>
            public bool changeable { get; set; }

            ///<Summary>
            /// Available or not
            ///</Summary>
            public bool Available { get; set; }
        }

        public class Function
        {
            ///<Summary>
            /// Function Id
            ///</Summary>
            public int? FunctionId { get; set; }

            ///<Summary>
            /// Function Name
            ///</Summary>
            public string FunctionName { get; set; }

            ///<Summary>
            ///Accessability is granted to this role or not
            ///</Summary>
            public bool? Granted { get; set; }

            ///<Summary>
            /// Sub Accessability List
            ///</Summary>
            public List<Function> ChildFunctionList { get; set; }
        }

        public class Company
        {
            ///<Summary>
            /// Company Id
            ///</Summary>
            public int CompanyId { get; set; }

            ///<Summary>
            /// Company Name
            ///</Summary>
            public string CompanyName { get; set; }

            ///<Summary>
            /// Company Contact First Name
            ///</Summary>
            public string ContactFirstName { get; set; }

            ///<Summary>
            /// Company Contact Last Name
            ///</Summary>
            public string ContactLastName { get; set; }

            ///<Summary>
            /// Email
            ///</Summary>
            public string Email { get; set; }
        }


        public class ResultToken
        {
            ///<Summary>
            /// Login Token
            ///</Summary>
            public string Token { get; set; }
        }

        public class Brand
        {
            ///<Summary>
            /// Brand Name
            ///</Summary>
            public string BrandName { get; set; }

            ///<Summary>
            /// ChildBrandList
            ///</Summary>
            public List<Brand> ChildBrandList { get; set; }

            ///<Summary>
            /// Brand Description
            ///</Summary>
            public string BrandDescription { get; set; }

            ///<Summary>
            /// CategoryList
            ///</Summary>
            public List<Category> CategoryList { get; set; }
        }

        public class Category
        {
            ///<Summary>
            /// Category Name
            ///</Summary>
            public string CategoryName { get; set; }

            ///<Summary>
            /// ChildCategoryList
            ///</Summary>
            public List<Brand> ChildCategoryList { get; set; }

            ///<Summary>
            /// Category Description
            ///</Summary>
            public string CategoryDescription { get; set; }

            ///<Summary>
            /// BrandList
            ///</Summary>
            public List<Brand> BrandList { get; set; }
        }

        public class ParaUserSearch
        {
            public string FirstName { get; set; }
            public string LastName { get; set; }
            public string Email { get; set; }
            public int? RoleId { get; set; }
            public bool Available { get; set; }
            public int PageSize { get; set; }
            public int Page { get; set; }
        }

        public class ResultPageResult
        {
            public int? CurrentPage { get; set; }
            public int? NextPage { get; set; }
            public int? TotalRecords { get; set; }
            public int? TotalPage { get; set; }
            public List<Object> records { get; set; }
        }
        public class ResultCategroyList
        {
            public List<ResultCategory> CategoryList { get; set; }
        }

        public class ResultCategory
        {
            public int? CategoryId { get; set; }
            public int? ParentCategoryId { get; set; }
            public string CategoryName { get; set; }
            public int CategoryLevel { get; set; }
            public string Order { get; set; }
            public bool? FinalLevel { get; set; }
        }
        public class ResultBrandList
        {
            public List<ResultBrand> BrandList { get; set; }
        }

        public class ResultBrand
        {
            public int? BrandId { get; set; }
            public string BrandName { get; set; }
            public string BrandDescription { get; set; }
        }

        public class ResultItem
        {
            public int? ItemId { get; set; }
            public int? ItemStatusCodeId { get; set; }
            public string ItemStatusCode { get; set; }
            public WizardForm.WizardInputFile mainImage { get; set; }
            public int? WizardSession { get; set; }
            public string ItemName { get; set; }
        }

        public class ResultItemList
        {
            public List<ResultItem> ItemList { get; set; }
        }

        public class ResultProduct
        {
            public int? ProductId { get; set; }
            public int? WizardSessionId { get; set; }
            public string ProductName { get; set; }
            public string Category { get; set; }
            public string Brand { get; set; }
            public int? ProductStatusCodeId { get; set; }
            public string ProductStatus { get; set; }
            public WizardForm.WizardInputFile MainImage { get; set; }
            public string SKU { get; set; }
            public string ProductCode { get; set; }
            public string ModelNumber { get; set; }
            public string SupplierSKU { get; set; }
            public string ProductDescription { get; set; }
            public string VariationTitle { get; set; }
            public int? VariationReasonCodeId { get; set; }
            public bool? VariationCompleted { get; set; }
            public WizardForm.WizardSessionForm2 WizardSession { get; set; }
            public bool? IsSelf { get; set; }

        }

        public class ResultCode
        {
            public string Category { get; set; }
            public int CodeId { get; set; }
            public string CodeShort { get; set; }
            public string CodeLong { get; set; }
            public string SortOrder { get; set; }
            public int SystemLanguageId { get; set; }
            public bool Available { get; set; }

        }

        public class ResultProductSupplyInfo
        {
            public int? SupplierPlaceInfoId { get; set; }
            public string SupplierName { get; set; }
            public string SupplierLocation { get; set; }
            public int CurrencyId { get; set; }
            public string Price { get; set; }
            public string Description { get; set; }
        }

        public class ResultItemRelatedUPCInfo
        {
            public int? ItemRelatedUPCInfoId { get; set; }
            public string UPC { get; set; }
            public string Description { get; set; }
            public string SaleTag { get; set; }
        }

        public class ResultCategorySearch
        {
            public List<ResultCategory> CategoryTraceList { get; set; }

            public ResultCategory FinalCategory { get; set; }
        }

        public class ResultBrandSearchItem
        {
            public int BrandId { get; set; }
            public string Name { get; set; }
            public string Description { get; set; }
            public bool? SystemBrand { get; set; }
            public int? CategoryId { get; set; }
            public string CategoryName { get; set; }
        }

        public class ResultCategorySearchList
        {
            public List<ResultCategorySearch> records { get; set; }
        }

        public class ResultItemFinalPage
        {
            public string SKU { get; set; }
            public string VariationTitle { get; set; }
            public int? VariationReasonCodeId { get; set; }
            public bool? VariationCompleted { get; set; }
            public List<ResultProduct> RelatedUPCProductList { get; set; }
        }

        public class ResultItemPackage
        {
            public int? ItemId { get; set; }
            public int? WizardSessionId { get; set; }
            public bool? IsUpdate { get; set; }
            public int? ItemSubmitPackageId { get; set; }
            public int? ItemUpdatePackageId { get; set; }
            public string UPC { get; set; }
            public string Price { get; set; }
            public int CurrencyId { get; set; }
            public string Currency { get; set; }
            public string ProductName { get; set; }
            public string Weight { get; set; }
            public string SaleTitle { get; set; }
            public string SalePlace { get; set; }
            public string DiscountDescription { get; set; }
            public string SizeRange { get; set; }
            public string ColorRange { get; set; }
            public int? ItemPackageStatusCodeId { get; set; }
            public string ItemPackageStatus { get; set; }
            public List<WizardForm.WizardInputFile> ImageList { get; set; }
        }

        public class ResultItemOnSaleRequestTempBuffer
        {
            public int? ItemOnSaleRequestTempBufferId { get; set; }
            public string Description { get; set; }
            public string Price { get; set; }
            public int? CurrencyId { get; set; }
            public string Currency { get; set; }
            public ResultProduct Product { get; set; }
            public ResultItemPackage ItemPackage { get; set; }
        }

        public class ResultItemOnSaleRequest
        {
            public int? ItemOnSaleRequestId { get; set; }
            //public ResultItemOnSaleRequestTempBuffer TempBuffer { get; set; }
            public string Description { get; set; }
            public string Price { get; set; }
            public int? CurrencyId { get; set; }
            public string Currency { get; set; }
            public List<ResultPlatform> PlatformList { get; set; }
            public ResultProduct Product { get; set; }
        }

        public class ResultPlatform
        {
            public int? ItemOnSaleRequestPlatformInfoId { get; set; }
            public string PlatformName { get; set; }
        }

        public class ItemOnSaleDetail
        {
            public int? ItemId { get; set; }
            public int? ItemOnSaleId { get; set; }
            public bool? OnMarket { get; set; }
            public string ItemTitle { get; set; }
            public string ItemDescription { get; set; }
            public decimal? Price { get; set; }
            public int? CurrencyId { get; set; }
            public List<string> BulletPointList { get; set; }
            public string VariationTitle { get; set; }
            public WizardForm.WizardInputFile MainImage { get; set; }
            public List<WizardForm.WizardInputFile> ImageList { get; set; }
            public List<ItemOnSaleDetailRelated> RelatedItemList { get; set; }
        }

        public class ItemOnSaleDetailRelated
        {
            public int? ItemId { get; set; }
            public int? ItemOnSaleId { get; set; }
            public string VariationTitle { get; set; }
            public bool OnMarket { get; set; }
        }

        public class ResultCustomer
        {
            public int? CustomerId { get; set; }
            public string FirstName { get; set; }
            public string LastName { get; set; }
            public string PhoneNumber { get; set; }
            public int? CountryId { get; set; }
            public string NickName { get; set; }
            public string LoginName { get; set; }
            public string AvatarUrl { get; set; }
            public string Gender { get; set; }
        }


        public class ResultShippingOrder
        {
            public int? ShippingOrderId { get; set; }
		    public CustomerManager.Customer Customer { get; set; }
            public CustomerOrder.CustomerOrderDetail CustomerOrder { get; set; }
            public string ReferenceOrderCode { get; set; }
		    public ParaDataModel.ParaShippingOrderAddress ShippingFromAddress { get; set; }
            public ParaDataModel.ParaShippingOrderAddress ShippingToAddress { get; set; }
		    public ShippingOrder.ShippingChannel ShippingChannel { get; set; }
            public Decimal? Price { get; set; }
		    public int? CurrencyId { get; set; }
            public Decimal? TotalWeight { get; set; }
		    public int? WeightUnitId { get; set; }
            public int? ShippingOrderStatusCodeId { get; set; }
		    public string ShippingOrderStatus { get; set; }
            public string ShippingOrderCode { get; set; }
            public string BatchHandlerNumber { get; set; }
            public int? UserId { get; set; }
            public DateTime? CreateDate { get; set; }
		    public DateTime? LastUpdate { get; set; }
            public ResultShippingOrderIdentityProfile ShippingOrderIdentityProfile { get; set; }
            public bool? LabelReady { get; set; }
            public Decimal? PaidPrice { get; set; }
            public List<ResultShippingOrderLabel> LabelList { get; set; }
            public ShippingOrder.ANTOTOShippingOrderTaxPayment TaxPayment { get; set; }
            public string CustomTax { get; set; }
            public string SFOrderCode { get; set; }
        }

        public class ResultShippingOrderIdentityProfile
        {
            public int? ShippingOrderId { get; set; }
            public int? ShippingOrderIdentityProfileId { get; set; }
            public string IDNumber { get; set; }
            public List<WizardForm.WizardInputFile> FileList { get; set; }
            public WizardForm.WizardInputFile FrontFile { get; set; }
            public WizardForm.WizardInputFile BackFile { get; set; }
            public int? FrontFileId { get; set; }
            public int? BackFileId { get; set; }
            public string Name { get; set; }
            public string PhoneNumber { get; set; }
        }



        public class ResultShippingOrderLabel
        {
            public int? ShippingOrderLabelId { get; set; }
            public string LabelName { get; set; }
            public WizardForm.WizardInputFile File { get; set; }
            public int? Order { get; set; }
        }

        public class ResultShippingOrderBatchActionPackage
        {
            public List<ResultShippingOrderBatchAction> ResultList { get; set; }
            public WizardForm.WizardInputFile PrintFile { get; set; }
        }

        public class ResultShippingOrderBatchAction
        {
            public int? ShippingOrderId { get; set; }
            public string ShippingOrderCode { get; set; }
            public string ResultCode { get; set; }
            
        }

        public class ResultShippingOrderCompanyTransaction
        {
            public int? CompanyTransactionId { get; set; }
            public string Description { get; set; }
            public int? CompanyId { get; set; }
            public string CompanyName { get; set; }
            public int? TransactionTypeCodeId { get; set; }
            public string TransactionType { get; set; }
            public Decimal? Amount { get; set; }
            public int? CurrencyId { get; set; }
            public string Currency { get; set; }
            public int? UserId { get; set; }
            public string UserName { get; set; }
            public Decimal? CurrentBalance { get; set; }
            public bool? IsSourceCompany { get; set; }
        }

        public class ResultCompanyTransactionRequest
        {
            public int? CompanyTransactionRequestId { get; set; }
            public Decimal? Amount { get; set; }
            public int? CurrencyId { get; set; }
            public string Currency { get; set; }
            public int? SourceCompanyId { get; set; }
            public string SourceCompany { get; set; }
            public int? HandlerCompanyId { get; set; }
            public string HandlerCompany { get; set; }
            public int? CompanyTransactionRequestStatusCodeId { get; set; }
            public string CompanyTransactionRequestStatus { get; set; }
            public int? UserId { get; set; }
            public string UserName { get; set; }
            public string Description { get; set; }
            public List<ResultCompanyTransactionRequestFile> CompanyTransactionRequestFileList { get; set; }
        }

        public class ResultCompanyTransactionRequestFile
        {
            public WizardForm.WizardInputFile File { get; set; }
        }
        public class ResultShippingOrderSubOrder
        {
            public int? ShippingOrderSubOrderId { get; set; }
            public int? ShippingOrderId { get; set; }
            public int? SubOrderTypeCodeId { get; set; }
            public string SubOrderType { get; set; }
            public string SubOrderCode { get; set; }
            public string SubOrderDescription { get; set; }
            public List<ResultShippingOrderRoutingTransaction> RoutingTransactionList { get; set; }
        }

        public class ResultShippingOrderRoutingTransaction
        {
            public int? ShippingOrderSubOrderId { get; set; }
            public int? ShippingOrderOrderRoutingTransactionId { get; set; }
            public string AcceptedAddress { get; set; }
            public string OpCode { get; set; }
            public string RemarkDetail { get; set; }
            public DateTime? AcceptTime { get; set; }
            public int? SourceId { get; set; }
            public string SourceTable { get; set; }
            public int? UserId { get; set; }
            public string UserName { get; set; }
        }

        public class ResultCodeList
        {
            public int? CodeId { get; set; }
            public string Code { get; set; }
        }
        





    }
}
