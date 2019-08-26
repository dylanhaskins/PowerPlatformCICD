using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.IDALModel
{

    [DataContract]
    public class ApplicationType
    {

        [DataMember(Name = "applicationTypeCode", EmitDefaultValue = false)]
        public string applicationTypeCode { get; set; }
        [DataMember(Name = "modifiedbyStaff", EmitDefaultValue = false)]
        public string modifiedbyStaff { get; set; }

        [DataMember(Name = "modifiedDate", EmitDefaultValue = false)]
        public DateTime modifiedDate { get; set; }
        [DataMember(Name = "additionalProp1", EmitDefaultValue = false)]
        public object additionalProp1 { get; set; }
    }
}
