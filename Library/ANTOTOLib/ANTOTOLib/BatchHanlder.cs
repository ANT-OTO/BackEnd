using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using static ANTOTOLib.DataModel;
using ExcelDataReader;

namespace ANTOTOLib
{
    public partial class BatchHandler
    {
        public class BatchRequest
        {
            public int? BatchHanlderId { get; set; }

            public int? BatchTemplateId { get; set; }

            public int? BatchStatusCodeId { get; set; }

            public string BatchNumber { get; set; }

            public string BatchNotificationMsg { get; set; }

            public int? UserId { get; set; }

            public List<BatchHandlerColumn> ColumnList { get; set; }

            public List<BatchHandlerRecord> RecordList { get; set; }

            public WizardForm.WizardInputFile outputFile { get; set; }
        }

        public class BatchHandlerColumn
        {
            public string ColumnName { get; set; }

            public int? ColumnOrder { get; set; }

            public bool? Required { get; set; }

            public int? ColumnTypeCodeId { get; set; }

            public int? BatchHandlerColumnId { get; set; }
        }

        public class BatchHandlerRecord
        {
            public bool? Changed { get; set; }

            public int? BatchHandlerRecordId { get; set; }

            public int? BatchHandlerRecordStatusCodeId { get; set; }

            public string BatchHandlerRecordStatus { get; set; }

            public string RecordNumber { get; set; }

            public List<BatchHandlerRecordDetail> DetailList { get; set; }
        }

        public class BatchHandlerRecordDetail
        {
            public int? BatchHandlerRecordId { get; set; }

            public int? BatchHandlerColumnId { get; set; }

            public string BatchHandlerValue { get; set; }

            public int? BatchHandlerRecordDetailId { get; set; }

            public string ColumnName { get; set; }

            public int? ColumnOrder { get; set; }

            public bool? Required { get; set; }

            public int? ColumnTypeCodeId { get; set; }

            public bool? HasError { get; set; }

            public string ErrorReason { get; set; }
        }

        public class BatchTemplate
        {
            public int? BatchTemplateId { get; set; }

            public string TemplateName { get; set; }

            public string TemplatePath { get; set; }

            public string TemplatePublicUrl { get; set; }

            public string TemplateCode { get; set; }
        }
        

        public static int BatchHandlerColumnIdGetFromName(string ColumnName, List<BatchHandlerColumn> list)
        {
            int? BatchHandlerColumnId = 0;
            if (list != null)
            {
                foreach(var item in list)
                {
                    if(item.ColumnName == ColumnName)
                    {
                        BatchHandlerColumnId = item.BatchHandlerColumnId;
                        break;
                    }
                }
            }
            return BatchHandlerColumnId == null? 0 : BatchHandlerColumnId.Value;
        }

        public static List<BatchHandlerColumn> ColumnListGet(int? BatchHandlerId)
        {
            List<BatchHandlerColumn> result = new List<BatchHandlerColumn>();

            antoto_dbDataContext db = new antoto_dbDataContext();

            var list = db.tfnBatchHandlerColumnListGet(BatchHandlerId);

            if (list != null)
            {
                foreach(var item in list)
                {
                    BatchHandlerColumn column = new BatchHandlerColumn();
                    column.BatchHandlerColumnId = item.BatchHandlerColumnId;
                    column.ColumnName = item.ColumnName;
                    column.ColumnOrder = item.ColumnOrder;
                    column.ColumnTypeCodeId = item.ColumnTypeCodeId;
                    column.Required = item.Required;
                    result.Add(column);
                }
            }

            return result;
        }

        public static BatchRequest GetBatchRequest(int? BatchRequestId)
        {
            BatchRequest result = new BatchRequest();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnBatchHandlerGet(BatchRequestId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    result.BatchHanlderId = item.BatchHandlerId;
                    result.BatchTemplateId = item.BatchTemplateId;
                    result.BatchStatusCodeId = item.BatchStatusCodeId;
                    result.BatchNumber = item.BatchNumber;
                    result.ColumnList = ColumnListGet(item.BatchHandlerId);
                    result.RecordList = getRecordList(item.BatchHandlerId);
                    result.UserId = item.UserId;
                    break;
                }
            }
            return result;
        }

        public static List<BatchHandlerRecord> getRecordList(int? BatchHandlerId)
        {
            List<BatchHandlerRecord> result = new List<BatchHandlerRecord>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnBatchHandlerRecordListGet(BatchHandlerId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    BatchHandlerRecord temp = new BatchHandlerRecord();
                    temp.BatchHandlerRecordId = item.BatchHandlerRecordId;
                    temp.BatchHandlerRecordStatusCodeId = item.BatchHandlerRecordStatusCodeId;
                    temp.RecordNumber = item.RecordNumber;
                    temp.DetailList = getBatchHandlerDetailList(temp.BatchHandlerRecordId);
                    result.Add(temp);
                }
            }
            return result;
        }

        public static List<BatchHandlerRecordDetail> getBatchHandlerDetailList(int? BatchHandlerRecordId)
        {
            List<BatchHandlerRecordDetail> result = new List<BatchHandlerRecordDetail>();

            antoto_dbDataContext db = new antoto_dbDataContext();

            var list = db.tfnBatchHandlerRecordDetailGet(BatchHandlerRecordId);

            if (list != null)
            {
                foreach(var item in list)
                {
                    BatchHandlerRecordDetail temp = new BatchHandlerRecordDetail();
                    temp.BatchHandlerRecordDetailId = item.BatchHandlerRecordDetailId;
                    temp.BatchHandlerRecordId = item.BatchHandlerRecordId;
                    temp.BatchHandlerColumnId = item.BatchHandlerColumnId;
                    temp.BatchHandlerValue = item.Value;
                    temp.ColumnName = item.ColumnName;
                    temp.ColumnOrder = item.ColumnOrder;
                    temp.ColumnTypeCodeId = item.ColumnTypeCodeId;
                    temp.HasError = item.HasError;
                    temp.ErrorReason = item.ErrorReason;
                    result.Add(temp);
                }
            }

            return result;
        }

        public static BatchRequest uploadExcelFileToBatchHandler(int FileId, int? BatchTemplateId, int? HandlerCompanyId, int? UserId, int? CompanyId)
        {
            BatchRequest result = new BatchRequest();

            antoto_dbDataContext db = new antoto_dbDataContext();

            List<BatchHandlerColumn> columns = ColumnListGet(BatchTemplateId);
            //Setup Batch Request
            int? BatchHandlerId = 0;
            db.sp_BatchHandlerSetup(ref BatchHandlerId, BatchTemplateId, 1, UserId, UserId, 1);

            BatchRequestPropertySet(BatchHandlerId, "HandlerCompanyId", HandlerCompanyId.ToString(), UserId);
            BatchRequestPropertySet(BatchHandlerId, "SourceCompanyId", CompanyId.ToString(), UserId);

            var file = AntotoFile.getFileFromIdInternal(FileId);
            
            using (var stream = File.Open(file.FilePath, FileMode.Open, FileAccess.Read))
            {
                // Auto-detect format, supports:
                //  - Binary Excel files (2.0-2003 format; *.xls)
                //  - OpenXml Excel files (2007 format; *.xlsx)
                using (var reader = ExcelReaderFactory.CreateReader(stream))
                {
                    // Choose one of either 1 or 2:
                    // 1. Use the reader methods 
                    do
                    {
                        while (reader.Read())
                        {
                            // reader.GetDouble(0);
                        }
                    } while (reader.NextResult());
                    // 2. Use the AsDataSet extension method
                    System.Data.DataSet temp = reader.AsDataSet();
                    int i = 0;
                    foreach (DataTable table in temp.Tables)
                    {
                        foreach (DataRow row in table.Rows)
                        {
                            if (i == 0 || i == 1)
                            {
                                i++;
                                continue;
                            }
                            bool emptyRow = false;
                            //foreach(DataColumn column in table.Columns)
                            //{
                            //    var tempStr = table.Rows[i][column.ColumnName].ToString();
                            //    ErrorLog.Insert("Row " + i.ToString() + ": " + tempStr);
                            //    if (!String.IsNullOrEmpty(tempStr))
                            //    {
                            //        emptyRow = false;
                            //    }
                            //}
                            if (!emptyRow)
                            {
                                int? BatchHandlerRecordId = 0;
                                db.sp_BatchHandlerRecordInsert(BatchHandlerId, ref BatchHandlerRecordId, UserId, 1);
                                int columnId = 1;
                                foreach (DataColumn column in table.Columns)
                                {
                                    var str = table.Rows[i][column.ColumnName].ToString();
                                    //int ColumnId = BatchHandlerColumnIdGetFromName(column.ColumnName, )
                                    //db.sp_ErrorLog_Insert("Batch Content is "+str+"; Column name is " + columnId, "Batch");

                                    int? BatchHandlerRecordDetailId = 0;
                                    db.sp_BatchHandlerRecordDetailInsert(BatchHandlerRecordId, columnId.ToString(), ref BatchHandlerRecordDetailId, str, UserId, 1);
                                    columnId++;
                                }
                                
                            }
                            i++;
                        }
                        db.sp_BatchHandlerRecordCheck(BatchHandlerId, UserId, UserId, 1);
                    }
                }
                result = GetBatchRequest(BatchHandlerId);
                return result;
            }
        }

        public static BatchRequest updateBatchRequest(BatchRequest batchRequest, int? UserId)
        {
            BatchRequest result = new BatchRequest();

            antoto_dbDataContext db = new antoto_dbDataContext();

            if (batchRequest != null)
            {
                foreach(var item in batchRequest.RecordList)
                {
                    if(item.Changed == true)
                    {
                        foreach(var item1 in item.DetailList)
                        {
                            db.sp_BatchHandlerRecordDetailUpdate(item1.BatchHandlerRecordDetailId, item1.BatchHandlerValue, UserId, 1);
                        }
                    }
                }
                db.sp_BatchHandlerRecordCheck(batchRequest.BatchHanlderId, UserId, UserId, 1);
            }
            result = GetBatchRequest(batchRequest.BatchHanlderId);
            return result;
        }

        public static BatchRequest completeBatchRequest(BatchRequest batchRequest, int? UserId)
        {
            BatchRequest result = new BatchRequest();

            antoto_dbDataContext db = new antoto_dbDataContext();

            var temp = GetBatchRequest(batchRequest.BatchHanlderId);

            if (temp.RecordList != null)
            {
                foreach(var record in temp.RecordList)
                {
                    int? BatchHandlerRecordId = record.BatchHandlerRecordId;
                    int? ShippingOrderId = 0;
                    db.sp_BatchHandlerRecordDetailGenerateShippingOrder(BatchHandlerRecordId, ref ShippingOrderId);
                    var shippingOrder = ShippingOrder.GetShippingOrder(ShippingOrderId);
                    string shippingOrderCode = "";
                    if (shippingOrder != null)
                    {
                        shippingOrderCode = shippingOrder.ShippingOrderCode;
                    }
                    try
                    {
                        ParaDataModel.ParaShippingOrderPackage tt = new ParaDataModel.ParaShippingOrderPackage();
                        tt.ShippingOrderId = ShippingOrderId;
                        ShippingOrderAction.ShippingOrderGenerateLabel(tt, UserId, 0);
                        db.sp_BatchHandlerRecordPropertySet(BatchHandlerRecordId, "ShippingOrderCode", shippingOrderCode, UserId, UserId, 1);
                    }
                    catch(Exception ex)
                    {

                    }
                    
                }
            }


            db.sp_BatchHandlerComplete(batchRequest.BatchHanlderId, UserId, UserId, 1);
            
            result = GetBatchRequest(batchRequest.BatchHanlderId);

            result.outputFile = Utilities.generateBatchExcelReceiptFile(batchRequest.BatchHanlderId.Value);

            return result;
        }

        public static BatchRequest cancelBatchRequest(BatchRequest batchRequest, int? UserId)
        {
            BatchRequest result = new BatchRequest();

            antoto_dbDataContext db = new antoto_dbDataContext();

            db.sp_BatchHandlerCancel(batchRequest.BatchHanlderId, UserId, UserId, 1);

            result = GetBatchRequest(batchRequest.BatchHanlderId);

            return result;
        }

        public static List<BatchTemplate> BatchTemplateListGet(int? CompanyId)
        {
            List<BatchTemplate> result = new List<BatchTemplate>();

            antoto_dbDataContext db = new antoto_dbDataContext();

            var list = db.tfnBatchTemplateListGet(CompanyId);

            if (list != null)
            {
                foreach(var item in list)
                {
                    BatchTemplate batchTemplate = new BatchTemplate();
                    batchTemplate.BatchTemplateId = item.BatchTemplateId;
                    batchTemplate.TemplateName = item.TemplateName;
                    batchTemplate.TemplatePath = item.FilePath;
                    batchTemplate.TemplateCode = item.TemplateCode;
                    batchTemplate.TemplatePublicUrl = item.FilePublicUrl;
                    result.Add(batchTemplate);
                }
            }

            return result;
        }

        public static void BatchRequestPropertySet(int? BatchRequestId, string PropertyName, string PropertyValue, int? UserId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            db.sp_BatchHandlerPropertySet(BatchRequestId, PropertyName, PropertyValue, UserId, UserId, 1);
            return;
        }

        public static string BatchHandlerRecordPropertyValueGet(int BatchHandlerRecordId, string PropertyName)
        {
            string result = "";

            antoto_dbDataContext db = new antoto_dbDataContext();

            result = db.sfnBatchHandlerRecordDetailPropertyGet(BatchHandlerRecordId, PropertyName);

            return result;
        }
    }
}
