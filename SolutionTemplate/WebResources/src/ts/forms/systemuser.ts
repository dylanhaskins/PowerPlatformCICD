import { GetDate } from '../../../../../Common/TypescriptLibraries/DateHelper'; //Sample Import from Common TypeScript Helper Library

let Form: Form.systemuser.Main.User;
let BaseForm: Xrm.BasicPage;

const OnLoad = function (executionContext: Xrm.ExecutionContext<any, any>) {
    Form = <Form.systemuser.Main.User>executionContext.getFormContext();
    // Code here..
    Form.getAttribute("firstname");
};

export { OnLoad };
