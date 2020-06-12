declare namespace Form.systemuser.AppointmentBook {
  namespace Information {
    namespace Tabs {
      interface general extends Xrm.SectionCollectionBase {
        get(name: "organization info"): Xrm.PageSection;
        get(name: "section 1"): Xrm.PageSection;
        get(name: string): undefined;
        get(): Xrm.PageSection[];
        get(index: number): Xrm.PageSection;
        get(chooser: (item: Xrm.PageSection, index: number) => boolean): Xrm.PageSection[];
      }
    }
    interface Attributes extends Xrm.AttributeCollectionBase {
      get(name: "address1_telephone1"): Xrm.Attribute<string>;
      get(name: "address1_telephone2"): Xrm.Attribute<string>;
      get(name: "address1_telephone3"): Xrm.Attribute<string>;
      get(name: "businessunitid"): Xrm.LookupAttribute<"businessunit">;
      get(name: "domainname"): Xrm.Attribute<string>;
      get(name: "firstname"): Xrm.Attribute<string>;
      get(name: "homephone"): Xrm.Attribute<string>;
      get(name: "internalemailaddress"): Xrm.Attribute<string>;
      get(name: "lastname"): Xrm.Attribute<string>;
      get(name: "mobilealertemail"): Xrm.Attribute<string>;
      get(name: "mobilephone"): Xrm.Attribute<string>;
      get(name: "parentsystemuserid"): Xrm.LookupAttribute<"systemuser">;
      get(name: "personalemailaddress"): Xrm.Attribute<string>;
      get(name: "positionid"): Xrm.LookupAttribute<"position">;
      get(name: "preferredphonecode"): Xrm.OptionSetAttribute<systemuser_preferredphonecode>;
      get(name: "title"): Xrm.Attribute<string>;
      get(name: string): undefined;
      get(): Xrm.Attribute<any>[];
      get(index: number): Xrm.Attribute<any>;
      get(chooser: (item: Xrm.Attribute<any>, index: number) => boolean): Xrm.Attribute<any>[];
    }
    interface Controls extends Xrm.ControlCollectionBase {
      get(name: "address1_telephone1"): Xrm.StringControl;
      get(name: "address1_telephone2"): Xrm.StringControl;
      get(name: "address1_telephone3"): Xrm.StringControl;
      get(name: "businessunitid"): Xrm.LookupControl<"businessunit">;
      get(name: "domainname"): Xrm.StringControl;
      get(name: "firstname"): Xrm.StringControl;
      get(name: "homephone"): Xrm.StringControl;
      get(name: "internalemailaddress"): Xrm.StringControl;
      get(name: "lastname"): Xrm.StringControl;
      get(name: "mobilealertemail"): Xrm.StringControl;
      get(name: "mobilephone"): Xrm.StringControl;
      get(name: "parentsystemuserid"): Xrm.LookupControl<"systemuser">;
      get(name: "personalemailaddress"): Xrm.StringControl;
      get(name: "positionid"): Xrm.LookupControl<"position">;
      get(name: "preferredphonecode"): Xrm.OptionSetControl<systemuser_preferredphonecode>;
      get(name: "title"): Xrm.StringControl;
      get(name: string): undefined;
      get(): Xrm.BaseControl[];
      get(index: number): Xrm.BaseControl;
      get(chooser: (item: Xrm.BaseControl, index: number) => boolean): Xrm.BaseControl[];
    }
    interface Tabs extends Xrm.TabCollectionBase {
      get(name: "general"): Xrm.PageTab<Tabs.general>;
      get(name: string): undefined;
      get(): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>[];
      get(index: number): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>;
      get(chooser: (item: Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>, index: number) => boolean): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>[];
    }
  }
  interface Information extends Xrm.PageBase<Information.Attributes,Information.Tabs,Information.Controls> {
    getAttribute(attributeName: "address1_telephone1"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address1_telephone2"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address1_telephone3"): Xrm.Attribute<string>;
    getAttribute(attributeName: "businessunitid"): Xrm.LookupAttribute<"businessunit">;
    getAttribute(attributeName: "domainname"): Xrm.Attribute<string>;
    getAttribute(attributeName: "firstname"): Xrm.Attribute<string>;
    getAttribute(attributeName: "homephone"): Xrm.Attribute<string>;
    getAttribute(attributeName: "internalemailaddress"): Xrm.Attribute<string>;
    getAttribute(attributeName: "lastname"): Xrm.Attribute<string>;
    getAttribute(attributeName: "mobilealertemail"): Xrm.Attribute<string>;
    getAttribute(attributeName: "mobilephone"): Xrm.Attribute<string>;
    getAttribute(attributeName: "parentsystemuserid"): Xrm.LookupAttribute<"systemuser">;
    getAttribute(attributeName: "personalemailaddress"): Xrm.Attribute<string>;
    getAttribute(attributeName: "positionid"): Xrm.LookupAttribute<"position">;
    getAttribute(attributeName: "preferredphonecode"): Xrm.OptionSetAttribute<systemuser_preferredphonecode>;
    getAttribute(attributeName: "title"): Xrm.Attribute<string>;
    getAttribute(attributeName: string): undefined;
    getControl(controlName: "address1_telephone1"): Xrm.StringControl;
    getControl(controlName: "address1_telephone2"): Xrm.StringControl;
    getControl(controlName: "address1_telephone3"): Xrm.StringControl;
    getControl(controlName: "businessunitid"): Xrm.LookupControl<"businessunit">;
    getControl(controlName: "domainname"): Xrm.StringControl;
    getControl(controlName: "firstname"): Xrm.StringControl;
    getControl(controlName: "homephone"): Xrm.StringControl;
    getControl(controlName: "internalemailaddress"): Xrm.StringControl;
    getControl(controlName: "lastname"): Xrm.StringControl;
    getControl(controlName: "mobilealertemail"): Xrm.StringControl;
    getControl(controlName: "mobilephone"): Xrm.StringControl;
    getControl(controlName: "parentsystemuserid"): Xrm.LookupControl<"systemuser">;
    getControl(controlName: "personalemailaddress"): Xrm.StringControl;
    getControl(controlName: "positionid"): Xrm.LookupControl<"position">;
    getControl(controlName: "preferredphonecode"): Xrm.OptionSetControl<systemuser_preferredphonecode>;
    getControl(controlName: "title"): Xrm.StringControl;
    getControl(controlName: string): undefined;
  }
}
