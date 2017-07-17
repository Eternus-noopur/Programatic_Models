@isTest
private class ContactAlphabeticalSearchTest {
      static testMethod void constructorTest() {
       system.test.startTest();
           List<Contact> contacts = ContactFactoryNew.createAndInsertContacts(100,'');
           ContactAlphabeticalSearch s=new ContactAlphabeticalSearch();
       system.test.stopTest();
       System.assertEquals(contacts.size(), s.contactList.size());
       System.assertEquals(100, s.showContacts.size());
   }
   
   static testMethod void displayByAlphabetTest() {
       system.test.startTest();
           List<Contact> contacts = ContactFactoryNew.createAndInsertContacts(100,'');
           ContactAlphabeticalSearch s=new ContactAlphabeticalSearch();
           s.searchAlphabet = 'C';
           s.display();
       system.test.stopTest();
       System.assertEquals(contacts.size(), s.showContacts.size());
   }

   static testMethod void displayAllTest() {
       system.test.startTest();
           List<Contact> contacts = ContactFactoryNew.createAndInsertContacts(100,'');
           ContactAlphabeticalSearch s=new ContactAlphabeticalSearch();
           s.searchAlphabet = 'All';
           s.display();
       system.test.stopTest();
       System.assertEquals(contacts.size(), s.showContacts.size());
   }
   
   static testMethod void remoteTest() {
       system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
       system.test.startTest();
           List<Contact> contacts = ContactFactoryNew.createAndInsertContacts(100,'');
           Contact contact = [Select Id,Name,firstName from Contact where firstName='Contact1'][0];
           Id contactId = contact.id;
           ContactAlphabeticalSearch.deleteContact(contactId);
       system.test.stopTest();
       List<contact> conlist = [Select Id , firstName from Contact where firstName = 'Contact1'];
       System.assertNotEquals(contact.firstName,'');
   }
}