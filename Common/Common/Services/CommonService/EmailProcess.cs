using CCMS.Entities;
using Microsoft.Crm.Sdk.Messages;
using Microsoft.Xrm.Sdk;
using System;

namespace CCMS.Common.Services.CommonServices
{
    internal class EmailProcessService : BaseService
    {
        public EmailProcessService(IOrganizationService service, IOrganizationService elevatedService, ITracingService trace) : base(service, elevatedService, trace)
        {
        }

        /**
        * <summary>
        * Sends the email. 
        * </summary>
        * <param name="emialId">the ID of the email that is going to be sent to SIS.</param> 
        * */
        public void SendEmail( Guid emailID)
        {
            // create a send email request 
            SendEmailRequest sendEmailreq = new SendEmailRequest
            {
                EmailId = emailID,
                TrackingToken = "",
                IssueSend = true
            };
            // execute the send email request
            SendEmailResponse sendEmailresp = (SendEmailResponse)ElevatedServiceContext.Execute(sendEmailreq);
        }
        /**
        * <summary>
        * Creates a CSV file attachment and adds it to the email that is to be sent to SIS. 
        * </summary>
        * <param name="emailID">the ID of the email that is going to be sent to SIS.</param>
        * <param name="filename">the file name of the attachment</param>
        * <param name="fileBody">the file content of the attachment</param>
        * <param name="subject">the subject of the attachment </param>
        * */
        public void AddAttachmentToEmail( EntityReference entityRef, string filename, string fileBody, string subject)
        {
            ActivityMimeAttachment attachment = new ActivityMimeAttachment()
            {
                ObjectId = entityRef,
                ObjectTypeCode = Email.EntityLogicalName,
                Subject = subject,
                Body = fileBody,
                FileName = filename,
            };
            ElevatedService.Create(attachment.ToEntity<Entity>());

        }
        /**
     * <summary>
     * Creates the email that is going to be sent and returns its ID. 
     * </summary>
     * <param name="fromQueue">ID of the queue the email is going to be sent from</param>
     * <param name="toQueue">ID of the queue the email is going to be sent to</param>
     * <param name="subject">the subject of the email </param>
     * <param name="cbgApplication">Cbg application - null for SIS check and populated for police check.</param>
     * */
        public  Guid CreateEmail( Guid fromQueue, Guid toQueue, string subject, EntityReference entityRef)
        {
            //creating activity party to set To field of the email address
            ActivityParty to = new ActivityParty()
            {
                PartyId = new EntityReference(Queue.EntityLogicalName, toQueue),
            };

            //creating activity party to set From field of the email address
            ActivityParty from = new ActivityParty()
            {
                PartyId = new EntityReference(Queue.EntityLogicalName, fromQueue),
            };

            // create the email to attach file to and send
            Email _emailToUpdate = new Email()
            {
                Id = Guid.NewGuid(),
                From = new ActivityParty[] { from },
                To = new ActivityParty[] { to },
                Subject = subject,
            };
            if (entityRef != null) _emailToUpdate.RegardingObjectId = entityRef;

            Guid emailId = ElevatedService.Create(_emailToUpdate);
            return emailId;
        }
    
    }
}
