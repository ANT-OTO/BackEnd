using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static ANTOTOLib.DataModel;

namespace ANTOTOLib
{
    public class CompanyTransaction
    {
        public static DataModel.ResultPageResult CompanyTransactionSearch(ParaDataModel.ParaCompanyTransactionSearch companyTransactionSearch, int pCompanyId, int pSystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? total = 0;
            int? totalPage = 0;
            int? Page = companyTransactionSearch.Page;
            int? NextPage = 0;
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
            var list = db.sp_CompanyTransactionSearch(pCompanyId, companyTransactionSearch.BeginDate, companyTransactionSearch.EndDate, 
                companyTransactionSearch.DescriptionSearch, companyTransactionSearch.PageSize, ref Page, ref total, ref totalPage);
            if (list != null)
            {
                NextPage = Page < totalPage ? Page + 1 : totalPage;
                foreach (var item in list)
                {
                    var currentobject = new DataModel.ResultShippingOrderCompanyTransaction
                    {
                        CompanyTransactionId = item.CompanyTransactionId,
                        CompanyId = item.CompanyId,
                        CompanyName = item.CompanyName,
                        Currency = item.Currency,
                        CurrencyId = item.CurrencyId,
                        Description = item.Description,
                        TransactionType = item.TransactionType,
                        TransactionTypeCodeId = item.TransactionTypeCodeId,
                        UserId = item.UserId,
                        UserName = item.UserName,
                        Amount = item.Amount,
                        CurrentBalance = item.CurrentBalance
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


        public static DataModel.ResultPageResult CompanyTransactionRequestSearch(ParaDataModel.ParaCompanyTransactionRequestSearch companyTransactionRequestSearch, int pCompanyId, int pSystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? total = 0;
            int? totalPage = 0;
            int? Page = companyTransactionRequestSearch.Page;
            int? NextPage = 0;
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
            var list = db.sp_CompanyTransactionRequestSearch(pCompanyId, companyTransactionRequestSearch.BeginDate, companyTransactionRequestSearch.EndDate, 
                companyTransactionRequestSearch.CompanyTransactionRequestStatusCodeId, companyTransactionRequestSearch.PageSize, ref Page, ref total, ref totalPage);
            if (list != null)
            {
                NextPage = Page < totalPage ? Page + 1 : totalPage;
                foreach (var item in list)
                {
                    var currentobject = new DataModel.ResultCompanyTransactionRequest
                    {
                        CompanyTransactionRequestId = item.CompanyTransactionRequestId,
                        Amount = item.Amount,
                        CurrencyId = item.CurrencyId,
                        Currency = item.Currency,
                        SourceCompanyId = item.SourceCompanyId,
                        SourceCompany = item.SourceCompanyName,
                        HandlerCompanyId = item.HandlerCompanyId,
                        HandlerCompany = item.HandlerCompanyName,
                        CompanyTransactionRequestStatusCodeId = item.CompanyTransactionRequestStatusCodeId,
                        CompanyTransactionRequestStatus = item.CompanyTransactionRequestStatus,
                        UserId = item.UserId,
                        UserName = item.UserName,
                        CompanyTransactionRequestFileList = getCompanyTransactionRequestFileList(item.CompanyTransactionRequestId)
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

        public static List<DataModel.ResultCompanyTransactionRequestFile> getCompanyTransactionRequestFileList(int? CompanyTransactionRequestId)
        {
            List<DataModel.ResultCompanyTransactionRequestFile> result = new List<ResultCompanyTransactionRequestFile>();

            antoto_dbDataContext db = new antoto_dbDataContext();

            var list = db.tfnCompanyTransactionRequestFileGet(CompanyTransactionRequestId);

            if (list != null)
            {
                foreach(var item in list)
                {
                    DataModel.ResultCompanyTransactionRequestFile temp = new ResultCompanyTransactionRequestFile();
                    temp.File = AntotoFile.getFileFromId(item.FileId);
                    result.Add(temp);
                }
            }

            return result;
        }

        public static DataModel.ResultCompanyTransactionRequest CompanyTransactionRequestCreate(DataModel.ResultCompanyTransactionRequest companyTransactionRequest, int? UserId)
        {
            DataModel.ResultCompanyTransactionRequest result = new ResultCompanyTransactionRequest();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? CompanyTransactionRequestId = 0;
            db.sp_CompanyTransactionRequestCreate(ref CompanyTransactionRequestId, companyTransactionRequest.SourceCompanyId,
                companyTransactionRequest.HandlerCompanyId, companyTransactionRequest.Amount, companyTransactionRequest.CurrencyId,
                companyTransactionRequest.Description, UserId, UserId, 1);
            result = GetCompanyTransactionRequest(CompanyTransactionRequestId);
            return result;
        }

        public static DataModel.ResultCompanyTransactionRequest CompanyTransactionRequestApprove(DataModel.ResultCompanyTransactionRequest companyTransactionRequest, int? UserId)
        {
            DataModel.ResultCompanyTransactionRequest result = new ResultCompanyTransactionRequest();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? CompanyTransactionRequestId = 0;
            db.sp_CompanyTransactionRequestApprove(ref CompanyTransactionRequestId, UserId, UserId, 1);
            result = GetCompanyTransactionRequest(CompanyTransactionRequestId);
            return result;
        }

        public static DataModel.ResultCompanyTransactionRequest CompanyTransactionRequestCancel(DataModel.ResultCompanyTransactionRequest companyTransactionRequest, int? UserId)
        {
            DataModel.ResultCompanyTransactionRequest result = new ResultCompanyTransactionRequest();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? CompanyTransactionRequestId = 0;
            db.sp_CompanyTransactionRequestCancel(ref CompanyTransactionRequestId, UserId, UserId, 1);
            result = GetCompanyTransactionRequest(CompanyTransactionRequestId);
            return result;
        }

        public static DataModel.ResultCompanyTransactionRequest CompanyTransactionRequestDeny(DataModel.ResultCompanyTransactionRequest companyTransactionRequest, int? UserId)
        {
            DataModel.ResultCompanyTransactionRequest result = new ResultCompanyTransactionRequest();
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? CompanyTransactionRequestId = 0;
            db.sp_CompanyTransactionRequestDeny(ref CompanyTransactionRequestId, UserId, UserId, 1);
            result = GetCompanyTransactionRequest(CompanyTransactionRequestId);
            return result;
        }

        public static DataModel.ResultCompanyTransactionRequest GetCompanyTransactionRequest(int? CompanyTransactionRequestId)
        {
            DataModel.ResultCompanyTransactionRequest result = new ResultCompanyTransactionRequest();

            antoto_dbDataContext db = new antoto_dbDataContext();

            var list = db.tfnCompanyTransactionRequestGet(CompanyTransactionRequestId);

            if (list != null)
            {
                foreach(var item in list)
                {
                    DataModel.ResultCompanyTransactionRequest temp = new ResultCompanyTransactionRequest();
                    temp.CompanyTransactionRequestId = item.CompanyTransactionRequestId;
                    temp.CompanyTransactionRequestStatusCodeId = item.CompanyTransactionRequestStatusCodeId;
                    temp.CompanyTransactionRequestStatus = item.CompanyTransactionRequestStatus;
                    temp.Amount = item.Amount;
                    temp.CompanyTransactionRequestFileList = getCompanyTransactionRequestFileList(item.CompanyTransactionRequestId);
                    temp.Currency = item.Currency;
                    temp.CurrencyId = item.CurrencyId;
                    temp.Description = "";
                    temp.HandlerCompanyId = item.HandlerCompanyId;
                    temp.HandlerCompany = item.HandlerCompanyName;
                    temp.SourceCompany = item.SourceCompanyName;
                    temp.SourceCompanyId = item.SourceCompanyId;
                    temp.UserId = item.UserId;
                    temp.UserName = item.UserName;
                    result = temp;
                }
            }
            return result;
        }

        public static DataModel.ResultPageResult CustomerCompanyTransactionListGet(ParaDataModel.ParaCustomerCompanyTransactionSearch companyTransactionSearch, int pCompanyId, int pSystemLanguageId)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            int? total = 0;
            int? totalPage = 0;
            int? Page = companyTransactionSearch.Page;
            int? NextPage = 0;
            DataModel.ResultPageResult result = new DataModel.ResultPageResult();
            var list = db.sp_CompanyTransactionSearch(companyTransactionSearch.SourceCompanyId, companyTransactionSearch.BeginDate, companyTransactionSearch.EndDate,
                companyTransactionSearch.DescriptionSearch, companyTransactionSearch.PageSize, ref Page, ref total, ref totalPage);
            if (list != null)
            {
                NextPage = Page < totalPage ? Page + 1 : totalPage;
                foreach (var item in list)
                {
                    var currentobject = new DataModel.ResultShippingOrderCompanyTransaction
                    {
                        CompanyTransactionId = item.CompanyTransactionId,
                        CompanyId = item.CompanyId,
                        CompanyName = item.CompanyName,
                        Currency = item.Currency,
                        CurrencyId = item.CurrencyId,
                        Description = item.Description,
                        TransactionType = item.TransactionType,
                        TransactionTypeCodeId = item.TransactionTypeCodeId,
                        UserId = item.UserId,
                        UserName = item.UserName,
                        Amount = item.Amount,
                        CurrentBalance = item.CurrentBalance
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

        public static int CustomerCompanyTransactionSet(ParaDataModel.ParaCompanyTransactionSet paraCompanyTransactionSet, int? UserId, int? CompanyId)
        {
            int? result = 0;
            antoto_dbDataContext db = new antoto_dbDataContext();
            db.sp_CompanyTransactionCustomerQuickAction(paraCompanyTransactionSet.CustomerCompanyId, CompanyId,
                paraCompanyTransactionSet.Price, paraCompanyTransactionSet.CurrencyId, paraCompanyTransactionSet.Description,
                paraCompanyTransactionSet.TransactionTypeCodeId, UserId, UserId, 1, ref result);

            return result == null ? 0 : result.Value;
        }
    }
}
