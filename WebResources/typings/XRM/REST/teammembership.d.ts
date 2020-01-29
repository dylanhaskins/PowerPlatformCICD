declare namespace Rest {
  interface TeamMembershipBase extends RestEntity {
    SystemUserId?: string | null;
    TeamId?: string | null;
    TeamMembershipId?: string | null;
    VersionNumber?: number | null;
  }
  interface TeamMembership extends TeamMembershipBase {
    teammembership_association?: SystemUser[] | null;
  }
  interface TeamMembershipResult extends TeamMembershipBase {
    teammembership_association?: SDK.Results<SystemUserResult> | null;
  }
  interface TeamMembership_Select extends TeamMembership_Expand {
    SystemUserId: RestAttribute<TeamMembership_Select>;
    TeamId: RestAttribute<TeamMembership_Select>;
    TeamMembershipId: RestAttribute<TeamMembership_Select>;
    VersionNumber: RestAttribute<TeamMembership_Select>;
  }
  interface TeamMembership_Filter {
    SystemUserId: XQR.Guid;
    TeamId: XQR.Guid;
    TeamMembershipId: XQR.Guid;
    VersionNumber: number;
  }
  interface TeamMembership_Expand {
    teammembership_association: RestExpand<TeamMembership_Select, SystemUser_Select>;
  }
}
interface RestEntities {
  TeamMembership: RestMapping<Rest.TeamMembership,Rest.TeamMembership_Select,Rest.TeamMembership_Expand,Rest.TeamMembership_Filter,Rest.TeamMembershipResult>;
}
