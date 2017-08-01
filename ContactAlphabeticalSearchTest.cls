@isTest
private class ContactAlphabeticalSearchTest {
    static testMethod void constructorTest() {
        system.test.startTest();
            PageReference pageRef = Page.AlphabeticalSearchUsingMap;
            system.test.setCurrentPage(pageRef);
            List<Contact> contacts = ContactFactoryNew.createAndInsertContacts(100,'');
            ContactAlphabeticalSearch searchObj=new ContactAlphabeticalSearch();
        system.test.stopTest();
        System.assertEquals(contacts.size(), searchObj.contactList.size());
        System.assertEquals(contacts.size(), searchObj.showContacts.size());
    }
    static testMethod void displayByAlphabetTest() {
        system.test.startTest();
            PageReference pageRef = Page.AlphabeticalSearchUsingMap;
            system.test.setCurrentPage(pageRef);
            List<Contact> contacts = ContactFactoryNew.createAndInsertContacts(100,'');
            ContactAlphabeticalSearch searchObj=new ContactAlphabeticalSearch();
            searchObj.searchAlphabet = 'C';
            searchObj.display();
        system.test.stopTest();
        System.assertEquals(contacts.size(), searchObj.showContacts.size());
    }
    static testMethod void displayAllTest() {
        system.test.startTest();
            PageReference pageRef = Page.AlphabeticalSearchUsingMap;
            system.test.setCurrentPage(pageRef);
            List<Contact> contacts = ContactFactoryNew.createAndInsertContacts(100,'');
            ContactAlphabeticalSearch searchObj=new ContactAlphabeticalSearch();
            searchObj.searchAlphabet = 'All';
            searchObj.display();
        system.test.stopTest();
        System.assertEquals(contacts.size(), searchObj.showContacts.size());
    }
    static testMethod void remoteTest() {
        system.test.startTest();
            PageReference pageRef = Page.AlphabeticalSearchUsingMap;
            system.test.setCurrentPage(pageRef);
            List<Contact> contacts = ContactFactoryNew.createAndInsertContacts(100,'');
            Contact contact = [Select Id,Name,firstName from Contact where firstName='Contact1'][0];
            Id contactId = contact.id;
            ContactAlphabeticalSearch.deleteContact(contactId);
        system.test.stopTest();
        List<contact> conlist = [Select Id , firstName from Contact where firstName = 'Contact1'];
        System.assertNotEquals(contact.firstName,'');
    }
}