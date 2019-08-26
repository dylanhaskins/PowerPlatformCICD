using System;
using Microsoft.Xrm.Sdk;
using System.Linq;
using Microsoft.Xrm.Sdk.Query;
using CCMS.Entities;

namespace CCMS.Common.Services.CommonServices
{
    internal class AutoNumberService : BaseService
    {
        internal AutoNumberService(IOrganizationService service, IOrganizationService elevatedService, ITracingService trace) : base(service, elevatedService, trace)
        {
        }

        internal string GenerateUniqueIdentifier(string key)
        {
            //read with no lock, just to get the right one
            var currentAutoNumber = GetUniqueIdentifierForEntity(key);
            if (currentAutoNumber == null)
            {
                Trace("Auto number configuration missing for the entity.");
                return null;
            }
            //check if we need to update, or generate a random number
            if (currentAutoNumber.dia_random.HasValue && currentAutoNumber.dia_random.Value)
            {
                Trace("Generating random ID.");
                return GenerateRandomIdentifier(currentAutoNumber);
            }
            else
            {
                return GetNextAutoNumber(currentAutoNumber);
            }
        }

        internal void GenerateUniqueIdentifier(Entity target)
        {
            //read with no lock, just to get the right one
            var currentAutoNumber = GetUniqueIdentifierForEntity(target.LogicalName);
            if (currentAutoNumber == null)
            {
                Trace("Auto number configuration missing for the entity.");
                return;
            }
            var entityFieldName = currentAutoNumber.dia_attributeschemaname;
            Trace(entityFieldName?.ToString() ?? "entity field name is null");
            if (entityFieldName == null)
            {
                return;
            }
            // If record already contains identifier, we ignore this
            if (target.Contains(entityFieldName) && !string.IsNullOrWhiteSpace(target.GetAttributeValue<string>(entityFieldName)))
            {
                Trace("Unique identifier field already set.");
                return;
            }
            //check if we need to update, or generate a random number
            if (currentAutoNumber.dia_random.HasValue && currentAutoNumber.dia_random.Value)
            {
                Trace("Generating random ID.");
                target[entityFieldName] = GenerateRandomIdentifier(currentAutoNumber);
            }
            else
            {
                var uniqueID = GetNextAutoNumber(currentAutoNumber);
                target[entityFieldName] = uniqueID;
                Trace($"Unique ID is { uniqueID }");
            }
        }

        private string GetNextAutoNumber(dia_autonumberconfiguration currentAutoNumber)
        {
            //update the entity, which would either block if there is an existing transaction, or lock the record
            Trace("Locking the current number for read.");
            var updAutoNumber = new dia_autonumberconfiguration(currentAutoNumber.Id);
            updAutoNumber.dia_updatekey = Guid.NewGuid().ToString();
            ElevatedService.Update(updAutoNumber);

            //now read the next number
            Trace("Retriving the current number.");
            currentAutoNumber = ElevatedService
                .Retrieve(dia_autonumberconfiguration.EntityLogicalName, currentAutoNumber.Id,
                    new Microsoft.Xrm.Sdk.Query.ColumnSet(true)).ToEntity<dia_autonumberconfiguration>();


            var currentNumber = currentAutoNumber.dia_nextuniqueidentifier.HasValue
                ? currentAutoNumber.dia_nextuniqueidentifier.Value
                : 1;
            Trace($"Current number is {currentNumber}");
            //update it back
            updAutoNumber = new dia_autonumberconfiguration(currentAutoNumber.Id);
            updAutoNumber.dia_nextuniqueidentifier = (currentNumber == Int32.MaxValue ? 1 : currentNumber + 1);
            ElevatedService.Update(updAutoNumber);
            string uniqueID = GenerateIdentifier(currentAutoNumber, currentNumber);
            return uniqueID;
        }

        private string GenerateRandomIdentifier(dia_autonumberconfiguration currentAutoNumber)
        {
            Guid guid = Guid.NewGuid();
            uint g = (uint)(guid.GetHashCode());
            g = g % 728999999; // 30 ^ 6 - 1 to ensure we only generate 6 character long codes.
            var code = GenerateObfuscatedNumber((int)g, 6);
            var prefix = currentAutoNumber.dia_prefix;
            return string.Format("{0}{1}", prefix, code);
        }

        private string GenerateIdentifier(dia_autonumberconfiguration currentAutoNumber, int number)
        {
            var prefix = currentAutoNumber.dia_prefix;
            var characters = currentAutoNumber.dia_numberofcharacters.HasValue ? currentAutoNumber.dia_numberofcharacters.Value : 6;
            var currentNumber = number.ToString(System.Globalization.CultureInfo.InvariantCulture);
            if (currentAutoNumber.dia_obfuscate.HasValue && currentAutoNumber.dia_obfuscate.Value)
            {
                currentNumber = GenerateObfuscatedNumber(number, characters);
            }
            else
            {
                currentNumber = currentNumber.PadLeft(characters, '0');
            }
            return string.Format("{0}{1}", prefix, currentNumber);
        }

        private string GenerateObfuscatedNumber(int number, int minLength)
        {
            //valid chars for the code
            //removed vowels or numbers that looks like letters to avoid accidental swearwords
            var validCodes = "KB968QNHMDP5YV4WCJRSF1GL7TZ32X"; //30 unique characters BCDFGHJKMNPQRSTVWXZ 23456789
            var code = "";
            //generate an alphanumeric code
            while (number > 0 || code.Length < minLength)
            {
                int i = number % validCodes.Length;
                code += validCodes[(int)i];
                number = (number - i) / validCodes.Length;
            }
            return code;
        }


        private dia_autonumberconfiguration GetUniqueIdentifierForEntity(string key)
        {
            Trace($"Retriving auto number configuration for key");
            var autoNumberQuery = new QueryExpression(dia_autonumberconfiguration.EntityLogicalName)
            {
                NoLock = false,
                ColumnSet = new ColumnSet(true)
            };
            autoNumberQuery.Criteria.AddCondition(nameof(dia_autonumberconfiguration.dia_entityschemaname).ToLower(), ConditionOperator.Equal, key);
            autoNumberQuery.Criteria.AddCondition(nameof(dia_autonumberconfiguration.statecode).ToLower(), ConditionOperator.Equal, (int)dia_autonumberconfigurationState.Active);

            Trace($"Auto number configuration for {key} retrieved");
            return ElevatedService.RetrieveMultiple(autoNumberQuery).Entities.FirstOrDefault()?.ToEntity<dia_autonumberconfiguration>();

        }
    }
}
