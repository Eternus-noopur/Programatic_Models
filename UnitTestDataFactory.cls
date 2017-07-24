@isTest
public class UnitTestDataFactory {

    public static List<Contact_Email_Handler_Junction__c> createContactEmailHandlerRecords(Integer count, Boolean toBeInserted) {
        List<Contact_Email_Handler_Junction__c> newList = new List<Contact_Email_Handler_Junction__c>();
        List<Email_Handler__c> emailHandler = EmailhandlerFactory.createEvents(1,True);
        List<Contact> contactList = ContactFactoryNew.createAndInsertContacts(1,'');
        
        for (Integer i = 1; i <= count; i++) {
            Contact_Email_Handler_Junction__c contactEmailJunction = new Contact_Email_Handler_Junction__c();
            contactEmailJunction.Search_Query__c = emailHandler[0].id;
            contactEmailJunction.Contact_Name__c = contactList[0].id;
            newList.add(contactEmailJunction);
        }
        if(toBeInserted) {
            insert newList;
        }
        return newList;
    }
    
    public static List<Email_Handler__c> createEmailHandlerRecords(Integer count, Boolean toBeInserted) {
        List<Email_Handler__c> newList = new List<Email_Handler__c>();
        for (Integer i = 1; i <= count; i++) {
            Email_Handler__c emailHandler = new Email_Handler__c();
            emailHandler.Email_Subject__c = 'Search Query';
            emailHandler.Email_Body__c = 'Salesforce';
            newList.add(emailHandler);
        }
        if(toBeInserted) {
            insert newList;
        }
        return newList;
    }
    
     public static List<Search_Result__c> createSearchResultRecords(Integer count, Boolean toBeInserted) {
        List<Search_Result__c> newList = new List<Search_Result__c>();
        List<Email_Handler__c> emailHandler = EmailhandlerFactory.createEvents(1,True);
        
        for (Integer i = 1; i <= count; i++) {
            Search_Result__c searchResultobject = new Search_Result__c();
            searchResultobject.Search_Query__c = emailHandler[0].id;
            searchResultobject.Links__c = 'www.test.com';
            newList.add(searchResultobject);
        }
        if(toBeInserted) {
            insert newList;
        }
        return newList;
    }
    
    public static List<Contact> createRecordsInContact(Integer count,Boolean toBeInserted)
    {
        List<Contact> contactList=new List<Contact>();
        for(Integer i=1; i<=count;i++)
        {
            Contact contact=new Contact();
            Contact.FirstName='Contact'+i;
            Contact.LastName='Sahu'+i;
            Contact.Email='abc'+i+'@gmail.com';
            Contact.MobilePhone='95036'+i;
            Contact.Phone='95036'+i;
            Contact.MailingStreet ='ShivajiNagar';
            contact.MailingCity = 'Pune';
            contactList.add(Contact);
        }
        if(toBeInserted) {
            insert contactList;
        }
        return contactList;
    }
    
    public static List<Account> createRecordsInAccount(Integer count,Boolean toBeInserted)
    {
        List<Account> accountList=new List<Account>();
        for(Integer i=1; i<=count;i++)
        {
            Account account=new Account();
            account.Name='Account'+i;
            account.DomainName__c='gmail'+i+'.com';
            account.BillingStreet ='ShivajiNagar';
            account.BillingCity ='Pune';
            account.BillingCountry ='India';
            accountList.add(account); 
        }
        if(toBeInserted) {
            insert accountList;
        }
        return accountList;
    }
}