/*---------------------------------------------------------------------------------------------------

Parent to child
Q3.Write a soql query on A and retrieve all the parents with their child records where in child name is
   'John'.
-----------------------------------------------------------------------------------------------------*/
public class ParentToChildThird {
	public static void aRecords()
	{
		List<A__c> aList= new List<A__c>([Select Name ,(Select Name from Cs__r where Name like 'john%') from A__c]);
		system.debug(aList);	
	}
}