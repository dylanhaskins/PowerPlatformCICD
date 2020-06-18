declare namespace Form.systemuser.Main {
  namespace ApplicationUser {
    namespace Tabs {
      interface SUMMARY_TAB extends Xrm.SectionCollectionBase {
        get(name: "onpremise account information"): Xrm.PageSection;
        get(name: "user information"): Xrm.PageSection;
        get(name: string): undefined;
        get(): Xrm.PageSection[];
        get(index: number): Xrm.PageSection;
        get(chooser: (item: Xrm.PageSection, index: number) => boolean): Xrm.PageSection[];
      }
    }
    interface Attributes extends Xrm.AttributeCollectionBase {
      get(name: "applicationid"): Xrm.Attribute<string>;
      get(name: "applicationiduri"): Xrm.Attribute<string>;
      get(name: "azureactivedirectoryobjectid"): Xrm.Attribute<string>;
      get(name: "domainname"): Xrm.Attribute<string>;
      get(name: "fullname"): Xrm.Attribute<string> | null;
      get(name: "internalemailaddress"): Xrm.Attribute<string>;
      get(name: "isdisabled"): Xrm.OptionSetAttribute<boolean>;
      get(name: string): undefined;
      get(): Xrm.Attribute<any>[];
      get(index: number): Xrm.Attribute<any>;
      get(chooser: (item: Xrm.Attribute<any>, index: number) => boolean): Xrm.Attribute<any>[];
    }
    interface Controls extends Xrm.ControlCollectionBase {
      get(name: "applicationid"): Xrm.StringControl;
      get(name: "applicationiduri"): Xrm.StringControl;
      get(name: "azureactivedirectoryobjectid"): Xrm.StringControl;
      get(name: "domainname"): Xrm.StringControl;
      get(name: "footer_isdisabled"): Xrm.OptionSetControl<boolean>;
      get(name: "fullname"): Xrm.StringControl | null;
      get(name: "internalemailaddress"): Xrm.StringControl;
      get(name: string): undefined;
      get(): Xrm.BaseControl[];
      get(index: number): Xrm.BaseControl;
      get(chooser: (item: Xrm.BaseControl, index: number) => boolean): Xrm.BaseControl[];
    }
    interface Tabs extends Xrm.TabCollectionBase {
      get(name: "SUMMARY_TAB"): Xrm.PageTab<Tabs.SUMMARY_TAB>;
      get(name: string): undefined;
      get(): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>[];
      get(index: number): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>;
      get(chooser: (item: Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>, index: number) => boolean): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>[];
    }
  }
  interface ApplicationUser extends Xrm.PageBase<ApplicationUser.Attributes,ApplicationUser.Tabs,ApplicationUser.Controls> {
    getAttribute(attributeName: "applicationid"): Xrm.Attribute<string>;
    getAttribute(attributeName: "applicationiduri"): Xrm.Attribute<string>;
    getAttribute(attributeName: "azureactivedirectoryobjectid"): Xrm.Attribute<string>;
    getAttribute(attributeName: "domainname"): Xrm.Attribute<string>;
    getAttribute(attributeName: "fullname"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "internalemailaddress"): Xrm.Attribute<string>;
    getAttribute(attributeName: "isdisabled"): Xrm.OptionSetAttribute<boolean>;
    getAttribute(attributeName: string): undefined;
    getControl(controlName: "applicationid"): Xrm.StringControl;
    getControl(controlName: "applicationiduri"): Xrm.StringControl;
    getControl(controlName: "azureactivedirectoryobjectid"): Xrm.StringControl;
    getControl(controlName: "domainname"): Xrm.StringControl;
    getControl(controlName: "footer_isdisabled"): Xrm.OptionSetControl<boolean>;
    getControl(controlName: "fullname"): Xrm.StringControl | null;
    getControl(controlName: "internalemailaddress"): Xrm.StringControl;
    getControl(controlName: string): undefined;
  }
}
