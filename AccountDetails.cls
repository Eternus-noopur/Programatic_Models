public class AccountDetails {
	public static void accdetails()
	{
		List<Account> accountlist=new List<Account>([Select id , name , (Select name from contacts) from account where name like 'john%']);
		system.debug( accountlist);
	}
    
}