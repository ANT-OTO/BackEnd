using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public class StockManager
    {
        public class StockItem
        {
            public int? ItemId { get; set; }

            public PurchaseManager.PurchasePoolTask PurchasePoolTask { get; set; }
            
            public DataModel.ResultProduct Item { get; set; }

            public WareHouseManager.WarehouseRackLevel WareHouseRackLevel { get; set; }

            public WareHouseManager.WareHouseCart WareHouseCart { get; set; }

            public int? StockItemStatusCodeId { get; set; }

            public string StockItemStatus { get; set; }

            public string StockCode { get; set; }

            public List<StockItemAction> StockItemActionList { get; set; }

            public List<StockItemActionLocationHistory> StockItemActionLocationHistoryList { get; set; }

        
        }

        public class StockItemAction
        {
            public int? StockItemId { get; set; }

            public int? StockItemActionId { get; set; }

            public int? StockActionTypeCodeId { get; set; }

            public int? ResponsibleUserId { get; set; }

            public string SourceTable { get; set; }
    
	        public int? SourceId { get; set; }

            public List<StockItemActionLocationHistory> StockItemActionLocationHistoryList { get; set; }
        }

        public class StockItemPayment
        {
            public int? StockItemId { get; set; }

            public int? StockItemPaymentId { get; set; }

            public decimal? Amount { get; set; }

            public int? CurrenyId { get; set; }

            public int? TransactionTypeCodeId { get; set; }

            public string TransactionType { get; set; }

            public DateTime? CreateDate { get; set; }
        }

        public class StockItemGroup
        {
            public int? StockItemGroupId { get; set; }

            public List<StockItem> StockItemList { get; set; }

            public int? StockItemGroupStatusCodeId { get; set; }

            public string StockItemGroupStatus { get; set; }

            public List<StockItemPayment> StockItemPaymentList { get; set; }
        }

        public class StockItemLocation
        {
            public int? StockItemId { get; set; }

            public int? WarehouseRackLevelId { get; set; }

            public int? WarehouseCartId { get; set; }

            public int? StockItemShippingId { get; set; }
        }

        public class StockItemActionLocationHistory
        {
            public int? StockItemActionId { get; set; }

            public int? WarehouseRackLevelId { get; set; }

            public int? WarehouseCartId { get; set; }

            public int? StockItemShippingId { get; set; }
        }

        public static StockItemGroup PutInStockItemGroup(PurchaseManager.PurchasePoolTask task, int? UserId, int? CompanyId)
        {
            StockItemGroup result = new StockItemGroup();

            antoto_dbDataContext db = new antoto_dbDataContext();



            return result;
        }

        public static StockItemGroup getStockItemGroupById (int? StockItemGroupId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            StockItemGroup result = new StockItemGroup();
            int? StockItemGroupStatusCodeId = 0;
            string StockItemGroupStatus = "";
            int? StockItemPaymentId = 0;
            var list = db.sp_StockItemGroupGet(StockItemGroupId, ref StockItemGroupStatusCodeId, ref StockItemGroupStatus, ref StockItemPaymentId);
            if (list != null)
            {
                result.StockItemGroupId = StockItemGroupId;
                result.StockItemGroupStatusCodeId = StockItemGroupStatusCodeId;
                result.StockItemGroupStatus = StockItemGroupStatus;
                result.StockItemList = new List<StockItem>();
                foreach(var item in list)
                {
                    var StockItem = getStockItem(item.ItemId);
                    result.StockItemList.Add(StockItem);
                }
            }
            return result;
        }

        public static StockItem getStockItem (int? StockItemId)
        {
            StockItem result = new StockItem();

            return result;
        }
    }

    
}
