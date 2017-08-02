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