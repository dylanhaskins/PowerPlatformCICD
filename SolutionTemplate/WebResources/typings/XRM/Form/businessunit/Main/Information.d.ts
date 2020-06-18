declare namespace Form.businessunit.Main {
  namespace Information {
    namespace Tabs {
      interface addresses extends Xrm.SectionCollectionBase {
        get(name: "bill to address"): Xrm.PageSection;
        get(name: "ship to address"): Xrm.PageSection;
        get(name: string): undefined;
        get(): Xrm.PageSection[];
        get(index: number): Xrm.PageSection;
        get(chooser: (item: Xrm.PageSection, index: number) => boolean): Xrm.PageSection[];
      }
      interface general extends Xrm.SectionCollectionBase {
        get(name: "section 1"): Xrm.PageSection;
        get(name: string): undefined;
        get(): Xrm.PageSection[];
        get(index: number): Xrm.PageSection;
        get(chooser: (item: Xrm.PageSection, index: number) => boolean): Xrm.PageSection[];
      }
    }
    interface Attributes extends Xrm.AttributeCollectionBase {
      get(name: "address1_city"): Xrm.Attribute<string>;
      get(name: "address1_country"): Xrm.Attribute<string>;
      get(name: "address1_line1"): Xrm.Attribute<string>;
      get(name: "address1_line2"): Xrm.Attribute<string>;
      get(name: "address1_line3"): Xrm.Attribute<string>;
      get(name: "address1_postalcode"): Xrm.Attribute<string>;
      get(name: "address1_stateorprovince"): Xrm.Attribute<string>;
      get(name: "address1_telephone1"): Xrm.Attribute<string>;
      get(name: "address1_telephone2"): Xrm.Attribute<string>;
      get(name: "address1_telephone3"): Xrm.Attribute<string>;
      get(name: "address2_city"): Xrm.Attribute<string>;
      get(name: "address2_country"): Xrm.Attribute<string>;
      get(name: "address2_line1"): Xrm.Attribute<string>;
      get(name: "address2_line2"): Xrm.Attribute<string>;
      get(name: "address2_line3"): Xrm.Attribute<string>;
      get(name: "address2_postalcode"): Xrm.Attribute<string>;
      get(name: "address2_stateorprovince"): Xrm.Attribute<string>;
      get(name: "divisionname"): Xrm.Attribute<string>;
      get(name: "emailaddress"): Xrm.Attribute<string>;
      get(name: "name"): Xrm.Attribute<string>;
      get(name: "parentbusinessunitid"): Xrm.LookupAttribute<"businessunit">;
      get(name: "websiteurl"): Xrm.Attribute<string>;
      get(name: string): undefined;
      get(): Xrm.Attribute<any>[];
      get(index: number): Xrm.Attribute<any>;
      get(chooser: (item: Xrm.Attribute<any>, index: number) => boolean): Xrm.Attribute<any>[];
    }
    interface Controls extends Xrm.ControlCollectionBase {
      get(name: "address1_city"): Xrm.StringControl;
      get(name: "address1_country"): Xrm.StringControl;
      get(name: "address1_line1"): Xrm.StringControl;
      get(name: "address1_line2"): Xrm.StringControl;
      get(name: "address1_line3"): Xrm.StringControl;
      get(name: "address1_postalcode"): Xrm.StringControl;
      get(name: "address1_stateorprovince"): Xrm.StringControl;
      get(name: "address1_telephone1"): Xrm.StringControl;
      get(name: "address1_telephone2"): Xrm.StringControl;
      get(name: "address1_telephone3"): Xrm.StringControl;
      get(name: "address2_city"): Xrm.StringControl;
      get(name: "address2_country"): Xrm.StringControl;
      get(name: "address2_line1"): Xrm.StringControl;
      get(name: "address2_line2"): Xrm.StringControl;
      get(name: "address2_line3"): Xrm.StringControl;
      get(name: "address2_postalcode"): Xrm.StringControl;
      get(name: "address2_stateorprovince"): Xrm.StringControl;
      get(name: "divisionname"): Xrm.StringControl;
      get(name: "emailaddress"): Xrm.StringControl;
      get(name: "name"): Xrm.StringControl;
      get(name: "parentbusinessunitid"): Xrm.LookupControl<"businessunit">;
      get(name: "websiteurl"): Xrm.StringControl;
      get(name: string): undefined;
      get(): Xrm.BaseControl[];
      get(index: number): Xrm.BaseControl;
      get(chooser: (item: Xrm.BaseControl, index: number) => boolean): Xrm.BaseControl[];
    }
    interface Tabs extends Xrm.TabCollectionBase {
      get(name: "addresses"): Xrm.PageTab<Tabs.addresses>;
      get(name: "general"): Xrm.PageTab<Tabs.general>;
      get(name: string): undefined;
      get(): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>[];
      get(index: number): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>;
      get(chooser: (item: Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>, index: number) => boolean): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>[];
    }
  }
  interface Information extends Xrm.PageBase<Information.Attributes,Information.Tabs,Information.Controls> {
    getAttribute(attributeName: "address1_city"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address1_country"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address1_line1"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address1_line2"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address1_line3"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address1_postalcode"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address1_stateorprovince"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address1_telephone1"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address1_telephone2"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address1_telephone3"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address2_city"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address2_country"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address2_line1"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address2_line2"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address2_line3"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address2_postalcode"): Xrm.Attribute<string>;
    getAttribute(attributeName: "address2_stateorprovince"): Xrm.Attribute<string>;
    getAttribute(attributeName: "divisionname"): Xrm.Attribute<string>;
    getAttribute(attributeName: "emailaddress"): Xrm.Attribute<string>;
    getAttribute(attributeName: "name"): Xrm.Attribute<string>;
    getAttribute(attributeName: "parentbusinessunitid"): Xrm.LookupAttribute<"businessunit">;
    getAttribute(attributeName: "websiteurl"): Xrm.Attribute<string>;
    getAttribute(attributeName: string): undefined;
    getControl(controlName: "address1_city"): Xrm.StringControl;
    getControl(controlName: "address1_country"): Xrm.StringControl;
    getControl(controlName: "address1_line1"): Xrm.StringControl;
    getControl(controlName: "address1_line2"): Xrm.StringControl;
    getControl(controlName: "address1_line3"): Xrm.StringControl;
    getControl(controlName: "address1_postalcode"): Xrm.StringControl;
    getControl(controlName: "address1_stateorprovince"): Xrm.StringControl;
    getControl(controlName: "address1_telephone1"): Xrm.StringControl;
    getControl(controlName: "address1_telephone2"): Xrm.StringControl;
    getControl(controlName: "address1_telephone3"): Xrm.StringControl;
    getControl(controlName: "address2_city"): Xrm.StringControl;
    getControl(controlName: "address2_country"): Xrm.StringControl;
    getControl(controlName: "address2_line1"): Xrm.StringControl;
    getControl(controlName: "address2_line2"): Xrm.StringControl;
    getControl(controlName: "address2_line3"): Xrm.StringControl;
    getControl(controlName: "address2_postalcode"): Xrm.StringControl;
    getControl(controlName: "address2_stateorprovince"): Xrm.StringControl;
    getControl(controlName: "divisionname"): Xrm.StringControl;
    getControl(controlName: "emailaddress"): Xrm.StringControl;
    getControl(controlName: "name"): Xrm.StringControl;
    getControl(controlName: "parentbusinessunitid"): Xrm.LookupControl<"businessunit">;
    getControl(controlName: "websiteurl"): Xrm.StringControl;
    getControl(controlName: string): undefined;
  }
}
