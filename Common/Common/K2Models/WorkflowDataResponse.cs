using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.K2Models
{
    [DataContract]
    public class WorkflowDataResponse
    {
        [DataMember(Name = "workflowInfo")]
        public WorkflowDefinition WorkflowInfo { get; set; }

        [DataMember(Name = "workflowSchema")]
        public string WorkflowSchema { get; set; }
    }
}
