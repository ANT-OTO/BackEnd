
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
    [RoutePrefix("Security")]
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class SecurityController : ApiController
    {


        /// <summary>
        /// GetList
        /// </summary>
        /// <returns></returns>
        [Route("Role/GetAvailableRoleList/{FunctionNeed}")]
        [HttpGet]
        public List<DataModel.Role> GetAvailableRoleList(bool FunctionNeed)
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
            if (UserSession == null)
            {
                Error = "Required Login";
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, Error));
            }
            #endregion

            List<DataModel.Role> result = null;

            try
            {
               result = CompanySecurity.getAvailableRoleList(UserSession.CompanyId, UserSession.UserId, FunctionNeed);
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
        /// Get Role Detail
        /// </summary>
        /// <returns></returns>
        [Route("Role/GetRoleDetail/{RoleId}")]
        [HttpGet]
        public DataModel.Role GetRoleDetail(int RoleId)
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
            if (UserSession == null)
            {
                Error = "Required Login";
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, Error));
            }
            #endregion
            DataModel.Role result = null;



            try
            {
                result = CompanySecurity.getRoleDetail(RoleId, UserSession.CompanyId, UserSession.UserId);
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
        /// Get Function List
        /// </summary>
        /// <returns></returns>
        [Route("Role/GetFunctionList/{RoleId}")]
        [HttpGet]
        public List<DataModel.Function> GetFunctionList(int RoleId)
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
            if (UserSession == null)
            {
                Error = "Required Login";
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, Error));
            }
            #endregion

            List<DataModel.Function> result = null;
            
            try
            {
                result = CompanySecurity.getFunctionList(RoleId, UserSession.UserId, UserSession.CompanyId);
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
        /// GetList
        /// </summary>
        /// <returns></returns>
        [Route("Role/CreateRole")]
        [HttpPost]
        public DataModel.Role CreateRole(ParaDataModel.ParaRoleCreate roleCreate)
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
            if (UserSession == null)
            {
                Error = "Required Login";
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, Error));
            }
            #endregion

            DataModel.Role result = null;

            try
            {
                result = CompanySecurity.createRole(roleCreate.RoleName, UserSession.CompanyId, roleCreate.ParentRoleId, roleCreate.CopyRoleId, roleCreate.SystemRole, UserSession.UserId);
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
        /// GetList
        /// </summary>
        /// <returns></returns>
        [Route("Role/UpdateRole")]
        [HttpPost]
        public DataModel.Role UpdateRole(DataModel.Role role)
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
            if (UserSession == null)
            {
                Error = "Required Login";
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, Error));
            }
            #endregion


            DataModel.Role result = null;

            try
            {
                result = CompanySecurity.updateRole(role.RoleName, role.RoleId.Value, role.Available, UserSession.UserId, UserSession.CompanyId);
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
        /// GetList
        /// </summary>
        /// <returns></returns>
        [Route("Role/GrantFunctionToRole")]
        [HttpPost]
        public HttpResponseMessage GrantFunctionToRole(ParaDataModel.ParaRoleGrantFunction grantFunction)
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
            if (UserSession == null)
            {
                Error = "Required Login";
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, Error));
            }
            #endregion

            DataModel.Role result = null;

            try
            {
                CompanySecurity.grantFunctionToRole(grantFunction.RoleId, grantFunction.FunctionId, grantFunction.granted, grantFunction.ActionForSubRole, grantFunction.ActionForSubFunction, UserSession.UserId);
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

            return Request.CreateResponse(HttpStatusCode.OK);

        }

    }


}
