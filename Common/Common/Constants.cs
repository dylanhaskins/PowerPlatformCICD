using System;
using System.Collections.Generic;
using System.Text;

namespace CCMS.Common
{
    public class MessageName
    {
        public const string Create = "Create";
        public const string Update = "Update";
        public const string Associate = "Associate";
        public const string Disassociate = "Disassociate";
    }
    public class Constants
    {
        public const string EncryptionKey = "십る샞ᜰ袟礠鄫옚玊춮≶㶏㜈菞姶뿙Ĵ襊䤈㘥룽鶋䤜Ⲗ簫敧䥹酧蒺૪뿙礠";
        public const string PoliceCheckAgency= "D80114";
        public const string PoliceCheckCitizenshipRole = "Citizenship Application";
        public const string PoliceVettingXSDResourceName = "dia_/data/VettingFile.xsd";

    }

    public class Configurations
    {
        public const string K2_Username = "K2_Username";
        public const string K2_Password = "K2Password";
        public const string K2_Url = "K2_URL";
        public const string K2_CBG_StartWorkflow = "CCMS.Citizenship.Master";
        public const string K2_IDAL_StartWorkflow = "CCMS.iDAL.APIRequests";
        public const string K2_CBG_FinishWorkflow = "";
        //public const string EI_CBGRegister_URL = "EI_CBGRegister_URL";
        //public const string EI_IDAL_URL = "EI_IDAL_URL";
        public const string NZClientID = "NZClientID";
        public const string NZClientSecret = "NZClientSecret";
        public const string NZPostAPI = "NZPostAPI";
        public const string NZPostAuthURL = "NZPostAuthURL";
        public const string DocumentManagementAPIKey = "DocumentManagementAPIKey";
        public const string DocumentUploadSASAPIURL = "DocumentUploadSASAPIURL";
        public const string DocumentDownloadAPIURL = "DocumentDownloadAPIURL";
        public const string DocumentDeleteAPIURL = "DocumentDeleteAPIURL";
        public const string Default_Price_List = "CCMS.PriceList.Id";
        public const string Queue_SIS = "Queue_SIS_ID";
        public const string Queue_Police = "Queue_Police_ID";
        public const string Queue_CITZ = "Queue_CITZ_ID";
        public const string Outcome_NotApprovedSubmission = "CCMS_Outcome_NotApprovedSubmission";
        public const string Outcome_ApprovedSubmission = "CCMS_Outcome_ApprovedSubmission";

    }

    public class Actions
    {
        public const string K2_StartWorkflow = "dia_K2_StartWorkflow";
        public const string K2_IDAL_StartWorkflow = "dia_K2_IDAL_StartWorkflow";
        public const string K2_CBG_StartWorkflow = "dia_K2_CBG_StartWorkflow";
        public const string K2_CBG_FinishServerEvent = "dia_K2_CBG_FinishServerEvent";
        public const string Documents_GetSASTokenForDocumentUpload = "dia_Documents_GetSASTokenForDocumentUpload";
        public const string Documents_GetDocumentDownloadURL = "dia_Documents_GetDocumentDownloadURL";
        public const string Documents_CleanupOnUploadFailure = "dia_Documents_CleanupOnUploadFailure";
        public const string Documents_CreateSupportingDocument = "dia_Documents_CreateSupportingDocument";
        public const string Documents_DeleteDocumentBlob = "dia_Documents_DeleteDocumentBlob";
        public const string IDAL_CreateCBGIntegrationRequest = "dia_IDAL_CreateCBGIntegrationRequest";
        public const string InformationRequestBatch_AddPendingInformationRequests = "dia_InformationRequestBatch_AddPendingInformationRequests";
        public const string K2_INFINITY_StartWorkflow = "dia_K2_INFINITY_StartWorkflow";
        public const string INFINITY_CreateInfinityBody = "dia_CreateInfinityBody";
    }
    public class ActionOutputParameters
    {
        public const string GetSASTokenForDocumentUploadResponse = "GetSASTokenForDocumentUploadResponse";
        public const string DocumentURL = "DocumentURL";
    }

    public class CacheKey
    {
        public const string NZPostAuthToken = "NZPostAuthToken";
        public const string KeyvaultAuthToken = "KeyValutAuthToken";

    }

    public class NZPostSourceDesc
    {
        public const string Postal = "Postal";
        public const string Physical = "Physical";
        public const string Postal_Physical = "Postal\\Physical";
        public const string Postal_Physical_NotDelivered = "Postal\\Physical - Not Delivered";
        public const string Box_Bag_Let = "Box\\Bag – Let";
        public const string Box_Bag_Available = "Box\\Bag - Available";
    }

    public class IntegrationType
    {
        public const string IDAL_CBG_ApplicationSubmitted = "IDAL_CBG_ApplicationSubmitted";
        public const string IDAL_CBG_ApplicationApproved = "IDAL_CBG_ApplicationApproved";
        public const string IDAL_CBG_ApplicationCitizenshipAcquired = "IDAL_CBG_ApplicationCitizenshipAcquired";
        public const string INFINITY_CBG_Order = "INFINITY_CBG_Order";
    }

    public class SequenceNumberKeys
    {
        public const string IDAL_Integration = "IDAL_Integration";
        public const string INFINITY_Integration = "INFINITY_Integration";
    }
}
