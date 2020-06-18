declare namespace Web {
  interface TeamMembership_Base extends WebEntity {
    systemuserid?: string | null;
    teamid?: string | null;
    teammembershipid?: string | null;
    versionnumber?: number | null;
  }
  interface TeamMembership_Relationships {
    teammembership_association?: SystemUser_Result[] | null;
  }
  interface TeamMembership extends TeamMembership_Base, TeamMembership_Relationships {
  }
  interface TeamMembership_Create extends TeamMembership {
  }
  interface TeamMembership_Update extends TeamMembership {
  }
  interface TeamMembership_Select {
    systemuserid: WebAttribute<TeamMembership_Select, { systemuserid: string | null }, {  }>;
    teamid: WebAttribute<TeamMembership_Select, { teamid: string | null }, {  }>;
    teammembershipid: WebAttribute<TeamMembership_Select, { teammembershipid: string | null }, {  }>;
    versionnumber: WebAttribute<TeamMembership_Select, { versionnumber: number | null }, {  }>;
  }
  interface TeamMembership_Filter {
    systemuserid: XQW.Guid;
    teamid: XQW.Guid;
    teammembershipid: XQW.Guid;
    versionnumber: number;
  }
  interface TeamMembership_Expand {
    teammembership_association: WebExpand<TeamMembership_Expand, SystemUser_Select, SystemUser_Filter, { teammembership_association: SystemUser_Result[] }>;
  }
  interface TeamMembership_FormattedResult {
  }
  interface TeamMembership_Result extends TeamMembership_Base, TeamMembership_Relationships {
    "@odata.etag": string;
  }
  interface TeamMembership_RelatedOne {
  }
  interface TeamMembership_RelatedMany {
    teammembership_association: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
  }
}
interface WebEntitiesRetrieve {
  teammemberships: WebMappingRetrieve<Web.TeamMembership_Select,Web.TeamMembership_Expand,Web.TeamMembership_Filter,Web.TeamMembership_Fixed,Web.TeamMembership_Result,Web.TeamMembership_FormattedResult>;
}
interface WebEntitiesRelated {
  teammemberships: WebMappingRelated<Web.TeamMembership_RelatedOne,Web.TeamMembership_RelatedMany>;
}
interface WebEntitiesCUDA {
  teammemberships: WebMappingCUDA<Web.TeamMembership_Create,Web.TeamMembership_Update,Web.TeamMembership_Select>;
}
