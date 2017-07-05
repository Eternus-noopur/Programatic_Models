/**
* @description: Schedular for the search engine batch for scheduling the batch 
                for particular time duration.
* @author: Noopur Naik
*
* @revision:
* Version      Date            Description
* ------------------------------------------------
* 1.0          2-July-2017     Initial revision.
**/
global class SchedularForSearchEngineBatch implements Schedulable {
     global void execute(SchedulableContext ctx)
        {
            BatchForSendingResponse emailHandler = new BatchForSendingResponse();
            Database.executeBatch(emailHandler);
        }
}