using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.K2Models
{
    [DataContract]
    public class ServerEventDataResponse
    {
        [DataMember(Name = "serialNumber")]
        public string SerialNumber { get; set; }

        [DataMember(Name = "workflowName")]
        public string WorkflowName { get; set; }

        [DataMember(Name = "workflowDisplayName")]
        public string WorkflowDisplayName { get; set; }

        [DataMember(Name = "workflowCategory")]
        public string WorkflowCategory { get; set; }

        [DataMember(Name = "workflowInstanceID")]
        public int? WorkflowInstanceID { get; set; }

        [DataMember(Name = "workflowInstanceFolio")]
        public string WorkflowInstanceFolio { get; set; }

        [DataMember(Name = "activityInstanceID")]
        public int? ActivityInstanceID { get; set; }

        [DataMember(Name = "activityInstanceDestinationID")]
        public int? ActivityInstanceDestinationID { get; set; }

        [DataMember(Name = "activityName")]
        public string ActivityName { get; set; }

        [DataMember(Name = "eventName")]
        public string EventName { get; set; }

        [DataMember(Name = "eventDescription")]
        public string EventDescription { get; set; }

        [DataMember(Name = "eventInstance")]
        public EventInstance EventInstance { get; set; }

        [DataMember(Name = "dataFields")]
        public DataFields DataFields { get; set; }

        //[DataMember(Name = "xmlFields")]
        //public IList<UserDefinedXmlField> XmlFields { get; set; }

        //[DataMember(Name = "itemReferences")]
        //public object ItemReferences { get; set; }

        [DataMember(Name = "workflowInstanceDataFieldsString")]
        public string WorkflowInstanceDataFieldsString { get; set; }

        //[DataMember(Name = "itemReferencesString")]
        //public string ItemReferencesString { get; private set; }

        [DataMember(Name = "viewFlowURL")]
        public string ViewFlowURL { get; set; }
    }
}
