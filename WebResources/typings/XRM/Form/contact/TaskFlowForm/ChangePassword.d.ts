declare namespace Form.contact.TaskFlowForm {
  namespace ChangePassword {
    namespace Tabs {
      interface pagestep11 extends Xrm.SectionCollectionBase {
        get(name: "pagestep11_section1"): Xrm.PageSection;
        get(name: string): undefined;
        get(): Xrm.PageSection[];
        get(index: number): Xrm.PageSection;
        get(chooser: (item: Xrm.PageSection, index: number) => boolean): Xrm.PageSection[];
      }
      interface pagestep15 extends Xrm.SectionCollectionBase {
        get(name: "pagestep15_section1"): Xrm.PageSection;
        get(name: string): undefined;
        get(): Xrm.PageSection[];
        get(index: number): Xrm.PageSection;
        get(chooser: (item: Xrm.PageSection, index: number) => boolean): Xrm.PageSection[];
      }
      interface pagestep19 extends Xrm.SectionCollectionBase {
        get(name: "pagestep19_section1"): Xrm.PageSection;
        get(name: string): undefined;
        get(): Xrm.PageSection[];
        get(index: number): Xrm.PageSection;
        get(chooser: (item: Xrm.PageSection, index: number) => boolean): Xrm.PageSection[];
      }
      interface pagestep3 extends Xrm.SectionCollectionBase {
        get(name: "pagestep3_section1"): Xrm.PageSection;
        get(name: string): undefined;
        get(): Xrm.PageSection[];
        get(index: number): Xrm.PageSection;
        get(chooser: (item: Xrm.PageSection, index: number) => boolean): Xrm.PageSection[];
      }
      interface pagestep7 extends Xrm.SectionCollectionBase {
        get(name: "pagestep7_section1"): Xrm.PageSection;
        get(name: string): undefined;
        get(): Xrm.PageSection[];
        get(index: number): Xrm.PageSection;
        get(chooser: (item: Xrm.PageSection, index: number) => boolean): Xrm.PageSection[];
      }
    }
    interface Attributes extends Xrm.AttributeCollectionBase {
      get(name: "7b40b93e-da23-43a9-8212-d90efa6a3a34_back"): Xrm.Attribute<any>;
      get(name: "7b40b93e-da23-43a9-8212-d90efa6a3a34_next"): Xrm.Attribute<any>;
      get(name: "835e8ba4-5212-4fbf-975f-f2fca8daaf84_next"): Xrm.Attribute<any>;
      get(name: "8eb18f36-0161-4659-8383-de2a55a8725f_back"): Xrm.Attribute<any>;
      get(name: "8eb18f36-0161-4659-8383-de2a55a8725f_next"): Xrm.Attribute<any>;
      get(name: "adx_confirmremovepassword"): Xrm.OptionSetAttribute<boolean>;
      get(name: "adx_identity_newpassword"): Xrm.Attribute<string>;
      get(name: "b2b04c9a-2d00-474c-b944-4e504ac95a97_back"): Xrm.Attribute<any>;
      get(name: "b2b04c9a-2d00-474c-b944-4e504ac95a97_next"): Xrm.Attribute<any>;
      get(name: "birthdate"): Xrm.DateAttribute | null;
      get(name: "d3897a39-855e-4940-bf92-9cc7feb64c42_back"): Xrm.Attribute<any>;
      get(name: "d3897a39-855e-4940-bf92-9cc7feb64c42_next"): Xrm.Attribute<any>;
      get(name: "emailaddress1"): Xrm.Attribute<string> | null;
      get(name: "familystatuscode"): Xrm.OptionSetAttribute<contact_familystatuscode> | null;
      get(name: "firstname"): Xrm.Attribute<string> | null;
      get(name: "industrycode"): Xrm.OptionSetAttribute<number> | null;
      get(name: "lastname"): Xrm.Attribute<string> | null;
      get(name: "middlename"): Xrm.Attribute<string> | null;
      get(name: "mobilephone"): Xrm.Attribute<string> | null;
      get(name: "name"): Xrm.Attribute<string> | null;
      get(name: "parentaccountid"): Xrm.LookupAttribute<"account"> | null;
      get(name: "spousesname"): Xrm.Attribute<string> | null;
      get(name: "telephone1"): Xrm.Attribute<string> | null;
      get(name: "websiteurl"): Xrm.Attribute<string> | null;
      get(name: string): undefined;
      get(): Xrm.Attribute<any>[];
      get(index: number): Xrm.Attribute<any>;
      get(chooser: (item: Xrm.Attribute<any>, index: number) => boolean): Xrm.Attribute<any>[];
    }
    interface Controls extends Xrm.ControlCollectionBase {
      get(name: "60990dc8-7a7d-49d7-bac2-d53c4864265b"): Xrm.BaseControl;
      get(name: "7b40b93e-da23-43a9-8212-d90efa6a3a34_back"): Xrm.Control<Xrm.Attribute<any>>;
      get(name: "7b40b93e-da23-43a9-8212-d90efa6a3a34_next"): Xrm.Control<Xrm.Attribute<any>>;
      get(name: "835e8ba4-5212-4fbf-975f-f2fca8daaf84_next"): Xrm.Control<Xrm.Attribute<any>>;
      get(name: "8eb18f36-0161-4659-8383-de2a55a8725f_back"): Xrm.Control<Xrm.Attribute<any>>;
      get(name: "8eb18f36-0161-4659-8383-de2a55a8725f_next"): Xrm.Control<Xrm.Attribute<any>>;
      get(name: "adx_confirmremovepassword"): Xrm.OptionSetControl<boolean>;
      get(name: "adx_identity_newpassword"): Xrm.StringControl;
      get(name: "b2b04c9a-2d00-474c-b944-4e504ac95a97_back"): Xrm.Control<Xrm.Attribute<any>>;
      get(name: "b2b04c9a-2d00-474c-b944-4e504ac95a97_next"): Xrm.Control<Xrm.Attribute<any>>;
      get(name: "d3897a39-855e-4940-bf92-9cc7feb64c42_back"): Xrm.Control<Xrm.Attribute<any>>;
      get(name: "d3897a39-855e-4940-bf92-9cc7feb64c42_next"): Xrm.Control<Xrm.Attribute<any>>;
      get(name: "de971d89-7bb1-450c-b4ae-2bf4f91d3bf7"): Xrm.BaseControl;
      get(name: "eebbd106-eaed-4719-bf7e-233a1ffec365"): Xrm.BaseControl;
      get(name: "header_process_60990dc8-7a7d-49d7-bac2-d53c4864265b"): Xrm.BaseControl | null;
      get(name: "header_process_adx_confirmremovepassword"): Xrm.OptionSetControl<boolean> | null;
      get(name: "header_process_adx_identity_newpassword"): Xrm.StringControl | null;
      get(name: "header_process_birthdate"): Xrm.DateControl | null;
      get(name: "header_process_de971d89-7bb1-450c-b4ae-2bf4f91d3bf7"): Xrm.BaseControl | null;
      get(name: "header_process_eebbd106-eaed-4719-bf7e-233a1ffec365"): Xrm.BaseControl | null;
      get(name: "header_process_emailaddress1"): Xrm.StringControl | null;
      get(name: "header_process_familystatuscode"): Xrm.OptionSetControl<contact_familystatuscode> | null;
      get(name: "header_process_firstname"): Xrm.StringControl | null;
      get(name: "header_process_industrycode"): Xrm.OptionSetControl<number> | null;
      get(name: "header_process_lastname"): Xrm.StringControl | null;
      get(name: "header_process_middlename"): Xrm.StringControl | null;
      get(name: "header_process_mobilephone"): Xrm.StringControl | null;
      get(name: "header_process_name"): Xrm.StringControl | null;
      get(name: "header_process_parentaccountid"): Xrm.LookupControl<"account"> | null;
      get(name: "header_process_spousesname"): Xrm.StringControl | null;
      get(name: "header_process_telephone1"): Xrm.StringControl | null;
      get(name: "header_process_websiteurl"): Xrm.StringControl | null;
      get(name: string): undefined;
      get(): Xrm.BaseControl[];
      get(index: number): Xrm.BaseControl;
      get(chooser: (item: Xrm.BaseControl, index: number) => boolean): Xrm.BaseControl[];
    }
    interface Tabs extends Xrm.TabCollectionBase {
      get(name: "pagestep11"): Xrm.PageTab<Tabs.pagestep11>;
      get(name: "pagestep15"): Xrm.PageTab<Tabs.pagestep15>;
      get(name: "pagestep19"): Xrm.PageTab<Tabs.pagestep19>;
      get(name: "pagestep3"): Xrm.PageTab<Tabs.pagestep3>;
      get(name: "pagestep7"): Xrm.PageTab<Tabs.pagestep7>;
      get(name: string): undefined;
      get(): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>[];
      get(index: number): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>;
      get(chooser: (item: Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>, index: number) => boolean): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>[];
    }
  }
  interface ChangePassword extends Xrm.PageBase<ChangePassword.Attributes,ChangePassword.Tabs,ChangePassword.Controls> {
    getAttribute(attributeName: "7b40b93e-da23-43a9-8212-d90efa6a3a34_back"): Xrm.Attribute<any>;
    getAttribute(attributeName: "7b40b93e-da23-43a9-8212-d90efa6a3a34_next"): Xrm.Attribute<any>;
    getAttribute(attributeName: "835e8ba4-5212-4fbf-975f-f2fca8daaf84_next"): Xrm.Attribute<any>;
    getAttribute(attributeName: "8eb18f36-0161-4659-8383-de2a55a8725f_back"): Xrm.Attribute<any>;
    getAttribute(attributeName: "8eb18f36-0161-4659-8383-de2a55a8725f_next"): Xrm.Attribute<any>;
    getAttribute(attributeName: "adx_confirmremovepassword"): Xrm.OptionSetAttribute<boolean>;
    getAttribute(attributeName: "adx_identity_newpassword"): Xrm.Attribute<string>;
    getAttribute(attributeName: "b2b04c9a-2d00-474c-b944-4e504ac95a97_back"): Xrm.Attribute<any>;
    getAttribute(attributeName: "b2b04c9a-2d00-474c-b944-4e504ac95a97_next"): Xrm.Attribute<any>;
    getAttribute(attributeName: "birthdate"): Xrm.DateAttribute | null;
    getAttribute(attributeName: "d3897a39-855e-4940-bf92-9cc7feb64c42_back"): Xrm.Attribute<any>;
    getAttribute(attributeName: "d3897a39-855e-4940-bf92-9cc7feb64c42_next"): Xrm.Attribute<any>;
    getAttribute(attributeName: "emailaddress1"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "familystatuscode"): Xrm.OptionSetAttribute<contact_familystatuscode> | null;
    getAttribute(attributeName: "firstname"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "industrycode"): Xrm.OptionSetAttribute<number> | null;
    getAttribute(attributeName: "lastname"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "middlename"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "mobilephone"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "name"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "parentaccountid"): Xrm.LookupAttribute<"account"> | null;
    getAttribute(attributeName: "spousesname"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "telephone1"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "websiteurl"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: string): undefined;
    getControl(controlName: "60990dc8-7a7d-49d7-bac2-d53c4864265b"): Xrm.BaseControl;
    getControl(controlName: "7b40b93e-da23-43a9-8212-d90efa6a3a34_back"): Xrm.Control<Xrm.Attribute<any>>;
    getControl(controlName: "7b40b93e-da23-43a9-8212-d90efa6a3a34_next"): Xrm.Control<Xrm.Attribute<any>>;
    getControl(controlName: "835e8ba4-5212-4fbf-975f-f2fca8daaf84_next"): Xrm.Control<Xrm.Attribute<any>>;
    getControl(controlName: "8eb18f36-0161-4659-8383-de2a55a8725f_back"): Xrm.Control<Xrm.Attribute<any>>;
    getControl(controlName: "8eb18f36-0161-4659-8383-de2a55a8725f_next"): Xrm.Control<Xrm.Attribute<any>>;
    getControl(controlName: "adx_confirmremovepassword"): Xrm.OptionSetControl<boolean>;
    getControl(controlName: "adx_identity_newpassword"): Xrm.StringControl;
    getControl(controlName: "b2b04c9a-2d00-474c-b944-4e504ac95a97_back"): Xrm.Control<Xrm.Attribute<any>>;
    getControl(controlName: "b2b04c9a-2d00-474c-b944-4e504ac95a97_next"): Xrm.Control<Xrm.Attribute<any>>;
    getControl(controlName: "d3897a39-855e-4940-bf92-9cc7feb64c42_back"): Xrm.Control<Xrm.Attribute<any>>;
    getControl(controlName: "d3897a39-855e-4940-bf92-9cc7feb64c42_next"): Xrm.Control<Xrm.Attribute<any>>;
    getControl(controlName: "de971d89-7bb1-450c-b4ae-2bf4f91d3bf7"): Xrm.BaseControl;
    getControl(controlName: "eebbd106-eaed-4719-bf7e-233a1ffec365"): Xrm.BaseControl;
    getControl(controlName: "header_process_60990dc8-7a7d-49d7-bac2-d53c4864265b"): Xrm.BaseControl | null;
    getControl(controlName: "header_process_adx_confirmremovepassword"): Xrm.OptionSetControl<boolean> | null;
    getControl(controlName: "header_process_adx_identity_newpassword"): Xrm.StringControl | null;
    getControl(controlName: "header_process_birthdate"): Xrm.DateControl | null;
    getControl(controlName: "header_process_de971d89-7bb1-450c-b4ae-2bf4f91d3bf7"): Xrm.BaseControl | null;
    getControl(controlName: "header_process_eebbd106-eaed-4719-bf7e-233a1ffec365"): Xrm.BaseControl | null;
    getControl(controlName: "header_process_emailaddress1"): Xrm.StringControl | null;
    getControl(controlName: "header_process_familystatuscode"): Xrm.OptionSetControl<contact_familystatuscode> | null;
    getControl(controlName: "header_process_firstname"): Xrm.StringControl | null;
    getControl(controlName: "header_process_industrycode"): Xrm.OptionSetControl<number> | null;
    getControl(controlName: "header_process_lastname"): Xrm.StringControl | null;
    getControl(controlName: "header_process_middlename"): Xrm.StringControl | null;
    getControl(controlName: "header_process_mobilephone"): Xrm.StringControl | null;
    getControl(controlName: "header_process_name"): Xrm.StringControl | null;
    getControl(controlName: "header_process_parentaccountid"): Xrm.LookupControl<"account"> | null;
    getControl(controlName: "header_process_spousesname"): Xrm.StringControl | null;
    getControl(controlName: "header_process_telephone1"): Xrm.StringControl | null;
    getControl(controlName: "header_process_websiteurl"): Xrm.StringControl | null;
    getControl(controlName: string): undefined;
  }
}
