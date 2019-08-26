using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.IDALModel
{

    [DataContract]
    public class CertificateHistory
    {
        [DataMember(Name = "certificateStatusCode", EmitDefaultValue = false)]
        public string certificateStatusCode { get; set; }
        [DataMember(Name = "createdbyStaff", EmitDefaultValue = false)]
        public string createdbyStaff { get; set; }

        [DataMember(Name = "createdDate", EmitDefaultValue = false)]
        public DateTime createdDate { get; set; }
        [DataMember(Name = "additionalProp1", EmitDefaultValue = false)]
        public object additionalProp1 { get; set; }

    }
}
