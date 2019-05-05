namespace ANTOTOService
{
    partial class Service1
    {
        /// <summary> 
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.tmAutoShippingOrderTrack = new System.Timers.Timer();
            this.tmAutoShippingOrderIdGenerate = new System.Timers.Timer();
            this.tmAutoShippingOrderIdValidate = new System.Timers.Timer();
            this.tmAutoShippingOrderLabelGenerate = new System.Timers.Timer();
            this.tmAutoShippingOrderLabelPdfGenerate = new System.Timers.Timer();
            ((System.ComponentModel.ISupportInitialize)(this.tmAutoShippingOrderTrack)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.tmAutoShippingOrderIdGenerate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.tmAutoShippingOrderIdValidate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.tmAutoShippingOrderLabelGenerate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.tmAutoShippingOrderLabelPdfGenerate)).BeginInit();
            // 
            // tmAutoShippingOrderTrack
            // 
            this.tmAutoShippingOrderTrack.Interval = 10000D;
            this.tmAutoShippingOrderTrack.Elapsed += new System.Timers.ElapsedEventHandler(this.tmAutoShippingOrderTrack_Elapsed);
            // 
            // tmAutoShippingOrderIdGenerate
            // 
            this.tmAutoShippingOrderIdGenerate.Interval = 10000D;
            this.tmAutoShippingOrderIdGenerate.Elapsed += new System.Timers.ElapsedEventHandler(this.AutoShippingOrderIdGenerate_Elapsed);
            // 
            // tmAutoShippingOrderIdValidate
            // 
            this.tmAutoShippingOrderIdValidate.Interval = 10000D;
            this.tmAutoShippingOrderIdValidate.Elapsed += new System.Timers.ElapsedEventHandler(this.AutoShippingOrderIdValidate_Elapsed);
            // 
            // tmAutoShippingOrderLabelGenerate
            // 
            this.tmAutoShippingOrderLabelGenerate.Interval = 10000D;
            this.tmAutoShippingOrderLabelGenerate.Elapsed += new System.Timers.ElapsedEventHandler(this.tmAutoShippingOrderLabelGenerate_Elapsed);
            // 
            // tmAutoShippingOrderLabelPdfGenerate
            // 
            this.tmAutoShippingOrderLabelPdfGenerate.Interval = 10000D;
            this.tmAutoShippingOrderLabelPdfGenerate.Elapsed += new System.Timers.ElapsedEventHandler(this.tmAutoShippingOrderLabelPdfGenerate_Elapsed);
            // 
            // Service1
            // 
            this.ServiceName = "Service1";
            ((System.ComponentModel.ISupportInitialize)(this.tmAutoShippingOrderTrack)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.tmAutoShippingOrderIdGenerate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.tmAutoShippingOrderIdValidate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.tmAutoShippingOrderLabelGenerate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.tmAutoShippingOrderLabelPdfGenerate)).EndInit();

        }

        #endregion

        
        private System.Timers.Timer tmAutoShippingOrderTrack;
        private System.Timers.Timer tmAutoShippingOrderIdGenerate;
        private System.Timers.Timer tmAutoShippingOrderIdValidate;
        private System.Timers.Timer tmAutoShippingOrderLabelGenerate;
        private System.Timers.Timer tmAutoShippingOrderLabelPdfGenerate;
    }
}
