using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Reflection;
using ANTOTOLib;

namespace ANTOTOService
{
    public partial class Service1 : ServiceBase
    {
        public Service1()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            #region Timer Configuration
            
            tmAutoShippingOrderTrack.Enabled = true;
            tmAutoShippingOrderTrack.Interval = 3600;         // start in 3.6 seconds

            tmAutoShippingOrderIdGenerate.Enabled = true;
            tmAutoShippingOrderIdGenerate.Interval = 3600;

            tmAutoShippingOrderIdValidate.Enabled = true;
            tmAutoShippingOrderIdValidate.Interval = 3600;

            tmAutoShippingOrderLabelGenerate.Enabled = true;
            tmAutoShippingOrderLabelGenerate.Interval = 3600;

            tmAutoShippingOrderLabelPdfGenerate.Enabled = true;
            tmAutoShippingOrderLabelPdfGenerate.Interval = 3600;

            #endregion


            bool IsDebug = false;
            if (IsDebug)
            {
                tmAutoShippingOrderTrack.Enabled = false;
                tmAutoShippingOrderIdValidate.Enabled = false;
                tmAutoShippingOrderIdGenerate.Enabled = false;
                tmAutoShippingOrderLabelGenerate.Enabled = false;
                tmAutoShippingOrderLabelPdfGenerate.Enabled = false;
            }
        }

        protected override void OnStop()
        {
            tmAutoShippingOrderTrack.Enabled = false;
            tmAutoShippingOrderIdValidate.Enabled = false;
            tmAutoShippingOrderIdGenerate.Enabled = false;
            tmAutoShippingOrderLabelGenerate.Enabled = false;
            tmAutoShippingOrderLabelPdfGenerate.Enabled = false;
        }
        
        private void tmAutoShippingOrderTrackProcess()
        {
            try
            {
                Thread tdObj = new Thread(new ThreadStart(AutoShippingOrderTrack.StartThreadProcess));
                tdObj.Start();
            }
            catch (Exception exp)
            {
                MethodBase a = MethodBase.GetCurrentMethod();
                string ErrorInfo = "Class: " + a.DeclaringType.ToString() + "; " + a.ToString() + '\r' + '\n'
                        + "Error Msg: " + exp.Message;
                int ErrId = ErrorLog.Insert(ErrorInfo);

            }

        }

        private void tmAutoShippingOrderIdGenerateProcess()
        {
            try
            {
                Thread tdObj = new Thread(new ThreadStart(AutoShippingOrderIdGenerate.StartThreadProcess));
                tdObj.Start();
            }
            catch (Exception exp)
            {
                MethodBase a = MethodBase.GetCurrentMethod();
                string ErrorInfo = "Class: " + a.DeclaringType.ToString() + "; " + a.ToString() + '\r' + '\n'
                        + "Error Msg: " + exp.Message;
                int ErrId = ErrorLog.Insert(ErrorInfo);

            }

        }

        private void tmAutoShippingOrderIdValidateProcess()
        {
            try
            {
                Thread tdObj = new Thread(new ThreadStart(AutoShippingOrderIdValidate.StartThreadProcess));
                tdObj.Start();
            }
            catch (Exception exp)
            {
                MethodBase a = MethodBase.GetCurrentMethod();
                string ErrorInfo = "Class: " + a.DeclaringType.ToString() + "; " + a.ToString() + '\r' + '\n'
                        + "Error Msg: " + exp.Message;
                int ErrId = ErrorLog.Insert(ErrorInfo);

            }

        }

        private void tmAutoShippingOrderLabelGenerateProcess()
        {
            try
            {
                Thread tdObj = new Thread(new ThreadStart(AutoShippingOrderLabelGenerate.StartThreadProcess));
                tdObj.Start();
            }
            catch (Exception exp)
            {
                MethodBase a = MethodBase.GetCurrentMethod();
                string ErrorInfo = "Class: " + a.DeclaringType.ToString() + "; " + a.ToString() + '\r' + '\n'
                        + "Error Msg: " + exp.Message;
                int ErrId = ErrorLog.Insert(ErrorInfo);

            }

        }

        private void tmAutoShippingOrderLabelPdfGenerateProcess()
        {
            try
            {
                Thread tdObj = new Thread(new ThreadStart(AutoShippingOrderLabelPdfGenerate.StartThreadProcess));
                tdObj.Start();
            }
            catch (Exception exp)
            {
                MethodBase a = MethodBase.GetCurrentMethod();
                string ErrorInfo = "Class: " + a.DeclaringType.ToString() + "; " + a.ToString() + '\r' + '\n'
                        + "Error Msg: " + exp.Message;
                int ErrId = ErrorLog.Insert(ErrorInfo);

            }

        }


        private void tmAutoShippingOrderTrack_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            tmAutoShippingOrderTrack.Interval = 5000;
            tmAutoShippingOrderTrackProcess();
        }

        private void AutoShippingOrderIdGenerate_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            tmAutoShippingOrderIdGenerate.Interval = 5000;
            tmAutoShippingOrderIdGenerateProcess();
        }

        private void AutoShippingOrderIdValidate_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            tmAutoShippingOrderIdValidate.Interval = 5000;
            tmAutoShippingOrderIdValidateProcess();
        }

        private void tmAutoShippingOrderLabelGenerate_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            tmAutoShippingOrderLabelGenerate.Interval = 5000;
            tmAutoShippingOrderLabelGenerateProcess();
        }

        private void tmAutoShippingOrderLabelPdfGenerate_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            tmAutoShippingOrderLabelPdfGenerate.Interval = 5000;
            tmAutoShippingOrderLabelPdfGenerateProcess();
        }
    }
}
