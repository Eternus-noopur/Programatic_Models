global with sharing class SchedulerForClosedWonOpportunity {
    global void execute(SchedulableContext ctx)
    {
        CollectionOfClosedWonOpportunities closedWonObject = new CollectionOfClosedWonOpportunities();
        Database.executeBatch(closedWonObject);
    }
}