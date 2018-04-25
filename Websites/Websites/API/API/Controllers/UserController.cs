
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Reflection;

using System.Threading.Tasks;
using System.Web;
using System.IO;
using System.Net.Http.Headers;
using System.Data.Linq;

using System.Diagnostics;

using System.Web.Http.Cors;
using ANTOTOLib;


namespace API.Controllers
{
    /// <summary>
    /// Client related functions
    /// </summary>
    [RoutePrefix("User")]
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class UserController : ApiController
    {
        /// <summary>
        /// Get Person's current status
        /// </summary>
        /// <returns></returns>
        [Route("")]
        [HttpGet]
        public DataModel.User PersonStatusGet()
        {

            //#region SSL Requirement
            //if (Request.RequestUri.Scheme != Uri.UriSchemeHttps)
            //{
            //    throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, "Requires SSL"));
            //}
            //#endregion


            int ErrId = 0;
            string Error = string.Empty;
            #region Token
            UserSession UserSession = UserSession.Validate(HeaderProcessor.ReadValueFromHeader(Request, "ANTToken"));
            if(UserSession == null)
            {
                Error = "Required Login";
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, Error));
            }
            #endregion

            DataModel.User result = null;

            try
            {
                result = ANTOTOLib.UserManager.GetUser(UserSession.UserId, UserSession.CompanyId);
                if(result == null)
                {
                    Error = "User Info Retrieve Fail";
                }
                
            }
            catch (Exception exp)
            {
                MethodBase a = MethodBase.GetCurrentMethod();
                string ErrorInfo = "Class: " + a.DeclaringType.ToString() + "; " + a.ToString() + '\r' + '\n'
                        + "Error Msg: " + exp.Message;
                //ErrId = ErrorLog.Insert(ErrorInfo);

                //APIError aeObj = new APIError(psObj.SystemLanguageId, "System Error");
                //aeObj.Description = aeObj.Description + " " + ErrId.ToString();
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.BadRequest, "System Error"));
            }

            if (!String.IsNullOrEmpty(Error))
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.BadRequest, Error));
            }

            return result;
        }

        /// <summary>
        /// Get Person's current status
        /// </summary>
        /// <returns></returns>
        [Route("Login")]
        [HttpPost]
        public DataModel.ResultToken Login(ParaDataModel.ParaUserLogin loginInfo)
        {

            int ErrId = 0;
            string Error = string.Empty;
            DataModel.ResultToken result = null;
            try
            {
                result = UserManager.login(loginInfo.LoginName, loginInfo.Password, loginInfo.SystemLanguageId);
                if(result == null)
                {
                    Error = "Login Failed"; 
                }
            }
            catch (Exception exp)
            {
                MethodBase a = MethodBase.GetCurrentMethod();
                string ErrorInfo = "Class: " + a.DeclaringType.ToString() + "; " + a.ToString() + '\r' + '\n'
                        + "Error Msg: " + exp.Message;
                //ErrId = ErrorLog.Insert(ErrorInfo);
                //APIError aeObj = new APIError(psObj.SystemLanguageId, "System Error");
                //aeObj.Description = aeObj.Description + " " + ErrId.ToString();
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.BadRequest, "ErrorInfo"));
            }

            if (!String.IsNullOrEmpty(Error))
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.BadRequest, Error));
            }

            return result;
        }



        


        
    }
}
