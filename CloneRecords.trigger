/*------------------------------------------------------------------------------------------------------

Q3.Write a trigger on account which will create the clone record.

-------------------------------------------------------------------------------------------------------*/

trigger CloneRecords on Account (after insert) {
    TriggerSetting__c triggerSttingInstance =  TriggerSetting__c.getInstance();
    if(triggerSttingInstance.ContactObject__c){
        if(CheckRecursion.runOnce())
        {
            List<Account> accountList= new List<Account>();
            accountList = trigger.new.deepClone();
            insert accountList;
        }
    }
}