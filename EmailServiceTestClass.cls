/**
* @description: Test class for fetchingEmailContents which is created to to test
                the functionality of fetchingEmailContents.
* @author: Noopur Naik
*
* @revision:
* Version      Date            Description
* ------------------------------------------------
* 1.0          30-Jun-2017     Initial revision.
**/
@isTest
public class EmailServiceTestClass {

    static testMethod void checkForNewContactCreation()
    {
        
         Messaging.InboundEmail email = new Messaging.InboundEmail();
         Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
         system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
         system.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
         email.subject = 'Test';
         email.plainTextBody = 'Demo';
         env.fromAddress ='test@test.com';
         email.fromname = 'FirstName LastName';
         
         system.test.startTest();
            FetchingEmailContents fetchEmail = new FetchingEmailContents();
            fetchEmail.handleInboundEmail(email,env);
         system.test.stopTest();
         
         List<contact> contactList = [Select id from contact ];
         List<Email_Handler__c> emaiHandlerList = [Select id from Email_Handler__c ];
         system.assertEquals(1,contactList.size());
         system.assertEquals(1,emaiHandlerList.size());
    }
    
    static testMethod void checkForExistingContactCreation()
    {
         List<Contact> contactList = UnitTestDataFactory.createRecordsInContact(1,True);
         Messaging.InboundEmail email = new Messaging.InboundEmail();
         Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
         system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
         system.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
         email.subject = 'Test';
         email.plainTextBody = 'Demo';
         env.fromAddress ='abc1@gmail.com';
         email.fromname = 'Contact1 Sahu1';
         
         system.test.startTest();
            FetchingEmailContents fetchEmail = new FetchingEmailContents();
            fetchEmail.handleInboundEmail(email,env);
         system.test.stopTest();
         
         List<contact> contacts = [Select id from contact ];
         system.assertEquals(contactList.size(),contacts.size());
    }
    
    static testMethod void checkForExistingEmailHandler()
    {
         List<Email_Handler__c> emailHandlerList = UnitTestDataFactory.createEmailHandlerRecords(1, True);
         Messaging.InboundEmail email = new Messaging.InboundEmail();
         Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
         system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
         system.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
         email.subject = 'Search Query';
         email.plainTextBody = 'Salesforce';
         env.fromAddress ='abc1@gmail.com';
         email.fromname = 'Contact1 Sahu1';
         
         system.test.startTest();
            FetchingEmailContents fetchEmail = new FetchingEmailContents();
            fetchEmail.handleInboundEmail(email,env);
         system.test.stopTest();
         
         List<Email_Handler__c> emailHandler = [Select id from Email_Handler__c ];
         system.assertEquals(emailHandlerList.size(),emailHandler.size());
    }
    
    static testMethod void checkForNewEmailHandlerCreation()
    {
         List<Email_Handler__c> emailHandlerList = UnitTestDataFactory.createEmailHandlerRecords(1,True);
         Messaging.InboundEmail email = new Messaging.InboundEmail();
         Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
         system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
         system.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
         email.subject = 'Search';
         email.plainTextBody = 'Test Query';
         env.fromAddress ='abc1@gmail.com';
         email.fromname = 'Contact1 Sahu1';
         
         system.test.startTest();
            FetchingEmailContents fetchEmail = new FetchingEmailContents();
            fetchEmail.handleInboundEmail(email,env);
         system.test.stopTest();
         
         List<Email_Handler__c> emailHandler = [Select id from Email_Handler__c ];
         system.assertNotEquals(emailHandlerList.size(),emailHandler.size());
    }
    
}