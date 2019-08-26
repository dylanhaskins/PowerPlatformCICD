using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.IDALModel
{

    [DataContract]
    public class PersonImage
    {

        [DataMember(Name = "imageID", EmitDefaultValue = false)]
        public string imageID { get; set; }

        [DataMember(Name = "image", EmitDefaultValue = false)]
        public string image { get; set; }

        [DataMember(Name = "imagePath", EmitDefaultValue = false)]
        public string imagePath { get; set; }
        [DataMember(Name = "additionalProp1", EmitDefaultValue = false)]
        public object additionalProp1 { get; set; }
    }
}
