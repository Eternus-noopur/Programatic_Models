/**
* @description: Batch for fetching the list of queries of users and sending response 
                back to the users through the email.
* @author: Noopur Naik
*
* @revision:
* Version      Date            Description
* ------------------------------------------------
* 1.0          30-Jun-2017     Initial revision.
**/

global class BatchForSendingResponse implements Database.Batchable<sobject>,Database.stateful {
    
    String query = 'Select Id, Email_Subject__c, (Select Id, Links__c From Search_Results__r limit 50000),'+ 
                    '(Select Id, Contact_Name__c ,Contact_Name__r.email From Contact_Email_Handler_Junctions__r where IsResponded__c = False)'+
                    'From Email_Handler__c where id in'+ 
                    '(Select Search_Query__c From Contact_Email_Handler_Junction__c)';
    global Database.QueryLocator start(Database.BatchableContext BC) {
       return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, list<Email_Handler__c> emailhandler)
    {
        BatchForSendingResponseHandler.recordsBasedOnResponse(emailhandler);
        
    }
    global void finish(Database.batchableContext bc)
    {
        
    }
    
}