var Demo;
(function (Demo) {
    var Systemuser;
    (function (Systemuser) {
        var Form;
        function onLoad(executionContext) {
            Form = executionContext.getFormContext();
            // Code here..
            Form.getAttribute("firstname");
        }
        Systemuser.onLoad = onLoad;
    })(Systemuser = Demo.Systemuser || (Demo.Systemuser = {}));
})(Demo || (Demo = {}));
//# sourceMappingURL=systemuser.js.map