declare namespace Web {
  interface BusinessUnit_Base extends WebEntity {
    address1_addressid?: string | null;
    address1_addresstypecode?: businessunit_address1_addresstypecode | null;
    address1_city?: string | null;
    address1_country?: string | null;
    address1_county?: string | null;
    address1_fax?: string | null;
    address1_latitude?: number | null;
    address1_line1?: string | null;
    address1_line2?: string | null;
    address1_line3?: string | null;
    address1_longitude?: number | null;
    address1_name?: string | null;
    address1_postalcode?: string | null;
    address1_postofficebox?: string | null;
    address1_shippingmethodcode?: businessunit_address1_shippingmethodcode | null;
    address1_stateorprovince?: string | null;
    address1_telephone1?: string | null;
    address1_telephone2?: string | null;
    address1_telephone3?: string | null;
    address1_upszone?: string | null;
    address1_utcoffset?: number | null;
    address2_addressid?: string | null;
    address2_addresstypecode?: businessunit_address2_addresstypecode | null;
    address2_city?: string | null;
    address2_country?: string | null;
    address2_county?: string | null;
    address2_fax?: string | null;
    address2_latitude?: number | null;
    address2_line1?: string | null;
    address2_line2?: string | null;
    address2_line3?: string | null;
    address2_longitude?: number | null;
    address2_name?: string | null;
    address2_postalcode?: string | null;
    address2_postofficebox?: string | null;
    address2_shippingmethodcode?: businessunit_address2_shippingmethodcode | null;
    address2_stateorprovince?: string | null;
    address2_telephone1?: string | null;
    address2_telephone2?: string | null;
    address2_telephone3?: string | null;
    address2_upszone?: string | null;
    address2_utcoffset?: number | null;
    businessunitid?: string | null;
    costcenter?: string | null;
    createdon?: Date | null;
    creditlimit?: number | null;
    description?: string | null;
    disabledreason?: string | null;
    divisionname?: string | null;
    emailaddress?: string | null;
    exchangerate?: number | null;
    fileasname?: string | null;
    ftpsiteurl?: string | null;
    importsequencenumber?: number | null;
    inheritancemask?: number | null;
    isdisabled?: boolean | null;
    modifiedon?: Date | null;
    name?: string | null;
    overriddencreatedon?: Date | null;
    picture?: string | null;
    stockexchange?: string | null;
    tickersymbol?: string | null;
    usergroupid?: string | null;
    utcoffset?: number | null;
    versionnumber?: number | null;
    websiteurl?: string | null;
    workflowsuspended?: boolean | null;
  }
  interface BusinessUnit_Relationships {
    business_unit_connections?: Connection_Result[] | null;
    business_unit_parent_business_unit?: BusinessUnit_Result[] | null;
    business_unit_system_users?: SystemUser_Result[] | null;
    business_unit_teams?: Team_Result[] | null;
  }
  interface BusinessUnit extends BusinessUnit_Base, BusinessUnit_Relationships {
    calendarid_bind$calendars?: string | null;
    parentbusinessunitid_bind$businessunits?: string | null;
    transactioncurrencyid_bind$transactioncurrencies?: string | null;
  }
  interface BusinessUnit_Create extends BusinessUnit {
  }
  interface BusinessUnit_Update extends BusinessUnit {
  }
  interface BusinessUnit_Select {
    address1_addressid: WebAttribute<BusinessUnit_Select, { address1_addressid: string | null }, {  }>;
    address1_addresstypecode: WebAttribute<BusinessUnit_Select, { address1_addresstypecode: businessunit_address1_addresstypecode | null }, { address1_addresstypecode_formatted?: string }>;
    address1_city: WebAttribute<BusinessUnit_Select, { address1_city: string | null }, {  }>;
    address1_country: WebAttribute<BusinessUnit_Select, { address1_country: string | null }, {  }>;
    address1_county: WebAttribute<BusinessUnit_Select, { address1_county: string | null }, {  }>;
    address1_fax: WebAttribute<BusinessUnit_Select, { address1_fax: string | null }, {  }>;
    address1_latitude: WebAttribute<BusinessUnit_Select, { address1_latitude: number | null }, {  }>;
    address1_line1: WebAttribute<BusinessUnit_Select, { address1_line1: string | null }, {  }>;
    address1_line2: WebAttribute<BusinessUnit_Select, { address1_line2: string | null }, {  }>;
    address1_line3: WebAttribute<BusinessUnit_Select, { address1_line3: string | null }, {  }>;
    address1_longitude: WebAttribute<BusinessUnit_Select, { address1_longitude: number | null }, {  }>;
    address1_name: WebAttribute<BusinessUnit_Select, { address1_name: string | null }, {  }>;
    address1_postalcode: WebAttribute<BusinessUnit_Select, { address1_postalcode: string | null }, {  }>;
    address1_postofficebox: WebAttribute<BusinessUnit_Select, { address1_postofficebox: string | null }, {  }>;
    address1_shippingmethodcode: WebAttribute<BusinessUnit_Select, { address1_shippingmethodcode: businessunit_address1_shippingmethodcode | null }, { address1_shippingmethodcode_formatted?: string }>;
    address1_stateorprovince: WebAttribute<BusinessUnit_Select, { address1_stateorprovince: string | null }, {  }>;
    address1_telephone1: WebAttribute<BusinessUnit_Select, { address1_telephone1: string | null }, {  }>;
    address1_telephone2: WebAttribute<BusinessUnit_Select, { address1_telephone2: string | null }, {  }>;
    address1_telephone3: WebAttribute<BusinessUnit_Select, { address1_telephone3: string | null }, {  }>;
    address1_upszone: WebAttribute<BusinessUnit_Select, { address1_upszone: string | null }, {  }>;
    address1_utcoffset: WebAttribute<BusinessUnit_Select, { address1_utcoffset: number | null }, {  }>;
    address2_addressid: WebAttribute<BusinessUnit_Select, { address2_addressid: string | null }, {  }>;
    address2_addresstypecode: WebAttribute<BusinessUnit_Select, { address2_addresstypecode: businessunit_address2_addresstypecode | null }, { address2_addresstypecode_formatted?: string }>;
    address2_city: WebAttribute<BusinessUnit_Select, { address2_city: string | null }, {  }>;
    address2_country: WebAttribute<BusinessUnit_Select, { address2_country: string | null }, {  }>;
    address2_county: WebAttribute<BusinessUnit_Select, { address2_county: string | null }, {  }>;
    address2_fax: WebAttribute<BusinessUnit_Select, { address2_fax: string | null }, {  }>;
    address2_latitude: WebAttribute<BusinessUnit_Select, { address2_latitude: number | null }, {  }>;
    address2_line1: WebAttribute<BusinessUnit_Select, { address2_line1: string | null }, {  }>;
    address2_line2: WebAttribute<BusinessUnit_Select, { address2_line2: string | null }, {  }>;
    address2_line3: WebAttribute<BusinessUnit_Select, { address2_line3: string | null }, {  }>;
    address2_longitude: WebAttribute<BusinessUnit_Select, { address2_longitude: number | null }, {  }>;
    address2_name: WebAttribute<BusinessUnit_Select, { address2_name: string | null }, {  }>;
    address2_postalcode: WebAttribute<BusinessUnit_Select, { address2_postalcode: string | null }, {  }>;
    address2_postofficebox: WebAttribute<BusinessUnit_Select, { address2_postofficebox: string | null }, {  }>;
    address2_shippingmethodcode: WebAttribute<BusinessUnit_Select, { address2_shippingmethodcode: businessunit_address2_shippingmethodcode | null }, { address2_shippingmethodcode_formatted?: string }>;
    address2_stateorprovince: WebAttribute<BusinessUnit_Select, { address2_stateorprovince: string | null }, {  }>;
    address2_telephone1: WebAttribute<BusinessUnit_Select, { address2_telephone1: string | null }, {  }>;
    address2_telephone2: WebAttribute<BusinessUnit_Select, { address2_telephone2: string | null }, {  }>;
    address2_telephone3: WebAttribute<BusinessUnit_Select, { address2_telephone3: string | null }, {  }>;
    address2_upszone: WebAttribute<BusinessUnit_Select, { address2_upszone: string | null }, {  }>;
    address2_utcoffset: WebAttribute<BusinessUnit_Select, { address2_utcoffset: number | null }, {  }>;
    businessunitid: WebAttribute<BusinessUnit_Select, { businessunitid: string | null }, {  }>;
    calendarid_guid: WebAttribute<BusinessUnit_Select, { calendarid_guid: string | null }, { calendarid_formatted?: string }>;
    costcenter: WebAttribute<BusinessUnit_Select, { costcenter: string | null }, {  }>;
    createdby_guid: WebAttribute<BusinessUnit_Select, { createdby_guid: string | null }, { createdby_formatted?: string }>;
    createdon: WebAttribute<BusinessUnit_Select, { createdon: Date | null }, { createdon_formatted?: string }>;
    createdonbehalfby_guid: WebAttribute<BusinessUnit_Select, { createdonbehalfby_guid: string | null }, { createdonbehalfby_formatted?: string }>;
    creditlimit: WebAttribute<BusinessUnit_Select, { creditlimit: number | null }, {  }>;
    description: WebAttribute<BusinessUnit_Select, { description: string | null }, {  }>;
    disabledreason: WebAttribute<BusinessUnit_Select, { disabledreason: string | null }, {  }>;
    divisionname: WebAttribute<BusinessUnit_Select, { divisionname: string | null }, {  }>;
    emailaddress: WebAttribute<BusinessUnit_Select, { emailaddress: string | null }, {  }>;
    exchangerate: WebAttribute<BusinessUnit_Select, { exchangerate: number | null }, {  }>;
    fileasname: WebAttribute<BusinessUnit_Select, { fileasname: string | null }, {  }>;
    ftpsiteurl: WebAttribute<BusinessUnit_Select, { ftpsiteurl: string | null }, {  }>;
    importsequencenumber: WebAttribute<BusinessUnit_Select, { importsequencenumber: number | null }, {  }>;
    inheritancemask: WebAttribute<BusinessUnit_Select, { inheritancemask: number | null }, {  }>;
    isdisabled: WebAttribute<BusinessUnit_Select, { isdisabled: boolean | null }, {  }>;
    modifiedby_guid: WebAttribute<BusinessUnit_Select, { modifiedby_guid: string | null }, { modifiedby_formatted?: string }>;
    modifiedon: WebAttribute<BusinessUnit_Select, { modifiedon: Date | null }, { modifiedon_formatted?: string }>;
    modifiedonbehalfby_guid: WebAttribute<BusinessUnit_Select, { modifiedonbehalfby_guid: string | null }, { modifiedonbehalfby_formatted?: string }>;
    name: WebAttribute<BusinessUnit_Select, { name: string | null }, {  }>;
    organizationid_guid: WebAttribute<BusinessUnit_Select, { organizationid_guid: string | null }, { organizationid_formatted?: string }>;
    overriddencreatedon: WebAttribute<BusinessUnit_Select, { overriddencreatedon: Date | null }, { overriddencreatedon_formatted?: string }>;
    parentbusinessunitid_guid: WebAttribute<BusinessUnit_Select, { parentbusinessunitid_guid: string | null }, { parentbusinessunitid_formatted?: string }>;
    picture: WebAttribute<BusinessUnit_Select, { picture: string | null }, {  }>;
    stockexchange: WebAttribute<BusinessUnit_Select, { stockexchange: string | null }, {  }>;
    tickersymbol: WebAttribute<BusinessUnit_Select, { tickersymbol: string | null }, {  }>;
    transactioncurrencyid_guid: WebAttribute<BusinessUnit_Select, { transactioncurrencyid_guid: string | null }, { transactioncurrencyid_formatted?: string }>;
    usergroupid: WebAttribute<BusinessUnit_Select, { usergroupid: string | null }, {  }>;
    utcoffset: WebAttribute<BusinessUnit_Select, { utcoffset: number | null }, {  }>;
    versionnumber: WebAttribute<BusinessUnit_Select, { versionnumber: number | null }, {  }>;
    websiteurl: WebAttribute<BusinessUnit_Select, { websiteurl: string | null }, {  }>;
    workflowsuspended: WebAttribute<BusinessUnit_Select, { workflowsuspended: boolean | null }, {  }>;
  }
  interface BusinessUnit_Filter {
    address1_addressid: XQW.Guid;
    address1_addresstypecode: businessunit_address1_addresstypecode;
    address1_city: string;
    address1_country: string;
    address1_county: string;
    address1_fax: string;
    address1_latitude: number;
    address1_line1: string;
    address1_line2: string;
    address1_line3: string;
    address1_longitude: number;
    address1_name: string;
    address1_postalcode: string;
    address1_postofficebox: string;
    address1_shippingmethodcode: businessunit_address1_shippingmethodcode;
    address1_stateorprovince: string;
    address1_telephone1: string;
    address1_telephone2: string;
    address1_telephone3: string;
    address1_upszone: string;
    address1_utcoffset: number;
    address2_addressid: XQW.Guid;
    address2_addresstypecode: businessunit_address2_addresstypecode;
    address2_city: string;
    address2_country: string;
    address2_county: string;
    address2_fax: string;
    address2_latitude: number;
    address2_line1: string;
    address2_line2: string;
    address2_line3: string;
    address2_longitude: number;
    address2_name: string;
    address2_postalcode: string;
    address2_postofficebox: string;
    address2_shippingmethodcode: businessunit_address2_shippingmethodcode;
    address2_stateorprovince: string;
    address2_telephone1: string;
    address2_telephone2: string;
    address2_telephone3: string;
    address2_upszone: string;
    address2_utcoffset: number;
    businessunitid: XQW.Guid;
    calendarid_guid: XQW.Guid;
    costcenter: string;
    createdby_guid: XQW.Guid;
    createdon: Date;
    createdonbehalfby_guid: XQW.Guid;
    creditlimit: number;
    description: string;
    disabledreason: string;
    divisionname: string;
    emailaddress: string;
    exchangerate: any;
    fileasname: string;
    ftpsiteurl: string;
    importsequencenumber: number;
    inheritancemask: number;
    isdisabled: boolean;
    modifiedby_guid: XQW.Guid;
    modifiedon: Date;
    modifiedonbehalfby_guid: XQW.Guid;
    name: string;
    organizationid_guid: XQW.Guid;
    overriddencreatedon: Date;
    parentbusinessunitid_guid: XQW.Guid;
    picture: string;
    stockexchange: string;
    tickersymbol: string;
    transactioncurrencyid_guid: XQW.Guid;
    usergroupid: XQW.Guid;
    utcoffset: number;
    versionnumber: number;
    websiteurl: string;
    workflowsuspended: boolean;
  }
  interface BusinessUnit_Expand {
    business_unit_connections: WebExpand<BusinessUnit_Expand, Connection_Select, Connection_Filter, { business_unit_connections: Connection_Result[] }>;
    business_unit_parent_business_unit: WebExpand<BusinessUnit_Expand, BusinessUnit_Select, BusinessUnit_Filter, { business_unit_parent_business_unit: BusinessUnit_Result[] }>;
    business_unit_system_users: WebExpand<BusinessUnit_Expand, SystemUser_Select, SystemUser_Filter, { business_unit_system_users: SystemUser_Result[] }>;
    business_unit_teams: WebExpand<BusinessUnit_Expand, Team_Select, Team_Filter, { business_unit_teams: Team_Result[] }>;
    createdby: WebExpand<BusinessUnit_Expand, SystemUser_Select, SystemUser_Filter, { createdby: SystemUser_Result }>;
    createdonbehalfby: WebExpand<BusinessUnit_Expand, SystemUser_Select, SystemUser_Filter, { createdonbehalfby: SystemUser_Result }>;
    modifiedby: WebExpand<BusinessUnit_Expand, SystemUser_Select, SystemUser_Filter, { modifiedby: SystemUser_Result }>;
    modifiedonbehalfby: WebExpand<BusinessUnit_Expand, SystemUser_Select, SystemUser_Filter, { modifiedonbehalfby: SystemUser_Result }>;
    parentbusinessunitid: WebExpand<BusinessUnit_Expand, BusinessUnit_Select, BusinessUnit_Filter, { parentbusinessunitid: BusinessUnit_Result }>;
  }
  interface BusinessUnit_FormattedResult {
    address1_addresstypecode_formatted?: string;
    address1_shippingmethodcode_formatted?: string;
    address2_addresstypecode_formatted?: string;
    address2_shippingmethodcode_formatted?: string;
    calendarid_formatted?: string;
    createdby_formatted?: string;
    createdon_formatted?: string;
    createdonbehalfby_formatted?: string;
    modifiedby_formatted?: string;
    modifiedon_formatted?: string;
    modifiedonbehalfby_formatted?: string;
    organizationid_formatted?: string;
    overriddencreatedon_formatted?: string;
    parentbusinessunitid_formatted?: string;
    transactioncurrencyid_formatted?: string;
  }
  interface BusinessUnit_Result extends BusinessUnit_Base, BusinessUnit_Relationships {
    "@odata.etag": string;
    calendarid_guid: string | null;
    createdby_guid: string | null;
    createdonbehalfby_guid: string | null;
    modifiedby_guid: string | null;
    modifiedonbehalfby_guid: string | null;
    organizationid_guid: string | null;
    parentbusinessunitid_guid: string | null;
    transactioncurrencyid_guid: string | null;
  }
  interface BusinessUnit_RelatedOne {
    createdby: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    createdonbehalfby: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    modifiedby: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    modifiedonbehalfby: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    parentbusinessunitid: WebMappingRetrieve<Web.BusinessUnit_Select,Web.BusinessUnit_Expand,Web.BusinessUnit_Filter,Web.BusinessUnit_Fixed,Web.BusinessUnit_Result,Web.BusinessUnit_FormattedResult>;
  }
  interface BusinessUnit_RelatedMany {
    business_unit_connections: WebMappingRetrieve<Web.Connection_Select,Web.Connection_Expand,Web.Connection_Filter,Web.Connection_Fixed,Web.Connection_Result,Web.Connection_FormattedResult>;
    business_unit_parent_business_unit: WebMappingRetrieve<Web.BusinessUnit_Select,Web.BusinessUnit_Expand,Web.BusinessUnit_Filter,Web.BusinessUnit_Fixed,Web.BusinessUnit_Result,Web.BusinessUnit_FormattedResult>;
    business_unit_system_users: WebMappingRetrieve<Web.SystemUser_Select,Web.SystemUser_Expand,Web.SystemUser_Filter,Web.SystemUser_Fixed,Web.SystemUser_Result,Web.SystemUser_FormattedResult>;
    business_unit_teams: WebMappingRetrieve<Web.Team_Select,Web.Team_Expand,Web.Team_Filter,Web.Team_Fixed,Web.Team_Result,Web.Team_FormattedResult>;
  }
}
interface WebEntitiesRetrieve {
  businessunits: WebMappingRetrieve<Web.BusinessUnit_Select,Web.BusinessUnit_Expand,Web.BusinessUnit_Filter,Web.BusinessUnit_Fixed,Web.BusinessUnit_Result,Web.BusinessUnit_FormattedResult>;
}
interface WebEntitiesRelated {
  businessunits: WebMappingRelated<Web.BusinessUnit_RelatedOne,Web.BusinessUnit_RelatedMany>;
}
interface WebEntitiesCUDA {
  businessunits: WebMappingCUDA<Web.BusinessUnit_Create,Web.BusinessUnit_Update,Web.BusinessUnit_Select>;
}
