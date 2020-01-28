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
}
