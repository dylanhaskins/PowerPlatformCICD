using Microsoft.Xrm.Sdk;
using System;
using System.Net.Http;
using System.Net.Http.Headers;
using CCMS.Entities;
using System.Linq;
using CCMS.Common.Services.CommonServices;
using System.Runtime.Serialization;

namespace CCMS.Common.Services.DocumentManagementService
{
    internal class DocumentManagementService : BaseService
    {
        private ConfigService _ConfigService = null;
        private string APIKey = null;
        private string UploadSASTokenAPIURL = null;
        private string DownloadAPIURL = null;
        private string DocumentDeleteAPIURL = null;
        public DocumentManagementService(IOrganizationService orgService, IOrganizationService elevatedService, ITracingService tracingservice) : base(orgService, elevatedService, tracingservice)
        {
            //get the configurations
            _ConfigService = new ConfigService(orgService, elevatedService,tracingservice);
            APIKey = _ConfigService.GetSetting(Configurations.DocumentManagementAPIKey);
            UploadSASTokenAPIURL = _ConfigService.GetSetting(Configurations.DocumentUploadSASAPIURL);
            DownloadAPIURL = _ConfigService.GetSetting(Configurations.DocumentDownloadAPIURL);
            DocumentDeleteAPIURL = _ConfigService.GetSetting(Configurations.DocumentDeleteAPIURL);
        }

        //The string Returned here is a JSON object that can be DeSerialised into the SASTokenReponse Class below
        public string GetSASTokenForDocumentUpload(string container = "")
        {
            Trace("Inside GetSASTokenForDocumentUpload");
            string result = null;
            if (!string.IsNullOrWhiteSpace(UploadSASTokenAPIURL) && !string.IsNullOrWhiteSpace(APIKey))
            {
                Trace("Getting SAS token from API");
                result = string.IsNullOrEmpty(container) ? HTTPRequest<string>(UploadSASTokenAPIURL, HttpMethod.Get, APIKey) :
                    HTTPRequest<string>(UploadSASTokenAPIURL + "?container=" + container, HttpMethod.Get, APIKey);
            }
            return result;
        }

        internal Guid CreateSuportingDocument(dia_supportingdocument supportingDocument)
        {
            Trace($"Creating supporting document");
            return ElevatedService.Create(supportingDocument.ToEntity<Entity>());
        }

        internal void CleanupOnUploadFailure(Guid docId)
        {
            Trace($"Deleting supporting document {docId}");
            ElevatedService.Delete(dia_supportingdocument.EntityLogicalName, docId);
        }

        internal string GetDocumentDownloadURL(Guid docId)
        {
            Trace("Inside GetDocumentDownloadURL");
            string result = null;
            dia_supportingdocument _doc = ElevatedServiceContext.dia_supportingdocumentSet
                .Where(x => x.dia_supportingdocumentId == docId).FirstOrDefault();

            if (_doc != null && !string.IsNullOrWhiteSpace(_doc.dia_documentpath) && !string.IsNullOrWhiteSpace(DownloadAPIURL) && !string.IsNullOrWhiteSpace(APIKey))
            {
                string url = $"{DownloadAPIURL}/{_doc.dia_documentpath}";
                Trace("Getting download url from API");
                result = HTTPRequest<string>(url, HttpMethod.Get, APIKey);
            }
            return result;
        }
        
        internal string DeleteDocumentBlob(Guid docId)
        {
            Trace("Inside DeleteDocumentBlob");
            string result = null;

            var _doc = dia_supportingdocument.Retrieve(OrgService, docId, x => x.dia_documentpath);

            if (_doc != null && !string.IsNullOrWhiteSpace(_doc.dia_documentpath) && !string.IsNullOrWhiteSpace(DocumentDeleteAPIURL) && !string.IsNullOrWhiteSpace(APIKey))
            {
                string url = $"{DocumentDeleteAPIURL}/{_doc.dia_documentpath}";
                Trace("Delete blob via API");
                result = HTTPRequest<string>(url, HttpMethod.Delete, APIKey);
            }
            return result;
        }


        public T HTTPRequest<T>(string url, HttpMethod method, string key, bool deserialize = false)
        {
            Trace("Creating Client");
            using (HttpClient client = new HttpClient())
            {
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                if (!string.IsNullOrEmpty(key))
                {
                    client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", key);
                }
                Trace($"Posting request to {url}");
                HttpRequestMessage request = new HttpRequestMessage(method, new Uri(url));
                Trace("Waiting for response");
                HttpResponseMessage response = client.SendAsync(request).Result;
                Trace("status " + response.IsSuccessStatusCode);

                string json = response.Content.ReadAsStringAsync().Result;
                Trace("json:" + json);

                if (!response.IsSuccessStatusCode)
                    throw new Exception("Error connecting to the source");

                if (!deserialize && typeof(T) == typeof(string))
                {
                    return (T)Convert.ChangeType(json, typeof(T));
                }
                Trace("Deserializing");
                T result = JsonHelper.DeserializeJSon<T>(json);
                Trace("Deserialized");
                return result;
            }
        }

    }
}
