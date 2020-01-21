declare namespace Form.email.Main {
  namespace Email {
    namespace Tabs {
      interface Email extends Xrm.SectionCollectionBase {
        get(name: "Emailrecipient_section_6"): Xrm.PageSection;
        get(name: "Regarding information"): Xrm.PageSection;
        get(name: "attachments"): Xrm.PageSection;
        get(name: "email description"): Xrm.PageSection;
        get(name: "emailengagementactions"): Xrm.PageSection;
        get(name: "recipient information"): Xrm.PageSection;
        get(name: "tab_4_section_2"): Xrm.PageSection;
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
      get(name: "isemailfollowed"): Xrm.OptionSetAttribute<boolean>;
      get(name: "isemailreminderset"): Xrm.OptionSetAttribute<boolean>;
      get(name: "ownerid"): Xrm.LookupAttribute<"systemuser" | "team">;
      get(name: "prioritycode"): Xrm.OptionSetAttribute<email_prioritycode>;
      get(name: "regardingobjectid"): Xrm.LookupAttribute<"account" | "adx_ad" | "adx_adplacement" | "adx_invitation" | "adx_poll" | "adx_polloption" | "adx_pollplacement" | "adx_pollsubmission" | "adx_publishingstatetransitionrule" | "adx_redirect" | "adx_shortcut" | "adx_webpage" | "adx_website" | "asyncoperation" | "contact" | "knowledgearticle" | "knowledgebaserecord">;
      get(name: "scheduledend"): Xrm.DateAttribute;
      get(name: "statuscode"): Xrm.OptionSetAttribute<email_statuscode>;
      get(name: "subject"): Xrm.Attribute<string>;
      get(name: "to"): Xrm.LookupAttribute<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
      get(name: string): undefined;
      get(): Xrm.Attribute<any>[];
      get(index: number): Xrm.Attribute<any>;
      get(chooser: (item: Xrm.Attribute<any>, index: number) => boolean): Xrm.Attribute<any>[];
    }
    interface Controls extends Xrm.ControlCollectionBase {
      get(name: "actualdurationminutes"): Xrm.NumberControl;
      get(name: "attachmentsGrid"): Xrm.SubGridControl<"activitymimeattachment">;
      get(name: "bcc"): Xrm.LookupControl<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
      get(name: "cc"): Xrm.LookupControl<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
      get(name: "description"): Xrm.StringControl;
      get(name: "emailengagementactionscontrol"): Xrm.BaseControl;
      get(name: "emailrecipientactivitycontrol"): Xrm.BaseControl;
      get(name: "footer_emailfollowed"): Xrm.OptionSetControl<boolean>;
      get(name: "footer_emailremainderset"): Xrm.OptionSetControl<boolean>;
      get(name: "from"): Xrm.LookupControl<"queue" | "systemuser">;
      get(name: "header_ownerid"): Xrm.LookupControl<"systemuser" | "team">;
      get(name: "header_prioritycode"): Xrm.OptionSetControl<email_prioritycode>;
      get(name: "header_scheduledend"): Xrm.DateControl;
      get(name: "header_statecode"): Xrm.OptionSetControl<email_statuscode>;
      get(name: "regardingobjectid"): Xrm.LookupControl<"account" | "adx_ad" | "adx_adplacement" | "adx_invitation" | "adx_poll" | "adx_polloption" | "adx_pollplacement" | "adx_pollsubmission" | "adx_publishingstatetransitionrule" | "adx_redirect" | "adx_shortcut" | "adx_webpage" | "adx_website" | "asyncoperation" | "contact" | "knowledgearticle" | "knowledgebaserecord">;
      get(name: "subject"): Xrm.StringControl;
      get(name: "to"): Xrm.LookupControl<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
      get(name: string): undefined;
      get(): Xrm.BaseControl[];
      get(index: number): Xrm.BaseControl;
      get(chooser: (item: Xrm.BaseControl, index: number) => boolean): Xrm.BaseControl[];
    }
    interface Tabs extends Xrm.TabCollectionBase {
      get(name: "Email"): Xrm.PageTab<Tabs.Email>;
      get(name: string): undefined;
      get(): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>[];
      get(index: number): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>;
      get(chooser: (item: Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>, index: number) => boolean): Xrm.PageTab<Xrm.Collection<Xrm.PageSection>>[];
    }
  }
  interface Email extends Xrm.PageBase<Email.Attributes,Email.Tabs,Email.Controls> {
    getAttribute(attributeName: "actualdurationminutes"): Xrm.NumberAttribute;
    getAttribute(attributeName: "bcc"): Xrm.LookupAttribute<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
    getAttribute(attributeName: "cc"): Xrm.LookupAttribute<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
    getAttribute(attributeName: "description"): Xrm.Attribute<string>;
    getAttribute(attributeName: "from"): Xrm.LookupAttribute<"queue" | "systemuser">;
    getAttribute(attributeName: "isemailfollowed"): Xrm.OptionSetAttribute<boolean>;
    getAttribute(attributeName: "isemailreminderset"): Xrm.OptionSetAttribute<boolean>;
    getAttribute(attributeName: "ownerid"): Xrm.LookupAttribute<"systemuser" | "team">;
    getAttribute(attributeName: "prioritycode"): Xrm.OptionSetAttribute<email_prioritycode>;
    getAttribute(attributeName: "regardingobjectid"): Xrm.LookupAttribute<"account" | "adx_ad" | "adx_adplacement" | "adx_invitation" | "adx_poll" | "adx_polloption" | "adx_pollplacement" | "adx_pollsubmission" | "adx_publishingstatetransitionrule" | "adx_redirect" | "adx_shortcut" | "adx_webpage" | "adx_website" | "asyncoperation" | "contact" | "knowledgearticle" | "knowledgebaserecord">;
    getAttribute(attributeName: "scheduledend"): Xrm.DateAttribute;
    getAttribute(attributeName: "statuscode"): Xrm.OptionSetAttribute<email_statuscode>;
    getAttribute(attributeName: "subject"): Xrm.Attribute<string>;
    getAttribute(attributeName: "to"): Xrm.LookupAttribute<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
    getAttribute(attributeName: string): undefined;
    getControl(controlName: "actualdurationminutes"): Xrm.NumberControl;
    getControl(controlName: "attachmentsGrid"): Xrm.SubGridControl<"activitymimeattachment">;
    getControl(controlName: "bcc"): Xrm.LookupControl<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
    getControl(controlName: "cc"): Xrm.LookupControl<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
    getControl(controlName: "description"): Xrm.StringControl;
    getControl(controlName: "emailengagementactionscontrol"): Xrm.BaseControl;
    getControl(controlName: "emailrecipientactivitycontrol"): Xrm.BaseControl;
    getControl(controlName: "footer_emailfollowed"): Xrm.OptionSetControl<boolean>;
    getControl(controlName: "footer_emailremainderset"): Xrm.OptionSetControl<boolean>;
    getControl(controlName: "from"): Xrm.LookupControl<"queue" | "systemuser">;
    getControl(controlName: "header_ownerid"): Xrm.LookupControl<"systemuser" | "team">;
    getControl(controlName: "header_prioritycode"): Xrm.OptionSetControl<email_prioritycode>;
    getControl(controlName: "header_scheduledend"): Xrm.DateControl;
    getControl(controlName: "header_statecode"): Xrm.OptionSetControl<email_statuscode>;
    getControl(controlName: "regardingobjectid"): Xrm.LookupControl<"account" | "adx_ad" | "adx_adplacement" | "adx_invitation" | "adx_poll" | "adx_polloption" | "adx_pollplacement" | "adx_pollsubmission" | "adx_publishingstatetransitionrule" | "adx_redirect" | "adx_shortcut" | "adx_webpage" | "adx_website" | "asyncoperation" | "contact" | "knowledgearticle" | "knowledgebaserecord">;
    getControl(controlName: "subject"): Xrm.StringControl;
    getControl(controlName: "to"): Xrm.LookupControl<"account" | "contact" | "knowledgearticle" | "queue" | "systemuser" | "unresolvedaddress">;
    getControl(controlName: string): undefined;
  }
}
