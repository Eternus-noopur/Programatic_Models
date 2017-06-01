public class QueryOnContactAccoount {
    public static void printingAccountRecords(){
    
    	List<Account> accountDetails=new List<Account>([SELECT Name,(SELECT Contact.Name FROM contacts) FROM Account]);
    	system.debug(accountDetails);
    }
}