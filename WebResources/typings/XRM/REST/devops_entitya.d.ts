declare namespace Rest {
  interface devops_EntityABase extends RestEntity {
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
    devops_EntityAId?: string | null;
    devops_Name?: string | null;
    statecode?: SDK.OptionSet<devops_entitya_statecode> | null;
    statuscode?: SDK.OptionSet<devops_entitya_statuscode> | null;
  }
  interface devops_EntityA extends devops_EntityABase {
    lk_devops_entitya_createdby?: SystemUser | null;
    lk_devops_entitya_createdonbehalfby?: SystemUser | null;
    lk_devops_entitya_modifiedby?: SystemUser | null;
    lk_devops_entitya_modifiedonbehalfby?: SystemUser | null;
    owner_devops_entitya?: SystemUser | null;
    user_devops_entitya?: SystemUser | null;
  }
  interface devops_EntityAResult extends devops_EntityABase {
    lk_devops_entitya_createdby?: SystemUser | null;
    lk_devops_entitya_createdonbehalfby?: SystemUser | null;
    lk_devops_entitya_modifiedby?: SystemUser | null;
    lk_devops_entitya_modifiedonbehalfby?: SystemUser | null;
    owner_devops_entitya?: SystemUser | null;
    user_devops_entitya?: SystemUser | null;
  }
  interface devops_EntityA_Select extends devops_EntityA_Expand {
    CreatedBy: RestAttribute<devops_EntityA_Select>;
    CreatedOn: RestAttribute<devops_EntityA_Select>;
    CreatedOnBehalfBy: RestAttribute<devops_EntityA_Select>;
    ImportSequenceNumber: RestAttribute<devops_EntityA_Select>;
    ModifiedBy: RestAttribute<devops_EntityA_Select>;
    ModifiedOn: RestAttribute<devops_EntityA_Select>;
    ModifiedOnBehalfBy: RestAttribute<devops_EntityA_Select>;
    OverriddenCreatedOn: RestAttribute<devops_EntityA_Select>;
    OwnerId: RestAttribute<devops_EntityA_Select>;
    OwningBusinessUnit: RestAttribute<devops_EntityA_Select>;
    OwningTeam: RestAttribute<devops_EntityA_Select>;
    OwningUser: RestAttribute<devops_EntityA_Select>;
    TimeZoneRuleVersionNumber: RestAttribute<devops_EntityA_Select>;
    UTCConversionTimeZoneCode: RestAttribute<devops_EntityA_Select>;
    VersionNumber: RestAttribute<devops_EntityA_Select>;
    devops_EntityAId: RestAttribute<devops_EntityA_Select>;
    devops_Name: RestAttribute<devops_EntityA_Select>;
    statecode: RestAttribute<devops_EntityA_Select>;
    statuscode: RestAttribute<devops_EntityA_Select>;
  }
  interface devops_EntityA_Filter {
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
    devops_EntityAId: XQR.Guid;
    devops_Name: string;
    statecode: XQR.ValueContainerFilter<devops_entitya_statecode>;
    statuscode: XQR.ValueContainerFilter<devops_entitya_statuscode>;
  }
  interface devops_EntityA_Expand {
    lk_devops_entitya_createdby: RestExpand<devops_EntityA_Select, SystemUser_Select>;
    lk_devops_entitya_createdonbehalfby: RestExpand<devops_EntityA_Select, SystemUser_Select>;
    lk_devops_entitya_modifiedby: RestExpand<devops_EntityA_Select, SystemUser_Select>;
    lk_devops_entitya_modifiedonbehalfby: RestExpand<devops_EntityA_Select, SystemUser_Select>;
    owner_devops_entitya: RestExpand<devops_EntityA_Select, SystemUser_Select>;
    user_devops_entitya: RestExpand<devops_EntityA_Select, SystemUser_Select>;
  }
}
interface RestEntities {
  devops_EntityA: RestMapping<Rest.devops_EntityA,Rest.devops_EntityA_Select,Rest.devops_EntityA_Expand,Rest.devops_EntityA_Filter,Rest.devops_EntityAResult>;
}
