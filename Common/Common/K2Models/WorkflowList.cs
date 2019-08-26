using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.K2Models
{
    [DataContract]
    public class WorkflowList
    {
        [DataMember(Name = "itemCount")]
        public int? ItemCount { get; set; }

        [DataMember(Name = "workflows")]
        public IList<Workflow> Workflows { get; set; }
    }
}
