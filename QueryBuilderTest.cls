@isTest
private class QueryBuilderTest {

    @testSetup
    static void datafactory() 
    {
        AccontFactoryNew.createRecordsInAccount(100);
    }
    static testMethod void testForAccountObject() 
    {
        system.test.startTest();
        QueryBuilderController controller = new QueryBuilderController();
        controller.selectedObj = 'account';
        controller.details();
        system.test.stopTest();
        System.assert(controller.fields != NULL);
        System.assert(controller.fieldnotselected != NULL);
        System.assert(controller.fieldselected.isEmpty());
        System.assertEquals(true,controller.isObjSelected);
        System.assertEquals(controller.feildOptions.size(),controller.fields.size());
        System.assert(controller.selectedfieldOptions.isEmpty());
    }
    static testMethod void testFieldSelectedScenario()
    {
        system.test.startTest();
        QueryBuilderController controller = new QueryBuilderController();
        controller.selectedObj = 'account';
        controller.details();
        controller.selectfields.add('AccountNumber');
        controller.selectfields.add('Name');
        controller.addFields();
        system.test.stopTest();
        System.assert(controller.fieldselected != NULL);
        System.assert(controller.fieldselected.contains('AccountNumber'));
        System.assert(controller.fieldselected.contains('Name'));
        System.assert(!controller.fieldnotselected.contains('AccountNumber'));
        System.assert(!controller.fieldnotselected.contains('Name'));
        controller.selectedfields.add('AccountNumber');
        controller.removeFields();
        System.assert(controller.fieldnotselected.contains('AccountNumber'));
        System.assert(!controller.fieldselected.contains('AccountNumber'));
    }
    static testMethod void testNoneObjectSelectedScenario()
    {
        system.test.startTest();
        QueryBuilderController controller = new QueryBuilderController();
        controller.selectedObj = 'account';
        controller.details();
        controller.selectfields.add('AccountNumber');
        controller.selectfields.add('Name');
        controller.addFields();
        controller.selectedObj = 'None';
        controller.details();
        system.test.stopTest();
        System.assertEquals(false,controller.isObjSelected);
        System.assertEquals(false,controller.isQueryExecuted);
    }
    static testMethod void testExecuteQueryScenario()
    {
        system.test.startTest();
        QueryBuilderController controller = new QueryBuilderController();
        controller.selectedObj = 'account';
        controller.details();
        controller.selectfields.add('AccountNumber');
        controller.selectfields.add('Name');
        controller.addFields();
        controller.queryData();
        system.test.stopTest();
        System.assertEquals(true,controller.isQueryExecuted);
    }
    static testMethod void testExecuteQueryWithNoFieldsScenario()
    {
        system.Test.startTest();
        PageReference pageRef = Page.QueryBuilderPage;
        system.Test.setCurrentPage(pageRef);
        QueryBuilderController controller = new QueryBuilderController();
        controller.selectedObj = 'account';
        controller.details();
        controller.queryData();
        system.Test.stopTest();
        System.assertEquals(false,controller.isQueryExecuted);
        System.assertEquals('SELECT  FROM account ORDER BY Id ASC LIMIT 500',controller.query);
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        System.assertEquals(system.label.FieldSelectionMessage,msgs[0].getDetail());
    }
    static testMethod void testExecuteQueryWithInvalidFieldsScenario()
    {
        system.Test.startTest();
        PageReference pageRef = Page.QueryBuilderPage;
        system.Test.setCurrentPage(pageRef);
        QueryBuilderController controller = new QueryBuilderController();
        controller.selectedObj = 'account';
        controller.details();
        controller.selectfields.add('LastName');
        controller.addFields();
        controller.queryData();
        system.Test.stopTest();
        System.assertEquals(controller.fieldselected.size(),controller.fieldsTobeRetrieved.size());
        System.assertEquals('SELECT LastName FROM account ORDER BY Id ASC LIMIT 500',controller.query);
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        System.assertEquals('No such column \'LastName\' on entity \'Account\'. If you are attempting to use a custom field, be sure to append the \'__c\' after the custom field name. Please reference your WSDL or the describe call for the appropriate names.',msgs[0].getDetail(),'Page is not returing error message even when invalid fields are selected');
    }

}