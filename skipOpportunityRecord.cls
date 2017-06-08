/*---------------------------------------------------------------------------------------------------------

6. Write a SOQL query to display 100 opportunity records with amount greater than 10,000 order by
created date. Skip first 50 records and include records from recycle bin. 

------------------------------------------------------------------------------------------------------------*/

public  class skipOpportunityRecord {
	public static void addMultipleOpportunityRecords()
    {
          List<Opportunity> opportunityList = new List<Opportunity>([Select Name,Amount,StageName from Opportunity where Amount>10000 order by CreatedDate limit 100 offset 50 ALL ROWS]);
          system.debug(opportunityList);
    } 
}