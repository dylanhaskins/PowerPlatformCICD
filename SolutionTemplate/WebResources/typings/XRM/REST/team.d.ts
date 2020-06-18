declare namespace Rest {
  interface TeamBase extends RestEntity {
    AdministratorId?: SDK.EntityReference | null;
    AzureActiveDirectoryObjectId?: string | null;
    BusinessUnitId?: SDK.EntityReference | null;
    CreatedBy?: SDK.EntityReference | null;
    CreatedOn?: Date | null;
    CreatedOnBehalfBy?: SDK.EntityReference | null;
    Description?: string | null;
    EMailAddress?: string | null;
    ExchangeRate?: string | null;
    ImportSequenceNumber?: number | null;
    IsDefault?: boolean | null;
    ModifiedBy?: SDK.EntityReference | null;
    ModifiedOn?: Date | null;
    ModifiedOnBehalfBy?: SDK.EntityReference | null;
    Name?: string | null;
    OrganizationId?: string | null;
    OverriddenCreatedOn?: Date | null;
    ProcessId?: string | null;
    QueueId?: SDK.EntityReference | null;
    RegardingObjectId?: SDK.EntityReference | null;
    StageId?: string | null;
    SystemManaged?: boolean | null;
    TeamId?: string | null;
    TeamTemplateId?: SDK.EntityReference | null;
    TeamType?: SDK.OptionSet<team_type> | null;
    TransactionCurrencyId?: SDK.EntityReference | null;
    TraversedPath?: string | null;
    VersionNumber?: number | null;
  }
  interface Team extends TeamBase {
    business_unit_teams?: BusinessUnit | null;
    lk_team_createdonbehalfby?: SystemUser | null;
    lk_team_modifiedonbehalfby?: SystemUser | null;
    lk_teambase_administratorid?: SystemUser | null;
    lk_teambase_createdby?: SystemUser | null;
    lk_teambase_modifiedby?: SystemUser | null;
    team_connections1?: Connection[] | null;
    team_connections2?: Connection[] | null;
    teammembership_association?: SystemUser[] | null;
  }
  interface TeamResult extends TeamBase {
    business_unit_teams?: BusinessUnit | null;
    lk_team_createdonbehalfby?: SystemUser | null;
    lk_team_modifiedonbehalfby?: SystemUser | null;
    lk_teambase_administratorid?: SystemUser | null;
    lk_teambase_createdby?: SystemUser | null;
    lk_teambase_modifiedby?: SystemUser | null;
    team_connections1?: SDK.Results<ConnectionResult> | null;
    team_connections2?: SDK.Results<ConnectionResult> | null;
    teammembership_association?: SDK.Results<SystemUserResult> | null;
  }
  interface Team_Select extends Team_Expand {
    AdministratorId: RestAttribute<Team_Select>;
    AzureActiveDirectoryObjectId: RestAttribute<Team_Select>;
    BusinessUnitId: RestAttribute<Team_Select>;
    CreatedBy: RestAttribute<Team_Select>;
    CreatedOn: RestAttribute<Team_Select>;
    CreatedOnBehalfBy: RestAttribute<Team_Select>;
    Description: RestAttribute<Team_Select>;
    EMailAddress: RestAttribute<Team_Select>;
    ExchangeRate: RestAttribute<Team_Select>;
    ImportSequenceNumber: RestAttribute<Team_Select>;
    IsDefault: RestAttribute<Team_Select>;
    ModifiedBy: RestAttribute<Team_Select>;
    ModifiedOn: RestAttribute<Team_Select>;
    ModifiedOnBehalfBy: RestAttribute<Team_Select>;
    Name: RestAttribute<Team_Select>;
    OrganizationId: RestAttribute<Team_Select>;
    OverriddenCreatedOn: RestAttribute<Team_Select>;
    ProcessId: RestAttribute<Team_Select>;
    QueueId: RestAttribute<Team_Select>;
    RegardingObjectId: RestAttribute<Team_Select>;
    StageId: RestAttribute<Team_Select>;
    SystemManaged: RestAttribute<Team_Select>;
    TeamId: RestAttribute<Team_Select>;
    TeamTemplateId: RestAttribute<Team_Select>;
    TeamType: RestAttribute<Team_Select>;
    TransactionCurrencyId: RestAttribute<Team_Select>;
    TraversedPath: RestAttribute<Team_Select>;
    VersionNumber: RestAttribute<Team_Select>;
  }
  interface Team_Filter {
    AdministratorId: XQR.EntityReferenceFilter;
    AzureActiveDirectoryObjectId: XQR.Guid;
    BusinessUnitId: XQR.EntityReferenceFilter;
    CreatedBy: XQR.EntityReferenceFilter;
    CreatedOn: Date;
    CreatedOnBehalfBy: XQR.EntityReferenceFilter;
    Description: string;
    EMailAddress: string;
    ExchangeRate: any;
    ImportSequenceNumber: number;
    IsDefault: boolean;
    ModifiedBy: XQR.EntityReferenceFilter;
    ModifiedOn: Date;
    ModifiedOnBehalfBy: XQR.EntityReferenceFilter;
    Name: string;
    OrganizationId: XQR.Guid;
    OverriddenCreatedOn: Date;
    ProcessId: XQR.Guid;
    QueueId: XQR.EntityReferenceFilter;
    RegardingObjectId: XQR.EntityReferenceFilter;
    StageId: XQR.Guid;
    SystemManaged: boolean;
    TeamId: XQR.Guid;
    TeamTemplateId: XQR.EntityReferenceFilter;
    TeamType: XQR.ValueContainerFilter<team_type>;
    TransactionCurrencyId: XQR.EntityReferenceFilter;
    TraversedPath: string;
    VersionNumber: number;
  }
  interface Team_Expand {
    business_unit_teams: RestExpand<Team_Select, BusinessUnit_Select>;
    lk_team_createdonbehalfby: RestExpand<Team_Select, SystemUser_Select>;
    lk_team_modifiedonbehalfby: RestExpand<Team_Select, SystemUser_Select>;
    lk_teambase_administratorid: RestExpand<Team_Select, SystemUser_Select>;
    lk_teambase_createdby: RestExpand<Team_Select, SystemUser_Select>;
    lk_teambase_modifiedby: RestExpand<Team_Select, SystemUser_Select>;
    team_connections1: RestExpand<Team_Select, Connection_Select>;
    team_connections2: RestExpand<Team_Select, Connection_Select>;
    teammembership_association: RestExpand<Team_Select, SystemUser_Select>;
  }
}
interface RestEntities {
  Team: RestMapping<Rest.Team,Rest.Team_Select,Rest.Team_Expand,Rest.Team_Filter,Rest.TeamResult>;
}
