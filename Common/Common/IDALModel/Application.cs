using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.IDALModel
{

    [DataContract]
    public class Application
    {

        [DataMember(Name = "applicationNumber", EmitDefaultValue = false)]
        public string applicationNumber { get; set; }
        [DataMember(Name = "applicationType", EmitDefaultValue = false)]
        public string applicationType { get; set; }
        [DataMember(Name = "creationDate", EmitDefaultValue = false)]
        public string creationDate { get; set; }
        [DataMember(Name = "previousApplicationNumber", EmitDefaultValue = false)]
        public string previousApplicationNumber { get; set; }
        [DataMember(Name = "dateRegistered", EmitDefaultValue = false)]
        public DateTime dateRegistered { get; set; }
        [DataMember(Name = "registeredLocation", EmitDefaultValue = false)]
        public string registeredLocation { get; set; }
        [DataMember(Name = "scheduleType", EmitDefaultValue = false)]
        public string scheduleType { get; set; }
        [DataMember(Name = "scheduleID", EmitDefaultValue = false)]
        public int scheduleID { get; set; }
        [DataMember(Name = "submissionID", EmitDefaultValue = false)]
        public int submissionID { get; set; }
        [DataMember(Name = "oldSystemID", EmitDefaultValue = false)]
        public string oldSystemID { get; set; }
        [DataMember(Name = "applicationTypeList", EmitDefaultValue = false)]
        public List<ApplicationType> applicationTypeList { get; set; }
        [DataMember(Name = "applicationHistoryList", EmitDefaultValue = false)]
        public List<ApplicationHistory> applicationHistoryList { get; set; }
        [DataMember(Name = "certificateList", EmitDefaultValue = false)]
        public List<Certificate> certificateList { get; set; }
        [DataMember(Name = "additionalProp1", EmitDefaultValue = false)]
        public object additionalProp1 { get; set; }
    }
}
