/**
* @description: Trigger is written on the insert of Email_Handler__c records.
                Whenever the records are inserted trigger is fired and @future 
                method is called which will search for the related links For the
                user queries.
* @author: Noopur Naik
*
* @revision:
* Version      Date            Description
* ------------------------------------------------
* 1.0          29-Jun-2017     Initial revision.
**/

trigger SearchQueryTrigger on Email_Handler__c (after insert) {
    SearchQueryHandler.searchQueryMethod(trigger.new);
}