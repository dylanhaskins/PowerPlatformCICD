using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.K2Models
{
    [DataContract]
    public class Workflow
    {
        [DataMember(Name = "id")]
        public int? Id { get; set; }

        [DataMember(Name = "defaultVersionId")]
        public int? DefaultVersionId { get; set; }

        [DataMember(Name = "name")]
        public string Name { get; set; }

        [DataMember(Name = "folder")]
        public string Folder { get; set; }

        [DataMember(Name = "systemName")]
        public string SystemName { get; set; }
    }
}
