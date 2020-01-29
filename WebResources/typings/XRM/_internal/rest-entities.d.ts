declare namespace Rest {
  interface RestMapping<O, S, E, F, R> {
  }
  interface RestEntity {
  }
  interface BusinessUnitBase extends RestEntity {
  }
  interface BusinessUnitResult extends BusinessUnitBase {
  }
  interface BusinessUnit_Select {
  }
  interface BusinessUnit extends BusinessUnitBase {
  }
  interface SystemUserBase extends RestEntity {
  }
  interface SystemUserResult extends SystemUserBase {
  }
  interface SystemUser_Select {
  }
  interface SystemUser extends SystemUserBase {
  }
  interface TeamBase extends RestEntity {
  }
  interface TeamResult extends TeamBase {
  }
  interface Team_Select {
  }
  interface Team extends TeamBase {
  }
  interface TeamMembershipBase extends RestEntity {
  }
  interface TeamMembershipResult extends TeamMembershipBase {
  }
  interface TeamMembership_Select {
  }
  interface TeamMembership extends TeamMembershipBase {
  }
  interface ConnectionBase extends RestEntity {
  }
  interface ConnectionResult extends ConnectionBase {
  }
  interface Connection_Select {
  }
  interface Connection extends ConnectionBase {
  }
}
