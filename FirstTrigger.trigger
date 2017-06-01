/*--------------------------------------------------------------------------------------------------------

Q1.System.debug the following statements for any object
a)Trigger.new b)Trigger.old c)Trigger.newMap d)Trigger.oldmap

----------------------------------------------------------------------------------------------------------*/

trigger FirstTrigger on Lead (before update) {
	
	System.debug('TriggerNew'+trigger.new);
	system.debug('TRiggerOld' +trigger.old);
	system.debug('Trigger.NewMap' +trigger.NewMap);
	system.debug('Trigger.NewMap' +trigger.OldMap);
	
    
}