/***********************************************************************************

C. Generic Record Creation Engine
1. The third party system will create events in a system to create any sobject's records.
2. There will be a field will hold the JSON of the record & the object name.

 JSON : {
 Name : Eternus Solutions
 }
 Object Name : Account
3. so create a process which will execute per minute & process the Event's records creating the
respective sObject.

****************************************************************************************/

global class BatchJSON implements Database.Batchable<sobject>,Database.stateful {
    String query = 'Select JSON__c, IsProcessed__c from Events__c where IsProcessed__c = false';
    global Database.QueryLocator start(Database.BatchableContext BC) {
       return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, list<Events__c> events)
    {
        BatchJSON_Handler.createRecordsBasedOnEvents(events);
    }
    global void finish(Database.batchableContext bc)
    {
        
    }   
}