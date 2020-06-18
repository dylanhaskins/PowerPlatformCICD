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
  interface BusinessUnit_Base extends WebEntity {
  }
  interface BusinessUnit_Fixed extends WebEntity_Fixed {
    businessunitid: string;
  }
  interface BusinessUnit extends BusinessUnit_Base, BusinessUnit_Relationships {
  }
  interface BusinessUnit_Relationships {
  }
  interface BusinessUnit_Result extends BusinessUnit_Base, BusinessUnit_Relationships {
  }
  interface BusinessUnit_FormattedResult {
  }
  interface BusinessUnit_Select {
  }
  interface BusinessUnit_Expand {
  }
  interface BusinessUnit_Filter {
  }
  interface BusinessUnit_Create extends BusinessUnit {
  }
  interface BusinessUnit_Update extends BusinessUnit {
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
  interface Team_Base extends WebEntity {
  }
  interface Team_Fixed extends WebEntity_Fixed {
    teamid: string;
  }
  interface Team extends Team_Base, Team_Relationships {
  }
  interface Team_Relationships {
  }
  interface Team_Result extends Team_Base, Team_Relationships {
  }
  interface Team_FormattedResult {
  }
  interface Team_Select {
  }
  interface Team_Expand {
  }
  interface Team_Filter {
  }
  interface Team_Create extends Team {
  }
  interface Team_Update extends Team {
  }
  interface TeamMembership_Base extends WebEntity {
  }
  interface TeamMembership_Fixed extends WebEntity_Fixed {
    teammembershipid: string;
  }
  interface TeamMembership extends TeamMembership_Base, TeamMembership_Relationships {
  }
  interface TeamMembership_Relationships {
  }
  interface TeamMembership_Result extends TeamMembership_Base, TeamMembership_Relationships {
  }
  interface TeamMembership_FormattedResult {
  }
  interface TeamMembership_Select {
  }
  interface TeamMembership_Expand {
  }
  interface TeamMembership_Filter {
  }
  interface TeamMembership_Create extends TeamMembership {
  }
  interface TeamMembership_Update extends TeamMembership {
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
}
