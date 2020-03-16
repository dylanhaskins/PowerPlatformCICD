using Microsoft.Xrm.Tooling.PackageDeployment.CrmPackageExtentionBase;
using System;
using System.ComponentModel.Composition;

namespace PackageDeployer
{
    [Export(typeof(IImportExtensions))]
    public class MasterPackage : ImportExtension
    {
        public override string GetLongNameOfImport => "Master Package";

        public override string GetImportPackageDataFolderName => "PkgFolder";

        public override string GetImportPackageDescriptionText => "Master Package";

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
            return GetLongNameOfImport;
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
