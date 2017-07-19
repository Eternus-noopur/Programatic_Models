/**
* @description: Test class for Batch scheduler which is created to to test
                the functionality of Batch scheduler.
* @author: Noopur Naik
*
* @revision:
* Version      Date            Description
* ------------------------------------------------
* 1.0          2-July-2017     Initial revision.
**/
@isTest
public class SearchEngineBatchTestClass {

    static testMethod void checkForSuccessfullReplyToTheUser() {
        List<Contact_Email_Handler_Junction__c> contactEmailhandlerList = ContactEmailHandlerFactory.createEvents(1,True);
        system.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        system.test.startTest();
               BatchForSendingResponse batchObj = new BatchForSendingResponse();
               Database.executeBatch(batchObj);
        system.test.stopTest();
        
        List<Contact_Email_Handler_Junction__c> contactEmailJunction = [Select id,isResponded__c from Contact_Email_Handler_Junction__c limit 1];
        system.assertEquals(true,contactEmailJunction[0].IsResponded__c);
        
    }
    
    static testMethod void checkForSuccessfullReplyToTheUserBulk() {
        List<Contact_Email_Handler_Junction__c> contactEmailhandlerList = ContactEmailHandlerFactory.createEvents(10,True);
        system.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        system.test.startTest();
               BatchForSendingResponse batchObj = new BatchForSendingResponse();
               Database.executeBatch(batchObj);
        system.test.stopTest();
        
        List<Contact_Email_Handler_Junction__c> contactEmailJunction = [Select id,isResponded__c from Contact_Email_Handler_Junction__c];
        For(Contact_Email_Handler_Junction__c contactEmailJuc :contactEmailJunction)
        {
            system.assertEquals(true,contactEmailJuc.IsResponded__c);
        }
        
    }
}