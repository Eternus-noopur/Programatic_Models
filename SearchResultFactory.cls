/**
* @description: This is the data factory for Search_Result__c object where dummy records 
                are created and inserted and furthur used in the test class.
* @author: Noopur Naik
*
* @revision:
* Version      Date            Description
* ------------------------------------------------
* 1.0          30-Jun-2017     Initial revision.
**/
@isTest
private class SearchResultFactory {
    
    public static List<Search_Result__c> createEvents(Integer count, Boolean toBeInserted) {
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
}