using Microsoft.Xrm.Tooling.PackageDeployment.CrmPackageExtentionBase;
using System;
using System.ComponentModel.Composition;

namespace Deployment
{
    [Export(typeof(IImportExtensions))]
    public class AddName : ImportExtension
    {
        public override string GetLongNameOfImport => "AddName";

        public override string GetImportPackageDataFolderName => "AddName";

        public override string GetImportPackageDescriptionText => "AddName";

        public override bool AfterPrimaryImport()
        {
            return true;
        }

        public override bool BeforeImportStage()
        {
            return true;
        }

        public override string GetNameOfImport(bool plural)
        {
            return "AddName";
        }

        public override void InitializeCustomExtension()
        {
            //Do Nothing
        }

        public override UserRequestedImportAction OverrideSolutionImportDecision(string solutionUniqueName, Version organizationVersion, Version packageSolutionVersion, Version inboundSolutionVersion, Version deployedSolutionVersion, ImportAction systemSelectedImportAction)
        {
            return ((systemSelectedImportAction == ImportAction.Import) && solutionUniqueName.Contains("Patch"))
                ? UserRequestedImportAction.ForceUpdate
                : base.OverrideSolutionImportDecision(solutionUniqueName, organizationVersion, packageSolutionVersion,
                    inboundSolutionVersion, deployedSolutionVersion, systemSelectedImportAction);

        }

    }
}
