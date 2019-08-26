using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.K2Models
{
    [DataContract]
    public class DataFields
    {
        [DataMember(Name = "NumberOrganisations")]
        public int? NumberOrganisations { get; set; }

        [DataMember(Name = "NextOrganisationNumber")]
        public decimal? NextOrganisationNumber { get; set; }
    }

}
