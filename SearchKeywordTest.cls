@isTest
private class SearchKeywordTest {
    static testMethod void searchSuccessfullTest()
    {
        system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
        system.test.startTest();
            PageReference pageRef = Page.AccountSearchPage;
            system.test.setCurrentPage(pageRef);
            List<Account> accountList = AccontFactoryNew.createAndInsertAccounts(100);
            ApexPages.StandardSetController stdController = new ApexPages.StandardSetController(accountList);
            SearchForAccountManagerExtension searchControllerObj=new SearchForAccountManagerExtension(stdController);
            searchControllerObj.searchText = 'Acc';
            searchControllerObj.searchRecords();
        system.test.stopTest();
        System.assertEquals(accountList.size(),searchControllerObj.countOfRows);
    }
    static testMethod void searchFailTest()
    {
        system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
        system.test.startTest();
            PageReference pageRef = Page.AccountSearchPage;
            system.test.setCurrentPage(pageRef);
            List<Account> accountList = AccontFactoryNew.createAndInsertAccounts(100);
            ApexPages.StandardSetController stdController = new ApexPages.StandardSetController(accountList);
            SearchForAccountManagerExtension searchControllerObj=new SearchForAccountManagerExtension(stdController);
            searchControllerObj.searchText = 'Ac';
            searchControllerObj.searchRecords();
        system.test.stopTest();
        System.assert(ApexPages.hasMessages(ApexPages.SEVERITY.ERROR));
    }
    static testMethod void clearTest()
    {
        system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
        system.test.startTest();
            PageReference pageRef = Page.AccountSearchPage;
            system.test.setCurrentPage(pageRef);
            List<Account> accountList = AccontFactoryNew.createAndInsertAccounts(100);
            ApexPages.StandardSetController stdController = new ApexPages.StandardSetController(accountList);
            SearchForAccountManagerExtension searchControllerObj=new SearchForAccountManagerExtension(stdController);
            searchControllerObj.clearSearch();
        system.test.stopTest();
        System.assertEquals(true,searchControllerObj.show);
        System.assertEquals(accountList.size(),searchControllerObj.countOfRows);
    }
    static testMethod void searchForUnAvailableRecord()
    {
        system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
        system.test.startTest();
            PageReference pageRef = Page.AccountSearchPage;
            system.test.setCurrentPage(pageRef);
            List<Account> accountList = AccontFactoryNew.createAndInsertAccounts(100);
            ApexPages.StandardSetController stdController = new ApexPages.StandardSetController(accountList);
            SearchForAccountManagerExtension searchObj=new SearchForAccountManagerExtension(stdController);
            searchObj.searchText = 'kkr';
            searchObj.searchRecords();
            List<ApexPages.message> message = ApexPages.getMessages();
            String RecordNotFound=message[0].getDetail();
        system.test.stopTest();
        System.assertEquals(system.label.RecordNotFound,RecordNotFound);
    }
}