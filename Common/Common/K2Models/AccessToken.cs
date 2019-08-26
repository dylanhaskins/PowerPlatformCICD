using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.K2Models
{
    [DataContract]
    class AccessToken
    {
        //public string token_type;
        [DataMember(Name = "Scope")]
        public string Scope
        {
            get;
            set;
        }
        [DataMember(Name = "ExpiresIn")]
        public string ExpiresIn
        {
            get;
            set;
        }
        [DataMember(Name = "ExpiresOn")]
        public string ExpiresOn
        {
            get;
            set;
        }
        [DataMember(Name = "NotBefore")]
        public string NotBefore
        {
            get;
            set;
        }
        [DataMember(Name = "Resource")]
        public string Resource
        {
            get;
            set;
        }
        [DataMember(Name = "Access_Token")]
        public string Access_Token
        {
            get;
            set;
        }
        [DataMember(Name = "RefreshToken")]
        public string RefreshToken
        {
            get;
            set;
        }
        [DataMember(Name = "IdToken")]
        public string IdToken
        {
            get;
            set;
        }

    }
}
