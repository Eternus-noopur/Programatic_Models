/**
* @description: This is the data factory for Contact_Email_Handler_Junction__c 
                object where dummy records are created and inserted and furthur 
                used in the test class.
* @author: Noopur Naik
*
* @revision:
* Version      Date            Description
* ------------------------------------------------
* 1.0          30-Jun-2017     Initial revision.
**/
@isTest
public class ContactEmailHandlerFactory {

     public static List<Contact_Email_Handler_Junction__c> createEvents(Integer count, Boolean toBeInserted) {
        List<Contact_Email_Handler_Junction__c> newList = new List<Contact_Email_Handler_Junction__c>();
        List<Email_Handler__c> emailHandler = EmailhandlerFactory.createEvents(1,True);
        List<Contact> contactList = ContactFactoryNew.createAndInsertContacts(1);
        
        for (Integer i = 1; i <= count; i++) {
            Contact_Email_Handler_Junction__c contactEmailJunction = new Contact_Email_Handler_Junction__c();
            contactEmailJunction.Search_Query__c = emailHandler[0].id;
            contactEmailJunction.Contact_Name__c = contactList[0].id;
            newList.add(contactEmailJunction);
        }
        if(toBeInserted) {
            insert newList;
        }
        return newList;
    }
}