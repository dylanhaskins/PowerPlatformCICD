declare namespace Web {
  interface devops_EntityA_Base extends WebEntity {
    createdon?: Date | null;
    devops_entityaid?: string | null;
    devops_name?: string | null;
    importsequencenumber?: number | null;
    modifiedon?: Date | null;
    overriddencreatedon?: Date | null;
    statecode?: devops_entitya_statecode | null;
    statuscode?: devops_entitya_statuscode | null;
    timezoneruleversionnumber?: number | null;
    utcconversiontimezonecode?: number | null;
    versionnumber?: number | null;
  }
  interface devops_EntityA_Relationships {
  }
  interface devops_EntityA extends devops_EntityA_Base, devops_EntityA_Relationships {
    ownerid_bind$systemusers?: string | null;
    ownerid_bind$teams?: string | null;
  }
  interface devops_EntityA_Create extends devops_EntityA {
  }
  interface devops_EntityA_Update extends devops_EntityA {
  }
  interface devops_EntityA_Select {
    createdby_guid: WebAttribute<devops_EntityA_Select, { createdby_guid: string | null }, { createdby_formatted?: string }>;
    createdon: WebAttribute<devops_EntityA_Select, { createdon: Date | null }, { createdon_formatted?: string }>;
    createdonbehalfby_guid: WebAttribute<devops_EntityA_Select, { createdonbehalfby_guid: string | null }, { createdonbehalfby_formatted?: string }>;
    devops_entityaid: WebAttribute<devops_EntityA_Select, { devops_entityaid: string | null }, {  }>;
    devops_name: WebAttribute<devops_EntityA_Select, { devops_name: string | null }, {  }>;
    importsequencenumber: WebAttribute<devops_EntityA_Select, { importsequencenumber: number | null }, {  }>;
    modifiedby_guid: WebAttribute<devops_EntityA_Select, { modifiedby_guid: string | null }, { modifiedby_formatted?: string }>;
    modifiedon: WebAttribute<devops_EntityA_Select, { modifiedon: Date | null }, { modifiedon_formatted?: string }>;
    modifiedonbehalfby_guid: WebAttribute<devops_EntityA_Select, { modifiedonbehalfby_guid: string | null }, { modifiedonbehalfby_formatted?: string }>;
    overriddencreatedon: WebAttribute<devops_EntityA_Select, { overriddencreatedon: Date | null }, { overriddencreatedon_formatted?: string }>;
    ownerid_guid: WebAttribute<devops_EntityA_Select, { ownerid_guid: string | null }, { ownerid_formatted?: string }>;
    owningbusinessunit_guid: WebAttribute<devops_EntityA_Select, { owningbusinessunit_guid: string | null }, { owningbusinessunit_formatted?: string }>;
    owningteam_guid: WebAttribute<devops_EntityA_Select, { owningteam_guid: string | null }, { owningteam_formatted?: string }>;
    owninguser_guid: WebAttribute<devops_EntityA_Select, { owninguser_guid: string | null }, { owninguser_formatted?: string }>;
    statecode: WebAttribute<devops_EntityA_Select, { statecode: devops_entitya_statecode | null }, { statecode_formatted?: string }>;
    statuscode: WebAttribute<devops_EntityA_Select, { statuscode: devops_entitya_statuscode | null }, { statuscode_formatted?: string }>;
    timezoneruleversionnumber: WebAttribute<devops_EntityA_Select, { timezoneruleversionnumber: number | null }, {  }>;
    utcconversiontimezonecode: WebAttribute<devops_EntityA_Select, { utcconversiontimezonecode: number | null }, {  }>;
    versionnumber: WebAttribute<devops_EntityA_Select, { versionnumber: number | null }, {  }>;
  }
  interface devops_EntityA_Filter {
    createdby_guid: XQW.Guid;
    createdon: Date;
    createdonbehalfby_guid: XQW.Guid;
    devops_entityaid: XQW.Guid;
    devops_name: string;
    importsequencenumber: number;
    modifiedby_guid: XQW.Guid;
    modifiedon: Date;
    modifiedonbehalfby_guid: XQW.Guid;
    overriddencreatedon: Date;
    ownerid_guid: XQW.Guid;
    owningbusinessunit_guid: XQW.Guid;
    owningteam_guid: XQW.Guid;
    owninguser_guid: XQW.Guid;
    statecode: devops_entitya_statecode;
    statuscode: devops_entitya_statuscode;
    timezoneruleversionnumber: number;
    utcconversiontimezonecode: number;
    versionnumber: number;
  }
  interface devops_EntityA_Expand {
    createdby: WebExpand<devops_EntityA_Expand, SystemUser_Select, SystemUser_Filter, { createdby: SystemUser_Result }>;
    createdonbehalfby: WebExpand<devops_EntityA_Expand, SystemUser_Select, SystemUser_Filter, { createdonbehalfby: SystemUser_Result }>;
    modifiedby: WebExpand<devops_EntityA_Expand, SystemUser_Select, SystemUser_Filter, { modifiedby: SystemUser_Result }>;
    modifiedonbehalfby: WebExpand<devops_EntityA_Expand, SystemUser_Select, SystemUser_Filter, { modifiedonbehalfby: SystemUser_Result }>;
    ownerid: WebExpand<devops_EntityA_Expand, SystemUser_Select, SystemUser_Filter, { ownerid: SystemUser_Result }>;
    owninguser: WebExpand<devops_EntityA_Expand, SystemUser_Select, SystemUser_Filter, { owninguser: SystemUser_Result }>;
  }
  interface devops_EntityA_FormattedResult {
    createdby_formatted?: string;
    createdon_formatted?: string;
    createdonbehalfby_formatted?: string;
    modifiedby_formatted?: string;
    modifiedon_formatted?: string;
    modifiedonbehalfby_formatted?: string;
    overriddencreatedon_formatted?: string;
    ownerid_formatted?: string;
    owningbusinessunit_formatted?: string;
    owningteam_formatted?: string;
    owninguser_formatted?: string;
    statecode_formatted?: string;
    statuscode_formatted?: string;
  }
  interface devops_EntityA_Result extends devops_EntityA_Base, devops_EntityA_Relationships {
    "@odata.etag": string;
    createdby_guid: string | null;
    createdonbehalfby_guid: string | null;
    modifiedby_guid: string | null;
    modifiedonbehalfby_guid: string | null;
    ownerid_guid: string | null;
    owningbusinessunit_guid: string | null;
    owningteam_guid: string | null;
    owninguser_guid: string | null;
  }
  interface devops_EntityA_RelatedOne {
    createdby: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    createdonbehalfby: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    modifiedby: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    modifiedonbehalfby: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    ownerid: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    owninguser: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
  }
  interface devops_EntityA_RelatedMany {
  }
}
interface WebEntitiesRetrieve {
  devops_entityas: WebMappingRetrieve<Web.devops_EntityA_Select,Web.devops_EntityA_Expand,Web.devops_EntityA_Filter,Web.devops_EntityA_Fixed,Web.devops_EntityA_Result,Web.devops_EntityA_FormattedResult>;
}
interface WebEntitiesRelated {
  devops_entityas: WebMappingRelated<Web.devops_EntityA_RelatedOne,Web.devops_EntityA_RelatedMany>;
}
interface WebEntitiesCUDA {
  devops_entityas: WebMappingCUDA<Web.devops_EntityA_Create,Web.devops_EntityA_Update,Web.devops_EntityA_Select>;
}
