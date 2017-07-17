/**
* @description: This is the handler for BatchForSendingResponse.In this all the
                contacts are fetched from Contact_Email_Handler__c where IsResponded
                field is not checked to true and response is sent back to them and 
                Isresponded field is checked to true.
* @author: Noopur Naik
*
* @revision:
* Version      Date            Description
* ------------------------------------------------
* 1.0          30-Jun-2017     Initial revision.
**/

public with sharing class BatchForSendingResponseHandler {
     
     public static void recordsBasedOnResponse(List<Email_Handler__c> emailhandlerList)
     {
        Id templateId = [Select id from EmailTemplate where name=:'SearchEngineTemplateNew'].id;
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        List<Contact_Email_Handler_Junction__c> contactEmailList = new List<Contact_Email_Handler_Junction__c>();
        Messaging.SingleEmailMessage message;
        for(Email_Handler__c emailhandlerobj :emailhandlerList)
        {
            for(Contact_Email_Handler_Junction__c contactEmailObj : emailhandlerobj.Contact_Email_Handler_Junctions__r)
            {      
                message = new Messaging.SingleEmailMessage();
                if(contactEmailObj.Contact_Name__r!=null)
                {
                    Message.setToAddresses(new String[] {contactEmailObj.Contact_Name__r.Email});
                }
                if(emailhandlerobj.Search_Results__r!=null)
                {
                    message.setWhatId(emailhandlerobj.Search_Results__r[0].id);
                }
                if(contactEmailObj.Contact_Name__c!=null)
                {
                    message.setTargetObjectId(contactEmailObj.Contact_Name__c);
                }
                message.setSaveAsActivity(true);
                if(templateId!=null)
                {
                    message.setTemplateId(templateId);
                }
                contactEmailObj.IsResponded__c = true;
                contactEmailList.add(contactEmailObj);
                messaging.sendEmail(new messaging.SingleEmailMessage[] {message});
                mailList.add(Message);
            }
        }
        if(!mailList.isEmpty())
        {
            messaging.sendEmail(mailList);
            try{
                update contactEmailList;
            }catch(DMLException e){
                system.debug('Run time exception...');
            }
        }
     }
}