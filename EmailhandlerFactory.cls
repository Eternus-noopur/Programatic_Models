/**
* @description: This is the data factory for Email_Handler__c object where dummy records 
                are created and inserted and furthur used in the test class.
* @author: Noopur Naik
*
* @revision:
* Version      Date            Description
* ------------------------------------------------
* 1.0          30-Jun-2017     Initial revision.
**/
@isTest
public class EmailhandlerFactory {

        public static List<Email_Handler__c> createEvents(Integer count, Boolean toBeInserted) {
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
}