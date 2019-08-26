using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.IDALModel
{

    [DataContract]
    public class PersonNZCitizenshipHistory
    {

        [DataMember(Name = "citizenshipTypeCode", EmitDefaultValue = false)]
        public string citizenshipTypeCode { get; set; }
        [DataMember(Name = "effectiveDate", EmitDefaultValue = false)]
        public DateTime effectiveDate { get; set; }
        [DataMember(Name = "registeredDate", EmitDefaultValue = false)]
        public DateTime registeredDate { get; set; }
        [DataMember(Name = "additionalProp1", EmitDefaultValue = false)]
        public object additionalProp1 { get; set; }
    }
}
