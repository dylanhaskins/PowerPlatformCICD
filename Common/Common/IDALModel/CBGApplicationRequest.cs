using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.IDALModel
{

    [DataContract]
    public class CBGApplicationRequest
    {
        [DataMember(Name = "person", EmitDefaultValue = false)]
        public Person person { get; set; }
        [DataMember(Name = "applicationNumber", EmitDefaultValue = false)]
        public string applicationNumber { get; set; }
        [DataMember(Name = "sequenceNumber", EmitDefaultValue = false)]
        public int sequenceNumber { get; set; }
        [DataMember(Name = "additionalProp1", EmitDefaultValue = false)]
        public object additionalProp1 { get; set; }
    }
}
