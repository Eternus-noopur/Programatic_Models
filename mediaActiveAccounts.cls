/*---------------------------------------------------------------------------------------------------------------

Child to parent
Q1.Write a soql query to retrieve all active contact records belonging to media industry. Also display the name of the
   account to which it is associated to.

-----------------------------------------------------------------------------------------------------------------*/

public with sharing class mediaActiveAccounts {
	public static void activeAccounts(){
		
		List<Contact> contactList=new List<Contact>([select Name, Id, Account.Id, Account.name from contact where Account.Industry='media' AND Account.Active__c='yes' ]);
		system.debug(contactList);
	
	}
    
}