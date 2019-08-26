using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.IDALModel
{

    [DataContract]
    public class PersonName
    {

        [DataMember(Name = "nameID", EmitDefaultValue = false)]
        public int nameID { get; set; }
        [DataMember(Name = "diaNameType", EmitDefaultValue = false)]
        public string diaNameType { get; set; }
        [DataMember(Name = "initials", EmitDefaultValue = false)]
        public string initials { get; set; }
        [DataMember(Name = "diaFamilyName", EmitDefaultValue = false)]
        public string diaFamilyName { get; set; }
        [DataMember(Name = "diaGivenNames", EmitDefaultValue = false)]
        public string diaGivenNames { get; set; }
        [DataMember(Name = "otherGivenName", EmitDefaultValue = false)]
        public string otherGivenName { get; set; }
        [DataMember(Name = "diaStartDate", EmitDefaultValue = false)]
        public string diaStartDate { get; set; }
        [DataMember(Name = "diaEndDate", EmitDefaultValue = false)]
        public string diaEndDate { get; set; }
        [DataMember(Name = "additionalProp1", EmitDefaultValue = false)]
        public object additionalProp1 { get; set; }
    }
}
