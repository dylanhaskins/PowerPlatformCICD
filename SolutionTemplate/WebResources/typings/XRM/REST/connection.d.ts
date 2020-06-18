declare namespace Rest {
  interface ConnectionBase extends RestEntity {
    ConnectionId?: string | null;
    CreatedBy?: SDK.EntityReference | null;
    CreatedOn?: Date | null;
    CreatedOnBehalfBy?: SDK.EntityReference | null;
    Description?: string | null;
    EffectiveEnd?: Date | null;
    EffectiveStart?: Date | null;
    EntityImageId?: string | null;
    ExchangeRate?: string | null;
    ImportSequenceNumber?: number | null;
    IsMaster?: boolean | null;
    ModifiedBy?: SDK.EntityReference | null;
    ModifiedOn?: Date | null;
    ModifiedOnBehalfBy?: SDK.EntityReference | null;
    Name?: string | null;
    OverriddenCreatedOn?: Date | null;
    OwnerId?: SDK.EntityReference | null;
    OwningBusinessUnit?: SDK.EntityReference | null;
    OwningTeam?: SDK.EntityReference | null;
    OwningUser?: SDK.EntityReference | null;
    Record1Id?: SDK.EntityReference | null;
    Record1ObjectTypeCode?: SDK.OptionSet<connection_record1objecttypecode> | null;
    Record1RoleId?: SDK.EntityReference | null;
    Record2Id?: SDK.EntityReference | null;
    Record2ObjectTypeCode?: SDK.OptionSet<connection_record2objecttypecode> | null;
    Record2RoleId?: SDK.EntityReference | null;
    RelatedConnectionId?: SDK.EntityReference | null;
    StateCode?: SDK.OptionSet<connection_statecode> | null;
    StatusCode?: SDK.OptionSet<connection_statuscode> | null;
    TransactionCurrencyId?: SDK.EntityReference | null;
    VersionNumber?: number | null;
  }
  interface Connection extends ConnectionBase {
    Referencedconnection_related_connection?: Connection[] | null;
    Referencingconnection_related_connection?: Connection | null;
    business_unit_connections?: BusinessUnit | null;
    createdby_connection?: SystemUser | null;
    lk_connectionbase_createdonbehalfby?: SystemUser | null;
    lk_connectionbase_modifiedonbehalfby?: SystemUser | null;
    modifiedby_connection?: SystemUser | null;
    owner_connections: Team | null | SystemUser;
    systemuser_connections1?: SystemUser | null;
    systemuser_connections2?: SystemUser | null;
    team_connections1?: Team | null;
    team_connections2?: Team | null;
  }
  interface ConnectionResult extends ConnectionBase {
    Referencedconnection_related_connection?: SDK.Results<ConnectionResult> | null;
    Referencingconnection_related_connection?: Connection | null;
    business_unit_connections?: BusinessUnit | null;
    createdby_connection?: SystemUser | null;
    lk_connectionbase_createdonbehalfby?: SystemUser | null;
    lk_connectionbase_modifiedonbehalfby?: SystemUser | null;
    modifiedby_connection?: SystemUser | null;
    owner_connections: Team | null | SystemUser;
    systemuser_connections1?: SystemUser | null;
    systemuser_connections2?: SystemUser | null;
    team_connections1?: Team | null;
    team_connections2?: Team | null;
  }
  interface Connection_Select extends Connection_Expand {
    ConnectionId: RestAttribute<Connection_Select>;
    CreatedBy: RestAttribute<Connection_Select>;
    CreatedOn: RestAttribute<Connection_Select>;
    CreatedOnBehalfBy: RestAttribute<Connection_Select>;
    Description: RestAttribute<Connection_Select>;
    EffectiveEnd: RestAttribute<Connection_Select>;
    EffectiveStart: RestAttribute<Connection_Select>;
    EntityImageId: RestAttribute<Connection_Select>;
    ExchangeRate: RestAttribute<Connection_Select>;
    ImportSequenceNumber: RestAttribute<Connection_Select>;
    IsMaster: RestAttribute<Connection_Select>;
    ModifiedBy: RestAttribute<Connection_Select>;
    ModifiedOn: RestAttribute<Connection_Select>;
    ModifiedOnBehalfBy: RestAttribute<Connection_Select>;
    Name: RestAttribute<Connection_Select>;
    OverriddenCreatedOn: RestAttribute<Connection_Select>;
    OwnerId: RestAttribute<Connection_Select>;
    OwningBusinessUnit: RestAttribute<Connection_Select>;
    OwningTeam: RestAttribute<Connection_Select>;
    OwningUser: RestAttribute<Connection_Select>;
    Record1Id: RestAttribute<Connection_Select>;
    Record1ObjectTypeCode: RestAttribute<Connection_Select>;
    Record1RoleId: RestAttribute<Connection_Select>;
    Record2Id: RestAttribute<Connection_Select>;
    Record2ObjectTypeCode: RestAttribute<Connection_Select>;
    Record2RoleId: RestAttribute<Connection_Select>;
    RelatedConnectionId: RestAttribute<Connection_Select>;
    StateCode: RestAttribute<Connection_Select>;
    StatusCode: RestAttribute<Connection_Select>;
    TransactionCurrencyId: RestAttribute<Connection_Select>;
    VersionNumber: RestAttribute<Connection_Select>;
  }
  interface Connection_Filter {
    ConnectionId: XQR.Guid;
    CreatedBy: XQR.EntityReferenceFilter;
    CreatedOn: Date;
    CreatedOnBehalfBy: XQR.EntityReferenceFilter;
    Description: string;
    EffectiveEnd: Date;
    EffectiveStart: Date;
    EntityImageId: XQR.Guid;
    ExchangeRate: any;
    ImportSequenceNumber: number;
    IsMaster: boolean;
    ModifiedBy: XQR.EntityReferenceFilter;
    ModifiedOn: Date;
    ModifiedOnBehalfBy: XQR.EntityReferenceFilter;
    Name: string;
    OverriddenCreatedOn: Date;
    OwnerId: XQR.EntityReferenceFilter;
    OwningBusinessUnit: XQR.EntityReferenceFilter;
    OwningTeam: XQR.EntityReferenceFilter;
    OwningUser: XQR.EntityReferenceFilter;
    Record1Id: XQR.EntityReferenceFilter;
    Record1ObjectTypeCode: XQR.ValueContainerFilter<connection_record1objecttypecode>;
    Record1RoleId: XQR.EntityReferenceFilter;
    Record2Id: XQR.EntityReferenceFilter;
    Record2ObjectTypeCode: XQR.ValueContainerFilter<connection_record2objecttypecode>;
    Record2RoleId: XQR.EntityReferenceFilter;
    RelatedConnectionId: XQR.EntityReferenceFilter;
    StateCode: XQR.ValueContainerFilter<connection_statecode>;
    StatusCode: XQR.ValueContainerFilter<connection_statuscode>;
    TransactionCurrencyId: XQR.EntityReferenceFilter;
    VersionNumber: number;
  }
  interface Connection_Expand {
    Referencedconnection_related_connection: RestExpand<Connection_Select, Connection_Select>;
    Referencingconnection_related_connection: RestExpand<Connection_Select, Connection_Select>;
    business_unit_connections: RestExpand<Connection_Select, BusinessUnit_Select>;
    createdby_connection: RestExpand<Connection_Select, SystemUser_Select>;
    lk_connectionbase_createdonbehalfby: RestExpand<Connection_Select, SystemUser_Select>;
    lk_connectionbase_modifiedonbehalfby: RestExpand<Connection_Select, SystemUser_Select>;
    modifiedby_connection: RestExpand<Connection_Select, SystemUser_Select>;
    owner_connections: RestExpand<Connection_Select, SystemUser_Select & Team_Select>;
    systemuser_connections1: RestExpand<Connection_Select, SystemUser_Select>;
    systemuser_connections2: RestExpand<Connection_Select, SystemUser_Select>;
    team_connections1: RestExpand<Connection_Select, Team_Select>;
    team_connections2: RestExpand<Connection_Select, Team_Select>;
  }
}
interface RestEntities {
  Connection: RestMapping<Rest.Connection,Rest.Connection_Select,Rest.Connection_Expand,Rest.Connection_Filter,Rest.ConnectionResult>;
}
