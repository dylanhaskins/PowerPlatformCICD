using CCMS.Common.KeyVaultModels;
using CCMS.Entities;
using Microsoft.Xrm.Sdk;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Runtime.Caching;
using System.Runtime.Serialization.Json;
using System.Threading.Tasks;

namespace CCMS.Common.Services.CommonServices
{
    internal class ConfigService : BaseService
    {
        EncryptionHelper EncryptionHelper { get; set; }
        public ConfigService(IOrganizationService service, IOrganizationService elevatedService, ITracingService trace) : base(service, elevatedService, trace)
        {
            EncryptionHelper = new EncryptionHelper();
        }

        /**
       * <summary>
       * Gets the value of the system configuration 
       * </summary>
       * <param name="settingName">The name of the system configuration record</param>
       */

        public string GetSetting(string settingName)
        {
            Trace("Getting Setting");
            // string value to be returned
            string value = string.Empty;
            //Retrieve system configuration that has the same name as the one specified in the parameter
            dia_configuration setting = ElevatedServiceContext.dia_configurationSet.Where(x => x.dia_name == settingName && x.statecode == dia_configurationState.Active)
                            .FirstOrDefault<dia_configuration>();
            // if a setting is found
            if (setting != null)
            {
                Trace("Setting is not null");

                // if it is flagged as external configuration
                if (setting.dia_isexternalconfiguration == true)
                {
                    Trace("Getting External Config Record for: " + settingName);


                    //Throw an error if external configuration is not provided
                    if (setting?.dia_externalconfigurationid == null) throw new InvalidPluginExecutionException($"External configuration for system setting {settingName} could not be found. Please contact your system administeator to provid the required external configuration.");

                    Trace("Setting contains external config entity reference");

                    var exteralConfigID = setting.dia_externalconfigurationid;
                    
                    // retrieve the associated external configuration record
                    dia_externalconfiguration externalconfig = ElevatedServiceContext.dia_externalconfigurationSet.Where(x => x.dia_externalconfigurationId == exteralConfigID.Id).ToList().FirstOrDefault<dia_externalconfiguration>();
                    if (externalconfig != null)
                    {
                        Trace("External Config is not null");

                        // get the value stored on key vault using configurations on associated configuration record
                        value = GetKeyvaultValue(settingName, externalconfig);
                    }
                    else
                    {
                        Trace("Couldn't find external config");
                        throw new InvalidPluginExecutionException("The required external configuration was not found.");
                    }
                }
                // if it is not flagged as external configuration
                else
                {
                    // set the value to the value of the system configuration record
                    value = setting.dia_value;
                    // if it is flagged as encrypted 
                    if (setting.dia_enrcypt.HasValue && setting.dia_enrcypt.Value)
                    {
                        // decrypt the value 
                        value = EncryptionHelper.Decrypt(value);
                    }
                }
            }
            Trace($"{value}");
            // finally, return the value
            return value;
        }
        /**
        * <summary>
        * Gets the value of the system configuration that is stored on Key vault
        * </summary>
        * <param name="settingName">The name of the system configuration record</param>
        * <param name="extConfig">External configuration related to system configuration</param>
        */
        public string GetKeyvaultValue(string settingName, dia_externalconfiguration extConfig)
        {
            string val = string.Empty;
      
            string url = extConfig.dia_url;

            //getting access token
            var token = GetKeyvaultAuthToken(extConfig);

            //Retrieve the latest version of a secret by name
            var getKeyByNameTask = System.Threading.Tasks.Task.Run(async () => await GetSecretByName(token, url, settingName));
            System.Threading.Tasks.Task.WaitAll(getKeyByNameTask);
            if (getKeyByNameTask.Result == null)
                throw new Exception("Error retrieving secret versions from key vault");
            var retrievedSecretUrl = getKeyByNameTask.Result;
            // Retrieve a secret by its url
            var getKeyByUrlTask2 = System.Threading.Tasks.Task.Run(async () => await GetSecretByUrl(token, retrievedSecretUrl));
            System.Threading.Tasks.Task.WaitAll(getKeyByUrlTask2);
            if (getKeyByUrlTask2.Result == null)
                throw new Exception("Error retrieving secret value from key vault");
            //Deserialize the vault response to get the secret
            GetSecretResponse getSecretResponse2 = DeserializeObject<GetSecretResponse>(getKeyByUrlTask2.Result);
            //val is the Azure Key Vault Secret
            val = getSecretResponse2.value;
            Trace($"Secret is successfully retrieved and it is: {val}");
            //return the value
            return val;
        }
        /**
        * <summary>
        * Encrypts the value of the system setting if the system configuration is flagged as encrypt
        * </summary>
        * <param name="config">System configuration record</param>
        * <param name="preImage">pre image of the system configuration record</param>
        */
        public void EncryptSetting(dia_configuration config, dia_configuration preImage)
        {
            if (config.dia_enrcypt == preImage?.dia_enrcypt && config.dia_value == preImage?.dia_value)
            {
                Trace("Value or Encrypt Flag not changed");
                return;
            }
            string value = config.dia_value ?? preImage?.dia_value;
            bool? encrypt = config.dia_enrcypt ?? preImage?.dia_enrcypt;
            if (string.IsNullOrWhiteSpace(value))
            {
                Trace("Value Is Null");
                return;
            }
            if (!encrypt.HasValue || !encrypt.Value)
            {
                Trace("Encrypt Flag Is Null or False");
                return;
            }
            string encryptedString = EncryptionHelper.Encrypt(value);
            config.dia_value = encryptedString;

        }

        /**
        * <summary>
        * Gets the access token either from keyvault and stores it in the cache for reuse until it expires or from cache if it hasn't expired yet
        * </summary>
        * <param name="extConfig">external configuration </param>
        */
        public string GetKeyvaultAuthToken(dia_externalconfiguration extConfig)
        {
            Trace("GetKeyvaultAuthToken started");

            //Cache object to store access token until it expires
            ObjectCache cache = MemoryCache.Default;
            string accessToken = null;

            //check if bearer token is cached
            if (cache.Contains(CacheKey.KeyvaultAuthToken))
            {
                //return cached token
                Trace("Auth token found in cache");
                accessToken = cache.Get(CacheKey.KeyvaultAuthToken).ToString();
            }
            else
            {
                Trace("Auth token not found in cache");

                // getting required settings from external config  
                string clientid = extConfig.dia_clientid;
                string secret = extConfig.dia_secret;
                string tenantid = extConfig.dia_tenantid;

                //check if config exists
                if (!string.IsNullOrEmpty(clientid) && !string.IsNullOrEmpty(secret) &&
                    !string.IsNullOrEmpty(tenantid))
                {
                    Trace("Getting auth token from KeyVault");
                    // getting access token from keyvault 
                    var getTokenTask = System.Threading.Tasks.Task.Run(async () => await GetToken(clientid, secret, tenantid));
                    System.Threading.Tasks.Task.WaitAll(getTokenTask);
                    // if no token is returned throw an error
                    if (getTokenTask.Result == null)
                        throw new InvalidPluginExecutionException("Error retrieving access token");

                    //Deserialize the token response to get the access token
                    TokenResponse tokenResponse = DeserializeObject<TokenResponse>(getTokenTask.Result);

                    //Get token from the deserialized response
                    string token = tokenResponse.access_token;

                    //Get auth token from keyvault
                    if (!string.IsNullOrEmpty(tokenResponse.access_token))
                    {
                        //Store auth token in cahce and return to the caller
                        Trace("Auth token returned from keyvault");
                        accessToken = tokenResponse.access_token;
                        CacheItemPolicy cacheItemPolicy = new CacheItemPolicy();
                        cacheItemPolicy.AbsoluteExpiration = DateTime.Now.AddSeconds(Double.Parse(tokenResponse.expires_in));
                        cache.Add(CacheKey.KeyvaultAuthToken, accessToken, cacheItemPolicy);
                        Trace("Auth token added to cache");
                    }
                }
            }
            //return access token
            return accessToken;
        }

        /**
        * <summary>
        * Get the access token required to access the Key Vault
        * <param name="clientId">Client ID from external configuration record</param>
        * <param name="clientSecret">Secret from external configuration record</param>
        * <param name="tenantId">Tenant ID from external configuration record </param>
        */
        private async Task<string> GetToken(string clientId, string clientSecret, string tenantId)
        {
            using (HttpClient httpClient = new HttpClient())
            {
                //Construct the form content of the http client
                var formContent = new FormUrlEncodedContent(new[]
                {
                    // create required key value pairs
                    new KeyValuePair<string, string>("resource","https://vault.azure.net"),
                    new KeyValuePair<string, string>("client_id", clientId),
                    new KeyValuePair<string, string>("client_secret", clientSecret),
                    new KeyValuePair<string, string>("grant_type", "client_credentials")
                });
                //Get the response
                HttpResponseMessage response = await httpClient.PostAsync(
                    "https://login.windows.net/" + tenantId + "/oauth2/token", formContent);
                //If the response is null return null otherwise return the result of the response
                return !response.IsSuccessStatusCode ? null
                    : response.Content.ReadAsStringAsync().Result;
            }
        }

        /**
        * <summary>
        * Creates a new secret or update an existing one on Key Vault
        * <param name="token">Token to access Key Vaul</param>
        * <param name="secretUrl">Url of Secret</param>
        * <param name="secretValue">The value to be stored on keyvault </param>
        */
        private static async Task<string> CreateSecret(string token, string secretUrl, string secretValue)
        {
            using (HttpClient httpClient = new HttpClient())
            {
                //Create Http request message using the access token
                HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Put,
                    new Uri(secretUrl + "?api-version=2016-10-01"));
                request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);
                //Create secret request object
                Secret setSecretRequest = new Secret
                {
                    Value = secretValue,
                    SecretAttributes = new SecretAttributes
                    {
                        Enabled = true
                    }
                };
                //Serialize the secret request
                string content = SerializeObject<Secret>(setSecretRequest);
                //Add the serialised content to the Http Message request
                HttpContent c = new StringContent(content);
                request.Content = c;
                c.Headers.ContentType = MediaTypeHeaderValue.Parse("application/json");

                //Get the response of the Http Message request
                HttpResponseMessage response = await httpClient.SendAsync(request);

                //Return null if the response is empty, otherwise return the result of the response
                return !response.IsSuccessStatusCode ? null
                    : response.Content.ReadAsStringAsync().Result;
            }
        }
        /**
        * <summary>
        * Get the Secret value from the Key Vault by url - api-version is required
        * <param name="token">Token to access Key Vaul</param>
        * <param name="secretUrl">Url of Secret</param>
        */

        private async Task<string> GetSecretByUrl(string token, string secretUrl)
        {
            using (HttpClient httpClient = new HttpClient())
            {
                //Create Http request message using the access token
                HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Get,
                        new Uri(secretUrl + "?api-version=2016-10-01"));
                request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);

                //Get the response of the Http Message request
                HttpResponseMessage response = await httpClient.SendAsync(request);

                //Return null if the response is empty, otherwise return the result of the response
                return !response.IsSuccessStatusCode ? null
                    : response.Content.ReadAsStringAsync().Result;
            }
        }
        /**
        * <summary>
        * Get the most recent, enabled Secret value by name  - api-version is required
        * <param name="token">Token to access Key Vaul</param>
        * <param name="vaultName">The name under which the value is stored on keyvault from system configuration</param>
        * <param name="secretName">Secret name from external configuration record</param>
        * 
        */

        private async Task<string> GetSecretByName(string token, string vaultName, string secretName)
        {
            string nextLink = vaultName + "/secrets/" + secretName + "/versions?api-version=2016-10-01";
            List<Value> values = new List<Value>();

            using (HttpClient httpClient = new HttpClient())
            {
                while (!string.IsNullOrEmpty(nextLink))
                {
                    //Create Http request message using the access token
                    HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Get,
                        new Uri(nextLink));
                    request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", token);

                    //Get the response of the Http Message request
                    HttpResponseMessage response = await httpClient.SendAsync(request);
                    //Return null if the response is empty
                    if (!response.IsSuccessStatusCode)
                        return null;
                    //Deserialise the result of the response into GetSecretVersionsResponse object
                    var versions = DeserializeObject<GetSecretVersionsResponse>(response.Content.ReadAsStringAsync().Result);
                    //Add the elements of the value list of the deserialised response (Version object)
                    values.AddRange(versions.value);
                    //Set nextLink string to vesions object next Link
                    nextLink = versions.nextLink;
                }
            }
            //Order the values by the date the were created on from most recent to oldest and get the most recent one
            Value mostRecentValue =
                values.Where(a => a.attributes.enabled)
                    .OrderByDescending(a => UnixTimeToUtc(a.attributes.created))
                    .FirstOrDefault();
            //Return the most recent valuse
            return mostRecentValue?.id;
        }
        /**
        * <summary>
        *Generic JSON to object deserialization 
        * <param name="json">String representation of json that needs deserialization</param>
        */
        public static T DeserializeObject<T>(string json)
        {
            try
            {
                using (MemoryStream stream = new MemoryStream())
                {
                    DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(T));
                    StreamWriter writer = new StreamWriter(stream);
                    writer.Write(json);
                    writer.Flush();
                    stream.Position = 0;
                    T o = (T)serializer.ReadObject(stream);

                    return o;
                }
            }
            catch (Exception e)
            {
                throw new InvalidPluginExecutionException(e.Message);
            }
        }
        /**
        * <summary>
        *Generic JSON to object serialization 
        * <param name="json">String representation of json that needs serialization</param>
        */
        public static string SerializeObject<T>(object o)
        {
            using (MemoryStream stream = new MemoryStream())
            {
                DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(T));
                serializer.WriteObject(stream, o);
                stream.Position = 0;
                StreamReader reader = new StreamReader(stream);
                string json = reader.ReadToEnd();

                return json;
            }
        }
        /**
        * <summary>
        *Converts double to datetime
        * <param name="unixTime">Double representation of time</param>
        */
        private DateTime UnixTimeToUtc(double unixTime)
        {
            var epoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
            var timeSpan = TimeSpan.FromSeconds(unixTime);
            return epoch.Add(timeSpan).ToUniversalTime();
        }
    }
}
