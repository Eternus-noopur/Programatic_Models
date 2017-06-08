/*-------------------------------------------------------------------------------------------

Q4.Create a multiselect picklist on Account object called as Enrollment Year with values-2010,2011,
   2012,2013,2014,2015 and 2016. Get all records where in 'Enrollment Year' is:
   a.2010
   b.2013 and 2014
    
----------------------------------------------------------------------------------------------*/


public class EnrollmentYear {
    public static void multiSelectPicklist()
    {	
		List<Account> acclist=new List<Account>([Select Id,Name FROM Account where EnrollmentYear__c includes ('2010')]);
		system.debug(acclist);
	}
    public static void multiSelectPicklistSecond()
 	{	
		List<Account> acclist=new List<Account>([Select Id,Name FROM Account where EnrollmentYear__c includes ('2013') and  EnrollmentYear__c includes ('2014')]);
		system.debug(acclist);
	}
}