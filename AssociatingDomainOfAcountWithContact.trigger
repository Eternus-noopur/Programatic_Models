/*-----------------------------------------------------------------------------------------------------------

Q1. ABC Containers require the ability to automatically associate a Contact created
    in their Salesforce Instance with the respective Account based on the email
    domain specified in the primary email address of the Contact. The association
    should happen real time as soon as a Contact record is created within the
    system.
    TODO:
     Ensure all the discussed implementation best practices are followed.
     Develop the necessary piece of Apex code to implement a solution for
      the given problem statement.
     Develop the necessary Test code to attain the right code coverage
      (minimum 90% with at least 4 test cases)
-------------------------------------------------------------------------------------------------------------*/

trigger AssociatingDomainOfAcountWithContact on Contact (before insert, before update) {
    TriggerCustomSetting__c triggerCustomSettingobj = TriggerCustomSetting__c.getInstance('AssociatingContactAccount');
    if(triggerCustomSettingobj != NULL && 'False'.equalsIgnorecase(String.valueOf(triggerCustomSettingobj.IsEnable__c))){ 
        return;
    }
    AssociatingAccountWithContactHandler.ContactAccontAssociation(trigger.new);  
}