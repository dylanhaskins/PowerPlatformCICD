using CCMS.Entities;
using Microsoft.Crm.Sdk.Messages;
using Microsoft.Xrm.Sdk;
using Microsoft.Xrm.Sdk.Query;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;

namespace CCMS.Common
{
    public static class EntityExtension
    {
        /// <summary>
        /// Only use this on the TARGET image with the preImage
        /// </summary>
        /// <typeparam name="T">CRM Type</typeparam>
        /// <param name="target">Input/Target Image</param>
        /// <param name="name">Attribute Name</param>
        /// <param name="preImage">Pre Image</param>
        /// <returns></returns>
        public static T GetAttributeValue<T>(this Entity target, Entity preImage, string name)
        {
            if (target != null && target.Contains(name))
            {
                return target.GetAttributeValue<T>(name);
            }

            if (preImage != null && preImage.Contains(name))
            {
                return preImage.GetAttributeValue<T>(name);
            }

            return default(T);
        }

        /// <summary>
        /// Returns true if field has changed
        /// </summary>
        /// <param name="target"></param>
        /// <param name="preImage"></param>
        /// <returns></returns>
        public static bool TargetFieldHasChanged(this Entity target, Entity preImage, string attribute)
        {
            // Can be used in the create or update
            if (preImage == null)
                preImage = new Entity();

            if (!target.Contains(attribute))
                return false;

            var targetField = target.Attributes[attribute];
            if (target.Attributes.Contains(attribute) && !preImage.Contains(attribute))
            {
                return true;
            }

            var preField = preImage[attribute];

            if (targetField == null && preField != null)
            {
                return true;
            }

            return !targetField.Equals(preField);
        }

        /// <summary>
        /// If single field has changed return true
        /// </summary>
        /// <param name="target"></param>
        /// <param name="preImage"></param>
        /// <param name="attributes"></param>
        /// <returns></returns>
        public static bool TargetFieldHasChanged(this Entity target, Entity preImage, params string[] attributes)
        {
            return attributes
                .Select(a => TargetFieldHasChanged(target, preImage, a))
                .Any(a => a);
        }

        /// <summary>
        /// compares attributes on 2 images
        /// does not check for nulls, so potentially if one contains the key value
        /// being null and the other contains nothins they will be not equal
        /// </summary>
        /// <param name="image2"></param>
        /// <param name="attribute"></param>
        /// <param name="image1"></param>
        /// <returns></returns>
        public static bool IsEqual(this Entity image1, Entity image2, string attribute)
        {
            if (!image1.Contains(attribute) && !image2.Contains(attribute))
            {
                return true;
            }

            if ((!image1.Contains(attribute) && image2.Contains(attribute)) ||
                (!image2.Contains(attribute) && image1.Contains(attribute)))
                return false;

            var preValue = image1[attribute];
            var postValue = image2[attribute];

            return preValue.Equals(postValue);
        }

        /// <summary>
        /// Determines if the given test value matches one of the supplied set values.
        /// </summary>
        /// <param name="optionSet">The supplied value to test.</param>
        /// <param name="setValues">The set of possible values to check against.</param>
        /// <returns></returns>
        public static bool IsInSet(this OptionSetValue optionSet, params object[] setValues)
        {
            if (optionSet == null)
            {
                throw new ArgumentNullException("optionSet");
            }

            if (setValues == null)
            {
                throw new ArgumentNullException("setValues");
            }

            // Will error if type cannot be cast to int
            return setValues
                .Cast<int>()
                .Contains(optionSet.Value);
        }

        /// <summary>
        /// This method will retrieve the plugins target or throw an error if there is something wrong with the target.
        /// </summary>
        /// <param name="pluginExecutionContext">The context that the plugin has been ran in, this will contain the event and input parameters</param>
        /// <param name="_service">Organization Service providing access to the crm web services</param>
        /// <returns>An entity that will be auto-numbered</returns>
        public static Entity RetrieveTarget(IPluginExecutionContext pluginExecutionContext, IOrganizationService _service)
        {
            Entity target = null;

            //Check to see if the plugin contains a target and that the target is not null, if conditions are met
            //assign our targetrequest to the target as an entity.
            if (pluginExecutionContext.InputParameters.Contains("Target") && pluginExecutionContext.InputParameters["Target"] != null)
            {
                var targetRef = (EntityReference)pluginExecutionContext.InputParameters["Target"];

                if (targetRef != null)
                {
                    target = _service.Retrieve(targetRef.LogicalName, targetRef.Id, new ColumnSet(true));
                }
            }

            //Check that we have not made it this far with a still null entity.
            if (target != null)
            {
                return target;
            }
            else
            {
                throw new NullReferenceException("No Target for plugin");
            }
        }

        /// <summary>
        /// Finds a sequence of values if condition is met using a predicate 
        /// </summary>
        /// <typeparam name="TSource"></typeparam>
        /// <param name="source"></param>
        /// <param name="condition"></param>
        /// <param name="predicate"></param>
        /// <returns></returns>
        public static IQueryable<TSource> WhereIf<TSource>(this IQueryable<TSource> source, bool condition, Expression<Func<TSource, bool>> predicate)
        {
            return condition
                ? source.Where(predicate)
                : source;
        }

        /// <summary>
        ///  Finds a sequence of values if condition is met using a predicate
        /// </summary>
        /// <typeparam name="TSource"></typeparam>
        /// <param name="source"></param>
        /// <param name="condition"></param>
        /// <param name="predicate"></param>
        /// <returns></returns>
        public static IEnumerable<TSource> WhereIf<TSource>(this IEnumerable<TSource> source, bool condition, Func<TSource, bool> predicate)
        {
            return condition
                ? source.Where(predicate)
                : source;
        }


        public static T GetValue<T>(this Entity entity, string attributeName)
        {
            if (entity.Attributes.ContainsKey(attributeName))
            {
                var attr = entity[attributeName];
                if (attr is AliasedValue)
                {
                    return GetAliasedValueValue<T>(entity, attributeName);
                }
                else
                {
                    return entity.GetAttributeValue<T>(attributeName);
                }
            }
            else
            {
                return default(T);
            }

        }

        private static T GetAliasedValueValue<T>(this Entity entity, string attributeName)
        {
            var attr = entity.GetAttributeValue<AliasedValue>(attributeName);
            if (attr != null)
            {
                return (T)attr.Value;
            }
            else
            {
                return default(T);
            }

        }

        public static T GetAliasedAttributeValue<T>(this Entity entity, string attributeName)
        {
            if (entity == null)
                return default(T);

            AliasedValue fieldAliasValue = entity.GetAttributeValue<AliasedValue>(attributeName);

            if (fieldAliasValue == null)
                return default(T);

            if (fieldAliasValue.Value != null && fieldAliasValue.Value.GetType() == typeof(T))
            {
                return (T)fieldAliasValue.Value;
            }

            return default(T);
        }
    }
}
