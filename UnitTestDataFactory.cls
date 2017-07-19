/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class UnitTestDataFactory {

    public static List<Contact_Email_Handler_Junction__c> createContactEmailHandlerRecords(Integer count, Boolean toBeInserted) {
        List<Contact_Email_Handler_Junction__c> newList = new List<Contact_Email_Handler_Junction__c>();
        List<Email_Handler__c> emailHandler = EmailhandlerFactory.createEvents(1,True);
        List<Contact> contactList = ContactFactoryNew.createAndInsertContacts(1,'');
        
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
    
    public static List<Email_Handler__c> createEmailHandlerRecords(Integer count, Boolean toBeInserted) {
        List<Email_Handler__c> newList = new List<Email_Handler__c>();
        for (Integer i = 1; i <= count; i++) {
            Email_Handler__c emailHandler = new Email_Handler__c();
            emailHandler.Email_Subject__c = 'Search Query';
            emailHandler.Email_Body__c = 'Salesforce';
            newList.add(emailHandler);
        }
        if(toBeInserted) {
            insert newList;
        }
        return newList;
    }
    
     public static List<Search_Result__c> createSearchResultRecords(Integer count, Boolean toBeInserted) {
        List<Search_Result__c> newList = new List<Search_Result__c>();
        List<Email_Handler__c> emailHandler = EmailhandlerFactory.createEvents(1,True);
        
        for (Integer i = 1; i <= count; i++) {
            Search_Result__c searchResultobject = new Search_Result__c();
            searchResultobject.Search_Query__c = emailHandler[0].id;
            searchResultobject.Links__c = 'www.test.com';
            newList.add(searchResultobject);
        }
        if(toBeInserted) {
            insert newList;
        }
        return newList;
    }
    
    public static List<Contact> createRecordsInContact(Integer count,Boolean toBeInserted)
    {
        List<Contact> contactList=new List<Contact>();
        for(Integer i=1; i<=count;i++)
        {
            Contact contact=new Contact();
            Contact.FirstName='Contact'+i;
            Contact.LastName='Sahu'+i;
            Contact.Email='abc'+i+'@gmail.com';
            Contact.MobilePhone='95036'+i;
            Contact.Phone='95036'+i;
            contact.MailingCity = 'Pune';
            contactList.add(Contact);
        }
        if(toBeInserted) {
            insert contactList;
        }
        return contactList;
    }
}