/**************************************************************************************

Q3.Restrict a Contact to be created with same LastName, Phone, Website.

***************************************************************************************/

trigger CheckForDuplicateEmailPhoneLName on Contact (before insert, before update) {
    
    TriggerCustomSetting__c triggerCustomSettingobj = TriggerCustomSetting__c.getInstance('CheckForDuplicate');
    if(triggerCustomSettingobj != NULL && 'False'.equalsIgnorecase(String.valueOf(triggerCustomSettingobj.IsEnable__c))){ 
        return;
    }
    Map<String, Contact> contactMap = new Map<String, Contact>();
    for (Contact contactObj : System.Trigger.new) {
        if ((contactObj.Email != null) &&(System.Trigger.isInsert ||(contactObj.Email != System.Trigger.oldMap.get(contactObj.Id).Email)))
        {
            if (contactMap.containsKey(contactObj.Email))
            {
                contactObj.Email.addError('Another new contact has the same email address.');
            } 
            else 
            {
                    contactMap.put(contactObj.Email, contactObj);
            }
        }
        if ((contactObj.Lastname != null) &&(System.Trigger.isInsert ||(contactObj.Lastname != System.Trigger.oldMap.get(contactObj.Id).Lastname)))
        {
            if (contactMap.containsKey(contactObj.Lastname))
            {
                contactObj.Email.addError('Another new contact has the same Last Name.');
            } 
            else 
            {
                    contactMap.put(contactObj.Lastname, contactObj);
            }
        }
        if((contactObj.Phone != null) &&(System.Trigger.isInsert ||(contactObj.Phone != System.Trigger.oldMap.get(contactObj.Id).Phone)))
        {
            if (contactMap.containsKey(contactObj.Phone))
            {
                contactObj.Phone.addError('Another new contact has the same Phone Number.');
            } 
            else 
            {
                    contactMap.put(contactObj.Phone, contactObj);
            }
        }
    }
    for (Contact contactObject : [SELECT Email,LastName,Phone FROM Contact WHERE Email IN :contactMap.KeySet() OR LastName IN :contactMap.KeySet() OR Phone IN :contactMap.KeySet()]) 
    {
        Contact newContactForEmail = contactMap.get(contactObject.Email);
        Contact newContactForName = contactMap.get(contactObject.LastName);
        Contact newContactForPhone = contactMap.get(contactObject.Phone);
        if(newContactForEmail!=null)
        newContactForEmail.Email.addError('A contact with this email address already exists.');
        if(newContactForName!=null)
        newContactForName.LastName.addError('A contact with this Last Name already exists.');
        
        if(newContactForPhone!=null)
        newContactForPhone.Phone.addError('A contact with this Phone Number already exists.');
    }
}