@isTest
private class QueryBuilderTest {

    @testSetup
    static void datafactory() 
    {
        AccontFactoryNew.createRecordsInAccount(100);
    }

    static testMethod void testForAccountObject() 
    {
        system.Test.startTest();
        QueryBuilderController controller = new QueryBuilderController();
        controller.selectedObj = 'account';
        controller.details();
        system.Test.stopTest();
        System.assert(controller.fields != NULL);
        System.assert(controller.fnotselected != NULL);
        System.assert(controller.fselected.isEmpty());
        System.assertEquals(true,controller.isObjSelected);
        System.assertEquals(controller.fnsoptions.size(),controller.fields.size());
        System.assert(controller.fsoptions.isEmpty());
    }

    static testMethod void testFieldSelectedScenario()
    {
        system.Test.startTest();
        QueryBuilderController controller = new QueryBuilderController();
        controller.selectedObj = 'account';
        controller.details();
        controller.sfields.add('AccountNumber');
        controller.sfields.add('Name');
        controller.addFields();
        system.Test.stopTest();
        System.assert(controller.fselected != NULL);
        System.assert(controller.fselected.contains('AccountNumber'));
        System.assert(controller.fselected.contains('Name'));
        System.assert(!controller.fnotselected.contains('AccountNumber'));
        System.assert(!controller.fnotselected.contains('Name'));
        controller.rfields.add('AccountNumber');
        controller.removeFields();
        System.assert(controller.fnotselected.contains('AccountNumber'));
        System.assert(!controller.fselected.contains('AccountNumber'));
    }

    static testMethod void testNoneObjectSelectedScenario()
    {
        system.Test.startTest();
        QueryBuilderController controller = new QueryBuilderController();
        controller.selectedObj = 'account';
        controller.details();
        controller.sfields.add('AccountNumber');
        controller.sfields.add('Name');
        controller.addFields();
        controller.selectedObj = 'None';
        controller.details();
        system.Test.stopTest();
        System.assertEquals(false,controller.isObjSelected);
        System.assertEquals(false,controller.isQueryExecuted);
    }

    static testMethod void testExecuteQueryScenario()
    {
        system.Test.startTest();
        QueryBuilderController controller = new QueryBuilderController();
        controller.selectedObj = 'account';
        controller.details();
        controller.sfields.add('AccountNumber');
        controller.sfields.add('Name');
        controller.addFields();
        System.assertEquals(false,controller.isQueryExecuted);
        controller.queryData();
        System.assertEquals(true,controller.isQueryExecuted);
    }

}