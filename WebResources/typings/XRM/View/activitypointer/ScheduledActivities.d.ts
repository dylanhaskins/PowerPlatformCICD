declare namespace Views.activitypointer {
  interface ScheduledActivities {
    community: string;
    community_Value: SDK.OptionSet<socialprofile_community>;
    scheduledend: string;
    scheduledend_Value: Date;
    scheduledstart: string;
    scheduledstart_Value: Date;
    instancetypecode: string;
    instancetypecode_Value: SDK.OptionSet<activitypointer_instancetypecode>;
    activitytypecode: string;
    activitytypecode_Value: string;
    prioritycode: string;
    prioritycode_Value: SDK.OptionSet<activitypointer_prioritycode>;
    subject: string;
    subject_Value: string;
    statecode: string;
    statecode_Value: SDK.OptionSet<activitypointer_statecode>;
    activityid: string;
    activityid_Value: string;
    regardingobjectid: string;
    regardingobjectid_Value: SDK.EntityReference;
  }
}
