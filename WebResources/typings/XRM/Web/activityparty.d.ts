declare namespace Web {
  interface ActivityParty_Base extends WebEntity {
    activitypartyid?: string | null;
    addressused?: string | null;
    addressusedemailcolumnnumber?: number | null;
    donotemail?: boolean | null;
    donotfax?: boolean | null;
    donotphone?: boolean | null;
    donotpostalmail?: boolean | null;
    effort?: number | null;
    exchangeentryid?: string | null;
    instancetypecode?: activityparty_instancetypecode | null;
    ispartydeleted?: boolean | null;
    owningbusinessunit?: string | null;
    owninguser?: string | null;
    participationtypemask?: activityparty_participationtypemask | null;
    scheduledend?: Date | null;
    scheduledstart?: Date | null;
    versionnumber?: number | null;
  }
  interface ActivityParty_Relationships {
    activityid_activitypointer?: ActivityPointer_Result | null;
    activityid_email?: Email_Result | null;
    partyid_account?: Account_Result | null;
    partyid_contact?: Contact_Result | null;
    partyid_systemuser?: SystemUser_Result | null;
  }
  interface ActivityParty extends ActivityParty_Base, ActivityParty_Relationships {
    activityid_activitypointer_bind$activitypointers?: string | null;
    activityid_adx_alertsubscription_activityparty_bind$adx_alertsubscriptions?: string | null;
    activityid_adx_inviteredemption_activityparty_bind$adx_inviteredemptions?: string | null;
    activityid_adx_portalcomment_activityparty_bind$adx_portalcomments?: string | null;
    activityid_appointment_bind$appointments?: string | null;
    activityid_email_bind$emails?: string | null;
    activityid_fax_bind$faxes?: string | null;
    activityid_letter_bind$letters?: string | null;
    activityid_phonecall_bind$phonecalls?: string | null;
    activityid_recurringappointmentmaster_bind$recurringappointmentmasters?: string | null;
    activityid_socialactivity_bind$socialactivities?: string | null;
    activityid_task_bind$tasks?: string | null;
    partyid_account_bind$accounts?: string | null;
    partyid_contact_bind$contacts?: string | null;
    partyid_knowledgearticle_bind$knowledgearticles?: string | null;
    partyid_queue_bind$queues?: string | null;
    partyid_systemuser_bind$systemusers?: string | null;
  }
  interface ActivityParty_Create extends ActivityParty {
  }
  interface ActivityParty_Update extends ActivityParty {
  }
  interface ActivityParty_Select {
    activityid_guid: WebAttribute<ActivityParty_Select, { activityid_guid: string | null }, { activityid_formatted?: string }>;
    activitypartyid: WebAttribute<ActivityParty_Select, { activitypartyid: string | null }, {  }>;
    addressused: WebAttribute<ActivityParty_Select, { addressused: string | null }, {  }>;
    addressusedemailcolumnnumber: WebAttribute<ActivityParty_Select, { addressusedemailcolumnnumber: number | null }, {  }>;
    donotemail: WebAttribute<ActivityParty_Select, { donotemail: boolean | null }, {  }>;
    donotfax: WebAttribute<ActivityParty_Select, { donotfax: boolean | null }, {  }>;
    donotphone: WebAttribute<ActivityParty_Select, { donotphone: boolean | null }, {  }>;
    donotpostalmail: WebAttribute<ActivityParty_Select, { donotpostalmail: boolean | null }, {  }>;
    effort: WebAttribute<ActivityParty_Select, { effort: number | null }, {  }>;
    exchangeentryid: WebAttribute<ActivityParty_Select, { exchangeentryid: string | null }, {  }>;
    instancetypecode: WebAttribute<ActivityParty_Select, { instancetypecode: activityparty_instancetypecode | null }, { instancetypecode_formatted?: string }>;
    ispartydeleted: WebAttribute<ActivityParty_Select, { ispartydeleted: boolean | null }, {  }>;
    ownerid_guid: WebAttribute<ActivityParty_Select, { ownerid_guid: string | null }, { ownerid_formatted?: string }>;
    owningbusinessunit: WebAttribute<ActivityParty_Select, { owningbusinessunit: string | null }, {  }>;
    owninguser: WebAttribute<ActivityParty_Select, { owninguser: string | null }, {  }>;
    participationtypemask: WebAttribute<ActivityParty_Select, { participationtypemask: activityparty_participationtypemask | null }, { participationtypemask_formatted?: string }>;
    partyid_guid: WebAttribute<ActivityParty_Select, { partyid_guid: string | null }, { partyid_formatted?: string }>;
    scheduledend: WebAttribute<ActivityParty_Select, { scheduledend: Date | null }, { scheduledend_formatted?: string }>;
    scheduledstart: WebAttribute<ActivityParty_Select, { scheduledstart: Date | null }, { scheduledstart_formatted?: string }>;
    versionnumber: WebAttribute<ActivityParty_Select, { versionnumber: number | null }, {  }>;
  }
  interface ActivityParty_Filter {
    activityid_guid: XQW.Guid;
    activitypartyid: XQW.Guid;
    addressused: string;
    addressusedemailcolumnnumber: number;
    donotemail: boolean;
    donotfax: boolean;
    donotphone: boolean;
    donotpostalmail: boolean;
    effort: number;
    exchangeentryid: string;
    instancetypecode: activityparty_instancetypecode;
    ispartydeleted: boolean;
    ownerid_guid: XQW.Guid;
    owningbusinessunit: XQW.Guid;
    owninguser: XQW.Guid;
    participationtypemask: activityparty_participationtypemask;
    partyid_guid: XQW.Guid;
    scheduledend: Date;
    scheduledstart: Date;
    versionnumber: number;
  }
  interface ActivityParty_Expand {
    activityid_activitypointer: WebExpand<ActivityParty_Expand, ActivityPointer_Select, ActivityPointer_Filter, { activityid_activitypointer: ActivityPointer_Result }>;
    activityid_email: WebExpand<ActivityParty_Expand, Email_Select, Email_Filter, { activityid_email: Email_Result }>;
    partyid_account: WebExpand<ActivityParty_Expand, Account_Select, Account_Filter, { partyid_account: Account_Result }>;
    partyid_contact: WebExpand<ActivityParty_Expand, Contact_Select, Contact_Filter, { partyid_contact: Contact_Result }>;
    partyid_systemuser: WebExpand<ActivityParty_Expand, SystemUser_Select, SystemUser_Filter, { partyid_systemuser: SystemUser_Result }>;
  }
  interface ActivityParty_FormattedResult {
    activityid_formatted?: string;
    instancetypecode_formatted?: string;
    ownerid_formatted?: string;
    participationtypemask_formatted?: string;
    partyid_formatted?: string;
    scheduledend_formatted?: string;
    scheduledstart_formatted?: string;
  }
  interface ActivityParty_Result extends ActivityParty_Base, ActivityParty_Relationships {
    "@odata.etag": string;
    activityid_guid: string | null;
    ownerid_guid: string | null;
    partyid_guid: string | null;
  }
  interface ActivityParty_RelatedOne {
    activityid_activitypointer: WebMappingRetrieve<Web.ActivityPointer_Select,Web.ActivityPointer_Expand,Web.ActivityPointer_Filter,Web.ActivityPointer_Fixed,Web.ActivityPointer_Result,Web.ActivityPointer_FormattedResult>;
    activityid_email: WebMappingRetrieve<Web.Email_Select,Web.Email_Expand,Web.Email_Filter,Web.Email_Fixed,Web.Email_Result,Web.Email_FormattedResult>;
    partyid_account: WebMappingRetrieve<Web.Account_Select,Web.Account_Expand,Web.Account_Filter,Web.Account_Fixed,Web.Account_Result,Web.Account_FormattedResult>;
    partyid_contact: WebMappingRetrieve<Web.Contact_Select,Web.Contact_Expand,Web.Contact_Filter,Web.Contact_Fixed,Web.Contact_Result,Web.Contact_FormattedResult>;
    partyid_systemuser: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
  }
  interface ActivityParty_RelatedMany {
  }
}
interface WebEntitiesRetrieve {
  activityparties: WebMappingRetrieve<Web.ActivityParty_Select,Web.ActivityParty_Expand,Web.ActivityParty_Filter,Web.ActivityParty_Fixed,Web.ActivityParty_Result,Web.ActivityParty_FormattedResult>;
}
interface WebEntitiesRelated {
  activityparties: WebMappingRelated<Web.ActivityParty_RelatedOne,Web.ActivityParty_RelatedMany>;
}
interface WebEntitiesCUDA {
  activityparties: WebMappingCUDA<Web.ActivityParty_Create,Web.ActivityParty_Update,Web.ActivityParty_Select>;
}
