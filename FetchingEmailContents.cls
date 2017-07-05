/**
* @description: Email Searvice to get the email from the user which consist of 
                search query in the email body.If the user contact does not exist,
                create new contact record and if the user query is new create new
                email_handler__c record.As there is juction between contact and 
                email_handler__c new record must be created in it.
* @author: Noopur Naik
*
* @revision:
* Version      Date            Description
* ------------------------------------------------
* 1.0          28-Jun-2017     Initial revision.
**/


global class FetchingEmailContents implements Messaging.InboundEmailHandler {
    global  String emailHandlerid;
    global  String contactId;
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
    Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
     String contactId;
    
     List<String> contactName =  email.fromname.split(' ');
     String contactEmail = envelope.fromaddress;
     String emailSubject = email.subject;
     String emailBody = email.plainTextBody;
     
     List<Contact> contacts = [SELECT Id
                                 FROM Contact
                                WHERE (FirstName = :contactName[0]
                                  AND LastName = :contactName[1]) 
                                  AND Email =:contactEmail];
      try{
            if (contacts.size() == 0)
            {
                Contact contactObj = new Contact();
                contactObj.FirstName = ContactName[0];
                contactObj.LastName = ContactName[1];
                contactObj.Email = ContactEmail;
                insert contactObj;
                contactId = contactObj.id;
            } 
            else
            {
                contactId = contacts[0].id;
            }
         }
        catch(DMLException e){} 
            
        
        
        
        
        try{
               if(!String.isBlank(emailBody)){
                
               String emailBodyNew = emailBody.split('\n')[0];
               List<Email_Handler__c> emailhandler = [SELECT Id
                                                        FROM Email_Handler__c
                                                       WHERE Email_Body__c = :emailBodyNew];
              
                if(emailhandler.size() != 0 )
                { 
                    emailHandlerid = emailhandler[0].id;
                }
                else
                {
                    
                    Email_Handler__c newEmailHandler = new Email_Handler__c();
                    newEmailHandler.Email_Subject__c =  emailSubject;
                    newEmailHandler.Email_Body__c = emailBodyNew;
                    insert newEmailHandler;
                    emailHandlerid = newEmailHandler.id;
                    
                }
                
/*                Contact_Email_Handler_Junction__c newJunctionRecord = new Contact_Email_Handler_Junction__c();
                newJunctionRecord.Contact_Name__c = contactId;
                newJunctionRecord.Search_Query__c = emailHandlerid;
                insert newJunctionRecord; */
            } 
            else{
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String[] toAddress =new String[]{email.fromAddress};
                mail.setToAddresses(toAddress);
                mail.setSubject('Test subject');
                mail.setplainTextBody('First line cannot be empty..');
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            }
            
       }
        catch(DMLException e){}
        
        System.debug('+++++++++++++++++++++++++++++++++++++++'+contactId);
        System.debug('+++++++++++++++++++++++++++++++++++++++'+emailHandlerid);
        
        try{
                Contact_Email_Handler_Junction__c newJunctionRecord = new Contact_Email_Handler_Junction__c();
                newJunctionRecord.Contact_Name__c = contactId;
                newJunctionRecord.Search_Query__c = emailHandlerid;
                insert newJunctionRecord; 
            }
            catch(DMLException e){} 
            return result;
}
}