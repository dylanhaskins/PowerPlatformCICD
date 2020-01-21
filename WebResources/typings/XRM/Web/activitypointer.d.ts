declare namespace Web {
  interface ActivityPointer_Base extends WebEntity {
    activityadditionalparams?: string | null;
    activityid?: string | null;
    activitytypecode?: string | null;
    actualdurationminutes?: number | null;
    actualend?: Date | null;
    actualstart?: Date | null;
    community?: socialprofile_community | null;
    createdon?: Date | null;
    deliverylastattemptedon?: Date | null;
    deliveryprioritycode?: activitypointer_deliveryprioritycode | null;
    description?: string | null;
    exchangeitemid?: string | null;
    exchangerate?: number | null;
    exchangeweblink?: string | null;
    instancetypecode?: activitypointer_instancetypecode | null;
    isbilled?: boolean | null;
    ismapiprivate?: boolean | null;
    isregularactivity?: boolean | null;
    isworkflowcreated?: boolean | null;
    lastonholdtime?: Date | null;
    leftvoicemail?: boolean | null;
    modifiedon?: Date | null;
    onholdtime?: number | null;
    postponeactivityprocessinguntil?: Date | null;
    prioritycode?: activitypointer_prioritycode | null;
    processid?: string | null;
    scheduleddurationminutes?: number | null;
    scheduledend?: Date | null;
    scheduledstart?: Date | null;
    senton?: Date | null;
    seriesid?: string | null;
    sortdate?: Date | null;
    stageid?: string | null;
    statecode?: activitypointer_statecode | null;
    statuscode?: activitypointer_statuscode | null;
    subject?: string | null;
    timezoneruleversionnumber?: number | null;
    traversedpath?: string | null;
    utcconversiontimezonecode?: number | null;
    versionnumber?: number | null;
  }
  interface ActivityPointer_Relationships {
    activity_pointer_email?: Email_Result[] | null;
    activitypointer_activity_parties?: ActivityParty_Result[] | null;
    activitypointer_connections1?: Connection_Result[] | null;
    activitypointer_connections2?: Connection_Result[] | null;
    regardingobjectid_account?: Account_Result | null;
    regardingobjectid_contact?: Contact_Result | null;
  }
  interface ActivityPointer extends ActivityPointer_Base, ActivityPointer_Relationships {
    regardingobjectid_account_bind$accounts?: string | null;
    regardingobjectid_adx_ad_bind$adx_ads?: string | null;
    regardingobjectid_adx_adplacement_bind$adx_adplacements?: string | null;
    regardingobjectid_adx_invitation_bind$adx_invitations?: string | null;
    regardingobjectid_adx_poll_bind$adx_polls?: string | null;
    regardingobjectid_adx_polloption_bind$adx_polloptions?: string | null;
    regardingobjectid_adx_pollplacement_bind$adx_pollplacements?: string | null;
    regardingobjectid_adx_pollsubmission_bind$adx_pollsubmissions?: string | null;
    regardingobjectid_adx_publishingstatetransitionrule_bind$adx_publishingstatetransitionrules?: string | null;
    regardingobjectid_adx_redirect_bind$adx_redirects?: string | null;
    regardingobjectid_adx_shortcut_bind$adx_shortcuts?: string | null;
    regardingobjectid_adx_webpage_bind$adx_webpages?: string | null;
    regardingobjectid_adx_website_bind$adx_websites?: string | null;
    regardingobjectid_contact_bind$contacts?: string | null;
    regardingobjectid_knowledgearticle_bind$knowledgearticles?: string | null;
    regardingobjectid_knowledgebaserecord_bind$knowledgebaserecords?: string | null;
    regardingobjectid_new_interactionforemail_bind$interactionforemails?: string | null;
    sla_activitypointer_sla_bind$slas?: string | null;
    transactioncurrencyid_bind$transactioncurrencies?: string | null;
  }
  interface ActivityPointer_Create extends ActivityPointer {
    ownerid_bind$systemusers?: string | null;
    ownerid_bind$teams?: string | null;
  }
  interface ActivityPointer_Update extends ActivityPointer {
  }
  interface ActivityPointer_Select {
    activityadditionalparams: WebAttribute<ActivityPointer_Select, { activityadditionalparams: string | null }, {  }>;
    activityid: WebAttribute<ActivityPointer_Select, { activityid: string | null }, {  }>;
    activitytypecode: WebAttribute<ActivityPointer_Select, { activitytypecode: string | null }, {  }>;
    actualdurationminutes: WebAttribute<ActivityPointer_Select, { actualdurationminutes: number | null }, {  }>;
    actualend: WebAttribute<ActivityPointer_Select, { actualend: Date | null }, { actualend_formatted?: string }>;
    actualstart: WebAttribute<ActivityPointer_Select, { actualstart: Date | null }, { actualstart_formatted?: string }>;
    allparties_guid: WebAttribute<ActivityPointer_Select, { allparties_guid: string | null }, { allparties_formatted?: string }>;
    community: WebAttribute<ActivityPointer_Select, { community: socialprofile_community | null }, { community_formatted?: string }>;
    createdby_guid: WebAttribute<ActivityPointer_Select, { createdby_guid: string | null }, { createdby_formatted?: string }>;
    createdon: WebAttribute<ActivityPointer_Select, { createdon: Date | null }, { createdon_formatted?: string }>;
    createdonbehalfby_guid: WebAttribute<ActivityPointer_Select, { createdonbehalfby_guid: string | null }, { createdonbehalfby_formatted?: string }>;
    deliverylastattemptedon: WebAttribute<ActivityPointer_Select, { deliverylastattemptedon: Date | null }, { deliverylastattemptedon_formatted?: string }>;
    deliveryprioritycode: WebAttribute<ActivityPointer_Select, { deliveryprioritycode: activitypointer_deliveryprioritycode | null }, { deliveryprioritycode_formatted?: string }>;
    description: WebAttribute<ActivityPointer_Select, { description: string | null }, {  }>;
    exchangeitemid: WebAttribute<ActivityPointer_Select, { exchangeitemid: string | null }, {  }>;
    exchangerate: WebAttribute<ActivityPointer_Select, { exchangerate: number | null }, {  }>;
    exchangeweblink: WebAttribute<ActivityPointer_Select, { exchangeweblink: string | null }, {  }>;
    instancetypecode: WebAttribute<ActivityPointer_Select, { instancetypecode: activitypointer_instancetypecode | null }, { instancetypecode_formatted?: string }>;
    isbilled: WebAttribute<ActivityPointer_Select, { isbilled: boolean | null }, {  }>;
    ismapiprivate: WebAttribute<ActivityPointer_Select, { ismapiprivate: boolean | null }, {  }>;
    isregularactivity: WebAttribute<ActivityPointer_Select, { isregularactivity: boolean | null }, {  }>;
    isworkflowcreated: WebAttribute<ActivityPointer_Select, { isworkflowcreated: boolean | null }, {  }>;
    lastonholdtime: WebAttribute<ActivityPointer_Select, { lastonholdtime: Date | null }, { lastonholdtime_formatted?: string }>;
    leftvoicemail: WebAttribute<ActivityPointer_Select, { leftvoicemail: boolean | null }, {  }>;
    modifiedby_guid: WebAttribute<ActivityPointer_Select, { modifiedby_guid: string | null }, { modifiedby_formatted?: string }>;
    modifiedon: WebAttribute<ActivityPointer_Select, { modifiedon: Date | null }, { modifiedon_formatted?: string }>;
    modifiedonbehalfby_guid: WebAttribute<ActivityPointer_Select, { modifiedonbehalfby_guid: string | null }, { modifiedonbehalfby_formatted?: string }>;
    onholdtime: WebAttribute<ActivityPointer_Select, { onholdtime: number | null }, {  }>;
    ownerid_guid: WebAttribute<ActivityPointer_Select, { ownerid_guid: string | null }, { ownerid_formatted?: string }>;
    owningbusinessunit_guid: WebAttribute<ActivityPointer_Select, { owningbusinessunit_guid: string | null }, { owningbusinessunit_formatted?: string }>;
    owningteam_guid: WebAttribute<ActivityPointer_Select, { owningteam_guid: string | null }, { owningteam_formatted?: string }>;
    owninguser_guid: WebAttribute<ActivityPointer_Select, { owninguser_guid: string | null }, { owninguser_formatted?: string }>;
    postponeactivityprocessinguntil: WebAttribute<ActivityPointer_Select, { postponeactivityprocessinguntil: Date | null }, { postponeactivityprocessinguntil_formatted?: string }>;
    prioritycode: WebAttribute<ActivityPointer_Select, { prioritycode: activitypointer_prioritycode | null }, { prioritycode_formatted?: string }>;
    processid: WebAttribute<ActivityPointer_Select, { processid: string | null }, {  }>;
    regardingobjectid_guid: WebAttribute<ActivityPointer_Select, { regardingobjectid_guid: string | null }, { regardingobjectid_formatted?: string }>;
    scheduleddurationminutes: WebAttribute<ActivityPointer_Select, { scheduleddurationminutes: number | null }, {  }>;
    scheduledend: WebAttribute<ActivityPointer_Select, { scheduledend: Date | null }, { scheduledend_formatted?: string }>;
    scheduledstart: WebAttribute<ActivityPointer_Select, { scheduledstart: Date | null }, { scheduledstart_formatted?: string }>;
    sendermailboxid_guid: WebAttribute<ActivityPointer_Select, { sendermailboxid_guid: string | null }, { sendermailboxid_formatted?: string }>;
    senton: WebAttribute<ActivityPointer_Select, { senton: Date | null }, { senton_formatted?: string }>;
    seriesid: WebAttribute<ActivityPointer_Select, { seriesid: string | null }, {  }>;
    slaid_guid: WebAttribute<ActivityPointer_Select, { slaid_guid: string | null }, { slaid_formatted?: string }>;
    slainvokedid_guid: WebAttribute<ActivityPointer_Select, { slainvokedid_guid: string | null }, { slainvokedid_formatted?: string }>;
    sortdate: WebAttribute<ActivityPointer_Select, { sortdate: Date | null }, { sortdate_formatted?: string }>;
    stageid: WebAttribute<ActivityPointer_Select, { stageid: string | null }, {  }>;
    statecode: WebAttribute<ActivityPointer_Select, { statecode: activitypointer_statecode | null }, { statecode_formatted?: string }>;
    statuscode: WebAttribute<ActivityPointer_Select, { statuscode: activitypointer_statuscode | null }, { statuscode_formatted?: string }>;
    subject: WebAttribute<ActivityPointer_Select, { subject: string | null }, {  }>;
    timezoneruleversionnumber: WebAttribute<ActivityPointer_Select, { timezoneruleversionnumber: number | null }, {  }>;
    transactioncurrencyid_guid: WebAttribute<ActivityPointer_Select, { transactioncurrencyid_guid: string | null }, { transactioncurrencyid_formatted?: string }>;
    traversedpath: WebAttribute<ActivityPointer_Select, { traversedpath: string | null }, {  }>;
    utcconversiontimezonecode: WebAttribute<ActivityPointer_Select, { utcconversiontimezonecode: number | null }, {  }>;
    versionnumber: WebAttribute<ActivityPointer_Select, { versionnumber: number | null }, {  }>;
  }
  interface ActivityPointer_Filter {
    activityadditionalparams: string;
    activityid: XQW.Guid;
    activitytypecode: string;
    actualdurationminutes: number;
    actualend: Date;
    actualstart: Date;
    allparties_guid: XQW.Guid;
    community: socialprofile_community;
    createdby_guid: XQW.Guid;
    createdon: Date;
    createdonbehalfby_guid: XQW.Guid;
    deliverylastattemptedon: Date;
    deliveryprioritycode: activitypointer_deliveryprioritycode;
    description: string;
    exchangeitemid: string;
    exchangerate: any;
    exchangeweblink: string;
    instancetypecode: activitypointer_instancetypecode;
    isbilled: boolean;
    ismapiprivate: boolean;
    isregularactivity: boolean;
    isworkflowcreated: boolean;
    lastonholdtime: Date;
    leftvoicemail: boolean;
    modifiedby_guid: XQW.Guid;
    modifiedon: Date;
    modifiedonbehalfby_guid: XQW.Guid;
    onholdtime: number;
    ownerid_guid: XQW.Guid;
    owningbusinessunit_guid: XQW.Guid;
    owningteam_guid: XQW.Guid;
    owninguser_guid: XQW.Guid;
    postponeactivityprocessinguntil: Date;
    prioritycode: activitypointer_prioritycode;
    processid: XQW.Guid;
    regardingobjectid_guid: XQW.Guid;
    scheduleddurationminutes: number;
    scheduledend: Date;
    scheduledstart: Date;
    sendermailboxid_guid: XQW.Guid;
    senton: Date;
    seriesid: XQW.Guid;
    slaid_guid: XQW.Guid;
    slainvokedid_guid: XQW.Guid;
    sortdate: Date;
    stageid: XQW.Guid;
    statecode: activitypointer_statecode;
    statuscode: activitypointer_statuscode;
    subject: string;
    timezoneruleversionnumber: number;
    transactioncurrencyid_guid: XQW.Guid;
    traversedpath: string;
    utcconversiontimezonecode: number;
    versionnumber: number;
  }
  interface ActivityPointer_Expand {
    activity_pointer_email: WebExpand<ActivityPointer_Expand, Email_Select, Email_Filter, { activity_pointer_email: Email_Result[] }>;
    activitypointer_activity_parties: WebExpand<ActivityPointer_Expand, ActivityParty_Select, ActivityParty_Filter, { activitypointer_activity_parties: ActivityParty_Result[] }>;
    activitypointer_connections1: WebExpand<ActivityPointer_Expand, Connection_Select, Connection_Filter, { activitypointer_connections1: Connection_Result[] }>;
    activitypointer_connections2: WebExpand<ActivityPointer_Expand, Connection_Select, Connection_Filter, { activitypointer_connections2: Connection_Result[] }>;
    createdby: WebExpand<ActivityPointer_Expand, SystemUser_Select, SystemUser_Filter, { createdby: SystemUser_Result }>;
    createdonbehalfby: WebExpand<ActivityPointer_Expand, SystemUser_Select, SystemUser_Filter, { createdonbehalfby: SystemUser_Result }>;
    modifiedby: WebExpand<ActivityPointer_Expand, SystemUser_Select, SystemUser_Filter, { modifiedby: SystemUser_Result }>;
    modifiedonbehalfby: WebExpand<ActivityPointer_Expand, SystemUser_Select, SystemUser_Filter, { modifiedonbehalfby: SystemUser_Result }>;
    ownerid: WebExpand<ActivityPointer_Expand, SystemUser_Select, SystemUser_Filter, { ownerid: SystemUser_Result }>;
    owninguser: WebExpand<ActivityPointer_Expand, SystemUser_Select, SystemUser_Filter, { owninguser: SystemUser_Result }>;
    regardingobjectid_account: WebExpand<ActivityPointer_Expand, Account_Select, Account_Filter, { regardingobjectid_account: Account_Result }>;
    regardingobjectid_contact: WebExpand<ActivityPointer_Expand, Contact_Select, Contact_Filter, { regardingobjectid_contact: Contact_Result }>;
  }
  interface ActivityPointer_FormattedResult {
    actualend_formatted?: string;
    actualstart_formatted?: string;
    allparties_formatted?: string;
    community_formatted?: string;
    createdby_formatted?: string;
    createdon_formatted?: string;
    createdonbehalfby_formatted?: string;
    deliverylastattemptedon_formatted?: string;
    deliveryprioritycode_formatted?: string;
    instancetypecode_formatted?: string;
    lastonholdtime_formatted?: string;
    modifiedby_formatted?: string;
    modifiedon_formatted?: string;
    modifiedonbehalfby_formatted?: string;
    ownerid_formatted?: string;
    owningbusinessunit_formatted?: string;
    owningteam_formatted?: string;
    owninguser_formatted?: string;
    postponeactivityprocessinguntil_formatted?: string;
    prioritycode_formatted?: string;
    regardingobjectid_formatted?: string;
    scheduledend_formatted?: string;
    scheduledstart_formatted?: string;
    sendermailboxid_formatted?: string;
    senton_formatted?: string;
    slaid_formatted?: string;
    slainvokedid_formatted?: string;
    sortdate_formatted?: string;
    statecode_formatted?: string;
    statuscode_formatted?: string;
    transactioncurrencyid_formatted?: string;
  }
  interface ActivityPointer_Result extends ActivityPointer_Base, ActivityPointer_Relationships {
    "@odata.etag": string;
    allparties_guid: string | null;
    createdby_guid: string | null;
    createdonbehalfby_guid: string | null;
    modifiedby_guid: string | null;
    modifiedonbehalfby_guid: string | null;
    ownerid_guid: string | null;
    owningbusinessunit_guid: string | null;
    owningteam_guid: string | null;
    owninguser_guid: string | null;
    regardingobjectid_guid: string | null;
    sendermailboxid_guid: string | null;
    slaid_guid: string | null;
    slainvokedid_guid: string | null;
    transactioncurrencyid_guid: string | null;
  }
  interface ActivityPointer_RelatedOne {
    createdby: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    createdonbehalfby: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    modifiedby: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    modifiedonbehalfby: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    ownerid: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    owninguser: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    regardingobjectid_account: WebMappingRetrieve<Web.Account_Select,Web.Account_Expand,Web.Account_Filter,Web.Account_Fixed,Web.Account_Result,Web.Account_FormattedResult>;
    regardingobjectid_contact: WebMappingRetrieve<Web.Contact_Select,Web.Contact_Expand,Web.Contact_Filter,Web.Contact_Fixed,Web.Contact_Result,Web.Contact_FormattedResult>;
  }
  interface ActivityPointer_RelatedMany {
    activity_pointer_email: WebMappingRetrieve<Web.Email_Select,Web.Email_Expand,Web.Email_Filter,Web.Email_Fixed,Web.Email_Result,Web.Email_FormattedResult>;
    activitypointer_activity_parties: WebMappingRetrieve<Web.ActivityParty_Select,Web.ActivityParty_Expand,Web.ActivityParty_Filter,Web.ActivityParty_Fixed,Web.ActivityParty_Result,Web.ActivityParty_FormattedResult>;
    activitypointer_connections1: WebMappingRetrieve<Web.Connection_Select,Web.Connection_Expand,Web.Connection_Filter,Web.Connection_Fixed,Web.Connection_Result,Web.Connection_FormattedResult>;
    activitypointer_connections2: WebMappingRetrieve<Web.Connection_Select,Web.Connection_Expand,Web.Connection_Filter,Web.Connection_Fixed,Web.Connection_Result,Web.Connection_FormattedResult>;
  }
}
interface WebEntitiesRetrieve {
  activitypointers: WebMappingRetrieve<Web.ActivityPointer_Select,Web.ActivityPointer_Expand,Web.ActivityPointer_Filter,Web.ActivityPointer_Fixed,Web.ActivityPointer_Result,Web.ActivityPointer_FormattedResult>;
}
interface WebEntitiesRelated {
  activitypointers: WebMappingRelated<Web.ActivityPointer_RelatedOne,Web.ActivityPointer_RelatedMany>;
}
interface WebEntitiesCUDA {
  activitypointers: WebMappingCUDA<Web.ActivityPointer_Create,Web.ActivityPointer_Update,Web.ActivityPointer_Select>;
}
