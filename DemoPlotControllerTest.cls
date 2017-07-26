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
public class DemoPlotControllerTest {

    static testMethod void checkForTotalRecordsForSearchText() {
       system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
       system.test.startTest();
           List<Account> accounts = AccontFactoryNew.createAndInsertAccounts(10);
           DempPlotController contlrObj=new DempPlotController();
           contlrObj.searchText = 'Acc';
           contlrObj.searchRecords();
       system.test.stopTest();
       System.assertEquals(10, contlrObj.countOfRows);
   }
   
   static testMethod void checkForBothAccountContactRecords() {
       system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
       system.test.startTest();
           List<Account> accounts = AccontFactoryNew.createAndInsertAccounts(1);
           List<Contact> contacts = ContactFactoryNew.createRecordsInContact(1,'');
           DempPlotController contlrObj=new DempPlotController();
           contlrObj.searchText = 'Acc';
           DempPlotController.getAccountContactRecords('Acc');
       system.test.stopTest();
        List<Account> accountlst = [Select id,name from Account];
       System.assertEquals('Account1', accountlst[0].Name);
   }

}