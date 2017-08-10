@isTest
private class CollectionOfClosedWonOpportunityTest {
    static testMethod void testAccount() {
        List<AccountContactRole> accountContactRoleList = AccountContactRoleFactory.createAndInsertAccountContactRoles(10);
        system.Test.StartTest();
            list <account> fetchedAccountList = [select id,Name from account limit 1000];
        system.Test.StopTest();
        System.assertEquals(accountContactRoleList.size(), fetchedAccountList.size());
    }
    static testMethod void testForAccountContactRoleOpportunity() {
        system.Test.StartTest();
        CollectionOfClosedWonOpportunities batchObj = new CollectionOfClosedWonOpportunities ();
        ID batchprocessid = Database.executeBatch(batchObj,200);
        AsyncApexJob apexJob = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =: batchprocessid];
        system.Test.StopTest();
    }
}