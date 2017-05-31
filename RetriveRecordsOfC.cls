public class RetriveRecordsOfC {
	
	public static void retrieveRecords()
	{
		List<C__c> cList=new List<C__c>([select A_Name__c , B_Name__c , A_Name__r.Name__c, B_Name__r.Name__c from C__c where Name like 'john%' ]);
		system.debug(cList);
		
	}
    
}