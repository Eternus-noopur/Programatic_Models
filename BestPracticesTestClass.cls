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
public class BestPracticesTestClass {

    static testMethod void AssociatingContactWithAccount() {
        system.Test.startTest();
        AccontFactoryNew.createAndInsertAccounts(1);
        List<Contact> contactList = ContactFactoryNew.createAndInsertContacts(1);
        system.Test.stopTest();
        Contact con=[Select Id, name ,Account.Name from Contact][0];
        System.assertEquals('Account1',con.Account.Name);
    }
    
    static testMethod void AssociatingContactWithAccountBulk() {
        system.Test.startTest();
        AccontFactoryNew.createAndInsertAccounts(1);
        List<Contact> contactList = ContactFactoryNew.createAndInsertContacts(10);
        system.Test.stopTest();
        List<Contact> con=[Select Id, name ,Account.Name from Contact];
        for(Contact contact:con)
        {
            System.assertEquals('Account1',contact.Account.Name);
        }
    }
    
    static testMethod void NotAssociatingContactWithAccountEmailNull() {
        system.Test.startTest();
        AccontFactoryNew.createAndInsertAccounts(1);
        Contact contact = ContactFactoryNew.createRecordsInContact(1)[0];
        contact.Email=null;
        insert contact;
        system.Test.stopTest();
        Contact con=[Select Id, name ,Account.Name from Contact][0];
        System.assertEquals(null,con.Account.Name);
    }
    
    static testMethod void AssociatingContactWithAccountEmailNullBulk() {
        system.Test.startTest();
        AccontFactoryNew.createAndInsertAccounts(1);
        List<Contact> contactList = ContactFactoryNew.createRecordsInContact(10);
        for(Contact con :contactList)
        {
            con.Email=null;
        }
        insert contactList;
        system.Test.stopTest();
        List<Contact> con=[Select Id, name ,Account.Name from Contact];
        for(Contact contact:con)
        {
            System.assertEquals(null,contact.Account.Name);
        }
    }
    
    static testMethod void NotAssociatingContactWithAccountDomainNameNull() {
        system.Test.startTest();
        Account acc=AccontFactoryNew.createRecordsInAccount(1)[0];
        acc.DomainName__c=null;
        insert acc;
        Contact contact = ContactFactoryNew.createAndInsertContacts(1)[0];
        system.Test.stopTest();
        Contact con=[Select Id, name ,Account.Name from Contact][0];
        System.assertEquals(null,con.Account.Name);
        
        
    }
    
    static testMethod void AssociatingContactWithAccountDomainNameNullBulk() {
        system.Test.startTest();
        List<Account> accountList=AccontFactoryNew.createRecordsInAccount(1);
        for(Account acc :accountList)
        {
            acc.DomainName__c=null;
        }
        insert accountList;
        List<Contact> contactList = ContactFactoryNew.createAndInsertContacts(10);
        system.Test.stopTest();
        List<Contact> con=[Select Id, name ,Account.Name from Contact];
        for(Contact contact:con)
        {
            System.assertEquals(null,contact.Account.Name);
        }
    }
    
    static testMethod void NotAssociatingContactWithAccountBothNull() {
        system.Test.startTest();
        Account acc=AccontFactoryNew.createRecordsInAccount(1)[0];
        acc.DomainName__c=null;
        insert acc;
        Contact contact = ContactFactoryNew.createRecordsInContact(1)[0];
        contact.Email=null;
        insert contact;
        system.Test.stopTest();
        Contact con=[Select Id, name ,Account.Name from Contact][0];
        System.assertEquals(null,con.Account.Name);
}

static testMethod void NotAssociatingContactWithAccountBothBulk() {
        system.Test.startTest();
        List<Account> accountList=AccontFactoryNew.createRecordsInAccount(1);
        for(Account acc :accountList)
        {
            acc.DomainName__c=null;
        }
        insert accountList;
        List<Contact> contactList = ContactFactoryNew.createRecordsInContact(10);
        for(Contact con :contactList)
        {
            con.Email=null;
        }
        insert contactList;
        system.Test.stopTest();
        List<Contact> con=[Select Id, name ,Account.Name from Contact];
        for(Contact contact:con)
        {
            System.assertEquals(null,contact.Account.Name);
        }
    }
}