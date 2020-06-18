declare namespace Web {
  interface Team_Base extends WebEntity {
    azureactivedirectoryobjectid?: string | null;
    createdon?: Date | null;
    description?: string | null;
    emailaddress?: string | null;
    exchangerate?: number | null;
    importsequencenumber?: number | null;
    isdefault?: boolean | null;
    modifiedon?: Date | null;
    name?: string | null;
    organizationid?: string | null;
    overriddencreatedon?: Date | null;
    processid?: string | null;
    stageid?: string | null;
    systemmanaged?: boolean | null;
    teamid?: string | null;
    teamtype?: team_type | null;
    traversedpath?: string | null;
    versionnumber?: number | null;
  }
  interface Team_Relationships {
    team_connections1?: Connection_Result[] | null;
    team_connections2?: Connection_Result[] | null;
    teammembership_association?: SystemUser_Result[] | null;
  }
  interface Team extends Team_Base, Team_Relationships {
    administratorid_bind$systemusers?: string | null;
    businessunitid_bind$businessunits?: string | null;
    queueid_bind$queues?: string | null;
    stageid_processstage_bind$processstages?: string | null;
    transactioncurrencyid_bind$transactioncurrencies?: string | null;
  }
  interface Team_Create extends Team {
    associatedteamtemplateid_bind$teamtemplates?: string | null;
    regardingobjectid_knowledgearticle_bind$knowledgearticles?: string | null;
  }
  interface Team_Update extends Team {
  }
  interface Team_Select {
    administratorid_guid: WebAttribute<Team_Select, { administratorid_guid: string | null }, { administratorid_formatted?: string }>;
    azureactivedirectoryobjectid: WebAttribute<Team_Select, { azureactivedirectoryobjectid: string | null }, {  }>;
    businessunitid_guid: WebAttribute<Team_Select, { businessunitid_guid: string | null }, { businessunitid_formatted?: string }>;
    createdby_guid: WebAttribute<Team_Select, { createdby_guid: string | null }, { createdby_formatted?: string }>;
    createdon: WebAttribute<Team_Select, { createdon: Date | null }, { createdon_formatted?: string }>;
    createdonbehalfby_guid: WebAttribute<Team_Select, { createdonbehalfby_guid: string | null }, { createdonbehalfby_formatted?: string }>;
    description: WebAttribute<Team_Select, { description: string | null }, {  }>;
    emailaddress: WebAttribute<Team_Select, { emailaddress: string | null }, {  }>;
    exchangerate: WebAttribute<Team_Select, { exchangerate: number | null }, {  }>;
    importsequencenumber: WebAttribute<Team_Select, { importsequencenumber: number | null }, {  }>;
    isdefault: WebAttribute<Team_Select, { isdefault: boolean | null }, {  }>;
    modifiedby_guid: WebAttribute<Team_Select, { modifiedby_guid: string | null }, { modifiedby_formatted?: string }>;
    modifiedon: WebAttribute<Team_Select, { modifiedon: Date | null }, { modifiedon_formatted?: string }>;
    modifiedonbehalfby_guid: WebAttribute<Team_Select, { modifiedonbehalfby_guid: string | null }, { modifiedonbehalfby_formatted?: string }>;
    name: WebAttribute<Team_Select, { name: string | null }, {  }>;
    organizationid: WebAttribute<Team_Select, { organizationid: string | null }, {  }>;
    overriddencreatedon: WebAttribute<Team_Select, { overriddencreatedon: Date | null }, { overriddencreatedon_formatted?: string }>;
    processid: WebAttribute<Team_Select, { processid: string | null }, {  }>;
    queueid_guid: WebAttribute<Team_Select, { queueid_guid: string | null }, { queueid_formatted?: string }>;
    regardingobjectid_guid: WebAttribute<Team_Select, { regardingobjectid_guid: string | null }, { regardingobjectid_formatted?: string }>;
    stageid: WebAttribute<Team_Select, { stageid: string | null }, {  }>;
    systemmanaged: WebAttribute<Team_Select, { systemmanaged: boolean | null }, {  }>;
    teamid: WebAttribute<Team_Select, { teamid: string | null }, {  }>;
    teamtemplateid_guid: WebAttribute<Team_Select, { teamtemplateid_guid: string | null }, { teamtemplateid_formatted?: string }>;
    teamtype: WebAttribute<Team_Select, { teamtype: team_type | null }, { teamtype_formatted?: string }>;
    transactioncurrencyid_guid: WebAttribute<Team_Select, { transactioncurrencyid_guid: string | null }, { transactioncurrencyid_formatted?: string }>;
    traversedpath: WebAttribute<Team_Select, { traversedpath: string | null }, {  }>;
    versionnumber: WebAttribute<Team_Select, { versionnumber: number | null }, {  }>;
  }
  interface Team_Filter {
    administratorid_guid: XQW.Guid;
    azureactivedirectoryobjectid: XQW.Guid;
    businessunitid_guid: XQW.Guid;
    createdby_guid: XQW.Guid;
    createdon: Date;
    createdonbehalfby_guid: XQW.Guid;
    description: string;
    emailaddress: string;
    exchangerate: any;
    importsequencenumber: number;
    isdefault: boolean;
    modifiedby_guid: XQW.Guid;
    modifiedon: Date;
    modifiedonbehalfby_guid: XQW.Guid;
    name: string;
    organizationid: XQW.Guid;
    overriddencreatedon: Date;
    processid: XQW.Guid;
    queueid_guid: XQW.Guid;
    regardingobjectid_guid: XQW.Guid;
    stageid: XQW.Guid;
    systemmanaged: boolean;
    teamid: XQW.Guid;
    teamtemplateid_guid: XQW.Guid;
    teamtype: team_type;
    transactioncurrencyid_guid: XQW.Guid;
    traversedpath: string;
    versionnumber: number;
  }
  interface Team_Expand {
    administratorid: WebExpand<Team_Expand, SystemUser_Select, SystemUser_Filter, { administratorid: SystemUser_Result }>;
    businessunitid: WebExpand<Team_Expand, BusinessUnit_Select, BusinessUnit_Filter, { businessunitid: BusinessUnit_Result }>;
    createdby: WebExpand<Team_Expand, SystemUser_Select, SystemUser_Filter, { createdby: SystemUser_Result }>;
    createdonbehalfby: WebExpand<Team_Expand, SystemUser_Select, SystemUser_Filter, { createdonbehalfby: SystemUser_Result }>;
    modifiedby: WebExpand<Team_Expand, SystemUser_Select, SystemUser_Filter, { modifiedby: SystemUser_Result }>;
    modifiedonbehalfby: WebExpand<Team_Expand, SystemUser_Select, SystemUser_Filter, { modifiedonbehalfby: SystemUser_Result }>;
    team_connections1: WebExpand<Team_Expand, Connection_Select, Connection_Filter, { team_connections1: Connection_Result[] }>;
    team_connections2: WebExpand<Team_Expand, Connection_Select, Connection_Filter, { team_connections2: Connection_Result[] }>;
    teammembership_association: WebExpand<Team_Expand, SystemUser_Select, SystemUser_Filter, { teammembership_association: SystemUser_Result[] }>;
  }
  interface Team_FormattedResult {
    administratorid_formatted?: string;
    businessunitid_formatted?: string;
    createdby_formatted?: string;
    createdon_formatted?: string;
    createdonbehalfby_formatted?: string;
    modifiedby_formatted?: string;
    modifiedon_formatted?: string;
    modifiedonbehalfby_formatted?: string;
    overriddencreatedon_formatted?: string;
    queueid_formatted?: string;
    regardingobjectid_formatted?: string;
    teamtemplateid_formatted?: string;
    teamtype_formatted?: string;
    transactioncurrencyid_formatted?: string;
  }
  interface Team_Result extends Team_Base, Team_Relationships {
    "@odata.etag": string;
    administratorid_guid: string | null;
    businessunitid_guid: string | null;
    createdby_guid: string | null;
    createdonbehalfby_guid: string | null;
    modifiedby_guid: string | null;
    modifiedonbehalfby_guid: string | null;
    queueid_guid: string | null;
    regardingobjectid_guid: string | null;
    teamtemplateid_guid: string | null;
    transactioncurrencyid_guid: string | null;
  }
  interface Team_RelatedOne {
    administratorid: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    businessunitid: WebMappingRetrieve<Web.BusinessUnit_Select,Web.BusinessUnit_Expand,Web.BusinessUnit_Filter,Web.BusinessUnit_Fixed,Web.BusinessUnit_Result,Web.BusinessUnit_FormattedResult>;
    createdby: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    createdonbehalfby: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    modifiedby: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    modifiedonbehalfby: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
  }
  interface Team_RelatedMany {
    team_connections1: WebMappingRetrieve<Web.Connection_Select,Web.Connection_Expand,Web.Connection_Filter,Web.Connection_Fixed,Web.Connection_Result,Web.Connection_FormattedResult>;
    team_connections2: WebMappingRetrieve<Web.Connection_Select,Web.Connection_Expand,Web.Connection_Filter,Web.Connection_Fixed,Web.Connection_Result,Web.Connection_FormattedResult>;
    teammembership_association: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
  }
}
interface WebEntitiesRetrieve {
  teams: WebMappingRetrieve<Web.Team_Select,Web.Team_Expand,Web.Team_Filter,Web.Team_Fixed,Web.Team_Result,Web.Team_FormattedResult>;
}
interface WebEntitiesRelated {
  teams: WebMappingRelated<Web.Team_RelatedOne,Web.Team_RelatedMany>;
}
interface WebEntitiesCUDA {
  teams: WebMappingCUDA<Web.Team_Create,Web.Team_Update,Web.Team_Select>;
}
