@isTest
private class PlotMarkersHandlerTest {

    static testMethod void checkForUpdationOfLatitudeAndLongitudeInAccount() {
        system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
        system.Test.startTest();
            list<Account> accountList = UnitTestDataFactory.createRecordsInAccount(1,True);
        system.Test.stopTest();
        list<Account> searchResultList = [Select id,BillingLatitude,BillingLongitude from Account];
        system.assertEquals(Double.valueOf(System.label.Latitude),searchResultList[0].BillingLatitude);
        system.assertEquals(Double.valueOf(System.label.Longitude),searchResultList[0].BillingLongitude);
    }
    
    static testMethod void checkForUpdationOfLatitudeAndLongitudeInContact() {
        system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
        system.Test.startTest();
            list<Contact> contactList = UnitTestDataFactory.createRecordsInContact(1,True);
        system.Test.stopTest();
        list<Contact> searchResultList = [Select id,MailingLatitude,MailingLongitude from Contact];
        system.assertEquals(Double.valueOf(System.label.Latitude),searchResultList[0].MailingLatitude);
        system.assertEquals(Double.valueOf(System.label.Longitude),searchResultList[0].MailingLongitude);
    }

    static testMethod void checkForUpdationOfLatitudeAndLongitudeInAccountBulk() {
        system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
        system.Test.startTest();
            list<Account> accountList = UnitTestDataFactory.createRecordsInAccount(10,True);
        system.Test.stopTest();
        list<Account> accList =[Select id,BillingLatitude,BillingLongitude from Account];
        for(Account accounts : accList )
        {
            system.assertEquals(Double.valueOf(System.label.Latitude),accounts.BillingLatitude);
            system.assertEquals(Double.valueOf(System.label.Longitude),accounts.BillingLongitude);
        }
    }
    
     static testMethod void checkForUpdationOfLatitudeAndLongitudeInContactBulk() {
        system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
        system.Test.startTest();
            list<Contact> contactList = UnitTestDataFactory.createRecordsInContact(10,True);
        system.Test.stopTest();
        list<Contact> conList = [Select id,MailingLatitude,MailingLongitude from Contact];
        for(Contact contacts : conList )
        {
            system.assertEquals(Double.valueOf(System.label.Latitude),contacts.MailingLatitude);
            system.assertEquals(Double.valueOf(System.label.Longitude),contacts.MailingLongitude);
        }
    }
    
    static testMethod void checkForEmptyResponseBody() {
        system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
        system.Test.startTest();
            list<Account> accountList = UnitTestDataFactory.createRecordsInAccount(1,false);
            system.debug('++++'+accountList);
            for(Account accounts:accountList )  
            {
                accounts.BillingStreet = null;
                accounts.BillingCity =null;
                accounts.BillingState =null;
            }
            insert accountList;
        system.Test.stopTest();
        system.assertEquals(null,accountList[0].BillingLatitude);
        system.assertEquals(null,accountList[0].BillingLongitude);
    }
}