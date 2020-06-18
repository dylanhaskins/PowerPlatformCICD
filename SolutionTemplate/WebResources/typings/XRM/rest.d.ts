declare namespace SDK {
  namespace REST {
    function createRecord(object: Rest.BusinessUnit, type: "BusinessUnit", successCallback: (result: Rest.BusinessUnitResult) => any, errorCallback: (err: Error) => any): void;
    function deleteRecord(id: string, type: "BusinessUnit", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveRecord(id: string, type: "BusinessUnit", select: string | null, expand: string | null, successCallback: (result: Rest.BusinessUnitResult) => any, errorCallback: (err: Error) => any): void;
    function updateRecord(id: string, object: Rest.BusinessUnit, type: "BusinessUnit", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveMultipleRecords(type: "BusinessUnit", options: string, successCallback: (result: Rest.BusinessUnitResult[]) => any, errorCallback: (err: Error) => any, onComplete: any): void;
    function createRecord(object: Rest.SystemUser, type: "SystemUser", successCallback: (result: Rest.SystemUserResult) => any, errorCallback: (err: Error) => any): void;
    function deleteRecord(id: string, type: "SystemUser", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveRecord(id: string, type: "SystemUser", select: string | null, expand: string | null, successCallback: (result: Rest.SystemUserResult) => any, errorCallback: (err: Error) => any): void;
    function updateRecord(id: string, object: Rest.SystemUser, type: "SystemUser", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveMultipleRecords(type: "SystemUser", options: string, successCallback: (result: Rest.SystemUserResult[]) => any, errorCallback: (err: Error) => any, onComplete: any): void;
    function createRecord(object: Rest.Team, type: "Team", successCallback: (result: Rest.TeamResult) => any, errorCallback: (err: Error) => any): void;
    function deleteRecord(id: string, type: "Team", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveRecord(id: string, type: "Team", select: string | null, expand: string | null, successCallback: (result: Rest.TeamResult) => any, errorCallback: (err: Error) => any): void;
    function updateRecord(id: string, object: Rest.Team, type: "Team", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveMultipleRecords(type: "Team", options: string, successCallback: (result: Rest.TeamResult[]) => any, errorCallback: (err: Error) => any, onComplete: any): void;
    function createRecord(object: Rest.TeamMembership, type: "TeamMembership", successCallback: (result: Rest.TeamMembershipResult) => any, errorCallback: (err: Error) => any): void;
    function deleteRecord(id: string, type: "TeamMembership", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveRecord(id: string, type: "TeamMembership", select: string | null, expand: string | null, successCallback: (result: Rest.TeamMembershipResult) => any, errorCallback: (err: Error) => any): void;
    function updateRecord(id: string, object: Rest.TeamMembership, type: "TeamMembership", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveMultipleRecords(type: "TeamMembership", options: string, successCallback: (result: Rest.TeamMembershipResult[]) => any, errorCallback: (err: Error) => any, onComplete: any): void;
    function createRecord(object: Rest.Connection, type: "Connection", successCallback: (result: Rest.ConnectionResult) => any, errorCallback: (err: Error) => any): void;
    function deleteRecord(id: string, type: "Connection", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveRecord(id: string, type: "Connection", select: string | null, expand: string | null, successCallback: (result: Rest.ConnectionResult) => any, errorCallback: (err: Error) => any): void;
    function updateRecord(id: string, object: Rest.Connection, type: "Connection", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveMultipleRecords(type: "Connection", options: string, successCallback: (result: Rest.ConnectionResult[]) => any, errorCallback: (err: Error) => any, onComplete: any): void;
    function createRecord(object: Rest.RestEntity, type: string, successCallback: (result: Rest.RestEntity) => any, errorCallback: (err: Error) => any): void;
    function deleteRecord(id: string, type: string, successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveRecord(id: string, type: string, select: string | null, expand: string | null, successCallback: (result: Rest.RestEntity) => any, errorCallback: (err: Error) => any): void;
    function updateRecord(id: string, object: Rest.RestEntity, type: string, successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveMultipleRecords(type: string, options: string, successCallback: (result: Rest.RestEntity[]) => any, errorCallback: (err: Error) => any, onComplete: any): void;
    function associateRecords(parentId: string, parentType: string, relationshipName: string, childId: string, childType: string, successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function disassociateRecords(parentId: string, parentType: string, relationshipName: string, childId: string, childType: string, successCallBack: () => any, errorCallback: (err: Error) => any): void;
  }
}
