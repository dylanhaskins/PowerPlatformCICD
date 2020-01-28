declare namespace Rest {
  interface ActivityPartyBase extends RestEntity {
    ActivityId?: SDK.EntityReference | null;
    ActivityPartyId?: string | null;
    AddressUsed?: string | null;
    AddressUsedEmailColumnNumber?: number | null;
    DoNotEmail?: boolean | null;
    DoNotFax?: boolean | null;
    DoNotPhone?: boolean | null;
    DoNotPostalMail?: boolean | null;
    Effort?: number | null;
    ExchangeEntryId?: string | null;
    InstanceTypeCode?: SDK.OptionSet<activityparty_instancetypecode> | null;
    IsPartyDeleted?: boolean | null;
    OwnerId?: SDK.EntityReference | null;
    OwningBusinessUnit?: string | null;
    OwningUser?: string | null;
    ParticipationTypeMask?: SDK.OptionSet<activityparty_participationtypemask> | null;
    PartyId?: SDK.EntityReference | null;
    ScheduledEnd?: Date | null;
    ScheduledStart?: Date | null;
    VersionNumber?: number | null;
  }
  interface ActivityParty extends ActivityPartyBase {
    account_activity_parties?: Account | null;
    contact_activity_parties?: Contact | null;
  }
  interface ActivityPartyResult extends ActivityPartyBase {
    account_activity_parties?: Account | null;
    contact_activity_parties?: Contact | null;
  }
  interface ActivityParty_Select extends ActivityParty_Expand {
    ActivityId: RestAttribute<ActivityParty_Select>;
    ActivityPartyId: RestAttribute<ActivityParty_Select>;
    AddressUsed: RestAttribute<ActivityParty_Select>;
    AddressUsedEmailColumnNumber: RestAttribute<ActivityParty_Select>;
    DoNotEmail: RestAttribute<ActivityParty_Select>;
    DoNotFax: RestAttribute<ActivityParty_Select>;
    DoNotPhone: RestAttribute<ActivityParty_Select>;
    DoNotPostalMail: RestAttribute<ActivityParty_Select>;
    Effort: RestAttribute<ActivityParty_Select>;
    ExchangeEntryId: RestAttribute<ActivityParty_Select>;
    InstanceTypeCode: RestAttribute<ActivityParty_Select>;
    IsPartyDeleted: RestAttribute<ActivityParty_Select>;
    OwnerId: RestAttribute<ActivityParty_Select>;
    OwningBusinessUnit: RestAttribute<ActivityParty_Select>;
    OwningUser: RestAttribute<ActivityParty_Select>;
    ParticipationTypeMask: RestAttribute<ActivityParty_Select>;
    PartyId: RestAttribute<ActivityParty_Select>;
    ScheduledEnd: RestAttribute<ActivityParty_Select>;
    ScheduledStart: RestAttribute<ActivityParty_Select>;
    VersionNumber: RestAttribute<ActivityParty_Select>;
  }
  interface ActivityParty_Filter {
    ActivityId: XQR.EntityReferenceFilter;
    ActivityPartyId: XQR.Guid;
    AddressUsed: string;
    AddressUsedEmailColumnNumber: number;
    DoNotEmail: boolean;
    DoNotFax: boolean;
    DoNotPhone: boolean;
    DoNotPostalMail: boolean;
    Effort: number;
    ExchangeEntryId: string;
    InstanceTypeCode: XQR.ValueContainerFilter<activityparty_instancetypecode>;
    IsPartyDeleted: boolean;
    OwnerId: XQR.EntityReferenceFilter;
    OwningBusinessUnit: XQR.Guid;
    OwningUser: XQR.Guid;
    ParticipationTypeMask: XQR.ValueContainerFilter<activityparty_participationtypemask>;
    PartyId: XQR.EntityReferenceFilter;
    ScheduledEnd: Date;
    ScheduledStart: Date;
    VersionNumber: number;
  }
  interface ActivityParty_Expand {
    account_activity_parties: RestExpand<ActivityParty_Select, Account_Select>;
    contact_activity_parties: RestExpand<ActivityParty_Select, Contact_Select>;
  }
}
interface RestEntities {
  ActivityParty: RestMapping<Rest.ActivityParty,Rest.ActivityParty_Select,Rest.ActivityParty_Expand,Rest.ActivityParty_Filter,Rest.ActivityPartyResult>;
}
