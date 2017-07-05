/**
* @description: This is the handler for BatchForSendingResponse.In this all the
                contacts are fetched from Contact_Email_Handler__c where IsResponded
                field is not checked to true and response is sent back to them and 
                Isresponded field is checked to true.
* @author: Noopur Naik
*
* @revision:
* Version      Date            Description
* ------------------------------------------------
* 1.0          30-Jun-2017     Initial revision.
**/
@isTest
public class SearchEngineSchedularTestClass {
       static testMethod void myUnitTest() {
        system.Test.startTest();
        SchedularForSearchEngineBatch responseObj = new SchedularForSearchEngineBatch();
        String cronEXP = '0 0 0/1 * * ?';
        String JobId = System.schedule('ResponseEmailBatch',cronEXP,responseObj);
        CronTrigger ct = [SELECT Id
                                , CronExpression
                                , TimesTriggered
                                , NextFireTime 
                             FROM CronTrigger 
                            WHERE id = :JobId];
        system.Test.stopTest();
        system.assert(JobId!=null);
        system.assertequals('0 0 0/1 * * ?',ct.CronExpression);
        system.assertequals(0,ct.TimesTriggered);
    }
}