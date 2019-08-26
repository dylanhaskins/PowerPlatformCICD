using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.K2Models
{
    [DataContract]
    public class StartWorkflow
    {
        [DataMember(Name = "folio")]
        public string Folio { get; set; }

        [DataMember(Name = "expectedDuration")]
        public string ExpectedDuration { get; set; }

        [DataMember(Name = "priority")]
        public string Priority { get; set; }

        [DataMember(Name = "dataFields")]
        public DataFieldsStartWorkflow DataFields { get; set; }
    }

    [DataContract]
    public class DataFieldsStartWorkflow
    {
        [DataMember(Name = "Input_RequestId")]
        public Guid Input_RequestId { get; set; }
    }

    [DataContract]
    public class CBG_StartWorkflow
    {
        [DataMember(Name = "folio")]
        public string Folio { get; set; }

        [DataMember(Name = "expectedDuration")]
        public string ExpectedDuration { get; set; }

        [DataMember(Name = "priority")]
        public string Priority { get; set; }

        [DataMember(Name = "dataFields")]
        public DataFieldsCBGStart DataFields { get; set; }
    }

    [DataContract]
    public class DataFieldsCBGStart
    {
        [DataMember(Name = "ServiceRequestId")]
        public Guid ServiceRequestId { get; set; }
    }

    [DataContract]
    public class CBG_FinishServerEvent
    {
        [DataMember(Name = "dataFields")]
        public DataFieldsFinish DataFields { get; set; }
    }

    [DataContract]
    public class DataFieldsFinish
    {
        [DataMember(Name = "ProcessStatus")]
        public string ProcessStatus { get; set; }
    }

    [DataContract]
    public class IDAL_StartWorkflow
    {
        [DataMember(Name = "folio")]
        public string Folio { get; set; }

        [DataMember(Name = "expectedDuration")]
        public string ExpectedDuration { get; set; }

        [DataMember(Name = "priority")]
        public string Priority { get; set; }

        [DataMember(Name = "dataFields")]
        public DataFieldsIDALStart DataFields { get; set; }
    }

    [DataContract]
    public class DataFieldsIDALStart
    {
        [DataMember(Name = "Param_iDALIntegrationId")]
        public Guid Param_iDALIntegrationId { get; set; }
    }
}

//{
//  "dataFields": {
//    "ProcessStatus": "Completed"
//  }
//}

//{
//  "dataFields": {
//    "ProcessStatus": "Cancelled"
//  }
//}

//{
//  "folio": "",
//  "expectedDuration": 86400,
//  "priority": 1,
//  "dataFields": {
//    "CitizenshipApplicationId": "5f72c71e-c7d7-e811-a966-000d3ae12152" 
//  }
//}