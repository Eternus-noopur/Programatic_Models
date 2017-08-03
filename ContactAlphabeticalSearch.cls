public with sharing class ContactAlphabeticalSearch {
    public List<String> alpabetList{get;set;}
    public Map<String,List<String>> alpabetRecordMap{get;set;}
    public String searchAlphabet{get;set;}
    public list<contact> contactList{set;get;}
    public list<contact> showContacts{set;get;}
    public static contact con {set; get;}
   
    public ContactAlphabeticalSearch()
    {
        alpabetList=new List<string>{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O',
                                     'P','Q','R','S','T','U','V','W','X','Y','Z','All'}; 
        contactList=new List<Contact>();
        contactList=[SELECT name,email,MobilePhone,Birthdate from contact order by Name limit 1000];
        showContacts=new List<Contact>();
        for(Contact contact:contactList)
        {
            showContacts.add(contact);
        }
    }
    public void display()
    {
        showContacts.clear();
        for(Contact contact:contactList)
        {
            if(searchAlphabet.equals('All'))
            {
                showContacts.add(contact);
            }
           else
           {
               if(contact.Name.startsWith(searchAlphabet.toLowerCase())||contact.Name.startsWith(searchAlphabet))
               {
                  showContacts.add(contact);
               }  
           }    
        }
   }

    @RemoteAction
    public static void deleteContact(Id acc)
    {
        con=[select id from Contact where Id=:acc];
        delete con;
    }
}