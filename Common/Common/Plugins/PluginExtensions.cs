using System;
using Microsoft.Xrm.Sdk;
using Microsoft.Xrm.Sdk.Query;

namespace Common
{
    internal static class PluginExtensions
    {
        internal static Entity GetEntityFromContext(this IExecutionContext context)
        {
            if (context.IsRetrieveOperation() && context.OutputParameters.Contains("BusinessEntity"))
                return context.OutputParameters["BusinessEntity"] as Entity;

            if (!context.IsRetrieveOperation() && context.InputParameters.Contains("Target"))
                return context.InputParameters["Target"] as Entity;

            return null;
        }
        public static EntityReference GetEntityReferenceFromContext(this IExecutionContext context)
        {
            return new EntityReference(context.PrimaryEntityName, context.PrimaryEntityId);
        }
        public static QueryExpression GetQueryFromContext(this IPluginExecutionContext context)
        {
            if (context.InputParameters.Contains("Query"))
                return context.InputParameters["Query"] as QueryExpression;

            return null;
        }
        internal static bool IsPreValidationStage(this IPluginExecutionContext context)
        {
            return context.Stage == (int)StageEnum.PreValidation;
        }

        internal static bool IsPreOperationStage(this IPluginExecutionContext context)
        {
            return context.Stage == (int)StageEnum.PreOperation;
        }

        internal static bool IsPostOperationStage(this IPluginExecutionContext context)
        {
            return context.Stage == (int)StageEnum.PostOperation;
        }

        /// <summary>
        ///     Return true when it matches the name of operation
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        internal static bool IsSetStateOperation(this IExecutionContext context, int? targetState = null)
        {
            if(string.Equals(context.MessageName, "SetState", StringComparison.InvariantCultureIgnoreCase) ||
                   string.Equals(context.MessageName, "SetStateDynamicEntity", StringComparison.InvariantCultureIgnoreCase))
            {
                if(targetState == null)
                    return true;

                return !context.IsAttributeImageEqual<OptionSetValue>("statecode", ImageHelpers.PreEntityImageName); //if it didn't change then return false as if it never changed
            }

            return false;
        }

        /// <summary>
        ///     Return true when it is create operation
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        internal static bool IsCreateOperation(this IExecutionContext context)
        {
            return string.Equals(context.MessageName, "Create", StringComparison.InvariantCultureIgnoreCase);
        }

        public static bool IsAssignOperation(this IExecutionContext context)
        {
            return string.Equals(context.MessageName, "Assign", StringComparison.InvariantCultureIgnoreCase);
        }

        public static bool IsAssociateOperation(this IExecutionContext context)
        {
            return string.Equals(context.MessageName, "Associate", StringComparison.InvariantCultureIgnoreCase);
        }

        public static bool IsDisassociateOperation(this IExecutionContext context)
        {
            return string.Equals(context.MessageName, "Disassociate", StringComparison.InvariantCultureIgnoreCase);
        }

        internal static bool IsRetrieveOperation(this IExecutionContext context)
        {
            return string.Equals(context.MessageName, "Retrieve", StringComparison.InvariantCultureIgnoreCase);
        }

        /// <summary>
        ///     Return true when it is update operation
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        internal static bool IsUpdateOperation(this IExecutionContext context)
        {
            return string.Equals(context.MessageName, "Update", StringComparison.InvariantCultureIgnoreCase);
        }

        /// <summary>
        ///     Return true when it is delete operation
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        internal static bool IsDeleteOperation(this IExecutionContext context)
        {
            return string.Equals(context.MessageName, "Delete", StringComparison.InvariantCultureIgnoreCase);
        }

        internal static TEntity GetTarget<TEntity>(this IExecutionContext context) where TEntity : Entity
        {
            TEntity target = null;
            if (context.InputParameters.Contains("Target") &&
               context.InputParameters["Target"] is Entity _entity
               )
            {
                target = _entity.ToEntity<TEntity>();
            }
            return target;
        }
        internal static EntityReference GetTargetReference(this IExecutionContext context)
        {
            EntityReference target = null;
            if (context.InputParameters.Contains("Target") &&
               context.InputParameters["Target"] is EntityReference _entityRef
               )
            {
                target = _entityRef;
            }
            return target;
        }

        internal static TEntity GetPreImageForAction<TEntity>(this IExecutionContext context) where TEntity : Entity
        {
            TEntity PreImage = null;
            if (context.InputParameters.Contains(ImageHelpers.PreEntityImageName) &&
               context.InputParameters[ImageHelpers.PreEntityImageName] is Entity _entity
               )
            {
                PreImage = _entity.ToEntity<TEntity>();
            }
            return PreImage;
        }
    }
}
