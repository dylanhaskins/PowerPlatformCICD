using Microsoft.Xrm.Sdk;
using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.Serialization.Json;
using System.Text;
using CCMS.Common.Services.CommonServices;
using Microsoft.Xrm.Sdk.Messages;
using Microsoft.Xrm.Sdk.Metadata;

namespace CCMS.Common
{
    public class JsonHelper
    {
        public static T DeserializeJSon<T>(string jsonString)
        {
            DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(T));
            MemoryStream stream = new MemoryStream(Encoding.UTF8.GetBytes(jsonString));
            T obj = (T)ser.ReadObject(stream);
            return obj;
        }

        public static string SerializeJSon<T>(T t)
        {
            MemoryStream stream = new MemoryStream();
            DataContractJsonSerializer ds = new DataContractJsonSerializer(typeof(T));
            ds.WriteObject(stream, t);
            string jsonString = Encoding.UTF8.GetString(stream.ToArray());
            stream.Close();
            return jsonString;
        }

        public static string jsonRender(string entityName, Entity retrievedObject, IOrganizationService service)
        {
            string PrimaryIdAttribute = "";
            string PrimaryNameAttribute = "";
            List<string> atts = getEntityAttributesToClone(entityName, service, ref PrimaryIdAttribute, ref PrimaryNameAttribute);
            StringBuilder sJson = new StringBuilder("{\"" + entityName + "\": {");

            sJson.Append("\"" + PrimaryIdAttribute + "\": \"" + retrievedObject.Id + "\"");
            foreach (string att in atts)
            {
                if (retrievedObject.Attributes.Contains(att))
                {

                    sJson.Append(",");


                    Type t = retrievedObject.Attributes[att].GetType();

                    if (t.Equals(typeof(string)))
                    {
                        sJson.Append("\"" + att + "\" : \"" + retrievedObject.Attributes[att].ToString().Replace("\\", "\\\\") + "\"");
                    }
                    else if (t.Equals(typeof(bool)))
                    {
                        sJson.Append("\"" + att + "\" : " + retrievedObject.Attributes[att].ToString().ToLower() + "");
                    }
                    else if (t.Equals(typeof(OptionSetValue)))
                    {
                        OptionSetValue obj = (OptionSetValue)retrievedObject.Attributes[att];
                        sJson.Append("\"" + att + "\" : " + obj.Value);
                    }
                    else if (t.Equals(typeof(Money)))
                    {
                        Money obj = (Money)retrievedObject.Attributes[att];
                        sJson.Append("\"" + att + "\" : " + obj.Value);
                    }
                    else if (t.Equals(typeof(DateTime)))
                    {
                        DateTime obj = (DateTime)retrievedObject.Attributes[att];
                        sJson.Append("\"" + att + "\" : " + obj.ToBinary());
                    }
                    else if (t.Equals(typeof(EntityReference)))
                    {
                        EntityReference obj = (EntityReference)retrievedObject.Attributes[att];
                        sJson.Append("\"" + att + "\" : { \"typename\" : \"" + obj.LogicalName.ToLower() + "\", \"id\" :\"" + obj.Id.ToString() + "\", \"name\":\"" + obj.Name + "\" }");
                    }
                    else
                    {
                        sJson.Append("\"" + att + "\" : " + retrievedObject.Attributes[att]);
                    }
                }

            }
            sJson.Append("}}");
            return sJson.ToString();
        }

        public static List<string> getEntityAttributesToClone(string entityName, IOrganizationService service,
 ref string PrimaryIdAttribute, ref string PrimaryNameAttribute)
        {


            List<string> atts = new List<string>();
            RetrieveEntityRequest req = new RetrieveEntityRequest()
            {
                EntityFilters = EntityFilters.Attributes,
                LogicalName = entityName
            };

            RetrieveEntityResponse res = (RetrieveEntityResponse)service.Execute(req);
            PrimaryIdAttribute = res.EntityMetadata.PrimaryIdAttribute;

            foreach (AttributeMetadata attMetadata in res.EntityMetadata.Attributes)
            {
                if (attMetadata.IsPrimaryName.Value)
                {
                    PrimaryNameAttribute = attMetadata.LogicalName;
                }
                if ((attMetadata.IsValidForCreate.Value || attMetadata.IsValidForUpdate.Value)
                    && !attMetadata.IsPrimaryId.Value)
                {
                    //tracingService.Trace("Tipo:{0}", attMetadata.AttributeTypeName.Value.ToLower());
                    if (attMetadata.AttributeTypeName.Value.ToLower() == "partylisttype")
                    {
                        atts.Add("partylist-" + attMetadata.LogicalName);
                        //atts.Add(attMetadata.LogicalName);
                    }
                    else
                    {
                        atts.Add(attMetadata.LogicalName);
                    }
                }
            }

            return (atts);
        }

    }
}
