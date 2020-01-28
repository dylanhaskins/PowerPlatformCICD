declare namespace SDK {
  namespace REST {
    function createRecord(object: Rest.Account, type: "Account", successCallback: (result: Rest.AccountResult) => any, errorCallback: (err: Error) => any): void;
    function deleteRecord(id: string, type: "Account", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveRecord(id: string, type: "Account", select: string | null, expand: string | null, successCallback: (result: Rest.AccountResult) => any, errorCallback: (err: Error) => any): void;
    function updateRecord(id: string, object: Rest.Account, type: "Account", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveMultipleRecords(type: "Account", options: string, successCallback: (result: Rest.AccountResult[]) => any, errorCallback: (err: Error) => any, onComplete: any): void;
    function createRecord(object: Rest.Contact, type: "Contact", successCallback: (result: Rest.ContactResult) => any, errorCallback: (err: Error) => any): void;
    function deleteRecord(id: string, type: "Contact", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveRecord(id: string, type: "Contact", select: string | null, expand: string | null, successCallback: (result: Rest.ContactResult) => any, errorCallback: (err: Error) => any): void;
    function updateRecord(id: string, object: Rest.Contact, type: "Contact", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveMultipleRecords(type: "Contact", options: string, successCallback: (result: Rest.ContactResult[]) => any, errorCallback: (err: Error) => any, onComplete: any): void;
    function createRecord(object: Rest.Connection, type: "Connection", successCallback: (result: Rest.ConnectionResult) => any, errorCallback: (err: Error) => any): void;
    function deleteRecord(id: string, type: "Connection", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveRecord(id: string, type: "Connection", select: string | null, expand: string | null, successCallback: (result: Rest.ConnectionResult) => any, errorCallback: (err: Error) => any): void;
    function updateRecord(id: string, object: Rest.Connection, type: "Connection", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveMultipleRecords(type: "Connection", options: string, successCallback: (result: Rest.ConnectionResult[]) => any, errorCallback: (err: Error) => any, onComplete: any): void;
    function createRecord(object: Rest.ActivityParty, type: "ActivityParty", successCallback: (result: Rest.ActivityPartyResult) => any, errorCallback: (err: Error) => any): void;
    function deleteRecord(id: string, type: "ActivityParty", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveRecord(id: string, type: "ActivityParty", select: string | null, expand: string | null, successCallback: (result: Rest.ActivityPartyResult) => any, errorCallback: (err: Error) => any): void;
    function updateRecord(id: string, object: Rest.ActivityParty, type: "ActivityParty", successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveMultipleRecords(type: "ActivityParty", options: string, successCallback: (result: Rest.ActivityPartyResult[]) => any, errorCallback: (err: Error) => any, onComplete: any): void;
    function createRecord(object: Rest.RestEntity, type: string, successCallback: (result: Rest.RestEntity) => any, errorCallback: (err: Error) => any): void;
    function deleteRecord(id: string, type: string, successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveRecord(id: string, type: string, select: string | null, expand: string | null, successCallback: (result: Rest.RestEntity) => any, errorCallback: (err: Error) => any): void;
    function updateRecord(id: string, object: Rest.RestEntity, type: string, successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function retrieveMultipleRecords(type: string, options: string, successCallback: (result: Rest.RestEntity[]) => any, errorCallback: (err: Error) => any, onComplete: any): void;
    function associateRecords(parentId: string, parentType: string, relationshipName: string, childId: string, childType: string, successCallBack: () => any, errorCallback: (err: Error) => any): void;
    function disassociateRecords(parentId: string, parentType: string, relationshipName: string, childId: string, childType: string, successCallBack: () => any, errorCallback: (err: Error) => any): void;
  }
}
