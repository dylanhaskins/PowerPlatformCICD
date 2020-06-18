declare namespace Form.systemuser.Main {
  namespace UserformBusiness {
    namespace Tabs {
      interface ADMINISTRATION_TAB extends Xrm.SectionCollectionBase {
        get(name: "administration"): Xrm.PageSection;
        get(name: "e-mail configuration"): Xrm.PageSection;
        get(name: string): undefined;
        get(): Xrm.PageSection[];
        get(index: number): Xrm.PageSection;
        get(chooser: (item: Xrm.PageSection, index: number) => boolean): Xrm.PageSection[];
      }
      interface SUMMARY_TAB extends Xrm.SectionCollectionBase {
        get(name: "DirectReports"): Xrm.PageSection;
        get(name: "TEAMS_TAB"): Xrm.PageSection;
        get(name: "mailing address"): Xrm.PageSection;
        get(name: "online account information"): Xrm.PageSection;
        get(name: "onpremise account information"): Xrm.PageSection;
        get(name: "organization information"): Xrm.PageSection;
        get(name: "user information"): Xrm.PageSection;
        get(name: string): undefined;
        get(): Xrm.PageSection[];
        get(index: number): Xrm.PageSection;
        get(chooser: (item: Xrm.PageSection, index: number) => boolean): Xrm.PageSection[];
      }
    }
    interface Attributes extends Xrm.AttributeCollectionBase {
      get(name: "accessmode"): Xrm.OptionSetAttribute<systemuser_accessmode>;
      get(name: "address1_city"): Xrm.Attribute<string> | null;
      get(name: "address1_composite"): Xrm.Attribute<string> | null;
      get(name: "address1_country"): Xrm.Attribute<string> | null;
      get(name: "address1_line1"): Xrm.Attribute<string> | null;
      get(name: "address1_line2"): Xrm.Attribute<string> | null;
      get(name: "address1_line3"): Xrm.Attribute<string> | null;
      get(name: "address1_postalcode"): Xrm.Attribute<string> | null;
      get(name: "address1_stateorprovince"): Xrm.Attribute<string> | null;
      get(name: "address1_telephone1"): Xrm.Attribute<string>;
      get(name: "businessunitid"): Xrm.LookupAttribute<"businessunit">;
      get(name: "caltype"): Xrm.OptionSetAttribute<systemuser_caltype>;
      get(name: "defaultmailbox"): Xrm.LookupAttribute<"mailbox">;
      get(name: "domainname"): Xrm.Attribute<string>;
      get(name: "fullname"): Xrm.Attribute<string> | null;
      get(name: "internalemailaddress"): Xrm.Attribute<string>;
      get(name: "invitestatuscode"): Xrm.OptionSetAttribute<systemuser_invitestatuscode>;
      get(name: "isdisabled"): Xrm.OptionSetAttribute<boolean>;
      get(name: "mobilephone"): Xrm.Attribute<string>;
      get(name: "parentsystemuserid"): Xrm.LookupAttribute<"systemuser">;
      get(name: "preferredaddresscode"): Xrm.OptionSetAttribute<systemuser_preferredaddresscode>;
      get(name: "title"): Xrm.Attribute<string>;
      get(name: "windowsliveid"): Xrm.Attribute<string>;
      get(name: string): undefined;
      get(): Xrm.Attribute<any>[];
      get(index: number): Xrm.Attribute<any>;
      get(chooser: (item: Xrm.Attribute<any>, index: number) => boolean): Xrm.Attribute<any>[];
    }
    interface Controls extends Xrm.ControlCollectionBase {
      get(name: "DirectReports"): Xrm.SubGridControl<"systemuser">;
      get(name: "TeamsSubGrid"): Xrm.SubGridControl<"team">;
      get(name: "accessmode"): Xrm.OptionSetControl<systemuser_accessmode>;
      get(name: "address1_composite"): Xrm.StringControl | null;
      get(name: "address1_composite_compositionLinkControl_address1_city"): Xrm.StringControl | null;
      get(name: "address1_composite_compositionLinkControl_address1_country"): Xrm.StringControl | null;
      get(name: "address1_composite_compositionLinkControl_address1_line1"): Xrm.StringControl | null;
      get(name: "address1_composite_compositionLinkControl_address1_line2"): Xrm.StringControl | null;
      get(name: "address1_composite_compositionLinkControl_address1_line3"): Xrm.StringControl | null;
      get(name: "address1_composite_compositionLinkControl_address1_postalcode"): Xrm.StringControl | null;
      get(name: "address1_composite_compositionLinkControl_address1_stateorprovince"): Xrm.StringControl | null;
      get(name: "address1_telephone1"): Xrm.StringControl;
      get(name: "businessunitid"): Xrm.LookupControl<"businessunit">;
      get(name: "caltype"): Xrm.OptionSetControl<systemuser_caltype>;
      get(name: "defaultmailbox"): Xrm.LookupControl<"mailbox">;
      get(name: "domainname"): Xrm.StringControl;
      get(name: "footer_isdisabled"): Xrm.OptionSetControl<boolean>;
      get(name: "fullname"): Xrm.StringControl | null;
      get(name: "internalemailaddress"): Xrm.StringControl;
      get(name: "invitestatuscode"): Xrm.OptionSetControl<systemuser_invitestatuscode>;
      get(name: "mobilephone"): Xrm.StringControl;
      get(name: "parentsystemuserid"): Xrm.LookupControl<"systemuser">;
      get(name: "preferredaddresscode"): Xrm.OptionSetControl<systemuser_preferredaddresscode>;
      get(name: "title"): Xrm.StringControl;
      get(name: "windowsliveid"): Xrm.StringControl;
      get(name: string): undefined;
      get(): Xrm.BaseControl[];
      get(index: number): Xrm.BaseControl;
      get(chooser: (item: Xrm.BaseControl, index: number) => boolean): Xrm.BaseControl[];
    }
    interface Tabs extends Xrm.TabCollectionBase {
      get(name: "ADMINISTRATION_TAB"): Xrm.PageTab<Tabs.ADMINISTRATION_TAB>;
      get(name: "SUMMARY_TAB"): Xrm.PageTab<Tabs.SUMMARY_TAB>;
      get(name: string): undefined;
      get(): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>[];
      get(index: number): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>;
      get(chooser: (item: Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>, index: number) => boolean): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>[];
    }
  }
  interface UserformBusiness extends Xrm.PageBase<UserformBusiness.Attributes,UserformBusiness.Tabs,UserformBusiness.Controls> {
    getAttribute(attributeName: "accessmode"): Xrm.OptionSetAttribute<systemuser_accessmode>;
    getAttribute(attributeName: "address1_city"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "address1_composite"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "address1_country"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "address1_line1"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "address1_line2"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "address1_line3"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "address1_postalcode"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "address1_stateorprovince"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "address1_telephone1"): Xrm.Attribute<string>;
    getAttribute(attributeName: "businessunitid"): Xrm.LookupAttribute<"businessunit">;
    getAttribute(attributeName: "caltype"): Xrm.OptionSetAttribute<systemuser_caltype>;
    getAttribute(attributeName: "defaultmailbox"): Xrm.LookupAttribute<"mailbox">;
    getAttribute(attributeName: "domainname"): Xrm.Attribute<string>;
    getAttribute(attributeName: "fullname"): Xrm.Attribute<string> | null;
    getAttribute(attributeName: "internalemailaddress"): Xrm.Attribute<string>;
    getAttribute(attributeName: "invitestatuscode"): Xrm.OptionSetAttribute<systemuser_invitestatuscode>;
    getAttribute(attributeName: "isdisabled"): Xrm.OptionSetAttribute<boolean>;
    getAttribute(attributeName: "mobilephone"): Xrm.Attribute<string>;
    getAttribute(attributeName: "parentsystemuserid"): Xrm.LookupAttribute<"systemuser">;
    getAttribute(attributeName: "preferredaddresscode"): Xrm.OptionSetAttribute<systemuser_preferredaddresscode>;
    getAttribute(attributeName: "title"): Xrm.Attribute<string>;
    getAttribute(attributeName: "windowsliveid"): Xrm.Attribute<string>;
    getAttribute(attributeName: string): undefined;
    getControl(controlName: "DirectReports"): Xrm.SubGridControl<"systemuser">;
    getControl(controlName: "TeamsSubGrid"): Xrm.SubGridControl<"team">;
    getControl(controlName: "accessmode"): Xrm.OptionSetControl<systemuser_accessmode>;
    getControl(controlName: "address1_composite"): Xrm.StringControl | null;
    getControl(controlName: "address1_composite_compositionLinkControl_address1_city"): Xrm.StringControl | null;
    getControl(controlName: "address1_composite_compositionLinkControl_address1_country"): Xrm.StringControl | null;
    getControl(controlName: "address1_composite_compositionLinkControl_address1_line1"): Xrm.StringControl | null;
    getControl(controlName: "address1_composite_compositionLinkControl_address1_line2"): Xrm.StringControl | null;
    getControl(controlName: "address1_composite_compositionLinkControl_address1_line3"): Xrm.StringControl | null;
    getControl(controlName: "address1_composite_compositionLinkControl_address1_postalcode"): Xrm.StringControl | null;
    getControl(controlName: "address1_composite_compositionLinkControl_address1_stateorprovince"): Xrm.StringControl | null;
    getControl(controlName: "address1_telephone1"): Xrm.StringControl;
    getControl(controlName: "businessunitid"): Xrm.LookupControl<"businessunit">;
    getControl(controlName: "caltype"): Xrm.OptionSetControl<systemuser_caltype>;
    getControl(controlName: "defaultmailbox"): Xrm.LookupControl<"mailbox">;
    getControl(controlName: "domainname"): Xrm.StringControl;
    getControl(controlName: "footer_isdisabled"): Xrm.OptionSetControl<boolean>;
    getControl(controlName: "fullname"): Xrm.StringControl | null;
    getControl(controlName: "internalemailaddress"): Xrm.StringControl;
    getControl(controlName: "invitestatuscode"): Xrm.OptionSetControl<systemuser_invitestatuscode>;
    getControl(controlName: "mobilephone"): Xrm.StringControl;
    getControl(controlName: "parentsystemuserid"): Xrm.LookupControl<"systemuser">;
    getControl(controlName: "preferredaddresscode"): Xrm.OptionSetControl<systemuser_preferredaddresscode>;
    getControl(controlName: "title"): Xrm.StringControl;
    getControl(controlName: "windowsliveid"): Xrm.StringControl;
    getControl(controlName: string): undefined;
  }
}
