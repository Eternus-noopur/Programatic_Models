global with sharing class SchedularToRemoveDuplicateList implements Schedulable{
    global void execute(SchedulableContext ctx)
    {
        RemoveDuplicateLeads leadObject = new RemoveDuplicateLeads();
        Database.executeBatch(leadObject);
    }
}