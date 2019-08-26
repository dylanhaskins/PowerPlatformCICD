using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.IDALModel
{

    [DataContract]
    public class Certificate
    {
        [DataMember(Name = "certificateNumber", EmitDefaultValue = false)]
        public string certificateNumber { get; set; }
        [DataMember(Name = "effectiveDate", EmitDefaultValue = false)]
        public DateTime effectiveDate { get; set; }
        [DataMember(Name = "processingLocation", EmitDefaultValue = false)]
        public string processingLocation { get; set; }
        [DataMember(Name = "imageID", EmitDefaultValue = false)]
        public string imageID { get; set; }
        [DataMember(Name = "certificateHistoryList", EmitDefaultValue = false)]
        public List<CertificateHistory> certificateHistoryList { get; set; }
        [DataMember(Name = "additionalProp1", EmitDefaultValue = false)]
        public object additionalProp1 { get; set; }
    }
}
