using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public class WareHouseManager
    {
        public class WareHouse
        {
            public string WareHouseName { get; set; }
            public UtilityClasses.Address WareHouseAddress { get; set; }
            public int? WareHouseId { get; set; }
            public int? CompanyId { get; set; }
            public string WareHouseCode { get; set; }
            public string ManagerName { get; set; }
            public string ContactNumber { get; set; }
            public int? ContactNumberCountryId { get; set; }
            public List<WarehouseLevel> LevelList { get; set; }
            public List<WareHouseCart> CartList { get; set; }
            public bool? Available { get; set; }
            
        }

        public class WarehouseRack
        {
            public int? WarehouseRackId { get; set; }
            public int? WarehouseZoneId { get; set; }
            public string RackName { get; set; }
            public string RackCode { get; set; }
            public bool? Available { get; set; }
            public List<WarehouseRackLevel> RackLevelList { get; set; }
        }

        public class WarehouseRackLevel
        {
            public int? WarehouseRackLevelId { get; set; }
            public int? WarehouseRackId { get; set; }
            public string RackLevelName { get; set; }
            public string RackLevelCode { get; set; }
            public bool? Available { get; set; }
        }

        public class WarehouseLevel
        {
            public int? WarehouseLevelId { get; set; }
            public int? WarehouseId { get; set; }
            public string LevelName { get; set; }
            public string LevelCode { get; set; }
            public bool? Available { get; set; }
            public List<WarehouseZone> ZoneList { get; set; }
        }

        public class WarehouseZone
        {
            public int? WarehouseZoneId { get; set; }
            public int? WarehouseLevelId { get; set; }
            public string ZoneName { get; set; }
            public string ZoneCode { get; set; }
            public bool? Available { get; set; }
            public List<WarehouseRack> RackList { get; set; }
        }

        public class WareHouseCart
        {
            public int? WarehouseCartId { get; set; }
            public int? WarehouseId { get; set; }
            public string CartName { get; set; }
            public string CartCode { get; set; }
            public bool? Available { get; set; }
        }

        public static List<WareHouse> getWareHouseList(int? CompanyId, int? UserId)
        {
            List<WareHouse> result = new List<WareHouse>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnWareHouseListGet(CompanyId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    WareHouse temp = new WareHouse();
                    temp.WareHouseId = item.WareHouseId;
                    temp.ContactNumber = item.ContactNumber;
                    temp.ContactNumberCountryId = item.ContactNumberCountryId;
                    temp.ManagerName = item.ManagerName;
                    temp.WareHouseCode = item.WareHouse_Code;
                    temp.WareHouseName = item.WareHouse_Name;
                    temp.WareHouseAddress = new UtilityClasses.Address();
                    temp.WareHouseAddress.Address1 = item.Address1;
                    temp.WareHouseAddress.Address2 = item.Address2;
                    temp.WareHouseAddress.AddressId = item.AddressId;
                    temp.WareHouseAddress.City = item.City;
                    temp.WareHouseAddress.CountryId = item.CountryId;
                    temp.WareHouseAddress.District = item.District;
                    temp.WareHouseAddress.State = item.State;
                    temp.WareHouseAddress.Zip = item.Zip;
                    temp.CompanyId = item.CompanyId;
                    temp.Available = item.Available;
                    result.Add(temp);
                }
            }
            return result;
        } 

        public static WareHouse getWareHouseDetail(int? WarehouseId)
        {
            WareHouse result = new WareHouse();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnWareHouseGet(WarehouseId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    result.WareHouseId = item.WareHouseId;
                    result.WareHouseCode = item.WareHouse_Code;
                    result.WareHouseName = item.WareHouse_Name;
                    result.ContactNumber = item.ContactNumber;
                    result.ContactNumberCountryId = item.ContactNumberCountryId;
                    result.ManagerName = item.ManagerName;
                    result.WareHouseAddress = new UtilityClasses.Address();
                    result.WareHouseAddress.Address1 = item.Address1;
                    result.WareHouseAddress.Address2 = item.Address2;
                    result.WareHouseAddress.AddressId = item.AddressId;
                    result.WareHouseAddress.City = item.City;
                    result.WareHouseAddress.CountryId = item.CountryId;
                    result.WareHouseAddress.District = item.District;
                    result.WareHouseAddress.State = item.State;
                    result.WareHouseAddress.Zip = item.Zip;
                    result.CompanyId = item.CompanyId;
                    result.Available = item.Available;
                    result.LevelList = getWarehouseLevelList(item.WareHouseId);
                }
               
            }
            return result;
        }

        public static WareHouseCart getWarehouseCart(int? WarehouseCartId)
        {
            WareHouseCart result = new WareHouseCart();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnWareHouseCartGet(WarehouseCartId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    WareHouseCart temp = new WareHouseCart();
                    temp.WarehouseId = item.WareHouseId;
                    temp.WarehouseCartId = item.WareHouseCartId;
                    temp.CartCode = item.CartCode;
                    temp.CartName = item.CartName;
                    temp.Available = item.Available;
                    result = temp;
                }
            }
            return result;
        }

        public static List<WareHouseCart> getWarehouseCartList(int? WarehouseId)
        {
            List<WareHouseCart> result = new List<WareHouseCart>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnWareHouseCartListGet(WarehouseId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    WareHouseCart temp = new WareHouseCart();
                    temp.WarehouseId = item.WareHouseId;
                    temp.WarehouseCartId = item.WareHouseCartId;
                    temp.CartCode = item.CartCode;
                    temp.CartName = item.CartName;
                    temp.Available = item.Available;
                    result.Add(temp);
                }
            }
            return result;
        }

        public static WarehouseLevel getWarehouseLevel(int? WarehouseLevelId)
        {
            WarehouseLevel result = new WarehouseLevel();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnWareHouseLevelGet(WarehouseLevelId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    WarehouseLevel temp = new WarehouseLevel();
                    temp.WarehouseId = item.WareHouseId;
                    temp.WarehouseLevelId = item.WareHouseLevelId;
                    temp.ZoneList = getWarehouseZoneList(item.WareHouseLevelId);
                    temp.LevelCode = item.LevelCode;
                    temp.LevelName = item.LevelName;
                    temp.Available = item.Available;
                    result = temp;
                }
            }
            return result;
        }

        public static List<WarehouseLevel> getWarehouseLevelList(int? WarehouseId)
        {
            List<WarehouseLevel> result = new List<WarehouseLevel>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnWareHouseLevelListGet(WarehouseId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    WarehouseLevel temp = new WarehouseLevel();
                    temp.WarehouseId = item.WareHouseId;
                    temp.WarehouseLevelId = item.WareHouseLevelId;
                    temp.ZoneList = getWarehouseZoneList(item.WareHouseLevelId);
                    temp.LevelCode = item.LevelCode;
                    temp.LevelName = item.LevelName;
                    temp.Available = item.Available;
                    result.Add(temp);
                }
            }
            return result;
        }

        public static WarehouseZone getWarehouseZone(int? WarehouseZoneId)
        {
            WarehouseZone result = new WarehouseZone();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnWareHouseZoneGet(WarehouseZoneId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    WarehouseZone temp = new WarehouseZone();
                    temp.WarehouseLevelId = item.WareHouseLevelId;
                    temp.WarehouseZoneId = item.WareHouseZoneId;
                    temp.ZoneCode = item.ZoneCode;
                    temp.ZoneName = item.ZoneName;
                    temp.RackList = getWarehouseRackList(item.WareHouseZoneId);
                    temp.Available = item.Available;
                    result = temp;
                }
            }
            return result;
        }

        public static List<WarehouseZone> getWarehouseZoneList(int? WarehouseLevelId)
        {
            List<WarehouseZone> result = new List<WarehouseZone>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnWareHouseZoneListGet(WarehouseLevelId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    WarehouseZone temp = new WarehouseZone();
                    temp.WarehouseLevelId = item.WareHouseLevelId;
                    temp.WarehouseZoneId = item.WareHouseZoneId;
                    temp.ZoneCode = item.ZoneCode;
                    temp.ZoneName = item.ZoneName;
                    temp.RackList = getWarehouseRackList(item.WareHouseZoneId);
                    temp.Available = item.Available;
                    result.Add(temp);
                }
            }
            return result;
        }

        public static WarehouseRack getWarehouseRack(int? WarehouseRackId)
        {
            WarehouseRack result = new WarehouseRack();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnWareHouseRackGet(WarehouseRackId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    WarehouseRack temp = new WarehouseRack();
                    temp.WarehouseRackId = item.WareHouseRackId;
                    temp.WarehouseZoneId = item.WareHouseZoneId;
                    temp.RackName = item.RackName;
                    temp.RackCode = item.RackCode;
                    temp.RackLevelList = getWarehouseRackLevelList(item.WareHouseRackId);
                    temp.Available = item.Available;
                    result = temp;
                }
            }
            return result;
        }

        public static List<WarehouseRack> getWarehouseRackList(int? WarehouseZoneId)
        {
            List<WarehouseRack> result = new List<WarehouseRack>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnWareHouseRackListGet(WarehouseZoneId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    WarehouseRack temp = new WarehouseRack();
                    temp.WarehouseRackId = item.WareHouseRackId;
                    temp.WarehouseZoneId = item.WareHouseZoneId;
                    temp.RackName = item.RackName;
                    temp.RackCode = item.RackCode;
                    temp.RackLevelList = getWarehouseRackLevelList(item.WareHouseRackId);
                    temp.Available = item.Available;
                    result.Add(temp);
                }
            }
            return result;
        }

        public static WarehouseRackLevel getWarehouseRackLevel(int? WarehouseRackLevelId)
        {
            WarehouseRackLevel result = new WarehouseRackLevel();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnWareHouseRackLevelGet(WarehouseRackLevelId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    WarehouseRackLevel temp = new WarehouseRackLevel();
                    temp.WarehouseRackId = item.WareHouseRackId;
                    temp.WarehouseRackLevelId = item.WareHouseRackLevelId;
                    temp.RackLevelCode = item.RackLevelCode;
                    temp.RackLevelName = item.RackLevelName;
                    temp.Available = item.Available;
                    result = temp;
                }
            }
            return result;
        }

        public static List<WarehouseRackLevel> getWarehouseRackLevelList(int? WarehouseRackId)
        {
            List<WarehouseRackLevel> result = new List<WarehouseRackLevel>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnWareHouseRackLevelListGet(WarehouseRackId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    WarehouseRackLevel temp = new WarehouseRackLevel();
                    temp.WarehouseRackId = item.WareHouseRackId;
                    temp.WarehouseRackLevelId = item.WareHouseRackLevelId;
                    temp.RackLevelCode = item.RackLevelCode;
                    temp.RackLevelName = item.RackLevelName;
                    temp.Available = item.Available;
                    result.Add(temp);
                }
            }
            return result;
        }





        public static WareHouse createWarehouse(WareHouse warehouse, int? CompanyId, int? UserId)
        {
            WareHouse result = new WareHouse();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? WarehouseId = warehouse.WareHouseId == null ? 0 : warehouse.WareHouseId;
            db.sp_WarehouseUpdate(warehouse.ManagerName, warehouse.ContactNumber, warehouse.ContactNumberCountryId,
                warehouse.WareHouseAddress.Address1, warehouse.WareHouseAddress.Address2, warehouse.WareHouseAddress.City,
                warehouse.WareHouseAddress.State, warehouse.WareHouseAddress.Zip, warehouse.WareHouseAddress.CountryId,
                warehouse.WareHouseName, true, UserId, CompanyId, ref WarehouseId);
            if(WarehouseId > 0)
            {
                result = getWareHouseDetail(WarehouseId);
            }
            else
            {
                result = null;
            }
            return result;
        }

        public static WarehouseLevel createWarehouseLevel(WarehouseLevel warehouseLevel, int? CompanyId, int? UserId)
        {
            WarehouseLevel result = new WarehouseLevel();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? warehouselevelId = warehouseLevel.WarehouseLevelId == null ? 0 : warehouseLevel.WarehouseLevelId;
            db.sp_WarehouseLevelUpdate(warehouseLevel.WarehouseId, warehouseLevel.LevelName,
                warehouseLevel.LevelCode, warehouseLevel.Available, UserId, CompanyId, ref warehouselevelId);
            if(warehouselevelId > 0)
            {
                result = getWarehouseLevel(warehouselevelId);
            }
            else
            {
                result = null;
            }
            return result;
        }
        

        public static WarehouseZone createWarehouseZone(WarehouseZone warehouseZone, int? CompanyId, int? UserId)
        {
            WarehouseZone result = new WarehouseZone();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? warehouseZoneId = warehouseZone.WarehouseZoneId == null ? 0 : warehouseZone.WarehouseZoneId;
            db.sp_WarehouseZoneUpdate(warehouseZone.WarehouseLevelId, warehouseZone.ZoneCode,
                warehouseZone.ZoneName, warehouseZone.Available, UserId, CompanyId, ref warehouseZoneId);
            if (warehouseZoneId > 0)
            {
                result = getWarehouseZone(warehouseZoneId);
            }
            else
            {
                result = null;
            }

            
            return result;
        }
        

        public static WarehouseRack createWarehouseRack(WarehouseRack warehouseRack, int? CompanyId, int? UserId)
        {
            WarehouseRack result = new WarehouseRack();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? WarehouseRackId = warehouseRack.WarehouseRackId == null ? 0 : warehouseRack.WarehouseRackId;
            db.sp_WarehouseRackUpdate(warehouseRack.WarehouseZoneId, warehouseRack.RackCode,
                warehouseRack.RackName, warehouseRack.Available, UserId, CompanyId, ref WarehouseRackId);
            if (WarehouseRackId > 0)
            {
                result = getWarehouseRack(WarehouseRackId);
            }
            else
            {
                result = null;
            }


            return result;
        }

        public static WarehouseRackLevel createWarehouseRackLevel(WarehouseRackLevel warehouseRackLevel, int? CompanyId, int? UserId)
        {
            WarehouseRackLevel result = new WarehouseRackLevel();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? WarehouseRackLevelId = warehouseRackLevel.WarehouseRackLevelId == null ? 0 : warehouseRackLevel.WarehouseRackLevelId;
            db.sp_WarehouseRackLevelUpdate(warehouseRackLevel.WarehouseRackId, warehouseRackLevel.RackLevelCode,
                warehouseRackLevel.RackLevelName, warehouseRackLevel.Available, UserId, CompanyId, ref WarehouseRackLevelId);
            if (WarehouseRackLevelId > 0)
            {
                result = getWarehouseRackLevel(WarehouseRackLevelId);
            }
            else
            {
                result = null;
            }


            return result;
        }
        

        public static WareHouseCart createWarehouseCart(WareHouseCart warehouseCart, int? CompanyId, int? UserId)
        {
            WareHouseCart result = new WareHouseCart();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? WareHouseCartId = warehouseCart.WarehouseCartId == null ? 0 : warehouseCart.WarehouseCartId;
            db.sp_WarehouseCartUpdate(warehouseCart.WarehouseId, warehouseCart.CartCode,
                warehouseCart.CartName, warehouseCart.Available, UserId, CompanyId, ref WareHouseCartId);
            if (WareHouseCartId > 0)
            {
                result = getWarehouseCart(WareHouseCartId);
            }
            else
            {
                result = null;
            }


            return result;
        }
        
    }

    
}
