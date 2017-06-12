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
private class ContactAlphabeticalSearchTest {
      static testMethod void constructorTest() {
       system.test.startTest();
           List<Contact> contacts = ContactFactoryNew.createAndInsertContacts(100);
           ContactAlphabeticalSearch s=new ContactAlphabeticalSearch();
       system.test.stopTest();
       System.assertEquals(contacts.size(), s.contactList.size());
       System.assertEquals(100, s.showContacts.size());
   }
   
   static testMethod void displayByAlphabetTest() {
       system.test.startTest();
           List<Contact> contacts = ContactFactoryNew.createAndInsertContacts(100);
           ContactAlphabeticalSearch s=new ContactAlphabeticalSearch();
           s.searchAlphabet = 'C';
           s.display();
       system.test.stopTest();
       System.assertEquals(contacts.size(), s.showContacts.size());
   }

   static testMethod void displayAllTest() {
       system.test.startTest();
           List<Contact> contacts = ContactFactoryNew.createAndInsertContacts(100);
           ContactAlphabeticalSearch s=new ContactAlphabeticalSearch();
           s.searchAlphabet = 'All';
           s.display();
       system.test.stopTest();
       System.assertEquals(contacts.size(), s.showContacts.size());
   }
   
   static testMethod void remoteTest() {
       system.test.startTest();
           List<Contact> contacts = ContactFactoryNew.createAndInsertContacts(100);
           Contact contact = [Select Id,Name from Contact where firstName='Contact1'][0];
           Id contactId = contact.id;
           ContactAlphabeticalSearch.deleteContact(contactId);
       system.test.stopTest();
       List<contact> conlist = [Select Id from Contact];
       System.assertEquals(99, conlist.size());
   }
}