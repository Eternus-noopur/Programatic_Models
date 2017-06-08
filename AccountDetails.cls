/*-------------------------------------------------------------------------------------------------------------------
Parent to Child
1. Write a SOQL query on Account and find all associated contact records of the Account which
contains the word 'John'. Print all Account and Contact records retrieved above.
----------------------------------------------------------------------------------------------------------------------*/

public class AccountDetails {
	public static void accdetails()
	{
		List<Account> accountlist=new List<Account>([Select id , name , (Select name from contacts) from account where name like 'john%']);
		system.debug( accountlist);
	}
    
}