/**
* @description: This is the data factory for contact object where dummy records 
                are created and inserted and furthur used in the test class.
* @author: Noopur Naik
*
* @revision:
* Version              Description
* -----------------------------------
* 1.0               Initial revision.
**/
@isTest
Public class ContactFactoryNew {

 public static List<Contact> createRecordsInContact(Integer count)
    {
        List<Contact> contactList=new List<Contact>();
        for(Integer i=1; i<=count;i++)
        {
            Contact contact=new Contact();
            Contact.FirstName='Contact'+i;
            Contact.LastName='Sahu'+i;
            Contact.Email='abc'+i+'@gmail.com';
            Contact.MobilePhone='95036'+i;
            Contact.Phone='95036'+i;
            
            contactList.add(Contact);
        }
        return contactList;
    }
    
    public static List<Contact> createAndInsertContacts(Integer count) {
    List<Contact> contactList = createRecordsInContact(count);
    return insertData(contactList);
    }
    
     public static List<Contact> insertData(List<Contact> contactList) {
     try{
     insert contactList;
     }
     catch(DMLException e)
     {}
     return contactList;
     }
     public static List<Contact> updateData(List<Contact> contactList) {
     update contactList;
     return contactList;
    }
}