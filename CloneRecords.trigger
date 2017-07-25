/*------------------------------------------------------------------------------------------------------

Q3.Write a trigger on account which will create the clone record.

-------------------------------------------------------------------------------------------------------*/

trigger CloneRecords on Account (after insert) {
    
    TriggerCustomSetting__c triggerCustomSettingobj = TriggerCustomSetting__c.getInstance(' CloneRecordsTrigger');
    if(triggerCustomSettingobj != NULL && 'False'.equalsIgnorecase(String.valueOf(triggerCustomSettingobj.IsEnable__c))){ 
        return;
    } 

    if(CheckRecursion.runOnce())
    {
        List<Account> accountList= new List<Account>();
        accountList = trigger.new.deepClone();
        insert accountList;
    }
    
}