using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.K2Models
{
    [DataContract]
    public class EventInstance
    {
        [DataMember(Name = "description")]
        public string Description { get; set; }

        [DataMember(Name = "expectedDuration")]
        public int? ExpectedDuration { get; set; }

        [DataMember(Name = "id")]
        public int? ID { get; set; }

        [DataMember(Name = "metadata")]
        public string MetaData { get; set; }

        [DataMember(Name = "name")]
        public string Name { get; set; }

        [DataMember(Name = "priority")]
        public int? Priority { get; set; }

        [DataMember(Name = "startDate")]
        public string StartDate { get; set; }

    }
}
