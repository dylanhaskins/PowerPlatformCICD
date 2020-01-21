interface WebMappingRetrieve<ISelect, IExpand, IFilter, IFixed, Result, FormattedResult> {
}
interface WebMappingCUDA<ICreate, IUpdate, ISelect> {
}
interface WebMappingRelated<ISingle, IMultiple> {
}
declare namespace Web {
  interface WebEntity {
  }
  interface WebEntity_Fixed {
    "@odata.etag": string;
  }
  interface Account_Base extends WebEntity {
  }
  interface Account_Fixed extends WebEntity_Fixed {
    accountid: string;
  }
  interface Account extends Account_Base, Account_Relationships {
  }
  interface Account_Relationships {
  }
  interface Account_Result extends Account_Base, Account_Relationships {
  }
  interface Account_FormattedResult {
  }
  interface Account_Select {
  }
  interface Account_Expand {
  }
  interface Account_Filter {
  }
  interface Account_Create extends Account {
  }
  interface Account_Update extends Account {
  }
  interface ActivityParty_Base extends WebEntity {
  }
  interface ActivityParty_Fixed extends WebEntity_Fixed {
    activitypartyid: string;
  }
  interface ActivityParty extends ActivityParty_Base, ActivityParty_Relationships {
  }
  interface ActivityParty_Relationships {
  }
  interface ActivityParty_Result extends ActivityParty_Base, ActivityParty_Relationships {
  }
  interface ActivityParty_FormattedResult {
  }
  interface ActivityParty_Select {
  }
  interface ActivityParty_Expand {
  }
  interface ActivityParty_Filter {
  }
  interface ActivityParty_Create extends ActivityParty {
  }
  interface ActivityParty_Update extends ActivityParty {
  }
  interface ActivityPointer_Base extends WebEntity {
  }
  interface ActivityPointer_Fixed extends WebEntity_Fixed {
    activityid: string;
  }
  interface ActivityPointer extends ActivityPointer_Base, ActivityPointer_Relationships {
  }
  interface ActivityPointer_Relationships {
  }
  interface ActivityPointer_Result extends ActivityPointer_Base, ActivityPointer_Relationships {
  }
  interface ActivityPointer_FormattedResult {
  }
  interface ActivityPointer_Select {
  }
  interface ActivityPointer_Expand {
  }
  interface ActivityPointer_Filter {
  }
  interface ActivityPointer_Create extends ActivityPointer {
  }
  interface ActivityPointer_Update extends ActivityPointer {
  }
  interface Contact_Base extends WebEntity {
  }
  interface Contact_Fixed extends WebEntity_Fixed {
    contactid: string;
  }
  interface Contact extends Contact_Base, Contact_Relationships {
  }
  interface Contact_Relationships {
  }
  interface Contact_Result extends Contact_Base, Contact_Relationships {
  }
  interface Contact_FormattedResult {
  }
  interface Contact_Select {
  }
  interface Contact_Expand {
  }
  interface Contact_Filter {
  }
  interface Contact_Create extends Contact {
  }
  interface Contact_Update extends Contact {
  }
  interface devops_EntityA_Base extends WebEntity {
  }
  interface devops_EntityA_Fixed extends WebEntity_Fixed {
    devops_entityaid: string;
  }
  interface devops_EntityA extends devops_EntityA_Base, devops_EntityA_Relationships {
  }
  interface devops_EntityA_Relationships {
  }
  interface devops_EntityA_Result extends devops_EntityA_Base, devops_EntityA_Relationships {
  }
  interface devops_EntityA_FormattedResult {
  }
  interface devops_EntityA_Select {
  }
  interface devops_EntityA_Expand {
  }
  interface devops_EntityA_Filter {
  }
  interface devops_EntityA_Create extends devops_EntityA {
  }
  interface devops_EntityA_Update extends devops_EntityA {
  }
  interface devops_EntityB_Base extends WebEntity {
  }
  interface devops_EntityB_Fixed extends WebEntity_Fixed {
    devops_entitybid: string;
  }
  interface devops_EntityB extends devops_EntityB_Base, devops_EntityB_Relationships {
  }
  interface devops_EntityB_Relationships {
  }
  interface devops_EntityB_Result extends devops_EntityB_Base, devops_EntityB_Relationships {
  }
  interface devops_EntityB_FormattedResult {
  }
  interface devops_EntityB_Select {
  }
  interface devops_EntityB_Expand {
  }
  interface devops_EntityB_Filter {
  }
  interface devops_EntityB_Create extends devops_EntityB {
  }
  interface devops_EntityB_Update extends devops_EntityB {
  }
  interface SystemUser_Base extends WebEntity {
  }
  interface SystemUser_Fixed extends WebEntity_Fixed {
    systemuserid: string;
  }
  interface SystemUser extends SystemUser_Base, SystemUser_Relationships {
  }
  interface SystemUser_Relationships {
  }
  interface SystemUser_Result extends SystemUser_Base, SystemUser_Relationships {
  }
  interface SystemUser_FormattedResult {
  }
  interface SystemUser_Select {
  }
  interface SystemUser_Expand {
  }
  interface SystemUser_Filter {
  }
  interface SystemUser_Create extends SystemUser {
  }
  interface SystemUser_Update extends SystemUser {
  }
  interface Connection_Base extends WebEntity {
  }
  interface Connection_Fixed extends WebEntity_Fixed {
    connectionid: string;
  }
  interface Connection extends Connection_Base, Connection_Relationships {
  }
  interface Connection_Relationships {
  }
  interface Connection_Result extends Connection_Base, Connection_Relationships {
  }
  interface Connection_FormattedResult {
  }
  interface Connection_Select {
  }
  interface Connection_Expand {
  }
  interface Connection_Filter {
  }
  interface Connection_Create extends Connection {
  }
  interface Connection_Update extends Connection {
  }
  interface Email_Base extends WebEntity {
  }
  interface Email_Fixed extends WebEntity_Fixed {
    activityid: string;
  }
  interface Email extends Email_Base, Email_Relationships {
  }
  interface Email_Relationships {
  }
  interface Email_Result extends Email_Base, Email_Relationships {
  }
  interface Email_FormattedResult {
  }
  interface Email_Select {
  }
  interface Email_Expand {
  }
  interface Email_Filter {
  }
  interface Email_Create extends Email {
  }
  interface Email_Update extends Email {
  }
}
