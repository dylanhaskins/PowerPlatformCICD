using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.K2Models
{
    [DataContract]
    public class User
    {
        [DataMember(Name = "username")]
        public string Username { get; set; }

        [DataMember(Name = "fqn")]
        public string Fqn { get; set; }

        [DataMember(Name = "email")]
        public string Email { get; set; }

        [DataMember(Name = "manager")]
        public string Manager { get; set; }

        [DataMember(Name = "displayName")]
        public string DisplayName { get; set; }
    }
}
