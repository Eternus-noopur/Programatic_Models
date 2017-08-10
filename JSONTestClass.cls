@isTest

private class JSONTestClass {
    static testMethod void singleInvalidJSON() {
        List<String> jsonField = new List<String>();
        String json = '{"JSON":{"Name":"Batch8"}"Object Name":"Account"}';
        jsonField.add(json);
        EventFactory.createEvents(1, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        Events__c event = [Select IsProcessed__c, Error_If_Any__c from Events__c][0];
        System.assertEquals(false, event.IsProcessed__c);
        System.assertEquals(System.Label.Event_InvalidJSON, event.Error_If_Any__c);
    }
    static testMethod void singleFieldEmpty() {
        List<String> jsonField = new List<String>();
        String json = '';
        jsonField.add(json);
        EventFactory.createEvents(1, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        Events__c event = [Select IsProcessed__c, Error_If_Any__c from Events__c][0];
        System.assertEquals(false, event.IsProcessed__c);
        System.assertEquals(System.Label.Event_FieldEmpty, event.Error_If_Any__c);
    }
    static testMethod void singleNoObject() {
        List<String> jsonField = new List<String>();
        String json = '{"JSON":{"Name":"Batch8"}}';
        jsonField.add(json);
        EventFactory.createEvents(1, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        Events__c event = [Select IsProcessed__c, Error_If_Any__c from Events__c][0];
        System.assertEquals(false, event.IsProcessed__c);
        System.assertEquals(System.Label.Event_NoObjectName, event.Error_If_Any__c);
    }
    static testMethod void singleInvalidObjectName() {
        List<String> jsonField = new List<String>();
        String json = '{"JSON":{"Name":"Batch8"},"Object Name":"Account1"}}';
        jsonField.add(json);
        EventFactory.createEvents(1, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        Events__c event = [Select IsProcessed__c, Error_If_Any__c from Events__c][0];
        System.assertEquals(false, event.IsProcessed__c);
        System.assertEquals(System.Label.Event_InvalidObjectName, event.Error_If_Any__c);
    }
    static testMethod void singleNoJSON() {
        List<String> jsonField = new List<String>();
        String json = '{"Object Name":"Account"}}';
        jsonField.add(json);
        EventFactory.createEvents(1, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        Events__c event = [Select IsProcessed__c, Error_If_Any__c from Events__c][0];
        System.assertEquals(false, event.IsProcessed__c);
        System.assertEquals(System.Label.Event_NoJSON, event.Error_If_Any__c);
    }
    static testMethod void singleEmptyJSON() {
        List<String> jsonField = new List<String>();
        String json = '{"JSON":"","Object Name":"Account"}}';
        jsonField.add(json);
        EventFactory.createEvents(1, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        Events__c event = [Select IsProcessed__c, Error_If_Any__c from Events__c][0];
        System.assertEquals(false, event.IsProcessed__c);
        System.assertEquals(System.Label.Event_NoJSON, event.Error_If_Any__c);
    }
    static testMethod void singleInvalidField() {
        List<String> jsonField = new List<String>();
        String json = '{"JSON":{"Name":"Batch8", "AccountNumber1":"11111"},"Object Name":"Account"}}';
        jsonField.add(json);
        EventFactory.createEvents(1, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        Events__c event = [Select IsProcessed__c, Error_If_Any__c from Events__c][0];
        System.assertEquals(false, event.IsProcessed__c);
        System.assertEquals(System.Label.Event_InvalidField, event.Error_If_Any__c);
    }
    static testMethod void singleRequiredFieldNotProvided() {
        List<String> jsonField = new List<String>();
        String json = '{"JSON":{"AccountNumber":"11111"},"Object Name":"Account"}}';
        jsonField.add(json);
        EventFactory.createEvents(1, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        Events__c event = [Select IsProcessed__c, Error_If_Any__c from Events__c][0];
        System.assertEquals(false, event.IsProcessed__c);
        System.assertEquals(System.Label.Event_RequiredNotProvided, event.Error_If_Any__c);
    }
    static testMethod void singleSuccess() {
        List<String> jsonField = new List<String>();
        String json = '{"JSON":{"Name":"Batch8", "AccountNumber":"11111"},"Object Name":"Account"}}';
        jsonField.add(json);
        List<Events__c> eventList = EventFactory.createEvents(1, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        Events__c event = [Select IsProcessed__c, Error_If_Any__c from Events__c][0];
        List<Account> account = [Select id,name,accountNumber from Account];
        System.assertEquals(true, event.IsProcessed__c);
        System.assertEquals(null, event.Error_If_Any__c);
        System.assertEquals('batch8',account[0].Name);
        System.assertEquals('11111',account[0].AccountNumber);
        System.assertEquals(eventList.size(),account.size());
    }
    static testMethod void singleException() {
        List<String> jsonField = new List<String>();
        String json =  '{"JSON":{"Name":"Batch8", "ParentId":"abcd"},"Object Name":"Account"}}';
        jsonField.add(json);
        EventFactory.createEvents(1, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        Events__c event = [Select IsProcessed__c, Error_If_Any__c from Events__c][0];
        System.assertEquals(false, event.IsProcessed__c);
    }
    static testMethod void bulkInvalidJSON() {
        List<String> jsonField = new  List<String>();
        for(Integer index=0 ; index<100 ; index++)
        {
           String json = '{"JSON":{"Name":"Batch"'+index+'}"Object Name":"Account"'+index+'}'; 
           jsonField.add(json);
        }
        EventFactory.createEvents(100, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Events__c> events = [Select IsProcessed__c, Error_If_Any__c from Events__c];
        for(Events__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals(System.Label.Event_InvalidJSON, event.Error_If_Any__c);
        }
    }
    static testMethod void bulkFieldEmpty() {
        List<String> jsonField = new List<String>();
        for(Integer index=0 ; index<100 ; index++)
        {
           String json = ''; 
           jsonField.add(json);
        }
        EventFactory.createEvents(100, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Events__c> events = [Select IsProcessed__c, Error_If_Any__c from Events__c];
        for(Events__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals(System.Label.Event_FieldEmpty, event.Error_If_Any__c);
        }
    }
    static testMethod void bulkNoObject() {
        List<String> jsonField = new List<String>();
        for(Integer index=0 ; index<100 ; index++)
        {
           String json = '{"JSON":{"Name":"Batch8'+index+'"}}'; 
           jsonField.add(json);
        }
        EventFactory.createEvents(100, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Events__c> events = [Select IsProcessed__c, Error_If_Any__c from Events__c];
        for(Events__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals(System.Label.Event_NoObjectName, event.Error_If_Any__c);
        }
    }
    static testMethod void bulkInvalidObjectName() {
        List<String> jsonField = new  List<String>();
        for(Integer index=0 ; index<100 ; index++)
        {
           String json = '{"JSON":{"Name":"Batch8'+index+'"},"Object Name":"Account1"}}'; 
           jsonField.add(json);
        }
        EventFactory.createEvents(100, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Events__c> events = [Select IsProcessed__c, Error_If_Any__c from Events__c];
        for(Events__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals(System.Label.Event_InvalidObjectName, event.Error_If_Any__c);
        }
    }
    static testMethod void bulkNoJSON() {
        List<String> jsonField = new  List<String>();
        for(Integer index=0 ; index<100 ; index++)
        {
           String json = '{"Object Name":"Account"}}'; 
           jsonField.add(json);
        }
        EventFactory.createEvents(100, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Events__c> events = [Select IsProcessed__c, Error_If_Any__c from Events__c];
        for(Events__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals(System.Label.Event_NoJSON, event.Error_If_Any__c);
        }
    }
    static testMethod void bulkEmptyJSON() {
        List<String> jsonField = new  List<String>();
        for(Integer index=0 ; index<100 ; index++)
        {
           String json = '{"JSON":"","Object Name":"Account"}}'; 
           jsonField.add(json);
        }
        EventFactory.createEvents(100, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Events__c> events = [Select IsProcessed__c, Error_If_Any__c from Events__c];
        for(Events__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals(System.Label.Event_NoJSON, event.Error_If_Any__c);
        }
    }
    static testMethod void bulkInvalidField() {
        List<String> jsonField = new  List<String>();
        for(Integer index=0 ; index<100 ; index++)
        {
           String json = '{"JSON":{"Name":"Batch8'+index+'", "AccountNumber1":"11111'+index+'"},"Object Name":"Account"}}'; 
           jsonField.add(json);
        }
        EventFactory.createEvents(100, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Events__c> events = [Select IsProcessed__c, Error_If_Any__c from Events__c];
        for(Events__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals(System.Label.Event_InvalidField, event.Error_If_Any__c);
        }
    }
    static testMethod void bulkRequiredFieldNotProvided() {
        List<String> jsonField = new  List<String>();
        for(Integer index=0 ; index<100 ; index++)
        {
           String json = '{"JSON":{"AccountNumber":"11111'+index+'"},"Object Name":"Account"}}'; 
           jsonField.add(json);
        }
        EventFactory.createEvents(100, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Events__c> events = [Select IsProcessed__c, Error_If_Any__c from Events__c];
        for(Events__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals(System.Label.Event_RequiredNotProvided, event.Error_If_Any__c);
        }
    }
    static testMethod void bulkSuccess() {
        List<String> jsonField = new  List<String>();
        for(Integer index=0 ; index<100 ; index++)
        {
           String json = '{"JSON":{"Name":"Batch8'+index+'", "AccountNumber":"11111'+index+'"},"Object name":"Account"}}'; 
           jsonField.add(json);
        }
        List<Events__c> eventList = EventFactory.createEvents(100, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Events__c> events = [Select IsProcessed__c, Error_If_Any__c from Events__c];
        List<Account> accounts = [Select Id, name, accountNumber  from Account];
        for(Events__c event : events) {
            System.assertEquals(true, event.IsProcessed__c);
            System.assertEquals(null, event.Error_If_Any__c);
        }
        System.assertEquals(eventList.size(), accounts.size());
    }
    static testMethod void bulkException() {
        List<String> jsonField = new  List<String>();
        for(Integer index=0 ; index<100 ; index++)
        {
           String json = '{"JSON":{"Name":"Batch8'+index+'", "Owner":"abcd'+index+'"},"Object Name":"Account"}}'; 
           jsonField.add(json);
        }
        EventFactory.createEvents(100, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Events__c> events = [Select IsProcessed__c, Error_If_Any__c from Events__c];
        for(Events__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
        }
    }
}