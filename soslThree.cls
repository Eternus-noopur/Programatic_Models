/*--------------------------------------------------------------------------------------------------------------

Q2.Delete all inactive Account records created in last 90 days.
-----------------------------------------------------------------------------------------------------------------*/
public class soslThree {
	public static void deleteRecords(){
	
	List<Account> inactiveRecordList= new List<Account>([Select Id,name from Account where active__c='No' AND CreatedDate=LAST_90_DAYS]);
	system.debug(inactiveRecordList);
	
	}
}