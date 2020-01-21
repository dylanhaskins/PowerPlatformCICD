declare namespace Views.activitypointer {
  interface MyTeamMembersActivities {
    community: string;
    community_Value: SDK.OptionSet<socialprofile_community>;
    statuscode: string;
    statuscode_Value: SDK.OptionSet<activitypointer_statuscode>;
    scheduledend: string;
    scheduledend_Value: Date;
    scheduledstart: string;
    scheduledstart_Value: Date;
    ownerid: string;
    ownerid_Value: SDK.EntityReference;
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
    senton: string;
    senton_Value: Date;
    email_engagement_delayedemailsendtime: string;
    email_engagement_delayedemailsendtime_Value: Date;
    email_engagement_lastopenedtime: string;
    email_engagement_lastopenedtime_Value: Date;
    email_engagement_isemailfollowed: string;
    email_engagement_isemailfollowed_Value: boolean;
  }
}
