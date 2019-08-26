using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.IDALModel
{

    [DataContract]
    public class PersonAddress
    {

        [DataMember(Name = "addressTypeCode", EmitDefaultValue = false)]
        public string addressTypeCode { get; set; }
        [DataMember(Name = "address", EmitDefaultValue = false)]
        public string address { get; set; }
        [DataMember(Name = "city", EmitDefaultValue = false)]
        public string city { get; set; }
        [DataMember(Name = "country", EmitDefaultValue = false)]
        public string country { get; set; }
        [DataMember(Name = "createdOn", EmitDefaultValue=false)]
        public string createdOn { get; set; }
        [DataMember(Name = "dateCancelled", EmitDefaultValue = false)]
        public string dateCancelled { get; set; }
        [DataMember(Name = "additionalProp1", EmitDefaultValue = false)]
        public object additionalProp1 { get; set; }
    }
}
