using System;
using System.Xml.Serialization;
using System.Collections.Generic;

namespace CCMS.Common.InfinityModels
{

    [XmlRoot(ElementName = "customerDetails")]
    public class CustomerDetails
    {
        [XmlElement(ElementName = "firstName")]
        public string FirstName { get; set; }
        [XmlElement(ElementName = "lastName")]
        public string LastName { get; set; }
        [XmlElement(ElementName = "email")]
        public string Email { get; set; }
        [XmlElement(ElementName = "phone1")]
        public string Phone1 { get; set; }
        [XmlElement(ElementName = "customerType")]
        public string CustomerType { get; set; }
    }

    [XmlRoot(ElementName = "orderHeader")]
    public class OrderHeader
    {
        [XmlElement(ElementName = "customerCode")]
        public string CustomerCode { get; set; }
        [XmlElement(ElementName = "customerDetails")]
        public CustomerDetails CustomerDetails { get; set; }
        [XmlElement(ElementName = "customerReference")]
        public string CustomerReference { get; set; }
        [XmlElement(ElementName = "applicationNote")]
        public string ApplicationNote { get; set; }
        [XmlElement(ElementName = "dateReceived")]
        public string DateReceived { get; set; }
        [XmlElement(ElementName = "overseasOrder")]
        public string OverseasOrder { get; set; }
        [XmlElement(ElementName = "location")]
        public string Location { get; set; }
        [XmlElement(ElementName = "applicationSource")]
        public string ApplicationSource { get; set; }
        [XmlElement(ElementName = "computerLocation")]
        public string ComputerLocation { get; set; }
    }

    [XmlRoot(ElementName = "genericFields")]
    public class GenericFields
    {
        [XmlAttribute(AttributeName = "nil", Namespace = "http://www.w3.org/2001/XMLSchema-instance")]
        public string Nil { get; set; }
    }

    [XmlRoot(ElementName = "categoryId")]
    public class CategoryId
    {
        [XmlAttribute(AttributeName = "nil", Namespace = "http://www.w3.org/2001/XMLSchema-instance")]
        public string Nil { get; set; }
    }

    [XmlRoot(ElementName = "orderLines")]
    public class OrderLines
    {
        [XmlElement(ElementName = "UPC")]
        public string UPC { get; set; }
        [XmlElement(ElementName = "qty")]
        public string Qty { get; set; }
        [XmlElement(ElementName = "orderStatus")]
        public string OrderStatus { get; set; }
        [XmlElement(ElementName = "lineNumber")]
        public string LineNumber { get; set; }
        [XmlElement(ElementName = "genericFields")]
        public GenericFields GenericFields { get; set; }
        [XmlElement(ElementName = "categoryId")]
        public CategoryId CategoryId { get; set; }
    }

    [XmlRoot(ElementName = "orderPayments")]
    public class OrderPayments
    {
        [XmlElement(ElementName = "amount")]
        public string Amount { get; set; }
        [XmlElement(ElementName = "paymentID")]
        public string PaymentID { get; set; }
        [XmlElement(ElementName = "paymentRef1")]
        public string PaymentRef1 { get; set; }
        [XmlElement(ElementName = "paymentRef2")]
        public string PaymentRef2 { get; set; }
    }

    [XmlRoot(ElementName = "insertOrderRequest")]
    public class InsertOrderRequest
    {
        [XmlElement(ElementName = "orderHeader")]
        public OrderHeader OrderHeader { get; set; }
        [XmlElement(ElementName = "orderLines")]
        public List<OrderLines> OrderLines { get; set; }
        [XmlElement(ElementName = "orderPayments")]
        public List<OrderPayments> OrderPayments { get; set; }
        [XmlAttribute(AttributeName = "xsi", Namespace = "http://www.w3.org/2000/xmlns/")]
        public string Xsi { get; set; }
        [XmlAttribute(AttributeName = "xsd", Namespace = "http://www.w3.org/2000/xmlns/")]
        public string Xsd { get; set; }
    }
}
