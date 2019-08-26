using CCMS.Core.Entities;
using Microsoft.Crm.Sdk.Messages;
using Microsoft.Xrm.Sdk;
using System;
using System.Collections.Generic;
using System.Text;

namespace CCMS.Core.Services
{
    internal abstract class BaseService
    {
        protected IOrganizationService OrgService { get; set; }
        protected IOrganizationService ElevatedService { get; set; }
        protected ITracingService TracingService { get; set; }
        protected CCMSContext OrgServiceContext { get; set; }
        protected CCMSContext ElevatedServiceContext { get; set; }
        public BaseService(IOrganizationService orgService, ITracingService tracingservice)
        {
            OrgService = orgService;
            TracingService = tracingservice;
            //Create OrganizationService Context
            OrgServiceContext = new CCMSContext(OrgService);
        }
        public BaseService(IOrganizationService orgService, IOrganizationService elevatedService, ITracingService tracingservice) : this(orgService, tracingservice)
        {
            ElevatedService = elevatedService;
            ElevatedServiceContext = new CCMSContext(ElevatedService);
        }
        protected void Trace(string trace)
        {
            if (TracingService != null)
            {
                TracingService.Trace(trace);
            }
        }
        protected DateTime? RetrieveLocalTimeFromUTCTime(DateTime utcTime, int? _timeZoneCode)
        {
            if (!_timeZoneCode.HasValue)
                return null;
            var request = new LocalTimeFromUtcTimeRequest
            {
                TimeZoneCode = _timeZoneCode.Value,
                UtcTime = utcTime.ToUniversalTime()
            };

            var response = (LocalTimeFromUtcTimeResponse)ElevatedService.Execute(request);
            return response.LocalTime;
        }
    }
}
