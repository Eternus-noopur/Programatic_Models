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
private class SearchKeywordTest {
   static testMethod void searchSuccessfullTest()
   {
       system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
       system.test.startTest();
           List<Account> accountList = AccontFactoryNew.createAndInsertAccounts(100);
           ApexPages.StandardSetController stdController = new ApexPages.StandardSetController(accountList);
           SearchForAccountManagerExtension s=new SearchForAccountManagerExtension(stdController);
           s.searchText = 'Acc';
           s.searchRecords();
       system.test.stopTest();
       System.assertEquals(accountList.size(),s.countOfRows);
   }
   
   static testMethod void searchFailTest()
   {
       system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
       system.test.startTest();
           List<Account> accountList = AccontFactoryNew.createAndInsertAccounts(100);
           ApexPages.StandardSetController stdController = new ApexPages.StandardSetController(accountList);
           SearchForAccountManagerExtension s=new SearchForAccountManagerExtension(stdController);
           s.searchText = 'Ac';
           s.searchRecords();
       system.test.stopTest();
       System.assert(ApexPages.hasMessages(ApexPages.SEVERITY.ERROR));
   }
   
   static testMethod void clearTest()
   {
       system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
       system.test.startTest();
           List<Account> accountList = AccontFactoryNew.createAndInsertAccounts(100);
           ApexPages.StandardSetController stdController = new ApexPages.StandardSetController(accountList);
           SearchForAccountManagerExtension s=new SearchForAccountManagerExtension(stdController);
           s.clearSearch();
       system.test.stopTest();
       System.assertEquals(true,s.show);
       System.assertEquals(accountList.size(),s.countOfRows);
   }
   static testMethod void searchForUnAvailableRecord()
   {
       system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
       system.test.startTest();
           List<Account> accountList = AccontFactoryNew.createAndInsertAccounts(100);
           ApexPages.StandardSetController stdController = new ApexPages.StandardSetController(accountList);
           SearchForAccountManagerExtension s=new SearchForAccountManagerExtension(stdController);
           s.searchText = 'kkr';
           s.searchRecords();
       system.test.stopTest();
       System.assertEquals(0,s.countOfRows);
   }
}