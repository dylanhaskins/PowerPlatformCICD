using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.IDALModel
{
    [DataContract]
    public class PersonContactNumber
    {
        [DataMember(Name = "addressTypeCode", EmitDefaultValue = false)]
        public string addressTypeCode { get; set; }
        [DataMember(Name = "contactNumberTypeCode", EmitDefaultValue = false)]
        public string contactNumberTypeCode { get; set; }
        [DataMember(Name = "contactNumber", EmitDefaultValue = false)]
        public string contactNumber { get; set; }
        [DataMember(Name = "emailAddress", EmitDefaultValue = false)]
        public string emailAddress { get; set; }
        [DataMember(Name = "dateCreated", EmitDefaultValue = false)]
        public string dateCreated { get; set; }
        [DataMember(Name = "dateCancelled", EmitDefaultValue = false)]
        public DateTime dateCancelled { get; set; }
        [DataMember(Name = "additionalProp1", EmitDefaultValue = false)]
        public object additionalProp1 { get; set; }
    }
}
