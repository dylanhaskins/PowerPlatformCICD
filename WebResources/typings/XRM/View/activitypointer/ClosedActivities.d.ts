declare namespace Views.activitypointer {
  interface ClosedActivities {
    statuscode: string;
    statuscode_Value: SDK.OptionSet<activitypointer_statuscode>;
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
    actualend: string;
    actualend_Value: Date;
    activityid: string;
    activityid_Value: string;
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
