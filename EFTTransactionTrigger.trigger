/*--------------------------------------------------------------------------------------------------------------

Q5. Address Did Not Verify – AVS:
    1.Create SalesHeader__c object :(Having lookup to Account & Contact ) & Add necessary fields.
    2.Create EFT_Transaction_Status__c object with the necessary fields and add look up to
      SalesHeader__c
    3.Create assignment record type on Case
    4.On Insert of a EFT_Transaction_Status__c, if
      EFT_Transaction_Status__c.Method_Name__c = “Credit Card Address Verify”
      EFT_Transaction_Status__c.Transaction_Status__c= “Declined”
      SalesHeader__c.Status__c = “Open”
      Create a Case with this mapping:
      Case                  Field Value
      Account               SalesHeader__c.Bill_to_Customer__c
      Contact               SalesHeader__c.Bill_to_Customer__c
      Record                Type Assignment
      Origin               "Internal"
      Owner                 AVS Queue
      Reason                Address Did Not Verify
      Priority              High
      Status                New
      Subject               Account.Name + " " + Case.Type
      Type                  Address Did Not Verify
      Open_Sales_Order__c   SalesHeader__c.Id
      Transaction_Status__c EFT_Transaction_Status__c.Transaction_Status__c
      Sales_Order_Number__c SalesHeader__c.Name
      Order_Date__c         EFT_Transaction_Status__c.Transaction_Date__c

----------------------------------------------------------------------------------------------------------------*/

trigger EFTTransactionTrigger on EFT_Transaction__c (after insert,after update) {
    
    TriggerCustomSetting__c triggerCustomSettingobj = TriggerCustomSetting__c.getInstance(' CaseGeneratingTrigger');
    if(triggerCustomSettingobj != NULL && 'False'.equalsIgnorecase(String.valueOf(triggerCustomSettingobj.IsEnable__c))){ 
        return;
    }
    
    HandlarEFTTransaction.EFTTransactionMethod(trigger.new);
}