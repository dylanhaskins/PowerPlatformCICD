declare namespace Form.email.Quick {
  namespace EmailReferencePanel {
    namespace Tabs {
      interface tab_1 extends Xrm.SectionCollectionBase {
        get(name: "tab_1_column_1_section_1"): Xrm.PageSection;
        get(name: "tab_1_section_2"): Xrm.PageSection;
        get(name: "tab_1_section_4"): Xrm.PageSection;
        get(name: string): undefined;
        get(): Xrm.PageSection[];
        get(index: number): Xrm.PageSection;
        get(chooser: (item: Xrm.PageSection, index: number) => boolean): Xrm.PageSection[];
      }
    }
    interface Attributes extends Xrm.AttributeCollectionBase {
      get(name: "actualdurationminutes"): Xrm.NumberAttribute;
      get(name: "bcc"): Xrm.LookupAttribute<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
      get(name: "cc"): Xrm.LookupAttribute<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
      get(name: "description"): Xrm.Attribute<string>;
      get(name: "from"): Xrm.LookupAttribute<"queue" | "systemuser">;
      get(name: "ownerid"): Xrm.LookupAttribute<"systemuser" | "team">;
      get(name: "prioritycode"): Xrm.OptionSetAttribute<email_prioritycode>;
      get(name: "regardingobjectid"): Xrm.LookupAttribute<"account" | "adx_ad" | "adx_adplacement" | "adx_invitation" | "adx_poll" | "adx_polloption" | "adx_pollplacement" | "adx_pollsubmission" | "adx_publishingstatetransitionrule" | "adx_redirect" | "adx_shortcut" | "adx_webpage" | "adx_website" | "asyncoperation" | "contact" | "knowledgearticle" | "knowledgebaserecord">;
      get(name: "scheduledend"): Xrm.DateAttribute;
      get(name: "statecode"): Xrm.OptionSetAttribute<email_statecode>;
      get(name: "subject"): Xrm.Attribute<string>;
      get(name: "to"): Xrm.LookupAttribute<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
      get(name: string): undefined;
      get(): Xrm.Attribute<any>[];
      get(index: number): Xrm.Attribute<any>;
      get(chooser: (item: Xrm.Attribute<any>, index: number) => boolean): Xrm.Attribute<any>[];
    }
    interface Controls extends Xrm.ControlCollectionBase {
      get(name: "actualdurationminutes"): Xrm.NumberControl;
      get(name: "bcc"): Xrm.LookupControl<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
      get(name: "cc"): Xrm.LookupControl<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
      get(name: "description"): Xrm.StringControl;
      get(name: "from"): Xrm.LookupControl<"queue" | "systemuser">;
      get(name: "ownerid"): Xrm.LookupControl<"systemuser" | "team">;
      get(name: "prioritycode"): Xrm.OptionSetControl<email_prioritycode>;
      get(name: "regardingobjectid"): Xrm.LookupControl<"account" | "adx_ad" | "adx_adplacement" | "adx_invitation" | "adx_poll" | "adx_polloption" | "adx_pollplacement" | "adx_pollsubmission" | "adx_publishingstatetransitionrule" | "adx_redirect" | "adx_shortcut" | "adx_webpage" | "adx_website" | "asyncoperation" | "contact" | "knowledgearticle" | "knowledgebaserecord">;
      get(name: "scheduledend"): Xrm.DateControl;
      get(name: "statecode"): Xrm.OptionSetControl<email_statecode>;
      get(name: "subject"): Xrm.StringControl;
      get(name: "to"): Xrm.LookupControl<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
      get(name: string): undefined;
      get(): Xrm.BaseControl[];
      get(index: number): Xrm.BaseControl;
      get(chooser: (item: Xrm.BaseControl, index: number) => boolean): Xrm.BaseControl[];
    }
    interface Tabs extends Xrm.TabCollectionBase {
      get(name: "tab_1"): Xrm.PageTab<Tabs.tab_1>;
      get(name: string): undefined;
      get(): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>[];
      get(index: number): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>;
      get(chooser: (item: Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>, index: number) => boolean): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>[];
    }
  }
  interface EmailReferencePanel extends Xrm.PageBase<EmailReferencePanel.Attributes,EmailReferencePanel.Tabs,EmailReferencePanel.Controls> {
    getAttribute(attributeName: "actualdurationminutes"): Xrm.NumberAttribute;
    getAttribute(attributeName: "bcc"): Xrm.LookupAttribute<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
    getAttribute(attributeName: "cc"): Xrm.LookupAttribute<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
    getAttribute(attributeName: "description"): Xrm.Attribute<string>;
    getAttribute(attributeName: "from"): Xrm.LookupAttribute<"queue" | "systemuser">;
    getAttribute(attributeName: "ownerid"): Xrm.LookupAttribute<"systemuser" | "team">;
    getAttribute(attributeName: "prioritycode"): Xrm.OptionSetAttribute<email_prioritycode>;
    getAttribute(attributeName: "regardingobjectid"): Xrm.LookupAttribute<"account" | "adx_ad" | "adx_adplacement" | "adx_invitation" | "adx_poll" | "adx_polloption" | "adx_pollplacement" | "adx_pollsubmission" | "adx_publishingstatetransitionrule" | "adx_redirect" | "adx_shortcut" | "adx_webpage" | "adx_website" | "asyncoperation" | "contact" | "knowledgearticle" | "knowledgebaserecord">;
    getAttribute(attributeName: "scheduledend"): Xrm.DateAttribute;
    getAttribute(attributeName: "statecode"): Xrm.OptionSetAttribute<email_statecode>;
    getAttribute(attributeName: "subject"): Xrm.Attribute<string>;
    getAttribute(attributeName: "to"): Xrm.LookupAttribute<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
    getAttribute(attributeName: string): undefined;
    getControl(controlName: "actualdurationminutes"): Xrm.NumberControl;
    getControl(controlName: "bcc"): Xrm.LookupControl<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
    getControl(controlName: "cc"): Xrm.LookupControl<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
    getControl(controlName: "description"): Xrm.StringControl;
    getControl(controlName: "from"): Xrm.LookupControl<"queue" | "systemuser">;
    getControl(controlName: "ownerid"): Xrm.LookupControl<"systemuser" | "team">;
    getControl(controlName: "prioritycode"): Xrm.OptionSetControl<email_prioritycode>;
    getControl(controlName: "regardingobjectid"): Xrm.LookupControl<"account" | "adx_ad" | "adx_adplacement" | "adx_invitation" | "adx_poll" | "adx_polloption" | "adx_pollplacement" | "adx_pollsubmission" | "adx_publishingstatetransitionrule" | "adx_redirect" | "adx_shortcut" | "adx_webpage" | "adx_website" | "asyncoperation" | "contact" | "knowledgearticle" | "knowledgebaserecord">;
    getControl(controlName: "scheduledend"): Xrm.DateControl;
    getControl(controlName: "statecode"): Xrm.OptionSetControl<email_statecode>;
    getControl(controlName: "subject"): Xrm.StringControl;
    getControl(controlName: "to"): Xrm.LookupControl<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
    getControl(controlName: string): undefined;
  }
}
