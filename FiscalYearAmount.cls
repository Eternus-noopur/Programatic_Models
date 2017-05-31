/*------------------------------------------------------------------------------------------------

Aggregate functions
Q1.Write a soql query to retrieve sum of all closed Opportunity amount for current fiscal year.Store this information in the map
   with key as year and value as sum of amount. Iterate this map to display statistics.

---------------------------------------------------------------------------------------------------*/

public class FiscalYearAmount {
	
	public static void sumFicalYearAmount(){
        Integer currentYear = System.Today().year();
		List<AggregateResult> opportunityList = new List<AggregateResult>([Select  SUM (Amount) FROM Opportunity where FiscalYear=:currentYear AND StageName='Closed Won' ] );
        system.debug( opportunityList );
       
        Map < Integer,  Object> sumAmount= new Map < Integer,  Object>();
        
        sumAmount.put( currentYear,opportunityList[0].get('expr0'));
        system.debug( sumAmount );

	}
    
}