public class AccountMap {
	public static void accMap(){
	List<Account> li=new List<Account>([Select id,name from Account]);
	Map <String , Id> accountmap= new Map <String , Id>();
	for(Account acc:li)
	{
		accountmap.put(acc.name,acc.id);
	}
	system.debug(accountmap);
List<Account> li2=new List<Account>([Select id, Name from Account]);
	Map < Id , Account> accountmap2= new Map <Id , Account>();
		for(Account  acc1:li2)
	{
		accountmap2.put(acc1.id,acc1);
	}
	system.debug(accountmap2);
	}
}