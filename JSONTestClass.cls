@isTest
private class JSONTestClass {
    static testMethod void singleInvalidJSON() {
        String jsonField = '{"JSON":{"Name":"Batch8"}"Object Name":"Account"}';
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
        String jsonField = '';
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
        String jsonField = '{"JSON":{"Name":"Batch8"}}';
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
        String jsonField = '{"JSON":{"Name":"Batch8"},"Object Name":"Account1"}}';
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
        String jsonField = '{"Object Name":"Account"}}';
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
        String jsonField = '{"JSON":"","Object Name":"Account"}}';
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
        String jsonField = '{"JSON":{"Name":"Batch8", "AccountNumber1":"11111"},"Object Name":"Account"}}';
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
        String jsonField = '{"JSON":{"AccountNumber":"11111"},"Object Name":"Account"}}';
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
        String jsonField = '{"JSON":{"Name":"Batch8", "AccountNumber":"11111"},"Object Name":"Account"}}';
        EventFactory.createEvents(1, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        Events__c event = [Select IsProcessed__c, Error_If_Any__c from Events__c][0];
        System.assertEquals(true, event.IsProcessed__c);
        System.assertEquals(null, event.Error_If_Any__c);
    }
    static testMethod void singleException() {
        String jsonField = '{"JSON":{"Name":"Batch8", "ParentId":"abcd"},"Object Name":"Account"}}';
        EventFactory.createEvents(1, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        Events__c event = [Select IsProcessed__c, Error_If_Any__c from Events__c][0];
        System.assertEquals(false, event.IsProcessed__c);
    }
    static testMethod void bulkInvalidJSON() {
        String jsonField = '{"JSON":{"Name":"Batch8"}"Object Name":"Account"}';
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
        String jsonField = '';
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
        String jsonField = '{"JSON":{"Name":"Batch8"}}';
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
        String jsonField = '{"JSON":{"Name":"Batch8"},"Object Name":"Account1"}}';
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
        String jsonField = '{"Object Name":"Account"}}';
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
        String jsonField = '{"JSON":"","Object Name":"Account"}}';
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
        String jsonField = '{"JSON":{"Name":"Batch8", "AccountNumber1":"11111"},"Object Name":"Account"}}';
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
        String jsonField = '{"JSON":{"AccountNumber":"11111"},"Object Name":"Account"}}';
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
        String jsonField = '{"JSON":{"Name":"Batch8", "AccountNumber":"11111"},"Object Name":"Account"}}';
        EventFactory.createEvents(100, jsonField, true);
        system.test.startTest();
            BatchJSON batchObj = new BatchJSON();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Events__c> events = [Select IsProcessed__c, Error_If_Any__c from Events__c];
        for(Events__c event : events) {
            System.assertEquals(true, event.IsProcessed__c);
            System.assertEquals(null, event.Error_If_Any__c);
        }
    }
    static testMethod void bulkException() {
        String jsonField = '{"JSON":{"Name":"Batch8", "Owner":"abcd"},"Object Name":"Account"}}';
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