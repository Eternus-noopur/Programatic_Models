public with sharing class AssociatingAccountWithContactHandler {
    
    public static void ContactAccontAssociation(List<Contact> contactList)
    {
        Set<String> emailDomainSet= new  Set<String> ();
        for(Contact con:contactList)
        {
            if(con.Email==NULL)
            {
                continue;
            }
        emailDomainSet.add(con.Email.split('@').get(1));
        }
        if(!emailDomainSet.IsEmpty())
        {
            Map<String,Id> accountContactMap = new Map<String,Id>();
            for (Account acc: [Select Id, DomainName__c from Account where DomainName__c IN : emailDomainSet ])
	        {
	           accountContactMap.put(acc.DomainName__c,acc.Id);
	        }
	        for (Contact cnt : contactList) {
                if (cnt.Email == null)
                {
                    continue;
                }
                String domain = cnt.Email.split('@').get(1);
                if (accountContactMap.containsKey(domain)) {
                    cnt.AccountId = accountContactMap.get(domain);
                }
        }
        }
    }    
}