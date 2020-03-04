using System;
using Microsoft.Xrm.Sdk;

namespace Common
{
    public abstract class BasePlugin : IPlugin
    {
        protected class LocalPluginContext
        {
            [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode", Justification = "LocalPluginContext")]
            internal IServiceProvider ServiceProvider { get; private set; }

            [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode", Justification = "LocalPluginContext")]
            internal IOrganizationService OrganizationService { get; private set; }

            internal IOrganizationService ElevatedService { get; private set; }

            internal IPluginExecutionContext PluginExecutionContext { get; private set; }

            internal IServiceEndpointNotificationService NotificationService { get; private set; }

            internal ITracingService TracingService { get; private set; }

            private LocalPluginContext() { }

            /// <summary>
            /// Helper object that stores the services available in this plug-in.
            /// </summary>
            /// <param name="serviceProvider"></param>
            internal LocalPluginContext(IServiceProvider serviceProvider)
            {
                if (serviceProvider == null)
                {
                    throw new InvalidPluginExecutionException("serviceProvider");
                }

                PluginExecutionContext = (IPluginExecutionContext)serviceProvider.GetService(typeof(IPluginExecutionContext));
                TracingService = (ITracingService)serviceProvider.GetService(typeof(ITracingService));
                NotificationService = (IServiceEndpointNotificationService)serviceProvider.GetService(typeof(IServiceEndpointNotificationService));
                IOrganizationServiceFactory factory = (IOrganizationServiceFactory)serviceProvider.GetService(typeof(IOrganizationServiceFactory));
                OrganizationService = factory.CreateOrganizationService(PluginExecutionContext.UserId);
                ElevatedService = factory.CreateOrganizationService(null);
            }

            internal void Trace(string message)
            {
                if (string.IsNullOrWhiteSpace(message) || TracingService == null)
                {
                    return;
                }

                if (PluginExecutionContext == null)
                {
                    TracingService.Trace(message, null);
                }
                else
                {
                    TracingService.Trace(message);

                    //TracingService.Trace(
                    //    "{0}, Correlation Id: {1}, Initiating User: {2}",
                    //    message,
                    //    PluginExecutionContext.CorrelationId,
                    //    PluginExecutionContext.InitiatingUserId);
                }
            }
        }
        protected abstract void Execute(LocalPluginContext localcontext);

        public void Execute(IServiceProvider serviceProvider)
        {
            try
            {
                LocalPluginContext localcontext = new LocalPluginContext(serviceProvider);
                Execute(localcontext);
            }
            catch (Exception e)
            {
                if (e is InvalidPluginExecutionException)
                {
                    // Let InvalidPluginExecutionExceptions flow without wrapping them
                    throw;
                }
                var ex = new InvalidPluginExecutionException($"An error has occurred in CRM plugin '{GetType().Name}': {e.Message}", e);
                throw ex;
            }
        }
    }
}
