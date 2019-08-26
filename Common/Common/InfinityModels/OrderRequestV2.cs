using System;
using System.Collections.Generic;
using System.Text;

namespace CCMS.Common.InfinityModels
{
    /* 
     Licensed under the Apache License, Version 2.0

     http://www.apache.org/licenses/LICENSE-2.0
     */
    using System;
    using System.Xml.Serialization;
    using System.Collections.Generic;
    namespace Xml2CSharp
    {
        [XmlRoot(ElementName = "Password", Namespace = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd")]
        public class Password
        {
            [XmlAttribute(AttributeName = "Type")]
            public string Type { get; set; }
            [XmlText]
            public string Text { get; set; }
        }

        [XmlRoot(ElementName = "UsernameToken", Namespace = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd")]
        public class UsernameToken
        {
            [XmlElement(ElementName = "Username", Namespace = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd")]
            public string Username { get; set; }
            [XmlElement(ElementName = "Password", Namespace = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd")]
            public Password Password { get; set; }
            [XmlAttribute(AttributeName = "wsu", Namespace = "http://www.w3.org/2000/xmlns/")]
            public string Wsu { get; set; }
            [XmlAttribute(AttributeName = "Id", Namespace = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd")]
            public string Id { get; set; }
        }

        [XmlRoot(ElementName = "Security", Namespace = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd")]
        public class Security
        {
            [XmlElement(ElementName = "UsernameToken", Namespace = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd")]
            public UsernameToken UsernameToken { get; set; }
            [XmlAttribute(AttributeName = "wsse", Namespace = "http://www.w3.org/2000/xmlns/")]
            public string Wsse { get; set; }
        }

        [XmlRoot(ElementName = "Header", Namespace = "http://schemas.xmlsoap.org/soap/envelope/")]
        public class Header
        {
            [XmlElement(ElementName = "Security", Namespace = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd")]
            public Security Security { get; set; }
        }

        [XmlRoot(ElementName = "customerDetails", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
        public class CustomerDetails
        {
            [XmlElement(ElementName = "firstName", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string FirstName { get; set; }
            [XmlElement(ElementName = "lastName", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string LastName { get; set; }
            [XmlElement(ElementName = "address1", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string Address1 { get; set; }
            [XmlElement(ElementName = "address2", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string Address2 { get; set; }
            [XmlElement(ElementName = "city", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string City { get; set; }
            [XmlElement(ElementName = "permanent", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string Permanent { get; set; }
            [XmlElement(ElementName = "customerType", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string CustomerType { get; set; }
        }

        [XmlRoot(ElementName = "deliveryDetails", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
        public class DeliveryDetails
        {
            [XmlElement(ElementName = "deliveryName", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string DeliveryName { get; set; }
            [XmlElement(ElementName = "deliveryStreetAddress", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string DeliveryStreetAddress { get; set; }
            [XmlElement(ElementName = "deliverySuburb", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string DeliverySuburb { get; set; }
            [XmlElement(ElementName = "city", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string City { get; set; }
            [XmlElement(ElementName = "deliveryOption", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string DeliveryOption { get; set; }
        }

        [XmlRoot(ElementName = "orderHeader", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
        public class OrderHeader
        {
            [XmlElement(ElementName = "customerDetails", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public CustomerDetails CustomerDetails { get; set; }
            [XmlElement(ElementName = "customerReference", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string CustomerReference { get; set; }
            [XmlElement(ElementName = "deliveryDetails", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public DeliveryDetails DeliveryDetails { get; set; }
            [XmlElement(ElementName = "applicationNote", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string ApplicationNote { get; set; }
            [XmlElement(ElementName = "overseasOrder", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string OverseasOrder { get; set; }
            [XmlElement(ElementName = "location", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string Location { get; set; }
            [XmlElement(ElementName = "userID", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string UserID { get; set; }
            [XmlElement(ElementName = "applicationSource", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string ApplicationSource { get; set; }
            [XmlElement(ElementName = "computerLocation", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string ComputerLocation { get; set; }
        }

        [XmlRoot(ElementName = "genericFields", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
        public class GenericFields
        {
            [XmlElement(ElementName = "eventDateFrom", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string EventDateFrom { get; set; }
            [XmlElement(ElementName = "placeOfEvent", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string PlaceOfEvent { get; set; }
            [XmlElement(ElementName = "registrationNumber", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string RegistrationNumber { get; set; }
            [XmlElement(ElementName = "fathersSurname", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string FathersSurname { get; set; }
            [XmlElement(ElementName = "fathersGivenNames", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string FathersGivenNames { get; set; }
            [XmlElement(ElementName = "personSurname", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string PersonSurname { get; set; }
            [XmlElement(ElementName = "personGivenNames", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string PersonGivenNames { get; set; }
        }

        [XmlRoot(ElementName = "orderLines", Namespace = "http://infinity.triquestra.com/schema/ordermessage")]
        public class OrderLines
        {
            [XmlElement(ElementName = "UPC", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string UPC { get; set; }
            [XmlElement(ElementName = "qty", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string Qty { get; set; }
            [XmlElement(ElementName = "orderStatus", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string OrderStatus { get; set; }
            [XmlElement(ElementName = "lineNumber", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string LineNumber { get; set; }
            [XmlElement(ElementName = "genericFields", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public GenericFields GenericFields { get; set; }
            [XmlElement(ElementName = "categoryId", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string CategoryId { get; set; }
        }

        [XmlRoot(ElementName = "orderPayments", Namespace = "http://infinity.triquestra.com/schema/ordermessage")]
        public class OrderPayments
        {
            [XmlElement(ElementName = "amount", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string Amount { get; set; }
            [XmlElement(ElementName = "paymentID", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string PaymentID { get; set; }
            [XmlElement(ElementName = "paymentRef1", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string PaymentRef1 { get; set; }
            [XmlElement(ElementName = "paymentRef2", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public string PaymentRef2 { get; set; }
        }

        [XmlRoot(ElementName = "insertOrderRequest", Namespace = "http://infinity.triquestra.com/schema/ordermessage")]
        public class InsertOrderRequest
        {
            [XmlElement(ElementName = "orderHeader", Namespace = "http://infinity.triquestra.com/schema/orderdata")]
            public OrderHeader OrderHeader { get; set; }
            [XmlElement(ElementName = "orderLines", Namespace = "http://infinity.triquestra.com/schema/ordermessage")]
            public OrderLines OrderLines { get; set; }
            [XmlElement(ElementName = "orderPayments", Namespace = "http://infinity.triquestra.com/schema/ordermessage")]
            public OrderPayments OrderPayments { get; set; }
        }

        [XmlRoot(ElementName = "Body", Namespace = "http://schemas.xmlsoap.org/soap/envelope/")]
        public class Body
        {
            [XmlElement(ElementName = "insertOrderRequest", Namespace = "http://infinity.triquestra.com/schema/ordermessage")]
            public InsertOrderRequest InsertOrderRequest { get; set; }
        }

        [XmlRoot(ElementName = "Envelope", Namespace = "http://schemas.xmlsoap.org/soap/envelope/")]
        public class Envelope
        {
            [XmlElement(ElementName = "Header", Namespace = "http://schemas.xmlsoap.org/soap/envelope/")]
            public Header Header { get; set; }
            [XmlElement(ElementName = "Body", Namespace = "http://schemas.xmlsoap.org/soap/envelope/")]
            public Body Body { get; set; }
            [XmlAttribute(AttributeName = "soapenv", Namespace = "http://www.w3.org/2000/xmlns/")]
            public string Soapenv { get; set; }
            [XmlAttribute(AttributeName = "ord", Namespace = "http://www.w3.org/2000/xmlns/")]
            public string Ord { get; set; }
            [XmlAttribute(AttributeName = "ord1", Namespace = "http://www.w3.org/2000/xmlns/")]
            public string Ord1 { get; set; }
        }

    }
}
