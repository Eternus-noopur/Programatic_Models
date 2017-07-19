/**
* @description: Test class for visual force page controller and test all its
                functionality.
* @author: Noopur Naik
*
* @revision:
* Version      Date            Description
* ------------------------------------------------
* 1.0          2-July-2017     Initial revision.
**/
@isTest
private class PageForDisplayingHistoryTestClass {
    
    static testMethod void defaultPageSizeAndListOfEmailHandlerRecords() {
        List<Email_Handler__c> emailHandlerObj = EmailhandlerFactory.createEvents(1,True);
        system.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        system.test.startTest();
            PageToDisplaySearHistoryController pageToDisplayHistory = new PageToDisplaySearHistoryController();
        system.test.stopTest();     
        List<Email_Handler__c> emailHandlerList = new List<Email_Handler__c> ();
        system.assertEquals(2,pageToDisplayHistory.pageSize);
        system.assertEquals(emailHandlerObj.size(),emailHandlerObj.size());
    }
    
    static testMethod void checkForSerchResult() {
        List<Email_Handler__c> emailHandlerObj = EmailhandlerFactory.createEvents(1,True);
        system.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        system.test.startTest();
            PageToDisplaySearHistoryController pageHostoryObj = new PageToDisplaySearHistoryController();
            pageHostoryObj.showHistory();
        system.test.stopTest();     
        List<Search_Result__c> searchResultList = [Select id from Search_Result__c]; 
        system.assertEquals(2,pageHostoryObj.pageSize);
        system.assertEquals(emailHandlerObj.size(),emailHandlerObj.size());
    }
    
    static testMethod void checkForPagination() {
        List<Email_Handler__c> emailHandlerObj = EmailhandlerFactory.createEvents(10,True);
        system.Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        PageToDisplaySearHistoryController displayHistoryObj = new PageToDisplaySearHistoryController();
        system.test.startTest();
        
          List<Email_Handler__c> displayHistory= displayHistoryObj.getEmailContentList();
          displayHistoryObj.next();
          displayHistoryObj.previous();
        system.test.stopTest();
        system.assertEquals(2,displayHistory.size());
    }
}