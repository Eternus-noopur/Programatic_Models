@isTest
private class ABCExtensionTestClass {
     static testMethod void myUnitTest() {
       system.test.startTest();
           Invoice_Containers__c invoiceObj = ABCContainersfactory.createAndInsertInvoices();
           ApexPages.StandardController stdController = new ApexPages.StandardController(invoiceObj);
           ABCExtension controllerObj = new ABCExtension(stdController);
       system.test.stopTest();
       Invoice_Containers__c invoice  = [Select id,Service_Fee__c,Total_Labour_Cost__c,Discount__c,Tax__c,Total_Cost__c from Invoice_Containers__c limit 50000];
       System.assertEquals(invoiceObj.Service_Fee__c , controllerObj.invoiceContainer.Service_Fee__c);
       System.assertEquals(invoiceObj.Total_Labour_Cost__c , controllerObj.invoiceContainer.Total_Labour_Cost__c);
       System.assertEquals(invoiceObj.Discount__c , controllerObj.invoiceContainer.Discount__c);
       System.assertEquals(invoiceObj.Tax__c , controllerObj.invoiceContainer.Tax__c);
       System.assertEquals(invoiceObj.Total_Cost__c , controllerObj.invoiceContainer.Total_Cost__c);
   }
}