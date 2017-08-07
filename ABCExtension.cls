public class ABCExtension {
    public Invoice_Containers__c invoiceContainer{get;set;}
    public Map<String,Double> mapExpenses{get;set;}
    public List<String> listOfKeys{get;set;}
    public ABCExtension (ApexPages.StandardController stdController)
    {
        invoiceContainer = (Invoice_Containers__c)stdController.getRecord();
        invoiceContainer = [Select Service_Fee__c,Total_Labour_Cost__c,Discount__c,Tax__c,Total_Cost__c from Invoice_Containers__c where Id=:invoiceContainer.Id];
        mapExpenses = new Map<String,Double>();
        listOfKeys = new List<String>(); 
        mapExpenses.put('Service Fee', invoiceContainer.Service_Fee__c);
        mapExpenses.put('Labour Cost', invoiceContainer.Total_Labour_Cost__c);
        mapExpenses.put('Discount', invoiceContainer.Discount__c);
        mapExpenses.put('Tax', invoiceContainer.Tax__c);
        mapExpenses.put('Total', invoiceContainer.Total_Cost__c);
        listOfKeys.addAll(mapExpenses.keySet());
    }
}