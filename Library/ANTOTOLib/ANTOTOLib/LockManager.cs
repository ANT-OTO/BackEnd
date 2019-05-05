using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public partial class LockManager
    {
        private static void Update(LockManager pNewItem)
        {
            antoto_dbDataContext db = new antoto_dbDataContext();
            pNewItem.LastUpdate = DateTime.UtcNow;
            db.LockManagers.Attach(pNewItem, true);
            db.SubmitChanges();
        }

        public static LockManager Lock(string pLockName, int pTimeout)
        {
            try
            {
                antoto_dbDataContext db = new antoto_dbDataContext();
                LockManager lk = LockManager.Lock(db, pLockName);

                int TimeWait = 0;
                while (lk == null && TimeWait < pTimeout)
                {
                    Random r = new Random();
                    int SleepTime = r.Next(15);
                    Thread.Sleep(SleepTime);
                    TimeWait += SleepTime;
                    lk = LockManager.Lock(db, pLockName);
                }
                return lk;
            }
            catch (Exception exp)
            {
                MethodBase a = MethodBase.GetCurrentMethod();
                string ErrorInfo = "Class: " + a.DeclaringType.ToString() + "; " + a.ToString() + '\r' + '\n'
                        + "Error Msg: " + exp.Message;

                int ErrId = ErrorLog.Insert(ErrorInfo);
                ErrorInfo = "ErrId=" + ErrId.ToString() + "; Parameters: LockName=" + pLockName + "; Timeout=" + pTimeout.ToString();
                ErrorLog.Insert(ErrorInfo);
                return null;
            }
        }

        private static LockManager Lock(antoto_dbDataContext db, string pLockName)
        {
            try
            {
                bool? success = false;

                if (String.IsNullOrEmpty(pLockName))
                {
                    pLockName = String.Empty;
                    ErrorLog.Insert("LockName is null/empty", "Debug");
                }

                db.sp_GetLock(pLockName, ref success);

                if (success.HasValue && success == true)
                {
                    var query = (from a in db.LockManagers
                                 where a.LockName == pLockName
                                 select a).Take(1);

                    foreach (LockManager v in query)
                    {
                        return v;
                    }
                }

                return null;

            }
            catch (Exception exp)
            {
                MethodBase a = MethodBase.GetCurrentMethod();
                string ErrorInfo = "Class: " + a.DeclaringType.ToString() + "; " + a.ToString() + '\r' + '\n'
                        + "Error Msg: " + exp.Message;
                int ErrId = ErrorLog.Insert(ErrorInfo);

                ErrorInfo = "ErrId=" + ErrId.ToString() + "; Parameters: LockName=" + pLockName;
                ErrorLog.Insert(ErrorInfo);

                return null;
            }

        }

        public static bool IsLockStillValid(LockManager pLockManager)
        {
            if (pLockManager == null)
            {
                return false;
            }

            try
            {
                pLockManager.Change = !pLockManager.Change;
                LockManager.Update(pLockManager);
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static bool Unlock(LockManager pLockManager)
        {
            // validate parameters
            if (pLockManager == null)
            {
                return false;
            }

            if (pLockManager.Locked == false)
            {
                return false;
            }

            try
            {
                pLockManager.Locked = false;
                LockManager.Update(pLockManager);
                return true;
            }
            catch (Exception exp)
            {
                MethodBase a = MethodBase.GetCurrentMethod();
                string ErrorInfo = "Class: " + a.DeclaringType.ToString() + "; " + a.ToString() + '\r' + '\n'
                        + "Error Msg: " + exp.Message;
                int ErrId = ErrorLog.Insert(ErrorInfo);

                return false;
            }
        }

        public static bool Unlock(string pLockName)
        {
            try
            {
                if (String.IsNullOrEmpty(pLockName))
                {
                    pLockName = String.Empty;
                }

                antoto_dbDataContext db = new antoto_dbDataContext();
                var query = (from a in db.LockManagers
                             where a.LockName == pLockName && a.Locked == true
                             select a).Take(1);

                foreach (LockManager v in query)
                {
                    v.Locked = false;
                    LockManager.Update(v);
                    break;
                }
                return true;
            }
            catch (Exception exp)
            {
                MethodBase a = MethodBase.GetCurrentMethod();
                string ErrorInfo = "Class: " + a.DeclaringType.ToString() + "; " + a.ToString() + '\r' + '\n'
                        + "Error Msg: " + exp.Message;
                int ErrId = ErrorLog.Insert(ErrorInfo);

                ErrorInfo = "ErrId=" + ErrId.ToString() + "; Parameters: LockName=" + pLockName;
                ErrorLog.Insert(ErrorInfo);

                return false;
            }

        }

    }
}
