/*--------------------------------------------------------------------------------------------------------------

SOSL
Q1.find the word test in all name fields returning contact,account,lead and user.
----------------------------------------------------------------------------------------------------------------*/

public  class soslOne {
	public static void searchInObjects()
	{
	    List<List<sObject>> searchList = new List<List<sObject>>([FIND 'test' IN Name FIELDS returning Contact,Account,Lead,User]);
	    Contact[] conList=((List<Contact>)searchList[0]);		
		System.debug(conList);
		Account[] accountList=((List<Account>)searchList[1]);
		System.debug(accountList);
		Lead[] leadList=((List<Lead>)searchList[2]);
		System.debug(leadList);
		User[] userList= ((List<User>)searchList[3]);
		System.debug(userList);
	}
}