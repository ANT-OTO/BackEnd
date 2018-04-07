using API.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Web.Http;
using System.Web.Http.Cors;
using WEYILib;

namespace API.Controllers
{
    [RoutePrefix("ErrorLog")]
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class ErrorLogController : ApiController
    {
        /// <summary>
        /// Debug Tool to get ErrorLog info. Special key is required.
        /// </summary>
        /// <param name="ErrorLogId"></param>
        /// <returns></returns>
        [Route("{ErrorLogId}")]
        [HttpGet]
        public ParaErrorLog ErrorLogGet(int ErrorLogId)
        {

            #region SSL Requirement
            if (Request.RequestUri.Scheme != Uri.UriSchemeHttps)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, new APIError(1, "Requires SSL")));
            }
            #endregion


            int ErrId = 0;
            string Error = string.Empty;

            ParaErrorLog result = null;


            try
            {
                if (HeaderProcessor.ReadValueFromHeader(Request, "DEBUG") == System.Configuration.ConfigurationManager.AppSettings["DebugKey"])
                {
                    ErrorLog erObj = ErrorLog.GetEntityObj(ErrorLogId);
                    if (erObj != null)
                    {
                        result = new ParaErrorLog();
                        result.ErrorLogId = ErrorLogId;
                        result.LogType = erObj.Type;
                        result.Info = erObj.Detail;
                    }
                }
                else
                {
                    Error = "Invalid Key";
                }

            }
            catch (Exception exp)
            {
                MethodBase a = MethodBase.GetCurrentMethod();
                string ErrorInfo = "Class: " + a.DeclaringType.ToString() + "; " + a.ToString() + '\r' + '\n'
                        + "Error Msg: " + exp.Message;
                ErrId = ErrorLog.Insert(ErrorInfo);

                APIError aeObj = new APIError(1, "System Error");
                aeObj.Description = aeObj.Description + " " + ErrId.ToString();
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.BadRequest, aeObj));
            }

            if (!String.IsNullOrEmpty(Error))
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.BadRequest, new APIError(1, Error)));
            }

            if (result == null)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.NotFound, new APIError(1, "Record not found")));
            }

            return result;
        }




        /// <summary>
        /// ErrorLog
        /// </summary>
        /// <returns></returns>
        [Route("Error")]
        [HttpPost]
        public ParaInteger ErrorLogSave(ParaErrorLog ErrorLogItem)
        {

            #region SSL Requirement
            if (Request.RequestUri.Scheme != Uri.UriSchemeHttps)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, new APIError(1, "Requires SSL")));
            }
            #endregion

            int ErrId = 0;
            string Error = string.Empty;
            ParaInteger result = new ParaInteger();

            try
            {
                result.iValue = WEYILib.ErrorLog.Insert(ErrorLogItem.Info, ErrorLogItem.LogType);

            }
            catch (Exception exp)
            {
                MethodBase a = MethodBase.GetCurrentMethod();
                string ErrorInfo = "Class: " + a.DeclaringType.ToString() + "; " + a.ToString() + '\r' + '\n'
                        + "Error Msg: " + exp.Message;
                ErrId = ErrorLog.Insert(ErrorInfo);

                APIError aeObj = new APIError(1, "System Error");
                aeObj.Description = aeObj.Description + " " + ErrId.ToString();
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.BadRequest, aeObj));
            }

            if (!String.IsNullOrEmpty(Error))
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.BadRequest, new APIError(1, Error)));
            }

            return result;
        }



        /// <summary>
        /// Clear Interview
        /// </summary>
        /// <param name="InterviewId"></param>
        /// <returns></returns>
        [Route("Interview/{InterviewId}")]
        [HttpPost]
        public HttpResponseMessage InterviewClear(int InterviewId)
        {

            #region SSL Requirement
            if (Request.RequestUri.Scheme != Uri.UriSchemeHttps)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, new APIError(1, "Requires SSL")));
            }
            #endregion


            int ErrId = 0;
            string Error = string.Empty;


            try
            {
                if (HeaderProcessor.ReadValueFromHeader(Request, "DEBUG") == System.Configuration.ConfigurationManager.AppSettings["DebugKey"])
                {
                    DebugUtility.ClearInterview(InterviewId);

                }
                else
                {
                    Error = "Invalid Key";
                }

            }
            catch (Exception exp)
            {
                MethodBase a = MethodBase.GetCurrentMethod();
                string ErrorInfo = "Class: " + a.DeclaringType.ToString() + "; " + a.ToString() + '\r' + '\n'
                        + "Error Msg: " + exp.Message;
                ErrId = ErrorLog.Insert(ErrorInfo);

                APIError aeObj = new APIError(1, "System Error");
                aeObj.Description = aeObj.Description + " " + ErrId.ToString();
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.BadRequest, aeObj));
            }

            if (!String.IsNullOrEmpty(Error))
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.BadRequest, new APIError(1, Error)));
            }

            return Request.CreateResponse(HttpStatusCode.OK);
        }



        /// <summary>
        /// Debug Tool to get TextSession Content
        /// </summary>
        /// <param name="TextSessionId"></param>
        /// <param name="isListener">true or false</param>
        /// <returns></returns>
        [Route("{TextSessionId}/{isListener}")]
        [HttpGet]
        public ResultRecoveryTextSession TextSessionRecover(int TextSessionId, bool isListener)
        {

            #region SSL Requirement
            if (Request.RequestUri.Scheme != Uri.UriSchemeHttps)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, new APIError(1, "Requires SSL")));
            }
            #endregion


            int ErrId = 0;
            string Error = string.Empty;

            ResultRecoveryTextSession result = null;


            try
            {
                if (HeaderProcessor.ReadValueFromHeader(Request, "DEBUG") == System.Configuration.ConfigurationManager.AppSettings["DebugKey"])
                {
                    result = ResultRecovery.TextSessionRecovery(TextSessionId, isListener);
                }
                else
                {
                    Error = "Invalid Key";
                }

            }
            catch (Exception exp)
            {
                MethodBase a = MethodBase.GetCurrentMethod();
                string ErrorInfo = "Class: " + a.DeclaringType.ToString() + "; " + a.ToString() + '\r' + '\n'
                        + "Error Msg: " + exp.Message;
                ErrId = ErrorLog.Insert(ErrorInfo);

                APIError aeObj = new APIError(1, "System Error");
                aeObj.Description = aeObj.Description + " " + ErrId.ToString();
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.BadRequest, aeObj));
            }

            if (!String.IsNullOrEmpty(Error))
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.BadRequest, new APIError(1, Error)));
            }

            return result;
        }


        /// <summary>
        /// This is used to set up the TimeZone map between different devices and the server.
        /// </summary>
        /// <param name="TimeZoneList"></param>
        /// <returns></returns>
        //[Route("TimeZone")]
        //[HttpPost]
        //public HttpResponseMessage TimeZoneListSetup(List<ParaTimeZone> TimeZoneList)
        //{

        //    #region SSL Requirement
        //    if (Request.RequestUri.Scheme != Uri.UriSchemeHttps)
        //    {
        //        throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, new APIError(1, "Requires SSL")));
        //    }
        //    #endregion


        //    int ErrId = 0;
        //    string Error = string.Empty;

            
        //    try
        //    {
        //        if (HeaderProcessor.ReadValueFromHeader(Request, "DEBUG") == System.Configuration.ConfigurationManager.AppSettings["DebugKey"])
        //        {
        //            foreach (var item in TimeZoneList)
        //            {
        //                TimeZoneMap tzmObj = new TimeZoneMap();
        //                tzmObj.DeviceTypeCodeId = item.DeviceTypeCodeId;
        //                tzmObj.TimeZoneId = item.TimeZoneId;
        //                tzmObj.TimeZoneName = item.TimeZoneName;
        //                tzmObj.TimeZoneAbbr = item.TimeZoneAbbreviation;
        //                tzmObj.SupportDST = item.SupportsDaylightSavingTime;
        //                tzmObj.UTCOffset = item.BaseUTCOffset;

        //                TimeZoneMap.Insert(tzmObj);

        //                if (tzmObj.Id == 0)
        //                {
        //                    Error = "Failed to add TimeZone record";
        //                }

        //            }
        //        }
        //        else
        //        {
        //            Error = "Invalid Key";
        //        }

        //    }
        //    catch (Exception exp)
        //    {
        //        MethodBase a = MethodBase.GetCurrentMethod();
        //        string ErrorInfo = "Class: " + a.DeclaringType.ToString() + "; " + a.ToString() + '\r' + '\n'
        //                + "Error Msg: " + exp.Message;
        //        ErrId = ErrorLog.Insert(ErrorInfo);

        //        APIError aeObj = new APIError(1, "System Error");
        //        aeObj.Description = aeObj.Description + " " + ErrId.ToString();
        //        throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.BadRequest, aeObj));
        //    }

        //    if (!String.IsNullOrEmpty(Error))
        //    {
        //        throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.BadRequest, new APIError(1, Error)));
        //    }


        //    return Request.CreateResponse(HttpStatusCode.OK);
        //}
    }
}
