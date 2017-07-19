/**
* @description: Test class for SerchQuerytrigger which is created to to test
                the functionality of SearchQueryTrigger.
* @author: Noopur Naik
*
* @revision:
* Version      Date            Description
* ------------------------------------------------
* 1.0          30-Jun-2017     Initial revision.
**/
@isTest
private class SearchQueryTriggerTestClass {

    static testMethod void checkForCreationOfNewObject() {
        system.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        system.Test.startTest();
            list<Email_Handler__c> emailHandlerList = EmailhandlerFactory.createEvents(1,True);
        system.Test.stopTest();
        list<Search_Result__c> searchResultList = [Select id from Search_Result__c ];
        system.assertEquals(1,searchResultList.size());
    }
    
 /*   static testMethod void checkForCreationOfNewObjectBulk() {
        system.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        system.Test.startTest();
            list<Email_Handler__c> emailHandlerList = EmailhandlerFactory.createEvents(10,True);
        system.Test.stopTest();
        list<Search_Result__c> searchResultList = [Select id from Search_Result__c ];
        system.assertEquals(10,searchResultList.size());
    }
 */ 
}