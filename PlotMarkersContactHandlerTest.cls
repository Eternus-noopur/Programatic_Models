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
private class PlotMarkersContactHandlerTest {

    static testMethod void checkForUpdationOfLatitudeAndLongitude() {
        system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
        system.Test.startTest();
            list<Contact> contactList = ContactFactoryNew.createAndInsertContacts(1,'');
        system.Test.stopTest();
        list<Contact> searchResultList = [Select id,MailingLatitude,MailingLongitude from Contact];
        system.assertEquals(18.5308,searchResultList[0].MailingLatitude);
        system.assertEquals(73.8475,searchResultList[0].MailingLongitude);
    }
    
    static testMethod void checkForUpdationOfLatitudeAndLongitudeBulk() {
        system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
        system.Test.startTest();
            list<Contact> contactList = ContactFactoryNew.createAndInsertContacts(10,'');
        system.Test.stopTest();
        list<Contact> conList = [Select id from Contact];
       system.assertEquals(contactList.size(),conList.size());
    }
}