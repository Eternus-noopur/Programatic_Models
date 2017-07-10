/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class CollectionOfClosedWonOpportunityTest {
     @testSetup
   static void setup() {
       List<AccountContactRole> AccountContactRole_List = AccountContactRoleFactory.createAndInsertAccountContactRoles(10);
   }
   static testMethod void testAccount() {
       list <account> fetchedAccount_List;
       system.Test.StartTest();
       fetchedAccount_List = [select id,Name from account];
       System.debug('Account Proper:::::'+fetchedAccount_List);
       System.assertEquals(10, fetchedAccount_List.size());
       system.Test.StopTest();
   }

   static testMethod void testForAccountContactRoleOpportunity() {
       system.Test.StartTest();
       CollectionOfClosedWonOpportunities obj = new CollectionOfClosedWonOpportunities ();
       ID batchprocessid = Database.executeBatch(obj,200);
       AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =: batchprocessid];
       System.debug('Batch Id:::'+a);
       system.Test.StopTest();
   }
}