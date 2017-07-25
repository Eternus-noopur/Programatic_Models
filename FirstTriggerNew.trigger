trigger FirstTriggerNew on Account (before update) {
    
    TriggerCustomSetting__c triggerCustomSettingobj = TriggerCustomSetting__c.getInstance('FirstTriggerNew');
    if(triggerCustomSettingobj != NULL && 'False'.equalsIgnorecase(String.valueOf(triggerCustomSettingobj.IsEnable__c))){ 
        return;
    }
    
    System.debug('TriggerNew'+trigger.new);
	system.debug('TRiggerOld' +trigger.old);
	system.debug('Trigger.NewMap' +trigger.NewMap);
	system.debug('Trigger.NewMap' +trigger.OldMap);
}