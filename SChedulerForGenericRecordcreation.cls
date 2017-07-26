global with sharing class SChedulerForGenericRecordcreation {
    global void execute(SchedulableContext ctx)
    {
        BatchJSON batchJSONObject = new BatchJSON();
        Database.executeBatch(batchJSONObject);
    }
}