using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public class AntotoFile
    {
        
        public static WizardForm.WizardInputFile getFileFromId(int FileId)
        {
            WizardForm.WizardInputFile result = new WizardForm.WizardInputFile();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnFileGet(FileId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    result.FileLink = item.FilePublicUrl;
                    result.FileExt = item.FileExt;
                    result.FileId = FileId;
                    result.FileDescription = item.Para1;
                    result.MFileLink = item.MFilePublicUrl;
                    result.SFileLink = item.SFilePublicUrl;
                    
                }
            }
            return result;
        }

        public static WizardForm.WizardInputFile getFileFromIdInternal(int FileId)
        {
            WizardForm.WizardInputFile result = new WizardForm.WizardInputFile();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnFileGet(FileId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    result.FileLink = item.FilePublicUrl;
                    result.FileExt = item.FileExt;
                    result.FileId = FileId;
                    result.FileDescription = item.Para1;
                    result.MFileLink = item.MFilePublicUrl;
                    result.SFileLink = item.SFilePublicUrl;
                    if (item.FilePath.Contains("."))
                    {
                        result.FilePath = item.FilePath;
                    }
                    else
                    {
                        result.FilePath = item.FilePath + item.FileName + "." + item.FileExt;
                    }
                    
                    

                }
            }
            return result;
        }

        public static int UploadFileConfirm(string FileName, string FileExt, string FilePath, string FilePublicUrl,string MFilePublicUrl, string SFilePublicUrl, int FileStoreTypeCodeId, int UserId)
        {
            int? result = 0;
            antoto_dbDataContext db = new antoto_dbDataContext();
            db.sp_FileInsert(FileExt, FileName, FileStoreTypeCodeId, FilePath, FilePublicUrl, MFilePublicUrl, SFilePublicUrl, UserId, ref result);
            return result == null ? 0 : result.Value;
        }


        public static DataModel.ResultProductSupplyInfo getProductSupplyInfo(int SupplierPlaceInfoId)
        {
            DataModel.ResultProductSupplyInfo result = new DataModel.ResultProductSupplyInfo();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnSupplierPlaceInfoGet(SupplierPlaceInfoId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    result.SupplierName = item.SupplierName;
                    result.SupplierLocation = item.SupplierLocation;
                    result.Price = item.PriceInfo;
                    result.CurrencyId = item.CurrencyId;
                    result.Description = item.Description;
                    result.SupplierPlaceInfoId = item.SupplierPlaceInfoId;
                    break;
                }
            }
            if(result.SupplierPlaceInfoId == null || result.SupplierPlaceInfoId == 0)
            {
                result = null;
            }
            return result;
        }

        public static DataModel.ResultProductSupplyInfo UploadProductSupplyInfo(DataModel.ResultProductSupplyInfo info, int UserId)
        {
            int? result = 0;
            antoto_dbDataContext db = new antoto_dbDataContext();
            db.sp_SupplierPlaceInfoSet(info.SupplierName, info.SupplierLocation, info.Price, info.CurrencyId, info.Description,
                UserId, ref result);
            if(result != null && result > 0)
            {
                return getProductSupplyInfo(result.Value);
            }
            else
            {
                return null;
            }
        }

        public static DataModel.ResultItemRelatedUPCInfo getItemRelatedUPCInfo(int ItemRelatedUPCInfoId)
        {
            DataModel.ResultItemRelatedUPCInfo result = new DataModel.ResultItemRelatedUPCInfo();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnItemRelatedUPCInfoGet(ItemRelatedUPCInfoId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    result.ItemRelatedUPCInfoId = item.ItemRelatedUPCInfoId;
                    result.Description = item.Description;
                    result.SaleTag = item.SaleTag;
                    result.UPC = item.UPC;
                    break;
                }
            }
            if (result.ItemRelatedUPCInfoId == null || result.ItemRelatedUPCInfoId == 0)
            {
                result = null;
            }
            return result;
        }

        public static DataModel.ResultItemRelatedUPCInfo UploadItemRelatedUPCInfo(DataModel.ResultItemRelatedUPCInfo info, int UserId)
        {
            int? result = 0;
            antoto_dbDataContext db = new antoto_dbDataContext();
            db.sp_ItemRelatedUPCInfoSet(info.UPC, info.Description, info.SaleTag, ref result);
            if (result != null && result > 0)
            {
                return getItemRelatedUPCInfo(result.Value);
            }
            else
            {
                return null;
            }
        }
    }
}
