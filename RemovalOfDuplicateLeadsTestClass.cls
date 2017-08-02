@isTest
private class RemovalOfDuplicateLeadsTestClass {
    static testMethod void nothingChecked() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new EliminateDuplicateRecords__c(Email__c = false,
                                          Phone_Number__c = false,
                                          Name__c = false);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals((2*leads.size()), leadList.size());
    }
    static testMethod void onlyName() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new EliminateDuplicateRecords__c(Email__c = false,
                                          Phone_Number__c = false,
                                          Name__c = true);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }
    static testMethod void onlyNameWithNoNameDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer index = 0; index<100; index = i+2) {
            leads[index].Phone = leads[index + 1].Phone;
            leads[index].Email = leads[index + 1].Email;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = false,
                                          Phone_Number__c = false,
                                          Name__c = true);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }
    static testMethod void onlyEmail() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new EliminateDuplicateRecords__c(Email__c = true,
                                          Phone_Number__c = false,
                                          Name__c = false);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }
    static testMethod void onlyEmailWithNoEmailDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer index = 0; index<100; index = index+2) {
            leads[index].Phone = leads[index + 1].Phone;
            leads[index].LastName = leads[index + 1].LastName;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = true,
                                          Phone_Number__c = false,
                                          Name__c = false);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }
    static testMethod void onlyPhone() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new EliminateDuplicateRecords__c(Email__c = false,
                                          Phone_Number__c = true,
                                          Name__c = false);
        system.test.startTest();
            RemoveDuplicateLeads batchObj= new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }
    static testMethod void onlyPhoneWithNoPhoneDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer index = 0; index<100; index = index+2) {
            leads[index].Email = leads[index + 1].Email;
            leads[index].LastName = leads[index + 1].LastName;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = false,
                                          Phone_Number__c = true,
                                          Name__c = false);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }
    static testMethod void phoneNameChecked() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new EliminateDuplicateRecords__c(Email__c = false,
                                          Phone_Number__c = true,
                                          Name__c = true);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }
    static testMethod void phoneNameCheckedWithPhoneDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer index = 0; index<100; index = index+2) {
            leads[index].Phone = leads[index + 1].Phone;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = false,
                                          Phone_Number__c = true,
                                          Name__c = true);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(((leads.Size())/2), leadList.size());
    }
    static testMethod void phoneNameCheckedWithEmailDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer index = 0; index<100; index = index+2) {
            leads[index].Email = leads[index + 1].Email;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = false,
                                          Phone_Number__c = true,
                                          Name__c = true);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }
    static testMethod void phoneEmailChecked() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new EliminateDuplicateRecords__c(Email__c = true,
                                          Phone_Number__c = true,
                                          Name__c = false);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }
    static testMethod void phoneEmailCheckedWithPhoneDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer index = 0; index<100; index = index+2) {
            leads[index].Phone = leads[index + 1].Phone;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = true,
                                          Phone_Number__c = true,
                                          Name__c = false);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(((leads.size())/2), leadList.size());
    }
    static testMethod void phoneEmailCheckedWithEmailDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer index = 0; index<100; index = index+2) {
            leads[index].Email = leads[index + 1].Email;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = true,
                                          Phone_Number__c = true,
                                          Name__c = false);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(((leads.size())/2), leadList.size());
    }
    static testMethod void phoneEmailCheckedWithNameDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer index = 0; index<100; index = index+2) {
            leads[index].LastName = leads[index + 1].LastName;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = true,
                                          Phone_Number__c = true,
                                          Name__c = false);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }
    static testMethod void nameEmailChecked() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new EliminateDuplicateRecords__c(Email__c = true,
                                          Phone_Number__c = false,
                                          Name__c = true);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }
    static testMethod void nameEmailCheckedWithEmailDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer index = 0; index<100; index = index+2) {
            leads[index].Email = leads[index + 1].Email;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = true,
                                          Phone_Number__c = false,
                                          Name__c = true);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(((leads.size())/2), leadList.size());
    }
    static testMethod void nameEmailCheckedWithPhoneDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer index = 0; index<100; index = index+2) {
            leads[index].Phone = leads[index + 1].Phone;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = true,
                                          Phone_Number__c = false,
                                          Name__c = true);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }
    static testMethod void allCheckedNoDuplicates() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        insert new EliminateDuplicateRecords__c(Email__c = true,
                                          Phone_Number__c = true,
                                          Name__c = true);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }
    static testMethod void allCheckedWithDuplicates() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new EliminateDuplicateRecords__c(Email__c = true,
                                          Phone_Number__c = true,
                                          Name__c = true);
        system.test.startTest();
            RemoveDuplicateLeads batchObj = new RemoveDuplicateLeads();
            database.executeBatch(batchObj);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }
}