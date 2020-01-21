declare namespace Rest {
  interface devops_EntityBBase extends RestEntity {
    CreatedBy?: SDK.EntityReference | null;
    CreatedOn?: Date | null;
    CreatedOnBehalfBy?: SDK.EntityReference | null;
    ImportSequenceNumber?: number | null;
    ModifiedBy?: SDK.EntityReference | null;
    ModifiedOn?: Date | null;
    ModifiedOnBehalfBy?: SDK.EntityReference | null;
    OverriddenCreatedOn?: Date | null;
    OwnerId?: SDK.EntityReference | null;
    OwningBusinessUnit?: SDK.EntityReference | null;
    OwningTeam?: SDK.EntityReference | null;
    OwningUser?: SDK.EntityReference | null;
    TimeZoneRuleVersionNumber?: number | null;
    UTCConversionTimeZoneCode?: number | null;
    VersionNumber?: number | null;
    devops_EntityBId?: string | null;
    devops_Name?: string | null;
    statecode?: SDK.OptionSet<devops_entityb_statecode> | null;
    statuscode?: SDK.OptionSet<devops_entityb_statuscode> | null;
  }
  interface devops_EntityB extends devops_EntityBBase {
    lk_devops_entityb_createdby?: SystemUser | null;
    lk_devops_entityb_createdonbehalfby?: SystemUser | null;
    lk_devops_entityb_modifiedby?: SystemUser | null;
    lk_devops_entityb_modifiedonbehalfby?: SystemUser | null;
    owner_devops_entityb?: SystemUser | null;
    user_devops_entityb?: SystemUser | null;
  }
  interface devops_EntityBResult extends devops_EntityBBase {
    lk_devops_entityb_createdby?: SystemUser | null;
    lk_devops_entityb_createdonbehalfby?: SystemUser | null;
    lk_devops_entityb_modifiedby?: SystemUser | null;
    lk_devops_entityb_modifiedonbehalfby?: SystemUser | null;
    owner_devops_entityb?: SystemUser | null;
    user_devops_entityb?: SystemUser | null;
  }
  interface devops_EntityB_Select extends devops_EntityB_Expand {
    CreatedBy: RestAttribute<devops_EntityB_Select>;
    CreatedOn: RestAttribute<devops_EntityB_Select>;
    CreatedOnBehalfBy: RestAttribute<devops_EntityB_Select>;
    ImportSequenceNumber: RestAttribute<devops_EntityB_Select>;
    ModifiedBy: RestAttribute<devops_EntityB_Select>;
    ModifiedOn: RestAttribute<devops_EntityB_Select>;
    ModifiedOnBehalfBy: RestAttribute<devops_EntityB_Select>;
    OverriddenCreatedOn: RestAttribute<devops_EntityB_Select>;
    OwnerId: RestAttribute<devops_EntityB_Select>;
    OwningBusinessUnit: RestAttribute<devops_EntityB_Select>;
    OwningTeam: RestAttribute<devops_EntityB_Select>;
    OwningUser: RestAttribute<devops_EntityB_Select>;
    TimeZoneRuleVersionNumber: RestAttribute<devops_EntityB_Select>;
    UTCConversionTimeZoneCode: RestAttribute<devops_EntityB_Select>;
    VersionNumber: RestAttribute<devops_EntityB_Select>;
    devops_EntityBId: RestAttribute<devops_EntityB_Select>;
    devops_Name: RestAttribute<devops_EntityB_Select>;
    statecode: RestAttribute<devops_EntityB_Select>;
    statuscode: RestAttribute<devops_EntityB_Select>;
  }
  interface devops_EntityB_Filter {
    CreatedBy: XQR.EntityReferenceFilter;
    CreatedOn: Date;
    CreatedOnBehalfBy: XQR.EntityReferenceFilter;
    ImportSequenceNumber: number;
    ModifiedBy: XQR.EntityReferenceFilter;
    ModifiedOn: Date;
    ModifiedOnBehalfBy: XQR.EntityReferenceFilter;
    OverriddenCreatedOn: Date;
    OwnerId: XQR.EntityReferenceFilter;
    OwningBusinessUnit: XQR.EntityReferenceFilter;
    OwningTeam: XQR.EntityReferenceFilter;
    OwningUser: XQR.EntityReferenceFilter;
    TimeZoneRuleVersionNumber: number;
    UTCConversionTimeZoneCode: number;
    VersionNumber: number;
    devops_EntityBId: XQR.Guid;
    devops_Name: string;
    statecode: XQR.ValueContainerFilter<devops_entityb_statecode>;
    statuscode: XQR.ValueContainerFilter<devops_entityb_statuscode>;
  }
  interface devops_EntityB_Expand {
    lk_devops_entityb_createdby: RestExpand<devops_EntityB_Select, SystemUser_Select>;
    lk_devops_entityb_createdonbehalfby: RestExpand<devops_EntityB_Select, SystemUser_Select>;
    lk_devops_entityb_modifiedby: RestExpand<devops_EntityB_Select, SystemUser_Select>;
    lk_devops_entityb_modifiedonbehalfby: RestExpand<devops_EntityB_Select, SystemUser_Select>;
    owner_devops_entityb: RestExpand<devops_EntityB_Select, SystemUser_Select>;
    user_devops_entityb: RestExpand<devops_EntityB_Select, SystemUser_Select>;
  }
}
interface RestEntities {
  devops_EntityB: RestMapping<Rest.devops_EntityB,Rest.devops_EntityB_Select,Rest.devops_EntityB_Expand,Rest.devops_EntityB_Filter,Rest.devops_EntityBResult>;
}
