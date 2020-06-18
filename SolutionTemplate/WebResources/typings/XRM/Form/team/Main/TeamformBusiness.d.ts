declare namespace Form.team.Main {
  namespace TeamformBusiness {
    namespace Tabs {
      interface general extends Xrm.SectionCollectionBase {
        get(name: "Description"): Xrm.PageSection;
        get(name: "General"): Xrm.PageSection;
        get(name: "TeamMembers"): Xrm.PageSection;
        get(name: string): undefined;
        get(): Xrm.PageSection[];
        get(index: number): Xrm.PageSection;
        get(chooser: (item: Xrm.PageSection, index: number) => boolean): Xrm.PageSection[];
      }
    }
    interface Attributes extends Xrm.AttributeCollectionBase {
      get(name: "administratorid"): Xrm.LookupAttribute<"systemuser">;
      get(name: "businessunitid"): Xrm.LookupAttribute<"businessunit">;
      get(name: "description"): Xrm.Attribute<string>;
      get(name: "name"): Xrm.Attribute<string>;
      get(name: "teamtype"): Xrm.OptionSetAttribute<team_type>;
      get(name: string): undefined;
      get(): Xrm.Attribute<any>[];
      get(index: number): Xrm.Attribute<any>;
      get(chooser: (item: Xrm.Attribute<any>, index: number) => boolean): Xrm.Attribute<any>[];
    }
    interface Controls extends Xrm.ControlCollectionBase {
      get(name: "Members"): Xrm.SubGridControl<"systemuser">;
      get(name: "administratorid"): Xrm.LookupControl<"systemuser">;
      get(name: "businessunitid"): Xrm.LookupControl<"businessunit">;
      get(name: "description"): Xrm.StringControl;
      get(name: "name"): Xrm.StringControl;
      get(name: "teamtype"): Xrm.OptionSetControl<team_type>;
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
  interface TeamformBusiness extends Xrm.PageBase<TeamformBusiness.Attributes,TeamformBusiness.Tabs,TeamformBusiness.Controls> {
    getAttribute(attributeName: "administratorid"): Xrm.LookupAttribute<"systemuser">;
    getAttribute(attributeName: "businessunitid"): Xrm.LookupAttribute<"businessunit">;
    getAttribute(attributeName: "description"): Xrm.Attribute<string>;
    getAttribute(attributeName: "name"): Xrm.Attribute<string>;
    getAttribute(attributeName: "teamtype"): Xrm.OptionSetAttribute<team_type>;
    getAttribute(attributeName: string): undefined;
    getControl(controlName: "Members"): Xrm.SubGridControl<"systemuser">;
    getControl(controlName: "administratorid"): Xrm.LookupControl<"systemuser">;
    getControl(controlName: "businessunitid"): Xrm.LookupControl<"businessunit">;
    getControl(controlName: "description"): Xrm.StringControl;
    getControl(controlName: "name"): Xrm.StringControl;
    getControl(controlName: "teamtype"): Xrm.OptionSetControl<team_type>;
    getControl(controlName: string): undefined;
  }
}
