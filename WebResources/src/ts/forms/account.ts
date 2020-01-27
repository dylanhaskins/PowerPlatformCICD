

namespace Demo.Account {
  var Form: Form.account.Main.Account;

  export function onLoad(executionContext: Xrm.ExecutionContext<any>) {
    Form = <Form.account.Main.Account>executionContext.getFormContext();
    // Code here..
    Form.getAttribute("firstname");
  }
}