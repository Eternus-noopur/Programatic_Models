public with sharing class ContactAlphabeticalSearchUsingMap {
    public List<String> alpabetList{get;set;}
    public String searchAlphabet{get;set;}
    public list<contact> contactList{set;get;}
    public list<contact> showContacts{set;get;}
    public static contact con {set; get;}
    public List<Integer> charArr= new List<Integer>();
    public map<String,List<Contact>> mapAlphabetRecord{get;set;}
    public String convertedChar;
    public String query;
   
    public ContactAlphabeticalSearchUsingMap()
    {
        mapAlphabetRecord = new map<String,List<Contact>>(); 
        contactList=new List<Contact>([Select name,email,birthdate,mobilePhone from contact order by Name limit 1000]);
        showContacts = new  list<contact>();
        alpabetList = new List<String>();
        List<Integer> charList= new List<Integer>();
        for (Integer alphabetAsci=65;alphabetAsci<91;alphabetAsci++)
        {
            charList.clear();
            charList.add(alphabetAsci);  
            String convertedChar = String.fromCharArray(charArr); 
            alpabetList.add(convertedChar);
            mapAlphabetRecord.put(convertedChar,new List<Contact>());
        }
        mapAlphabetRecord.put('All',new List<Contact>());
        alpabetList.add('All');
        for(Contact contact : contactList)
        {
            mapAlphabetRecord.get('All').add(contact);  
            String start = contact.Name.substring(0,1).toUppercase();
            mapAlphabetRecord.get(start).add(contact);
        }
    }
    public void display(){
        showContacts = mapAlphabetRecord.get(searchAlphabet);
    }
    
    @RemoteAction
    public static void deleteContact(Id accountId)
    {
        con=[select id from Contact where Id=:accountId];
        delete con;
    }
}