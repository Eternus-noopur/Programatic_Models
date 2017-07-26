@isTest
private class PlotMarkerOnGoogleMapsControllerTest {
    static testMethod void checkForTotalRecordsForSearchText() {
       system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
       system.test.startTest();
           List<Account> accounts = AccontFactoryNew.createAndInsertAccounts(10);
           PlotMarkerOnGoogleMapsController contlrObj=new PlotMarkerOnGoogleMapsController();
           contlrObj.searchText = 'Acc';
           contlrObj.searchRecords();
       system.test.stopTest();
       List<Account> accountList = [Select id from Account];
       System.assertEquals(accountList.size(), contlrObj.countOfRows);
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
        System.assertEquals(accounts[0].Name, accountlst[0].Name);
    }
       
    static testMethod void checkForBothAccountContactRecordsBulk() {
       system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
       system.test.startTest();
           List<Account> accounts = UnitTestDataFactory.createRecordsInAccount(10,true);
           List<Contact> contacts = UnitTestDataFactory.createRecordsInContact(1,false);
           PlotMarkerOnGoogleMapsController contlrObj=new PlotMarkerOnGoogleMapsController();
           contlrObj.searchText = 'Acc';
           PlotMarkerOnGoogleMapsController.getAccountContactRecords('Acc');
       system.test.stopTest();
       List<Account> accountlst = [Select id,name from Account];
       for(Integer index=1;index<10;index++)
       {
            System.assertEquals(accounts[index].name, accountlst[index].Name);
       }
    }
    
    static testMethod void checkForDeletionOfRecords() {
        system.Test.setMock(HttpCalloutMock.class, new MockHTTPResponsePlotMarkers());
        system.test.startTest();
            List<Account> accounts = UnitTestDataFactory.createRecordsInAccount(2,true);
            system.debug('+++'+accounts);
            List<Contact> contacts = UnitTestDataFactory.createRecordsInContact(1,false);
            List<String> Ids = new  List<String>();
            for(Account accLst : accounts)
            {
                Ids.add(accLst.id);   
            }
            PlotMarkerOnGoogleMapsController contlrObj=new PlotMarkerOnGoogleMapsController();
            PlotMarkerOnGoogleMapsController.deleteRec(Ids);
        system.test.stopTest();
        List<Account> accountlst = [Select id,name from Account];
        system.debug('==='+accountlst);
        System.assertNotEquals(accounts.size(), accountlst.size());
        
    }
}