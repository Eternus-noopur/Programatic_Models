/*--------------------------------------------------------------------------------------------

Parent to child
Q2.Write soql query to find all Account records which have atleast an opportunity record which is
   Closed won.
----------------------------------------------------------------------------------------------*/
public with sharing class ParentToChildSecond {
	public static void accountRecords()
	{
		List<Account> accountList = [Select id, name ,(select id,name,StageName from Opportunities) from Account where Id IN(Select AccountId from Opportunity where Stagename ='Closed Won')];
		system.debug(accountList);
	}
}