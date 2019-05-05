using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ANTOTOLib
{
    public class WizardForm
    {
        public class WizardSessionForm
        {
            public int? SourceId { get; set; }

            public string SourceTable { get; set; }

            public int? WizardSessionId { get; set; }

            public int? WizardMasterId { get; set; }

            public List<WizardStep> StepList { get; set; }

            public DataModel.ResultItemFinalPage VariationProduct { get; set; }

        }

        public class WizardSessionForm2
        {
            public int? SourceId { get; set; }

            public string SourceTable { get; set; }

            public int? WizardSessionId { get; set; }

            public int? WizardMasterId { get; set; }

            public List<WizardStep> StepList { get; set; }

        }
        public class WizardStep 
        {
            public int? WizardSessionId { get; set; }

            public string WizardStepCode { get; set; }

            public string WizardStepTitle { get; set; }

            public string Order { get; set; }

            public List<WizardItem> ElementList { get; set; }
        }

        public class WizardItem
        {
            public int? WizardMasterElementId { get; set; }

            public int? WizardMasterStepElementTypeCodeId { get; set; } 

            public WizardInput Input { get; set; }

            public WizardPrompt Prompt { get; set; }

            public int? Level { get; set; }

            public string Order { get; set; }

            public Decimal? Weight { get; set; }
        }

        public class WizardPrompt
        {
            public string content { get; set; }
        }

        public class WizardInput
        {
            public int? WizardMasterStepElementInputId { get; set; }

            public string WizardInputCode { get; set; }

            public int? WizardInputTypeCodeId { get; set; }

            public List<WizardInputListItem> WizardInputListItemList { get; set; }

            public List<WizardInputFile> FileList { get; set; }

            public List<DataModel.ResultProductSupplyInfo> SupplierList { get; set; }

            public List<DataModel.ResultItemRelatedUPCInfo> ItemRelatedUPCList { get; set; }

            public string WizardInputName { get; set; }

            public string WizardInputDisplayName { get; set; }

            public string WizardInputDescription { get; set; }

            public bool? Required { get; set; }

            public bool? ValidationFailed { get; set; }

            public string ValidationFailMessage { get; set; }

            public List<string> WizardInputValueList { get; set; }

            public bool? isList { get; set; }

        }

        public class WizardInputListItem
        {
            public string Value { get; set; }

            public string Content { get; set; }

            public string Order { get; set; }
        }

        public class WizardInputFile
        {
            public int? FileId { get; set; }

            public string FileExt { get; set; }

            public string FileLink { get; set; }

            public string MFileLink { get; set; }

            public string SFileLink { get; set; }

            public string FileDescription { get; set; }

            public bool? Selected { get; set; }

            public string FilePath { get; set; }

        }

        public static WizardSessionForm getWizardForm(int? WizardSessionId, int UserId, int SystemLanguageId, int CompanyId)
        {
            WizardSessionForm result = new WizardSessionForm();
            result.WizardSessionId = WizardSessionId;
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_WizardSessionStepListGet(WizardSessionId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    WizardStep step = new WizardStep();
                    step.WizardSessionId = WizardSessionId;
                    step.WizardStepCode = item.WizardMasterStepCode;
                    step.WizardStepTitle = item.WizardMasterStepTitle;
                    step.Order = item.Order;
                    step.ElementList = WizardStepElementListGet(WizardSessionId.Value, item.WizardMasterStepCode);
                    result.WizardMasterId = item.WizardMasterId;
                    if(result.StepList == null)
                    {
                        result.StepList = new List<WizardStep>();
                    }
                    result.StepList.Add(step);
                    ParaDataModel.ParaWizardSessionItem temp = new ParaDataModel.ParaWizardSessionItem();
                    temp.ItemId = null;
                    temp.WizardSessionId = WizardSessionId;
                    result.VariationProduct = ProductManager.getProductVariationInfoList(temp, UserId, SystemLanguageId, CompanyId);
                }
            }


            return result;
        }

        public static WizardSessionForm2 getWizardForm2(int? WizardSessionId, int UserId, int SystemLanguageId, int CompanyId)
        {
            WizardSessionForm2 result = new WizardSessionForm2();
            result.WizardSessionId = WizardSessionId;
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_WizardSessionStepListGet(WizardSessionId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    WizardStep step = new WizardStep();
                    step.WizardSessionId = WizardSessionId;
                    step.WizardStepCode = item.WizardMasterStepCode;
                    step.WizardStepTitle = item.WizardMasterStepTitle;
                    step.Order = item.Order;
                    step.ElementList = WizardStepElementListGet(WizardSessionId.Value, item.WizardMasterStepCode);
                    result.WizardMasterId = item.WizardMasterId;
                    if (result.StepList == null)
                    {
                        result.StepList = new List<WizardStep>();
                    }
                    result.StepList.Add(step);
                }
            }


            return result;
        }

        public static List<WizardItem> WizardStepElementListGet(int WizardSessionId, string WizardStepCode)
        {
            List<WizardItem> result = new List<WizardItem>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_WizardSessionStepElementListGet(WizardSessionId, WizardStepCode);
            if (list != null)
            {
                foreach ( var item in list)
                {
                    WizardItem current = new WizardItem();
                    current.WizardMasterElementId = item.WizardMasterStepElementId;
                    current.WizardMasterStepElementTypeCodeId = item.WizardMasterStepElementTypeCodeId;
                    current.Level = item.Level;
                    current.Order = item.Order;
                    current.Weight = item.Weight;
                    if(item.WizardMasterStepElementTypeCodeId == 1)
                    {
                        //Prompt
                        current.Prompt = getWizardElementPrompt(WizardSessionId, WizardStepCode, item.WizardMasterStepElementId);
                    }
                    if(item.WizardMasterStepElementTypeCodeId == 2)
                    {
                        //Input
                        current.Input = getWizardElementInput(WizardSessionId, WizardStepCode, item.WizardMasterStepElementId);
                    }
                    result.Add(current);
                }
            }
            return result;
        }

        public static WizardPrompt getWizardElementPrompt(int pWizardSessionId, string pWizardMasterStepCode, int pWizardSessionStepElementId)
        {
            WizardPrompt result = new WizardPrompt();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_WizardSessionStepElementPromptDetailGet(pWizardSessionId, pWizardMasterStepCode, pWizardSessionStepElementId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    result.content = item.DisplayText;
                }
            }
            return result;
        }

        public static WizardInput getWizardElementInput(int pWizardSessionId, string pWizardMasterStepCode, int pWizardSessionStepElementId)
        {
            WizardInput result = new WizardInput();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_WizardSessionStepElementInputDetailGet(pWizardSessionId, pWizardMasterStepCode, pWizardSessionStepElementId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    result.WizardMasterStepElementInputId = item.WizardMasterStepElementInputId;
                    result.WizardInputTypeCodeId = item.InputTypeCodeId;
                    result.WizardInputCode = item.InputName;
                    result.WizardInputDescription = item.InputDiscription;
                    result.WizardInputDisplayName = item.InputDisplayName;
                    result.Required = item.Required;
                    result.ValidationFailed = false;
                    result.ValidationFailMessage = item.ValidationFailMessage;
                    result.WizardInputListItemList = getWizardListItemList(item.WizardInputListId);
                    result.WizardInputName = item.InputName;
                    result.WizardInputValueList = getWizardInputValueList(pWizardSessionId, pWizardMasterStepCode, item.WizardMasterStepElementInputId);
                    result.FileList = getWizardInputFileValueList(pWizardSessionId, pWizardMasterStepCode, item.WizardMasterStepElementInputId);
                    result.SupplierList = getWizardSupplierListValueList(pWizardSessionId, pWizardMasterStepCode, item.WizardMasterStepElementInputId);
                    result.ItemRelatedUPCList = getWizardItemRelatedUPCValueList(pWizardSessionId, pWizardMasterStepCode, item.WizardMasterStepElementInputId);
                    result.isList = item.AllowList;
                }
            }

            return result;
        }

        public static List<string> getWizardInputValueList(int pWizardSessionId, string pWizardMasterStepCode, int pWizardSessionStepElementInputId)
        {
            List<string> result = new List<string>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_WizardSessionStepElementInputValueGet(pWizardSessionId, pWizardMasterStepCode, pWizardSessionStepElementInputId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    result.Add(item.StepValue);
                }
            }
            return result;
        }

        public static List<WizardInputFile> getWizardInputFileValueList(int pWizardSessionId, string pWizardMasterStepCode, int pWizardSessionStepElementInputId)
        {
            List<WizardInputFile> result = new List<WizardInputFile>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_WizardSessionStepElementInputValueGet(pWizardSessionId, pWizardMasterStepCode, pWizardSessionStepElementInputId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    if(item.StepSourceTable == "File")
                    {
                        WizardInputFile current = new WizardInputFile();
                        current = AntotoFile.getFileFromId(item.StepSourceId.Value);
                        result.Add(current);
                    }
                }
            }
            return result;
        }

        public static List<DataModel.ResultProductSupplyInfo> getWizardSupplierListValueList(int pWizardSessionId, string pWizardMasterStepCode, int pWizardSessionStepElementInputId)
        {
            List<DataModel.ResultProductSupplyInfo> result = new List<DataModel.ResultProductSupplyInfo>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_WizardSessionStepElementInputValueGet(pWizardSessionId, pWizardMasterStepCode, pWizardSessionStepElementInputId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    if (item.StepSourceTable == "SupplierPlaceInfo")
                    {
                        DataModel.ResultProductSupplyInfo current = new DataModel.ResultProductSupplyInfo();
                        current = AntotoFile.getProductSupplyInfo(item.StepSourceId.Value);
                        result.Add(current);
                    }
                }
            }
            return result;
        }

        public static List<DataModel.ResultItemRelatedUPCInfo> getWizardItemRelatedUPCValueList(int pWizardSessionId, string pWizardMasterStepCode, int pWizardSessionStepElementInputId)
        {
            List<DataModel.ResultItemRelatedUPCInfo> result = new List<DataModel.ResultItemRelatedUPCInfo>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.sp_WizardSessionStepElementInputValueGet(pWizardSessionId, pWizardMasterStepCode, pWizardSessionStepElementInputId);
            if (list != null)
            {
                foreach (var item in list)
                {
                    if (item.StepSourceTable == "ItemRelatedUPCInfo")
                    {
                        DataModel.ResultItemRelatedUPCInfo current = new DataModel.ResultItemRelatedUPCInfo();
                        current = AntotoFile.getItemRelatedUPCInfo(item.StepSourceId.Value);
                        result.Add(current);
                    }
                }
            }
            return result;
        }

        public static List<WizardInputListItem> getWizardListItemList(int? ListId)
        {
            List<WizardInputListItem> result = new List<WizardInputListItem>();
            antoto_dbDataContext db = new antoto_dbDataContext();
            var list = db.tfnWizardListDetailGet(ListId);
            if (list != null)
            {
                foreach(var item in list)
                {
                    WizardInputListItem current = new WizardInputListItem();
                    current.Value = item.Value;
                    current.Content = item.Content;
                    current.Order = item.Order;
                    result.Add(current);
                }
            }
            return result;
        }

        public static WizardSessionForm updateStepInputs(WizardStep stepDetail, int UserId, int SystemLanguageId, int CompanyId)
        {
            if(stepDetail == null || stepDetail.WizardSessionId == null || stepDetail.WizardSessionId == 0)
            {
                return null;
            }
            antoto_dbDataContext db = new antoto_dbDataContext();
            bool validated = false;
            if (stepDetail.ElementList != null)
            {
                //Clear original text

                foreach(var item in stepDetail.ElementList)
                {
                    if(item.Input != null)
                    {
                        db.sp_WizardSessionInput_Clear(stepDetail.WizardSessionId, stepDetail.WizardStepCode, item.Input.WizardMasterStepElementInputId);
                        if (item.Input.WizardInputTypeCodeId == 1)
                        {
                            validated = true;
                            for (int i = 1; i <= item.Input.WizardInputValueList.Count; i++)
                            {
                                var temp = item.Input.WizardInputValueList[i-1];
                                db.sp_WizardSessionInput_Set(stepDetail.WizardSessionId, stepDetail.WizardStepCode,
                                item.Input.WizardMasterStepElementInputId, i, temp, null, null, null);
                            }
                        }
                        if (item.Input.WizardInputTypeCodeId == 2)
                        {
                            validated = true;
                            for (int i = 1; i <= item.Input.WizardInputValueList.Count; i++)
                            {
                                var temp = item.Input.WizardInputValueList[i - 1];
                                db.sp_WizardSessionInput_Set(stepDetail.WizardSessionId, stepDetail.WizardStepCode,
                                item.Input.WizardMasterStepElementInputId, i, temp, null, null, null);
                            }
                        }
                        if (item.Input.WizardInputTypeCodeId == 3)
                        {
                            validated = true;
                            for (int i = 1; i <= item.Input.FileList.Count; i++)
                            {
                                var temp = item.Input.FileList[i - 1];
                                //update file
                                if (String.IsNullOrEmpty(temp.FileDescription))
                                {
                                    int? fileId = temp.FileId;
                                    db.sp_FileUpdate(temp.FileDescription, null, null, null, 1, ref fileId);
                                }
                                db.sp_WizardSessionInput_Set(stepDetail.WizardSessionId, stepDetail.WizardStepCode,
                                item.Input.WizardMasterStepElementInputId, i, null, null, temp.FileId, "File");
                            }
                        }

                        if (item.Input.WizardInputTypeCodeId == 4)
                        {
                            validated = true;
                            for (int i = 1; i <= item.Input.WizardInputValueList.Count; i++)
                            {
                                var temp = item.Input.WizardInputValueList[i - 1];
                                db.sp_WizardSessionInput_Set(stepDetail.WizardSessionId, stepDetail.WizardStepCode,
                                item.Input.WizardMasterStepElementInputId, i, temp, null, null, null);
                            }
                        }

                        if (item.Input.WizardInputTypeCodeId == 5)
                        {
                            validated = true;
                            for (int i = 1; i <= item.Input.SupplierList.Count; i++)
                            {
                                var temp = item.Input.SupplierList[i - 1];
                                var insertResult = AntotoFile.UploadProductSupplyInfo(temp, UserId);
                                temp = insertResult;
                                if(temp != null)
                                {
                                    db.sp_WizardSessionInput_Set(stepDetail.WizardSessionId, stepDetail.WizardStepCode,
                                    item.Input.WizardMasterStepElementInputId, i, null, null, temp.SupplierPlaceInfoId, "SupplierPlaceInfo");
                                }
                                
                            }
                        }

                        if (item.Input.WizardInputTypeCodeId == 6)
                        {
                            validated = true;
                            for (int i = 1; i <= item.Input.ItemRelatedUPCList.Count; i++)
                            {
                                var temp = item.Input.ItemRelatedUPCList[i - 1];
                                var insertResult = AntotoFile.UploadItemRelatedUPCInfo(temp, UserId);
                                temp = insertResult;
                                if (temp != null)
                                {
                                    db.sp_WizardSessionInput_Set(stepDetail.WizardSessionId, stepDetail.WizardStepCode,
                                    item.Input.WizardMasterStepElementInputId, i, null, null, temp.ItemRelatedUPCInfoId, "ItemRelatedUPCInfo");
                                }

                            }
                        }
                        //To be fixed
                        //Need to remove the rest of inputs
                    }
                }
                var isFinal = db.sfnWizardSessionStepCodeIsFinal(stepDetail.WizardStepCode, stepDetail.WizardSessionId);
                if(isFinal!=null && isFinal.Value && validated)
                {
                    ProductManager.ProductPublish(stepDetail.WizardSessionId.Value);
                }
            }
            if (!validated)
            {
                return null;
            }

            return getWizardForm(stepDetail.WizardSessionId, UserId, SystemLanguageId,CompanyId);
        }
        

    }

    
}
