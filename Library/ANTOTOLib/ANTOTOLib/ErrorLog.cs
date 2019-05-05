using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static ANTOTOLib.DataModel;

namespace ANTOTOLib
{
    /// <summary>
    /// ErrorLog handles logging information for system maintenaince, including errors caught by Try Catch, debug info, function call parameters,
    /// and any other info the developer think could help trouble shoot system issues.
    /// </summary>
    public partial class ErrorLog
    {
        /// <summary>
        /// Log a new error
        /// </summary>
        /// <param name="Error">Description of the error</param>
        /// <returns>Id for the newly inserted item in ErrorLog table. If it is 0, it means the database is not available for logging errors 
        /// and the error should be logged in the local file system</returns>
        public static int Insert(string pError)
        {
            return ErrorLog.Insert(pError, "Error");
        }


        /// <summary>
        /// Log a new item with specified type
        /// </summary>
        /// <param name="Error">Description of the logged info</param>
        /// <param name="Type">Info Type. It could be Error, Debug, Info, or anything string that is meaningful</param>
        /// <returns></returns>
        public static int Insert(string pError, string pType)
        {
            int result = 0;

            try
            {
                ErrorLog newItem = new ErrorLog();
                newItem.CreateDate = DateTime.UtcNow;
                newItem.Type = pType;
                newItem.Detail = pError;

                antoto_dbDataContext db = new antoto_dbDataContext();
                db.ErrorLogs.InsertOnSubmit(newItem);
                db.SubmitChanges();
                return newItem.Id;
            }
            catch
            {
                
            }
            return result;
        }

        public static ErrorLog GetEntityObj(int pId)
        {
            ErrorLog Result = null;

            antoto_dbDataContext db = new antoto_dbDataContext();

            Result = (from a in db.ErrorLogs
                      where a.Id == pId
                      select a).FirstOrDefault();


            return Result;
        }

        /// <summary>
        /// Check if database connection is good
        /// </summary>
        /// <returns>If greater than 0, the database connectivity is good. Otherwise, it is not</returns>
        public static int CheckDBConnectivity()
        {
            return ErrorLog.Insert("Check DB", "Debug");

        }


        /// <summary>
        /// Get Database connection string
        /// </summary>
        /// <returns></returns>
        public static string Debug_GetDBConnectionString()
        {
            string result = "";

            try
            {
                antoto_dbDataContext db = new antoto_dbDataContext();
                result = db.Connection.ConnectionString;
            }
            catch (Exception exp)
            {
                result = exp.Message;
                result = "";
            }

            return result;
        }
        
    }
}
