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
private class RemovalOfDuplicateLeadsTestClass {

     static testMethod void nothingChecked() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new EliminateDuplicateRecords__c(Email__c = false,
                                          Phone_Number__c = false,
                                          Name__c = false);
        system.test.startTest();
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(200, leadList.size());
    }

    static testMethod void onlyName() {
        List<Lead> leads = LeadFactory.createAndInsertLeads(100);
        List<Lead> duplicateLeads = LeadFactory.createAndInsertLeads(100);
        insert new EliminateDuplicateRecords__c(Email__c = false,
                                          Phone_Number__c = false,
                                          Name__c = true);
        system.test.startTest();
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void onlyNameWithNoNameDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Phone = leads[i + 1].Phone;
            leads[i].Email = leads[i + 1].Email;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = false,
                                          Phone_Number__c = false,
                                          Name__c = true);
        system.test.startTest();
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
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
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void onlyEmailWithNoEmailDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Phone = leads[i + 1].Phone;
            leads[i].LastName = leads[i + 1].LastName;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = true,
                                          Phone_Number__c = false,
                                          Name__c = false);
        system.test.startTest();
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
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
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void onlyPhoneWithNoPhoneDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Email = leads[i + 1].Email;
            leads[i].LastName = leads[i + 1].LastName;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = false,
                                          Phone_Number__c = true,
                                          Name__c = false);
        system.test.startTest();
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
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
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void phoneNameCheckedWithPhoneDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Phone = leads[i + 1].Phone;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = false,
                                          Phone_Number__c = true,
                                          Name__c = true);
        system.test.startTest();
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(50, leadList.size());
    }

   

    static testMethod void phoneNameCheckedWithEmailDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Email = leads[i + 1].Email;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = false,
                                          Phone_Number__c = true,
                                          Name__c = true);
        system.test.startTest();
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
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
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void phoneEmailCheckedWithPhoneDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Phone = leads[i + 1].Phone;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = true,
                                          Phone_Number__c = true,
                                          Name__c = false);
        system.test.startTest();
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(50, leadList.size());
    }

    static testMethod void phoneEmailCheckedWithEmailDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Email = leads[i + 1].Email;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = true,
                                          Phone_Number__c = true,
                                          Name__c = false);
        system.test.startTest();
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(50, leadList.size());
    }

    static testMethod void phoneEmailCheckedWithNameDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].LastName = leads[i + 1].LastName;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = true,
                                          Phone_Number__c = true,
                                          Name__c = false);
        system.test.startTest();
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
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
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }

    static testMethod void nameEmailCheckedWithEmailDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Email = leads[i + 1].Email;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = true,
                                          Phone_Number__c = false,
                                          Name__c = true);
        system.test.startTest();
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(50, leadList.size());
    }


    static testMethod void nameEmailCheckedWithPhoneDuplication() {
        List<Lead> leads = LeadFactory.createLeads(100);
        for(Integer i = 0; i<100; i = i+2) {
            leads[i].Phone = leads[i + 1].Phone;
        }
        insert leads;
        insert new EliminateDuplicateRecords__c(Email__c = true,
                                          Phone_Number__c = false,
                                          Name__c = true);
        system.test.startTest();
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
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
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
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
            RemoveDuplicateLeads b = new RemoveDuplicateLeads();
            database.executeBatch(b);
        system.test.stopTest();
        List<Lead> leadList = [Select id from lead];
        System.assertEquals(leads.size(), leadList.size());
    }
}