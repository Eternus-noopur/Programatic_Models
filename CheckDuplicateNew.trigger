/*------------------------------------------------------------------------------------------

Q4. Contact Duplicate Check Trigger:
    1)Create a new Trigger on Contact that will check for duplicates before allowing a new record
      into the database.
    2)Validate against the email address and phone number fields.
    3)An error be thrown with the error message – “A Contact with the same email address or
      phone number already exists in system.”
    4)Should be bulk safe in nature and must be capable of handling at least 200 records at a time.


-------------------------------------------------------------------------------------------*/

trigger CheckDuplicateNew on Contact (before insert, before update) {
    TriggerSetting__c triggerSettingInstance= TriggerSetting__c.getInstance();
        if(triggerSettingInstance.ContactObject__c)
        {
	       Set<String> Email= new set<String>();
	       Set<String> MobilePhone= new set<String>();
   	       For (Contact con:Trigger.new)
   	       {
            if(con.Email!=null)
     	    {
     	      if(Email.contains(con.Email))
      	      {
                con.addError('Record already exist');
      	      }
    	      else
       	      {
                Email.add(con.Email);
       	      }
            }
	           if(con.MobilePhone!=null)
               {
                if(MobilePhone.contains(con.MobilePhone))
       	        {
        	       con.addError('Record already exist');
      	        }
    	        else
       	        {
        	       MobilePhone.add(con.MobilePhone);
       	        }
               }
            }
            List<contact> contactList=new List<Contact> ([Select Email,MobilePhone from Contact where Email=:Email OR MobilePhone=:MobilePhone]);   
            Set<string> duplicateContact = new set <string >();
            for(Contact dupContact: contactList )
            {
                duplicateContact .add(dupContact.Email); 
                duplicateContact .add(dupContact.MobilePhone);
            }
            for(Contact c : Trigger.new)
            {
                if(c.Email!=null)
            {
                if(duplicateContact.contains(c.Email))
                {
                    c.Email.addError('Record already exist');
                }
            }
            if( c.MobilePhone!=null)
            {
                if(duplicateContact.contains(c.MobilePhone))
                {
                    c.MobilePhone.addError('Record already exist');
                }
            }
        }       
    } 
}