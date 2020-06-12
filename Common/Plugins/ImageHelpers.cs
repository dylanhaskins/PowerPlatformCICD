using System;
using Microsoft.Xrm.Sdk;

namespace Common
{
    public static class ImageHelpers
    {
        public const string PreEntityImageName = "PreImage";
        public const string PostEntityImageName = "PostImage";



        /// <summary>
        /// This utility method can be used to find the final attribute of an entity in a given time.
        /// If the attribute is being updated it will retrieve the updating version of the attribute, otherwise it will use the value of the pre-image
        /// </summary>
        internal static object GetFinalAttribute(this IExecutionContext context, string attributeName, string preEntityImageName)
        {
            bool gettingSet;
            return context.GetFinalAttribute(attributeName, preEntityImageName, out gettingSet);
        }

        internal static object GetFinalAttribute(this IExecutionContext context, string attributeName, string preEntityImageName, out bool gettingSet)
        {
            object contextAtt = context.GetContextAttribute(attributeName, out gettingSet);
            if (gettingSet)
            {
                return contextAtt;
            }

            return context.GetOriginalAttribute(attributeName, preEntityImageName);
        }

        internal static object GetContextAttribute(this IExecutionContext context, string attributeName, out bool gettingSet)
        {
            // Use gettingSet boolean because if the value is getting set to null there is no other way to tell whether
            // the attribute is not getting set (not in the context) or whether it is getting set to null explicitly.
            gettingSet = false;

            if (context.InputParameters.ContainsKey("Target"))
            {
                var newVersion = context.InputParameters["Target"] as Entity;
                if (newVersion != null && newVersion.Contains(attributeName))
                {
                    // The attribute is being updated, use the new value
                    gettingSet = true;
                    return newVersion[attributeName];
                }
            }
            else if (attributeName.Equals("statecode", StringComparison.InvariantCultureIgnoreCase) && context.InputParameters.Contains("State"))
            {
                gettingSet = true;
                return context.InputParameters["State"];
            }
            else if (attributeName.Equals("statuscode", StringComparison.InvariantCultureIgnoreCase) && context.InputParameters.Contains("Status"))
            {
                gettingSet = true;
                return context.InputParameters["Status"];
            }
            return null;
        }

        internal static object GetOriginalAttribute(this IExecutionContext context, string attributeName, string preEntityImageName)
        {
            if (context.PreEntityImages.Contains(preEntityImageName))
            {
                var oldVersion = context.PreEntityImages[preEntityImageName];
                if (oldVersion.Contains(attributeName))
                {
                    // Return the attribute value from the PreImage
                    return oldVersion[attributeName];
                }
            }
            return null;
        }

        internal static object GetPostImageAttribute(this IExecutionContext context, string attributeName, string postEntityImageName)
        {
            if (context.PostEntityImages.Contains(postEntityImageName))
            {
                var newVersion = context.PostEntityImages[postEntityImageName];
                if (newVersion.Contains(attributeName))
                {
                    // Return the attribute value from the PostImage
                    return newVersion[attributeName];
                }
            }

            return null;
        }

        internal static bool IsEntityReferenceImageEqual(EntityReference e1, EntityReference e2)
        {
            if (e1 == null && e2 == null)
            {
                return true;
            }
            if (e1 == null || e2 == null)
            {
                return false;
            }

            return e1.Id == e2.Id;
        }

        internal static bool IsOptionSetImageEqual(OptionSetValue o1, OptionSetValue o2)
        {
            if (o1 == null && o2 == null)   
            {
                return true;
            }
            if (o1 == null || o2 == null)
            {
                return false;
            }
            return o1.Value == o2.Value;
        }

        internal static bool IsAttributeImageEqual<T>(this IExecutionContext context, string attributeName, string preEntityImageName)
        {
            var preValue = context.GetOriginalAttribute(attributeName, preEntityImageName);
            var finalValue = context.GetFinalAttribute(attributeName, preEntityImageName);

            if (typeof(T) == typeof(OptionSetValue))
                return IsOptionSetImageEqual((OptionSetValue)preValue, (OptionSetValue)finalValue);
            if (typeof(T) == typeof(EntityReference))
                return IsEntityReferenceImageEqual((EntityReference)preValue, (EntityReference)finalValue);

            return preValue == finalValue;
        }

        internal static bool IsStringImageEqual(string s1, string s2)
        {
            // In CRM pipeline null is treated as string.Empty sometimes, so treat these equally.
            // For example, when setting string field to null, the plugin will actually catch "" value in the attributes
            if (s1 == null && s2 == null)
            {
                return true;
            }
            if (s1 == null && s2 == string.Empty)
            {
                return true;
            }
            if (s1 == string.Empty && s2 == null)
            {
                return true;
            }

            return s1 == s2;
        }

        internal static bool IsValueDifferent(object attributeValue, object originalValue)
        {
            if (attributeValue == null)
            {
                if (originalValue == null)
                {
                    return false;
                }
                return true;
            }

            var stringNewValue = attributeValue as string;
            if (stringNewValue != null)
            {
                var stringOldValue = originalValue as string;
                return !IsStringImageEqual(stringOldValue, stringNewValue);
            }

            var osvNewValue = attributeValue as OptionSetValue;
            if (osvNewValue != null)
            {
                var osvOldValue = originalValue as OptionSetValue;
                return !IsOptionSetImageEqual(osvOldValue, osvNewValue);
            }

            var erNewValue = attributeValue as EntityReference;
            if (erNewValue != null)
            {
                var erOldValue = originalValue as EntityReference;
                return !IsEntityReferenceImageEqual(erOldValue, erNewValue);
            }

            var iNewValue = attributeValue as int?;
            if (iNewValue != null)
            {
                var iOldValue = originalValue as int?;
                return iOldValue != iNewValue;
            }

            var bNewValue = attributeValue as bool?;
            if (bNewValue != null)
            {
                var bOldValue = originalValue as bool?;
                return bOldValue != bNewValue;
            }

            return true; // Other datatypes not covered, assume value is different
        }

        public static TEntity GetPreImage<TEntity>(this IExecutionContext context, string preEntityImageName = PreEntityImageName) where TEntity : Entity
        {
            TEntity preImage = null;
            if (context.PreEntityImages.Contains(preEntityImageName))
            {
                preImage = context.PreEntityImages[preEntityImageName].ToEntity<TEntity>();
            }
            return preImage;
        }
        public static TEntity GetPostImage<TEntity>(this IExecutionContext context, string postEntityImageName = PostEntityImageName) where TEntity : Entity
        {
            TEntity postImage = null;
            if (context.PostEntityImages.Contains(postEntityImageName))
            {
                postImage = context.PostEntityImages[postEntityImageName].ToEntity<TEntity>();
            }
            return postImage;
        }
    }
}
