using CCMS.Common;
using CCMS.Core.Entities;
using Microsoft.Xrm.Sdk;
using Microsoft.Xrm.Sdk.Query;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CCMS.Core.Services
{
    internal class ConfigService : BaseService
    {
        EncryptionHelper EncryptionHelper { get; set; }
        public ConfigService(IOrganizationService service, ITracingService trace) : base(service, trace)
        {
            EncryptionHelper = new EncryptionHelper();
        }
        public T GetSetting<T>(string settingName)
        {
            ConditionExpression condition = new ConditionExpression(
                "dia_name",
                ConditionOperator.Equal,
                settingName
            );

            ConditionExpression condition2 = new ConditionExpression(
                "statuscode",
                ConditionOperator.Equal,
                dia_configuration_statuscode.Active
            );

            QueryExpression query = new QueryExpression
            {
                EntityName = "dia_configuration",
                ColumnSet = new ColumnSet(true)
            };

            query.Criteria.AddCondition(condition);
            query.Criteria.AddCondition(condition2);

            var settings = OrgService.RetrieveMultiple(query).Entities;
            var setting = settings.FirstOrDefault();

            return setting.GetAttributeValue<T>("dia_value");
        }

        public string GetSetting(string settingName)
        {

            string value = string.Empty;
            dia_configuration setting = OrgServiceContext.dia_configurationSet.Where(x => x.dia_name == settingName && x.statecode == dia_configurationState.Active)
                            .FirstOrDefault<dia_configuration>();

            if (setting != null)
            {
                value = setting.dia_value;
                if (setting.dia_enrcypt.HasValue && setting.dia_enrcypt.Value)
                {
                    value = EncryptionHelper.Decrypt(value);
                }
            }
            return value;
        }

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
    }
}
