declare namespace Web {
  interface Account_Base extends WebEntity {
    accountcategorycode?: account_accountcategorycode | null;
    accountclassificationcode?: account_accountclassificationcode | null;
    accountid?: string | null;
    accountnumber?: string | null;
    accountratingcode?: account_accountratingcode | null;
    address1_addressid?: string | null;
    address1_addresstypecode?: account_address1_addresstypecode | null;
    address1_city?: string | null;
    address1_composite?: string | null;
    address1_country?: string | null;
    address1_county?: string | null;
    address1_fax?: string | null;
    address1_freighttermscode?: account_address1_freighttermscode | null;
    address1_latitude?: number | null;
    address1_line1?: string | null;
    address1_line2?: string | null;
    address1_line3?: string | null;
    address1_longitude?: number | null;
    address1_name?: string | null;
    address1_postalcode?: string | null;
    address1_postofficebox?: string | null;
    address1_primarycontactname?: string | null;
    address1_shippingmethodcode?: account_address1_shippingmethodcode | null;
    address1_stateorprovince?: string | null;
    address1_telephone1?: string | null;
    address1_telephone2?: string | null;
    address1_telephone3?: string | null;
    address1_upszone?: string | null;
    address1_utcoffset?: number | null;
    address2_addressid?: string | null;
    address2_addresstypecode?: account_address2_addresstypecode | null;
    address2_city?: string | null;
    address2_composite?: string | null;
    address2_country?: string | null;
    address2_county?: string | null;
    address2_fax?: string | null;
    address2_freighttermscode?: account_address2_freighttermscode | null;
    address2_latitude?: number | null;
    address2_line1?: string | null;
    address2_line2?: string | null;
    address2_line3?: string | null;
    address2_longitude?: number | null;
    address2_name?: string | null;
    address2_postalcode?: string | null;
    address2_postofficebox?: string | null;
    address2_primarycontactname?: string | null;
    address2_shippingmethodcode?: account_address2_shippingmethodcode | null;
    address2_stateorprovince?: string | null;
    address2_telephone1?: string | null;
    address2_telephone2?: string | null;
    address2_telephone3?: string | null;
    address2_upszone?: string | null;
    address2_utcoffset?: number | null;
    adx_createdbyipaddress?: string | null;
    adx_createdbyusername?: string | null;
    adx_modifiedbyipaddress?: string | null;
    adx_modifiedbyusername?: string | null;
    aging30?: number | null;
    aging30_base?: number | null;
    aging60?: number | null;
    aging60_base?: number | null;
    aging90?: number | null;
    aging90_base?: number | null;
    businesstypecode?: account_businesstypecode | null;
    createdon?: Date | null;
    creditlimit?: number | null;
    creditlimit_base?: number | null;
    creditonhold?: boolean | null;
    customersizecode?: account_customersizecode | null;
    customertypecode?: account_customertypecode | null;
    description?: string | null;
    donotbulkemail?: boolean | null;
    donotbulkpostalmail?: boolean | null;
    donotemail?: boolean | null;
    donotfax?: boolean | null;
    donotphone?: boolean | null;
    donotpostalmail?: boolean | null;
    donotsendmm?: boolean | null;
    emailaddress1?: string | null;
    emailaddress2?: string | null;
    emailaddress3?: string | null;
    entityimageid?: string | null;
    exchangerate?: number | null;
    fax?: string | null;
    followemail?: boolean | null;
    ftpsiteurl?: string | null;
    importsequencenumber?: number | null;
    industrycode?: account_industrycode | null;
    isprivate?: boolean | null;
    lastonholdtime?: Date | null;
    lastusedincampaign?: Date | null;
    marketcap?: number | null;
    marketcap_base?: number | null;
    marketingonly?: boolean | null;
    merged?: boolean | null;
    modifiedon?: Date | null;
    name?: string | null;
    numberofemployees?: number | null;
    onholdtime?: number | null;
    overriddencreatedon?: Date | null;
    ownershipcode?: account_ownershipcode | null;
    participatesinworkflow?: boolean | null;
    paymenttermscode?: account_paymenttermscode | null;
    preferredappointmentdaycode?: account_preferredappointmentdaycode | null;
    preferredappointmenttimecode?: account_preferredappointmenttimecode | null;
    preferredcontactmethodcode?: account_preferredcontactmethodcode | null;
    primarysatoriid?: string | null;
    primarytwitterid?: string | null;
    processid?: string | null;
    revenue?: number | null;
    revenue_base?: number | null;
    sharesoutstanding?: number | null;
    shippingmethodcode?: account_shippingmethodcode | null;
    sic?: string | null;
    stageid?: string | null;
    statecode?: account_statecode | null;
    statuscode?: account_statuscode | null;
    stockexchange?: string | null;
    telephone1?: string | null;
    telephone2?: string | null;
    telephone3?: string | null;
    territorycode?: account_territorycode | null;
    tickersymbol?: string | null;
    timespentbymeonemailandmeetings?: string | null;
    timezoneruleversionnumber?: number | null;
    transactioncurrencyid_guid?: string | null;
    traversedpath?: string | null;
    utcconversiontimezonecode?: number | null;
    versionnumber?: number | null;
    websiteurl?: string | null;
  }
  interface Account_Relationships {
    account_activity_parties?: ActivityParty_Result[] | null;
    account_connections1?: Connection_Result[] | null;
    account_connections2?: Connection_Result[] | null;
    account_master_account?: Account_Result[] | null;
    account_parent_account?: Account_Result[] | null;
    contact_customer_accounts?: Contact_Result[] | null;
    msa_account_managingpartner?: Account_Result[] | null;
    msa_contact_managingpartner?: Contact_Result[] | null;
  }
  interface Account extends Account_Base, Account_Relationships {
    msa_managingpartnerid_bind$accounts?: string | null;
    ownerid_bind$systemusers?: string | null;
    ownerid_bind$teams?: string | null;
    parentaccountid_bind$accounts?: string | null;
    preferredsystemuserid_bind$systemusers?: string | null;
    primarycontactid_bind$contacts?: string | null;
    sla_account_sla_bind$slas?: string | null;
    stageid_processstage_bind$processstages?: string | null;
    transactioncurrencyid_bind$transactioncurrencies?: string | null;
  }
  interface Account_Create extends Account {
  }
  interface Account_Update extends Account {
  }
  interface Account_Select {
    accountcategorycode: WebAttribute<Account_Select, { accountcategorycode: account_accountcategorycode | null }, { accountcategorycode_formatted?: string }>;
    accountclassificationcode: WebAttribute<Account_Select, { accountclassificationcode: account_accountclassificationcode | null }, { accountclassificationcode_formatted?: string }>;
    accountid: WebAttribute<Account_Select, { accountid: string | null }, {  }>;
    accountnumber: WebAttribute<Account_Select, { accountnumber: string | null }, {  }>;
    accountratingcode: WebAttribute<Account_Select, { accountratingcode: account_accountratingcode | null }, { accountratingcode_formatted?: string }>;
    address1_addressid: WebAttribute<Account_Select, { address1_addressid: string | null }, {  }>;
    address1_addresstypecode: WebAttribute<Account_Select, { address1_addresstypecode: account_address1_addresstypecode | null }, { address1_addresstypecode_formatted?: string }>;
    address1_city: WebAttribute<Account_Select, { address1_city: string | null }, {  }>;
    address1_composite: WebAttribute<Account_Select, { address1_composite: string | null }, {  }>;
    address1_country: WebAttribute<Account_Select, { address1_country: string | null }, {  }>;
    address1_county: WebAttribute<Account_Select, { address1_county: string | null }, {  }>;
    address1_fax: WebAttribute<Account_Select, { address1_fax: string | null }, {  }>;
    address1_freighttermscode: WebAttribute<Account_Select, { address1_freighttermscode: account_address1_freighttermscode | null }, { address1_freighttermscode_formatted?: string }>;
    address1_latitude: WebAttribute<Account_Select, { address1_latitude: number | null }, {  }>;
    address1_line1: WebAttribute<Account_Select, { address1_line1: string | null }, {  }>;
    address1_line2: WebAttribute<Account_Select, { address1_line2: string | null }, {  }>;
    address1_line3: WebAttribute<Account_Select, { address1_line3: string | null }, {  }>;
    address1_longitude: WebAttribute<Account_Select, { address1_longitude: number | null }, {  }>;
    address1_name: WebAttribute<Account_Select, { address1_name: string | null }, {  }>;
    address1_postalcode: WebAttribute<Account_Select, { address1_postalcode: string | null }, {  }>;
    address1_postofficebox: WebAttribute<Account_Select, { address1_postofficebox: string | null }, {  }>;
    address1_primarycontactname: WebAttribute<Account_Select, { address1_primarycontactname: string | null }, {  }>;
    address1_shippingmethodcode: WebAttribute<Account_Select, { address1_shippingmethodcode: account_address1_shippingmethodcode | null }, { address1_shippingmethodcode_formatted?: string }>;
    address1_stateorprovince: WebAttribute<Account_Select, { address1_stateorprovince: string | null }, {  }>;
    address1_telephone1: WebAttribute<Account_Select, { address1_telephone1: string | null }, {  }>;
    address1_telephone2: WebAttribute<Account_Select, { address1_telephone2: string | null }, {  }>;
    address1_telephone3: WebAttribute<Account_Select, { address1_telephone3: string | null }, {  }>;
    address1_upszone: WebAttribute<Account_Select, { address1_upszone: string | null }, {  }>;
    address1_utcoffset: WebAttribute<Account_Select, { address1_utcoffset: number | null }, {  }>;
    address2_addressid: WebAttribute<Account_Select, { address2_addressid: string | null }, {  }>;
    address2_addresstypecode: WebAttribute<Account_Select, { address2_addresstypecode: account_address2_addresstypecode | null }, { address2_addresstypecode_formatted?: string }>;
    address2_city: WebAttribute<Account_Select, { address2_city: string | null }, {  }>;
    address2_composite: WebAttribute<Account_Select, { address2_composite: string | null }, {  }>;
    address2_country: WebAttribute<Account_Select, { address2_country: string | null }, {  }>;
    address2_county: WebAttribute<Account_Select, { address2_county: string | null }, {  }>;
    address2_fax: WebAttribute<Account_Select, { address2_fax: string | null }, {  }>;
    address2_freighttermscode: WebAttribute<Account_Select, { address2_freighttermscode: account_address2_freighttermscode | null }, { address2_freighttermscode_formatted?: string }>;
    address2_latitude: WebAttribute<Account_Select, { address2_latitude: number | null }, {  }>;
    address2_line1: WebAttribute<Account_Select, { address2_line1: string | null }, {  }>;
    address2_line2: WebAttribute<Account_Select, { address2_line2: string | null }, {  }>;
    address2_line3: WebAttribute<Account_Select, { address2_line3: string | null }, {  }>;
    address2_longitude: WebAttribute<Account_Select, { address2_longitude: number | null }, {  }>;
    address2_name: WebAttribute<Account_Select, { address2_name: string | null }, {  }>;
    address2_postalcode: WebAttribute<Account_Select, { address2_postalcode: string | null }, {  }>;
    address2_postofficebox: WebAttribute<Account_Select, { address2_postofficebox: string | null }, {  }>;
    address2_primarycontactname: WebAttribute<Account_Select, { address2_primarycontactname: string | null }, {  }>;
    address2_shippingmethodcode: WebAttribute<Account_Select, { address2_shippingmethodcode: account_address2_shippingmethodcode | null }, { address2_shippingmethodcode_formatted?: string }>;
    address2_stateorprovince: WebAttribute<Account_Select, { address2_stateorprovince: string | null }, {  }>;
    address2_telephone1: WebAttribute<Account_Select, { address2_telephone1: string | null }, {  }>;
    address2_telephone2: WebAttribute<Account_Select, { address2_telephone2: string | null }, {  }>;
    address2_telephone3: WebAttribute<Account_Select, { address2_telephone3: string | null }, {  }>;
    address2_upszone: WebAttribute<Account_Select, { address2_upszone: string | null }, {  }>;
    address2_utcoffset: WebAttribute<Account_Select, { address2_utcoffset: number | null }, {  }>;
    adx_createdbyipaddress: WebAttribute<Account_Select, { adx_createdbyipaddress: string | null }, {  }>;
    adx_createdbyusername: WebAttribute<Account_Select, { adx_createdbyusername: string | null }, {  }>;
    adx_modifiedbyipaddress: WebAttribute<Account_Select, { adx_modifiedbyipaddress: string | null }, {  }>;
    adx_modifiedbyusername: WebAttribute<Account_Select, { adx_modifiedbyusername: string | null }, {  }>;
    aging30: WebAttribute<Account_Select, { aging30: number | null; transactioncurrencyid_guid: string | null }, { aging30_formatted?: string; transactioncurrencyid_formatted?: string }>;
    aging30_base: WebAttribute<Account_Select, { aging30_base: number | null; transactioncurrencyid_guid: string | null }, { aging30_base_formatted?: string; transactioncurrencyid_formatted?: string }>;
    aging60: WebAttribute<Account_Select, { aging60: number | null; transactioncurrencyid_guid: string | null }, { aging60_formatted?: string; transactioncurrencyid_formatted?: string }>;
    aging60_base: WebAttribute<Account_Select, { aging60_base: number | null; transactioncurrencyid_guid: string | null }, { aging60_base_formatted?: string; transactioncurrencyid_formatted?: string }>;
    aging90: WebAttribute<Account_Select, { aging90: number | null; transactioncurrencyid_guid: string | null }, { aging90_formatted?: string; transactioncurrencyid_formatted?: string }>;
    aging90_base: WebAttribute<Account_Select, { aging90_base: number | null; transactioncurrencyid_guid: string | null }, { aging90_base_formatted?: string; transactioncurrencyid_formatted?: string }>;
    businesstypecode: WebAttribute<Account_Select, { businesstypecode: account_businesstypecode | null }, { businesstypecode_formatted?: string }>;
    createdby_guid: WebAttribute<Account_Select, { createdby_guid: string | null }, { createdby_formatted?: string }>;
    createdbyexternalparty_guid: WebAttribute<Account_Select, { createdbyexternalparty_guid: string | null }, { createdbyexternalparty_formatted?: string }>;
    createdon: WebAttribute<Account_Select, { createdon: Date | null }, { createdon_formatted?: string }>;
    createdonbehalfby_guid: WebAttribute<Account_Select, { createdonbehalfby_guid: string | null }, { createdonbehalfby_formatted?: string }>;
    creditlimit: WebAttribute<Account_Select, { creditlimit: number | null; transactioncurrencyid_guid: string | null }, { creditlimit_formatted?: string; transactioncurrencyid_formatted?: string }>;
    creditlimit_base: WebAttribute<Account_Select, { creditlimit_base: number | null; transactioncurrencyid_guid: string | null }, { creditlimit_base_formatted?: string; transactioncurrencyid_formatted?: string }>;
    creditonhold: WebAttribute<Account_Select, { creditonhold: boolean | null }, {  }>;
    customersizecode: WebAttribute<Account_Select, { customersizecode: account_customersizecode | null }, { customersizecode_formatted?: string }>;
    customertypecode: WebAttribute<Account_Select, { customertypecode: account_customertypecode | null }, { customertypecode_formatted?: string }>;
    description: WebAttribute<Account_Select, { description: string | null }, {  }>;
    donotbulkemail: WebAttribute<Account_Select, { donotbulkemail: boolean | null }, {  }>;
    donotbulkpostalmail: WebAttribute<Account_Select, { donotbulkpostalmail: boolean | null }, {  }>;
    donotemail: WebAttribute<Account_Select, { donotemail: boolean | null }, {  }>;
    donotfax: WebAttribute<Account_Select, { donotfax: boolean | null }, {  }>;
    donotphone: WebAttribute<Account_Select, { donotphone: boolean | null }, {  }>;
    donotpostalmail: WebAttribute<Account_Select, { donotpostalmail: boolean | null }, {  }>;
    donotsendmm: WebAttribute<Account_Select, { donotsendmm: boolean | null }, {  }>;
    emailaddress1: WebAttribute<Account_Select, { emailaddress1: string | null }, {  }>;
    emailaddress2: WebAttribute<Account_Select, { emailaddress2: string | null }, {  }>;
    emailaddress3: WebAttribute<Account_Select, { emailaddress3: string | null }, {  }>;
    entityimageid: WebAttribute<Account_Select, { entityimageid: string | null }, {  }>;
    exchangerate: WebAttribute<Account_Select, { exchangerate: number | null }, {  }>;
    fax: WebAttribute<Account_Select, { fax: string | null }, {  }>;
    followemail: WebAttribute<Account_Select, { followemail: boolean | null }, {  }>;
    ftpsiteurl: WebAttribute<Account_Select, { ftpsiteurl: string | null }, {  }>;
    importsequencenumber: WebAttribute<Account_Select, { importsequencenumber: number | null }, {  }>;
    industrycode: WebAttribute<Account_Select, { industrycode: account_industrycode | null }, { industrycode_formatted?: string }>;
    isprivate: WebAttribute<Account_Select, { isprivate: boolean | null }, {  }>;
    lastonholdtime: WebAttribute<Account_Select, { lastonholdtime: Date | null }, { lastonholdtime_formatted?: string }>;
    lastusedincampaign: WebAttribute<Account_Select, { lastusedincampaign: Date | null }, { lastusedincampaign_formatted?: string }>;
    marketcap: WebAttribute<Account_Select, { marketcap: number | null; transactioncurrencyid_guid: string | null }, { marketcap_formatted?: string; transactioncurrencyid_formatted?: string }>;
    marketcap_base: WebAttribute<Account_Select, { marketcap_base: number | null; transactioncurrencyid_guid: string | null }, { marketcap_base_formatted?: string; transactioncurrencyid_formatted?: string }>;
    marketingonly: WebAttribute<Account_Select, { marketingonly: boolean | null }, {  }>;
    masterid_guid: WebAttribute<Account_Select, { masterid_guid: string | null }, { masterid_formatted?: string }>;
    merged: WebAttribute<Account_Select, { merged: boolean | null }, {  }>;
    modifiedby_guid: WebAttribute<Account_Select, { modifiedby_guid: string | null }, { modifiedby_formatted?: string }>;
    modifiedbyexternalparty_guid: WebAttribute<Account_Select, { modifiedbyexternalparty_guid: string | null }, { modifiedbyexternalparty_formatted?: string }>;
    modifiedon: WebAttribute<Account_Select, { modifiedon: Date | null }, { modifiedon_formatted?: string }>;
    modifiedonbehalfby_guid: WebAttribute<Account_Select, { modifiedonbehalfby_guid: string | null }, { modifiedonbehalfby_formatted?: string }>;
    msa_managingpartnerid_guid: WebAttribute<Account_Select, { msa_managingpartnerid_guid: string | null }, { msa_managingpartnerid_formatted?: string }>;
    name: WebAttribute<Account_Select, { name: string | null }, {  }>;
    numberofemployees: WebAttribute<Account_Select, { numberofemployees: number | null }, {  }>;
    onholdtime: WebAttribute<Account_Select, { onholdtime: number | null }, {  }>;
    overriddencreatedon: WebAttribute<Account_Select, { overriddencreatedon: Date | null }, { overriddencreatedon_formatted?: string }>;
    ownerid_guid: WebAttribute<Account_Select, { ownerid_guid: string | null }, { ownerid_formatted?: string }>;
    ownershipcode: WebAttribute<Account_Select, { ownershipcode: account_ownershipcode | null }, { ownershipcode_formatted?: string }>;
    owningbusinessunit_guid: WebAttribute<Account_Select, { owningbusinessunit_guid: string | null }, { owningbusinessunit_formatted?: string }>;
    owningteam_guid: WebAttribute<Account_Select, { owningteam_guid: string | null }, { owningteam_formatted?: string }>;
    owninguser_guid: WebAttribute<Account_Select, { owninguser_guid: string | null }, { owninguser_formatted?: string }>;
    parentaccountid_guid: WebAttribute<Account_Select, { parentaccountid_guid: string | null }, { parentaccountid_formatted?: string }>;
    participatesinworkflow: WebAttribute<Account_Select, { participatesinworkflow: boolean | null }, {  }>;
    paymenttermscode: WebAttribute<Account_Select, { paymenttermscode: account_paymenttermscode | null }, { paymenttermscode_formatted?: string }>;
    preferredappointmentdaycode: WebAttribute<Account_Select, { preferredappointmentdaycode: account_preferredappointmentdaycode | null }, { preferredappointmentdaycode_formatted?: string }>;
    preferredappointmenttimecode: WebAttribute<Account_Select, { preferredappointmenttimecode: account_preferredappointmenttimecode | null }, { preferredappointmenttimecode_formatted?: string }>;
    preferredcontactmethodcode: WebAttribute<Account_Select, { preferredcontactmethodcode: account_preferredcontactmethodcode | null }, { preferredcontactmethodcode_formatted?: string }>;
    preferredsystemuserid_guid: WebAttribute<Account_Select, { preferredsystemuserid_guid: string | null }, { preferredsystemuserid_formatted?: string }>;
    primarycontactid_guid: WebAttribute<Account_Select, { primarycontactid_guid: string | null }, { primarycontactid_formatted?: string }>;
    primarysatoriid: WebAttribute<Account_Select, { primarysatoriid: string | null }, {  }>;
    primarytwitterid: WebAttribute<Account_Select, { primarytwitterid: string | null }, {  }>;
    processid: WebAttribute<Account_Select, { processid: string | null }, {  }>;
    revenue: WebAttribute<Account_Select, { revenue: number | null; transactioncurrencyid_guid: string | null }, { revenue_formatted?: string; transactioncurrencyid_formatted?: string }>;
    revenue_base: WebAttribute<Account_Select, { revenue_base: number | null; transactioncurrencyid_guid: string | null }, { revenue_base_formatted?: string; transactioncurrencyid_formatted?: string }>;
    sharesoutstanding: WebAttribute<Account_Select, { sharesoutstanding: number | null }, {  }>;
    shippingmethodcode: WebAttribute<Account_Select, { shippingmethodcode: account_shippingmethodcode | null }, { shippingmethodcode_formatted?: string }>;
    sic: WebAttribute<Account_Select, { sic: string | null }, {  }>;
    slaid_guid: WebAttribute<Account_Select, { slaid_guid: string | null }, { slaid_formatted?: string }>;
    slainvokedid_guid: WebAttribute<Account_Select, { slainvokedid_guid: string | null }, { slainvokedid_formatted?: string }>;
    stageid: WebAttribute<Account_Select, { stageid: string | null }, {  }>;
    statecode: WebAttribute<Account_Select, { statecode: account_statecode | null }, { statecode_formatted?: string }>;
    statuscode: WebAttribute<Account_Select, { statuscode: account_statuscode | null }, { statuscode_formatted?: string }>;
    stockexchange: WebAttribute<Account_Select, { stockexchange: string | null }, {  }>;
    telephone1: WebAttribute<Account_Select, { telephone1: string | null }, {  }>;
    telephone2: WebAttribute<Account_Select, { telephone2: string | null }, {  }>;
    telephone3: WebAttribute<Account_Select, { telephone3: string | null }, {  }>;
    territorycode: WebAttribute<Account_Select, { territorycode: account_territorycode | null }, { territorycode_formatted?: string }>;
    tickersymbol: WebAttribute<Account_Select, { tickersymbol: string | null }, {  }>;
    timespentbymeonemailandmeetings: WebAttribute<Account_Select, { timespentbymeonemailandmeetings: string | null }, {  }>;
    timezoneruleversionnumber: WebAttribute<Account_Select, { timezoneruleversionnumber: number | null }, {  }>;
    transactioncurrencyid_guid: WebAttribute<Account_Select, { transactioncurrencyid_guid: string | null }, { transactioncurrencyid_formatted?: string }>;
    traversedpath: WebAttribute<Account_Select, { traversedpath: string | null }, {  }>;
    utcconversiontimezonecode: WebAttribute<Account_Select, { utcconversiontimezonecode: number | null }, {  }>;
    versionnumber: WebAttribute<Account_Select, { versionnumber: number | null }, {  }>;
    websiteurl: WebAttribute<Account_Select, { websiteurl: string | null }, {  }>;
  }
  interface Account_Filter {
    accountcategorycode: account_accountcategorycode;
    accountclassificationcode: account_accountclassificationcode;
    accountid: XQW.Guid;
    accountnumber: string;
    accountratingcode: account_accountratingcode;
    address1_addressid: XQW.Guid;
    address1_addresstypecode: account_address1_addresstypecode;
    address1_city: string;
    address1_composite: string;
    address1_country: string;
    address1_county: string;
    address1_fax: string;
    address1_freighttermscode: account_address1_freighttermscode;
    address1_latitude: number;
    address1_line1: string;
    address1_line2: string;
    address1_line3: string;
    address1_longitude: number;
    address1_name: string;
    address1_postalcode: string;
    address1_postofficebox: string;
    address1_primarycontactname: string;
    address1_shippingmethodcode: account_address1_shippingmethodcode;
    address1_stateorprovince: string;
    address1_telephone1: string;
    address1_telephone2: string;
    address1_telephone3: string;
    address1_upszone: string;
    address1_utcoffset: number;
    address2_addressid: XQW.Guid;
    address2_addresstypecode: account_address2_addresstypecode;
    address2_city: string;
    address2_composite: string;
    address2_country: string;
    address2_county: string;
    address2_fax: string;
    address2_freighttermscode: account_address2_freighttermscode;
    address2_latitude: number;
    address2_line1: string;
    address2_line2: string;
    address2_line3: string;
    address2_longitude: number;
    address2_name: string;
    address2_postalcode: string;
    address2_postofficebox: string;
    address2_primarycontactname: string;
    address2_shippingmethodcode: account_address2_shippingmethodcode;
    address2_stateorprovince: string;
    address2_telephone1: string;
    address2_telephone2: string;
    address2_telephone3: string;
    address2_upszone: string;
    address2_utcoffset: number;
    adx_createdbyipaddress: string;
    adx_createdbyusername: string;
    adx_modifiedbyipaddress: string;
    adx_modifiedbyusername: string;
    aging30: number;
    aging30_base: number;
    aging60: number;
    aging60_base: number;
    aging90: number;
    aging90_base: number;
    businesstypecode: account_businesstypecode;
    createdby_guid: XQW.Guid;
    createdbyexternalparty_guid: XQW.Guid;
    createdon: Date;
    createdonbehalfby_guid: XQW.Guid;
    creditlimit: number;
    creditlimit_base: number;
    creditonhold: boolean;
    customersizecode: account_customersizecode;
    customertypecode: account_customertypecode;
    description: string;
    donotbulkemail: boolean;
    donotbulkpostalmail: boolean;
    donotemail: boolean;
    donotfax: boolean;
    donotphone: boolean;
    donotpostalmail: boolean;
    donotsendmm: boolean;
    emailaddress1: string;
    emailaddress2: string;
    emailaddress3: string;
    entityimageid: XQW.Guid;
    exchangerate: any;
    fax: string;
    followemail: boolean;
    ftpsiteurl: string;
    importsequencenumber: number;
    industrycode: account_industrycode;
    isprivate: boolean;
    lastonholdtime: Date;
    lastusedincampaign: Date;
    marketcap: number;
    marketcap_base: number;
    marketingonly: boolean;
    masterid_guid: XQW.Guid;
    merged: boolean;
    modifiedby_guid: XQW.Guid;
    modifiedbyexternalparty_guid: XQW.Guid;
    modifiedon: Date;
    modifiedonbehalfby_guid: XQW.Guid;
    msa_managingpartnerid_guid: XQW.Guid;
    name: string;
    numberofemployees: number;
    onholdtime: number;
    overriddencreatedon: Date;
    ownerid_guid: XQW.Guid;
    ownershipcode: account_ownershipcode;
    owningbusinessunit_guid: XQW.Guid;
    owningteam_guid: XQW.Guid;
    owninguser_guid: XQW.Guid;
    parentaccountid_guid: XQW.Guid;
    participatesinworkflow: boolean;
    paymenttermscode: account_paymenttermscode;
    preferredappointmentdaycode: account_preferredappointmentdaycode;
    preferredappointmenttimecode: account_preferredappointmenttimecode;
    preferredcontactmethodcode: account_preferredcontactmethodcode;
    preferredsystemuserid_guid: XQW.Guid;
    primarycontactid_guid: XQW.Guid;
    primarysatoriid: string;
    primarytwitterid: string;
    processid: XQW.Guid;
    revenue: number;
    revenue_base: number;
    sharesoutstanding: number;
    shippingmethodcode: account_shippingmethodcode;
    sic: string;
    slaid_guid: XQW.Guid;
    slainvokedid_guid: XQW.Guid;
    stageid: XQW.Guid;
    statecode: account_statecode;
    statuscode: account_statuscode;
    stockexchange: string;
    telephone1: string;
    telephone2: string;
    telephone3: string;
    territorycode: account_territorycode;
    tickersymbol: string;
    timespentbymeonemailandmeetings: string;
    timezoneruleversionnumber: number;
    transactioncurrencyid_guid: XQW.Guid;
    traversedpath: string;
    utcconversiontimezonecode: number;
    versionnumber: number;
    websiteurl: string;
  }
  interface Account_Expand {
    account_activity_parties: WebExpand<Account_Expand, ActivityParty_Select, ActivityParty_Filter, { account_activity_parties: ActivityParty_Result[] }>;
    account_connections1: WebExpand<Account_Expand, Connection_Select, Connection_Filter, { account_connections1: Connection_Result[] }>;
    account_connections2: WebExpand<Account_Expand, Connection_Select, Connection_Filter, { account_connections2: Connection_Result[] }>;
    account_master_account: WebExpand<Account_Expand, Account_Select, Account_Filter, { account_master_account: Account_Result[] }>;
    account_parent_account: WebExpand<Account_Expand, Account_Select, Account_Filter, { account_parent_account: Account_Result[] }>;
    contact_customer_accounts: WebExpand<Account_Expand, Contact_Select, Contact_Filter, { contact_customer_accounts: Contact_Result[] }>;
    masterid: WebExpand<Account_Expand, Account_Select, Account_Filter, { masterid: Account_Result }>;
    msa_account_managingpartner: WebExpand<Account_Expand, Account_Select, Account_Filter, { msa_account_managingpartner: Account_Result[] }>;
    msa_contact_managingpartner: WebExpand<Account_Expand, Contact_Select, Contact_Filter, { msa_contact_managingpartner: Contact_Result[] }>;
    msa_managingpartnerid: WebExpand<Account_Expand, Account_Select, Account_Filter, { msa_managingpartnerid: Account_Result }>;
    parentaccountid: WebExpand<Account_Expand, Account_Select, Account_Filter, { parentaccountid: Account_Result }>;
    primarycontactid: WebExpand<Account_Expand, Contact_Select, Contact_Filter, { primarycontactid: Contact_Result }>;
  }
  interface Account_FormattedResult {
    accountcategorycode_formatted?: string;
    accountclassificationcode_formatted?: string;
    accountratingcode_formatted?: string;
    address1_addresstypecode_formatted?: string;
    address1_freighttermscode_formatted?: string;
    address1_shippingmethodcode_formatted?: string;
    address2_addresstypecode_formatted?: string;
    address2_freighttermscode_formatted?: string;
    address2_shippingmethodcode_formatted?: string;
    aging30_base_formatted?: string;
    aging30_formatted?: string;
    aging60_base_formatted?: string;
    aging60_formatted?: string;
    aging90_base_formatted?: string;
    aging90_formatted?: string;
    businesstypecode_formatted?: string;
    createdby_formatted?: string;
    createdbyexternalparty_formatted?: string;
    createdon_formatted?: string;
    createdonbehalfby_formatted?: string;
    creditlimit_base_formatted?: string;
    creditlimit_formatted?: string;
    customersizecode_formatted?: string;
    customertypecode_formatted?: string;
    industrycode_formatted?: string;
    lastonholdtime_formatted?: string;
    lastusedincampaign_formatted?: string;
    marketcap_base_formatted?: string;
    marketcap_formatted?: string;
    masterid_formatted?: string;
    modifiedby_formatted?: string;
    modifiedbyexternalparty_formatted?: string;
    modifiedon_formatted?: string;
    modifiedonbehalfby_formatted?: string;
    msa_managingpartnerid_formatted?: string;
    overriddencreatedon_formatted?: string;
    ownerid_formatted?: string;
    ownershipcode_formatted?: string;
    owningbusinessunit_formatted?: string;
    owningteam_formatted?: string;
    owninguser_formatted?: string;
    parentaccountid_formatted?: string;
    paymenttermscode_formatted?: string;
    preferredappointmentdaycode_formatted?: string;
    preferredappointmenttimecode_formatted?: string;
    preferredcontactmethodcode_formatted?: string;
    preferredsystemuserid_formatted?: string;
    primarycontactid_formatted?: string;
    revenue_base_formatted?: string;
    revenue_formatted?: string;
    shippingmethodcode_formatted?: string;
    slaid_formatted?: string;
    slainvokedid_formatted?: string;
    statecode_formatted?: string;
    statuscode_formatted?: string;
    territorycode_formatted?: string;
    transactioncurrencyid_formatted?: string;
  }
  interface Account_Result extends Account_Base, Account_Relationships {
    "@odata.etag": string;
    createdby_guid: string | null;
    createdbyexternalparty_guid: string | null;
    createdonbehalfby_guid: string | null;
    masterid_guid: string | null;
    modifiedby_guid: string | null;
    modifiedbyexternalparty_guid: string | null;
    modifiedonbehalfby_guid: string | null;
    msa_managingpartnerid_guid: string | null;
    ownerid_guid: string | null;
    owningbusinessunit_guid: string | null;
    owningteam_guid: string | null;
    owninguser_guid: string | null;
    parentaccountid_guid: string | null;
    preferredsystemuserid_guid: string | null;
    primarycontactid_guid: string | null;
    slaid_guid: string | null;
    slainvokedid_guid: string | null;
    transactioncurrencyid_guid: string | null;
  }
  interface Account_RelatedOne {
    masterid: WebMappingRetrieve<Web.Account_Select,Web.Account_Expand,Web.Account_Filter,Web.Account_Fixed,Web.Account_Result,Web.Account_FormattedResult>;
    msa_managingpartnerid: WebMappingRetrieve<Web.Account_Select,Web.Account_Expand,Web.Account_Filter,Web.Account_Fixed,Web.Account_Result,Web.Account_FormattedResult>;
    parentaccountid: WebMappingRetrieve<Web.Account_Select,Web.Account_Expand,Web.Account_Filter,Web.Account_Fixed,Web.Account_Result,Web.Account_FormattedResult>;
    primarycontactid: WebMappingRetrieve<Web.Contact_Select,Web.Contact_Expand,Web.Contact_Filter,Web.Contact_Fixed,Web.Contact_Result,Web.Contact_FormattedResult>;
  }
  interface Account_RelatedMany {
    account_activity_parties: WebMappingRetrieve<Web.ActivityParty_Select,Web.ActivityParty_Expand,Web.ActivityParty_Filter,Web.ActivityParty_Fixed,Web.ActivityParty_Result,Web.ActivityParty_FormattedResult>;
    account_connections1: WebMappingRetrieve<Web.Connection_Select,Web.Connection_Expand,Web.Connection_Filter,Web.Connection_Fixed,Web.Connection_Result,Web.Connection_FormattedResult>;
    account_connections2: WebMappingRetrieve<Web.Connection_Select,Web.Connection_Expand,Web.Connection_Filter,Web.Connection_Fixed,Web.Connection_Result,Web.Connection_FormattedResult>;
    account_master_account: WebMappingRetrieve<Web.Account_Select,Web.Account_Expand,Web.Account_Filter,Web.Account_Fixed,Web.Account_Result,Web.Account_FormattedResult>;
    account_parent_account: WebMappingRetrieve<Web.Account_Select,Web.Account_Expand,Web.Account_Filter,Web.Account_Fixed,Web.Account_Result,Web.Account_FormattedResult>;
    contact_customer_accounts: WebMappingRetrieve<Web.Contact_Select,Web.Contact_Expand,Web.Contact_Filter,Web.Contact_Fixed,Web.Contact_Result,Web.Contact_FormattedResult>;
    msa_account_managingpartner: WebMappingRetrieve<Web.Account_Select,Web.Account_Expand,Web.Account_Filter,Web.Account_Fixed,Web.Account_Result,Web.Account_FormattedResult>;
    msa_contact_managingpartner: WebMappingRetrieve<Web.Contact_Select,Web.Contact_Expand,Web.Contact_Filter,Web.Contact_Fixed,Web.Contact_Result,Web.Contact_FormattedResult>;
  }
}
interface WebEntitiesRetrieve {
  accounts: WebMappingRetrieve<Web.Account_Select,Web.Account_Expand,Web.Account_Filter,Web.Account_Fixed,Web.Account_Result,Web.Account_FormattedResult>;
}
interface WebEntitiesRelated {
  accounts: WebMappingRelated<Web.Account_RelatedOne,Web.Account_RelatedMany>;
}
interface WebEntitiesCUDA {
  accounts: WebMappingCUDA<Web.Account_Create,Web.Account_Update,Web.Account_Select>;
}
