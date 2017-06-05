trigger FirstTriggerNew on Account (before update) {
    TriggerSetting__c triggerSettingInastance= TriggerSetting__c.getInstance();
    if(triggerSettingInastance.AccountObject__c)
    {
	   System.debug('TriggerNew'+trigger.new);
	   system.debug('TRiggerOld' +trigger.old);
	   system.debug('Trigger.NewMap' +trigger.NewMap);
	   system.debug('Trigger.NewMap' +trigger.OldMap);
    }
}