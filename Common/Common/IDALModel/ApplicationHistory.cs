using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.IDALModel
{

    [DataContract]
    public class ApplicationHistory
    {

        [DataMember(Name = "applicationStatusCode", EmitDefaultValue = false)]
        public string applicationStatusCode { get; set; }
        [DataMember(Name = "createdByStaff", EmitDefaultValue = false)]
        public string createdByStaff { get; set; }
        [DataMember(Name = "createdDate", EmitDefaultValue = false)]
        public string createdDate { get; set; }
        [DataMember(Name = "additionalProp1", EmitDefaultValue = false)]
        public object additionalProp1 { get; set; }
    }
}
