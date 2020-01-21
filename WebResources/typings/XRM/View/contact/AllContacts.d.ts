declare namespace Views.contact {
  interface AllContacts {
    parentcustomerid: string;
    parentcustomerid_Value: SDK.EntityReference;
    emailaddress1: string;
    emailaddress1_Value: string;
    contactid: string;
    contactid_Value: string;
    telephone1: string;
    telephone1_Value: string;
    fullname: string;
    fullname_Value: string;
    statecode: string;
    statecode_Value: SDK.OptionSet<contact_statecode>;
  }
}
