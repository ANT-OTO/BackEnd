
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

            #region SSL Requirement
            if (Request.RequestUri.Scheme != Uri.UriSchemeHttps)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, "Requires SSL"));
            }
            #endregion
            DataModel.User user = null;
            DataModel.Company company = null;

            int ErrId = 0;
            string Error = string.Empty;


            List<DataModel.Role> result = null;

            try
            {
               result = CompanySecurity.getAvailableRoleList(0, 0, FunctionNeed);
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

            #region SSL Requirement
            if (Request.RequestUri.Scheme != Uri.UriSchemeHttps)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, "Requires SSL"));
            }
            #endregion
            DataModel.User user = null;
            DataModel.Company company = null;

            int ErrId = 0;
            string Error = string.Empty;


            DataModel.Role result = null;



            try
            {
                CompanySecurity.getRoleDetail(RoleId, company.CompanyId, user.UserId);
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

            #region SSL Requirement
            if (Request.RequestUri.Scheme != Uri.UriSchemeHttps)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, "Requires SSL"));
            }
            #endregion
            DataModel.User user = null;
            DataModel.Company company = null;

            int ErrId = 0;
            string Error = string.Empty;


            List<DataModel.Function> result = null;
            
            try
            {
                result = CompanySecurity.getFunctionList(RoleId, user.UserId, company.CompanyId);
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
        public DataModel.Role CreateRole(String RoleName, int ParentRoleId, int CopyRoleId, bool SystemRole)
        {

            #region SSL Requirement
            if (Request.RequestUri.Scheme != Uri.UriSchemeHttps)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, "Requires SSL"));
            }
            #endregion
            DataModel.Company company = null;
            DataModel.User user = null;


            int ErrId = 0;
            string Error = string.Empty;



            DataModel.Role result = null;

            try
            {
                result = CompanySecurity.createRole(RoleName, company.CompanyId, ParentRoleId, CopyRoleId, SystemRole, user.UserId);
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
        public DataModel.Role UpdateRole(String RoleName, int RoleId, bool Available)
        {

            #region SSL Requirement
            if (Request.RequestUri.Scheme != Uri.UriSchemeHttps)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, "Requires SSL"));
            }
            #endregion
            DataModel.Company company = null;
            DataModel.User user = null;


            int ErrId = 0;
            string Error = string.Empty;



            DataModel.Role result = null;

            try
            {
                result = CompanySecurity.updateRole(RoleName, RoleId, Available, user.UserId, company.CompanyId);
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
        public HttpResponseMessage GrantFunctionToRole(int RoleId, int FunctionId, bool granted, bool ActionForSubRole, bool ActionForSubFunction)
        {

            #region SSL Requirement
            if (Request.RequestUri.Scheme != Uri.UriSchemeHttps)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.Forbidden, "Requires SSL"));
            }
            #endregion
            DataModel.Company company = null;
            DataModel.User user = null;


            int ErrId = 0;
            string Error = string.Empty;



            DataModel.Role result = null;

            try
            {
                CompanySecurity.grantFunctionToRole(RoleId, FunctionId, granted, ActionForSubRole, ActionForSubFunction, user.UserId);
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
