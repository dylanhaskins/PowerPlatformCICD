
namespace Demo.Systemuser {
    var Form: Form.systemuser.Main.User;

    export function onLoad(executionContext: Xrm.ExecutionContext<any,any>) {
        Form = <Form.systemuser.Main.User>executionContext.getFormContext();
        // Code here..
        Form.getAttribute("firstname");
    }
}