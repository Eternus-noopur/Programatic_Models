/*---------------------------------------------------------------------------------------------------------------

Q2.System.debug the following statements for all events(Before and after)
a)Trigger.new b)Trigger.old c)Trigger.newMap d)Trigger.oldmap

--------------------------------------------------------------------------------------------------------------*/

trigger SecondTriggerNew on Contact (after insert, after update, before insert, before update) {
    TriggerSetting__c triggerSettingInstance =  TriggerSetting__c.getInstance();
	if(triggerSettingInstance.ContactObject__c){
	    if(trigger.isInsert && trigger.isbefore)
	   {
		  system.debug('Demo of Before Insert with Trigger.new' +trigger.new);
	   }  
	   else if(trigger.isUpdate && trigger.isbefore)
	   {
		  system.debug('Demo of Before update with Trigger.new' +trigger.new);
		  system.debug('Demo of Before update with Trigger.newMap' +trigger.newMap);
		  system.debug('Demo of Before update with Trigger.old' +trigger.old);
		  system.debug('Demo of Before update with Trigger.OldMap' +trigger.oldMap);
	   }  
	   else if(trigger.isInsert && trigger.isAfter)
	   {
		  system.debug('Demo of After insert with Trigger.new' +trigger.new);
		  system.debug('Demo of After update with Trigger.newMap' +trigger.newMap);
        
	   }  
	   else if(trigger.isUpdate && trigger.isAfter)
	   {
		  system.debug('Demo of After update with Trigger.new' +trigger.new);
		  system.debug('Demo of After update with Trigger.newMap' +trigger.newMap);
		  system.debug('Demo of After update with Trigger.old' +trigger.old);
		  system.debug('Demo of After update with Trigger.OldMap' +trigger.oldMap);
	   } 
	
    }
}