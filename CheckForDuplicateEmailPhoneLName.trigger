/**************************************************************************************

Q3.Restrict a Contact to be created with same LastName, Phone, Website.

***************************************************************************************/

trigger CheckForDuplicateEmailPhoneLName on Contact (before insert, before update) {
    public Set<String> emailSet= new set<String>();
    public Set<String> phoneSet= new set<String>();
    public Set<String> lastNameSet= new set<String>();
    List<contact> contactList=new List<Contact> ([Select Email,Phone,lastname from Contact]);   
  
    for(Contact contactObj: contactList )
    {
        emailSet.add(contactObj.Email); 
        phoneSet.add(contactObj.Phone);
        lastNameSet.add(contactObj.LastName.toLowerCase());       
    }
  
    For (Contact contactObj:Trigger.new)
    {
        if(contactObj.Email!=null)
        {
            if(emailSet.contains(contactObj.Email))
            {
                contactObj.addError('Email address should be unique.');
            }
            else
            {
                emailSet.add(contactObj.Email);
            }
      }
      if(contactObj.Phone!=null)
      {
          if(phoneSet.contains(contactObj.Phone))
          {
              contactObj.addError('Phone number should be unique.');
          }
          else
          {
              phoneSet.add(contactObj.Phone);
          }
             
      }
      if(contactObj.LastName!=null)
      {
          if(lastNameSet.contains(contactObj.LastName.toLowerCase()))
          {
              contactObj.addError('LastName should be unique.');
          }
          else
          {
              lastNameSet.add(contactObj.LastName.toLowerCase());
          }
      }
    }
}