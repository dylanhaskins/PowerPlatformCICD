using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.K2Models
{
    [DataContract]
    public class WorkflowDefinition
    {
        [DataMember(Name = "name")]
        public string Name { get; set; }

        [DataMember(Name = "description")]
        public string Description { get; set; }

        [DataMember(Name = "folder")]
        public string Folder { get; set; }

        [DataMember(Name = "systemName")]
        public string SystemName { get; set; }

        [DataMember(Name = "expectedDuration")]
        public int? ExpectedDuration { get; set; }
    }
}
