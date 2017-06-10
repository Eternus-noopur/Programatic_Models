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
private class CheckDupTestClass {

    static testMethod void CheckDuplicatesForSingleRecord() {
        system.Test.startTest();
        List<contact> contactList=ContactFactoryNew.createAndInsertContacts(1);
        system.Test.stopTest();
        List<contact> contacts=[Select Id from contact where FirstName like 'Contact%']; 
        system.assertEquals(contactList.size(),contacts.size());
     }
     
     
     static testMethod void CheckDuplicatesForForBulk() {
        system.Test.startTest();
        List<contact> contactList=ContactFactoryNew.createAndInsertContacts(100);
        system.Test.stopTest();
        List<contact> contacts=[Select Id from contact where FirstName like 'Contact%']; 
        system.assertEquals(contactList.size(),contacts.size());
     }
     
     
     static testMethod void CheckDuplicatesForNullEmailSingleRecord() {
        system.Test.startTest();
        List <Contact> conList=ContactFactoryNew.createRecordsInContact(1);
        for(Contact con:conList )  
        {
            con.email = null;
        }
        insert conList;
        system.Test.stopTest(); 
        List<contact> contacts=[Select Id from contact where FirstName like 'Contact%'];
        system.assertEquals(conList.size(),contacts.size());
     }
     
     
     static testMethod void CheckDuplicatesForNullEmailBulk() {
        system.Test.startTest();
        List<contact> contactList=ContactFactoryNew.createRecordsInContact(100);  
        for(Contact con : contactList)
        {
            con.Email=null;
        }
        insert contactlist;
        system.Test.stopTest();
        List<contact> contacts=[Select Id from contact where FirstName like 'Contact%'];
        system.assertEquals(contactList.size(),contacts.size());
      }
      
      
      static testMethod void CheckDuplicatesForNullMobileNumberSingleRecord(){
        system.Test.startTest();
        List<Contact> conList=ContactFactoryNew.createRecordsInContact(1);
        for(Contact con : conList)
        {
            con.MobilePhone=null;
        }
        insert conList;  
        system.Test.stopTest();
        List<contact> contacts=[Select Id from contact where FirstName like 'Contact%'];
        system.assertEquals(conList.size(),contacts.size());
      }
      
      
      static testMethod void CheckDuplicatesForNullMobileNumberBulk() {
        system.Test.startTest();
        List<contact> contactList=ContactFactoryNew.createRecordsInContact(100);
        for(Contact con : contactList)
        {
            con.MobilePhone=null;
        }
        insert contactList;    
        system.Test.stopTest();
        List<contact> contacts=[Select Id from contact where FirstName like 'Contact%'];
        system.assertEquals(contactList.size(),contacts.size());
      }
      
      
      static testMethod void CheckDuplicatesForNullMobileNumberAndEmail() {
        system.Test.startTest();
        Contact con=ContactFactoryNew.createRecordsInContact(1)[0];
        con.MobilePhone=null;
        con.Email=null;
        insert con;   
        system.Test.stopTest();
        List<contact> contacts=[Select Id from contact where FirstName like 'Contact%'];
        system.assertEquals(1,contacts.size());
      }
      
      
      static testMethod void CheckDuplicatesForNullMobileNumberAndEmailBulk() {
        system.Test.startTest();
        List<contact> contactList=ContactFactoryNew.createRecordsInContact(100);
        for(Contact con: contactList)
        {
            con.MobilePhone=null;
            con.Email=null;
        }  
        insert contactList;
        system.Test.stopTest();
        List<contact> contacts=[Select Id from contact where FirstName like 'Contact%'];
        system.assertEquals(contactList.size(),contacts.size());
      }
      
      
      static testMethod void CheckDuplicatesForEmailErrorForSingleRecord() {
        system.Test.startTest(); 
        List <Contact> conList=ContactFactoryNew.createRecordsInContact(1);
        try
        { 
            insert conList;
        }
        catch(Exception e)
        {
            Boolean expectedExceptionThrown = e.getMessage().contains('Record already exist') ? true : false;
            
        }
        system.Test.stoptest(); 
        List<contact> contacts=[Select Id from contact where FirstName like 'Contact%'];
        System.AssertEquals(conList.size(),contacts.size() );
      }
      
      static testMethod void CheckDuplicatesForEmailErrorForBulk() {
        system.Test.startTest();
        List<contact> conList=ContactFactoryNew.createAndInsertContacts(10); 
        try
        {
            insert conList;
        }
        catch(Exception e)
        {
            Boolean expectedExceptionThrown = e.getMessage().contains('Record already exist') ? true : false;
            
        }
        List<contact> contacts=[Select Id from contact where FirstName like 'Contact%']; 
        System.AssertEquals(conList.size(),contacts.size() );
      }

      static testMethod void CheckDuplicatesForMobileErrorForSingleRecord() {
        system.Test.startTest();
        List<Contact> conList=ContactFactoryNew.createRecordsInContact(1);
        try
        {
            insert conList;
        }
        catch(Exception e)
        {
            Boolean expectedExceptionThrown = e.getMessage().contains('Record already exist') ? true : false;
        }
        system.Test.stoptest(); 
        List<contact> contacts=[Select Id from contact where FirstName like 'Contact%'];
        System.AssertEquals(conList.size(),contacts.size() );
      }
      
      static testMethod void CheckDuplicatesForMobileErrorForBulk() {
        system.Test.startTest();
        List<contact> conList=ContactFactoryNew.createRecordsInContact(10);
        try
        {
             insert conList;
        }
        catch(Exception e)
        {
            Boolean expectedExceptionThrown = e.getMessage().contains('Record already exist') ? true : false;
        }
        List<contact> contacts=[Select Id from contact where FirstName like 'Contact%']; 
        System.AssertEquals(conList.size(),contacts.size());
        
      }
}