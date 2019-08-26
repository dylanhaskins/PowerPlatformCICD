using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.Services.CommonService
{
    [DataContract]
    public class SolutionList
    {
        [DataMember]
        public string solutionName { get; set; }
        [DataMember]
        public string solutionVersion { get; set; }
    }


    [DataContract]
    public class SASTokenReponse
    {
        [DataMember]
        public string container { get; set; }
        [DataMember]
        public string storageUri { get; set; }
        [DataMember]
        public string sasToken { get; set; }
    }
}
