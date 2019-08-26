using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;

namespace CCMS.Common.NZPostModel
{

    [DataContract]
    public class NZPostAddressSuggestions
    {
        [DataMember(Name = "addresses")]
        public List<NZPostAddressSuggestion> addresses { get; set; }
    }
    [DataContract]
    public class NZPostAddressSuggestion
    {
        [DataMember(Name = "SourceDesc")]
        public string SourceDesc { get; set; }
        [DataMember(Name = "DPID")]
        public string DPID { get; set; }
        [DataMember(Name = "FullAddress")]
        public string FullAddress { get; set; }
    }
    [DataContract]
    public class NZPostAddressDetails
    {
        [DataMember(Name = "details")]
        public List<NZPostAddressDetail> Detail { get; set; }
    }
    [DataContract]
    public class NZPostAddressDetail
    {
        [DataMember(Name = "DPID")]
        public string DPID { get; set; }
        [DataMember(Name = "AddressLine1")]
        public string AddressLine1 { get; set; }

        [DataMember(Name = "AddressLine2")]
        public string AddressLine2 { get; set; }
        [DataMember(Name = "AddressLine3")]
        public string AddressLine3 { get; set; }
        [DataMember(Name = "AddressLine4")]
        public string AddressLine4 { get; set; }
        [DataMember(Name = "AddressLine5")]
        public string AddressLine5 { get; set; }
        [DataMember(Name = "Postcode")]
        public string Postcode { get; set; }
        [DataMember(Name = "SourceDesc")]
        public string SourceDesc { get; set; }
        [DataMember(Name = "Deliverable")]
        public string Deliverable { get; set; }
        [DataMember(Name = "Physical")]
        public string Physical { get; set; }
        [DataMember(Name = "UnitType")]
        public string UnitType { get; set; }
        [DataMember(Name = "UnitValue")]
        public string UnitValue { get; set; }
        [DataMember(Name = "Floor")]
        public string Floor { get; set; }
        [DataMember(Name = "StreetNumber")]
        public string StreetNumber { get; set; }
        [DataMember(Name = "StreetAlpha")]
        public string StreetAlpha { get; set; }
        [DataMember(Name = "RoadName")]
        public string RoadName { get; set; }
        [DataMember(Name = "RoadTypeName")]
        public string RoadTypeName { get; set; }
        [DataMember(Name = "RoadSuffixName")]
        public string RoadSuffixName { get; set; }
        [DataMember(Name = "Suburb")]
        public string Suburb { get; set; }
        [DataMember(Name = "RuralDelivery")]
        public string RuralDelivery { get; set; }
        [DataMember(Name = "Lobby")]
        public string Lobby { get; set; }
        [DataMember(Name = "CityTown")]
        public string CityTown { get; set; }
        [DataMember(Name = "MailTown")]
        public string MailTown { get; set; }
        [DataMember(Name = "BoxBagNumber")]
        public string BoxBagNumber { get; set; }
        [DataMember(Name = "BoxBagType")]
        public string BoxBagType { get; set; }
        [DataMember(Name = "ParcelId")]
        public string ParcelId { get; set; }
    }

    public class NZPostAuthResponse
    {
        [DataMember]
        public string access_token;
        [DataMember]
        public string token_type;
        [DataMember]
        public int expires_in;
    }

}
