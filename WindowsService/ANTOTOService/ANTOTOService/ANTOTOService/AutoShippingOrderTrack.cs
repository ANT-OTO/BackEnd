using ANTOTOLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOService
{
    public class AutoShippingOrderTrack
    {
        public static void StartThreadProcess()
        {

            LockManager lk = null;
            try
            {
                lk = LockManager.Lock("AutoShippingOrderTrack", 0);
                if (lk == null)
                {
                    return;
                }
                ANTOTOLib.ShippingOrder.SFShippingOrderTrackProcess();
                LockManager.Unlock(lk);

            }
            catch (Exception exp)
            {
                LockManager.Unlock(lk);

                MethodBase a = MethodBase.GetCurrentMethod();
                string ErrorInfo = "Class: " + a.DeclaringType.ToString() + "; " + a.ToString() + '\r' + '\n'
                        + "Error Msg: " + exp.Message;
                int ErrId = ErrorLog.Insert(ErrorInfo);
            }


        }
    }
}
