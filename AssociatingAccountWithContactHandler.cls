public with sharing class AssociatingAccountWithContactHandler {
    
    public static void ContactAccontAssociation(List<Contact> contactList)
    {
        Map<String, List<Contact>> emailDomainMap= new  Map<String, List<Contact>>();
        String emailDomain;
        for(Contact con:contactList)
        {
            if(con.Email != NULL)
            {
                emailDomain = con.Email.split('@').get(1);
                if(!emailDomainMap.keySet().contains(emailDomain)) {
                    emailDomainMap.put(emailDomain, new List<Contact>());
                }
                emailDomainMap.get(emailDomain).add(con);
            }
        }
        if(!emailDomainMap.IsEmpty())
        {
            for (Account acc: [Select Id, DomainName__c from Account where DomainName__c IN : emailDomainMap.keySet() ])
	        {
	           for(Contact c : emailDomainMap.get(acc.DomainName__c))
	           {
	               c.accountId = acc.Id;
	           }
	        }
        }
    }    
}