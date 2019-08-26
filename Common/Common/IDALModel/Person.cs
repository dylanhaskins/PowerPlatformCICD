using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.IDALModel
{

    [DataContract]
    public class Person
    {
        [DataMember(Name = "personContactNumberList", EmitDefaultValue = false)]
        public List<PersonContactNumber> personContactNumberList { get; set; }

        [DataMember(Name = "personImagesList", EmitDefaultValue = false)]
        public List<PersonImage> personImagesList { get; set; }

        [DataMember(Name = "dateOfBirth", EmitDefaultValue = false)]
        public string dateOfBirth { get; set; }

        [DataMember(Name = "alertExists", EmitDefaultValue = false)]
        public string alertExists { get; set; }

        [DataMember(Name = "personNumber", EmitDefaultValue = false)]
        public string personNumber { get; set; }

        [DataMember(Name = "personNameList", EmitDefaultValue = false)]
        public List<PersonName> personNameList { get; set; }

        [DataMember(Name = "dateOfDeath", EmitDefaultValue = false)]
        public string dateOfDeath { get; set; }

        [DataMember(Name = "eyeColour", EmitDefaultValue = false)]
        public string eyeColour { get; set; }

        [DataMember(Name = "currentNameID", EmitDefaultValue = false)]
        public int currentNameID { get; set; }

        [DataMember(Name = "nzCitizenshipStatus", EmitDefaultValue = false)]
        public string nzCitizenshipStatus { get; set; }

        [DataMember(Name = "height", EmitDefaultValue = false)]
        public string height { get; set; }

        [DataMember(Name = "personNZCitizenshipHistoryList", EmitDefaultValue = false)]
        public List<PersonNZCitizenshipHistory> personNZCitizenshipHistoryList { get; set; }

        [DataMember(Name = "personType", EmitDefaultValue = false)]
        public string personType { get; set; }

        [DataMember(Name = "countryOfBirth", EmitDefaultValue = false)]
        public string countryOfBirth { get; set; }

        [DataMember(Name = "gender", EmitDefaultValue = false)]
        public string gender { get; set; }

        [DataMember(Name = "personAddressList", EmitDefaultValue = false)]
        public List<PersonAddress> personAddressList { get; set; }

        [DataMember(Name = "placeOfBirth", EmitDefaultValue = false)]
        public string placeOfBirth { get; set; }

        [DataMember(Name = "oldSystemID", EmitDefaultValue = false)]
        public string oldSystemID { get; set; }

        [DataMember(Name = "applications", EmitDefaultValue = false)]
        public List<Application> applications { get; set; }

        [DataMember(Name = "additionalProp1", EmitDefaultValue = false)]
        public object additionalProp1 { get; set; }
    }
}
