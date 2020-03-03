using Microsoft.Xrm.Tooling.PackageDeployment.CrmPackageExtentionBase;

namespace PackageDeployer
{
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
    }
}
