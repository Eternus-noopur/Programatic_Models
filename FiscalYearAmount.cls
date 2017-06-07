/*------------------------------------------------------------------------------------------------

Aggregate functions
Q1.Write a soql query to retrieve sum of all closed Opportunity amount for current fiscal year.Store this information in the map
   with key as year and value as sum of amount. Iterate this map to display statistics.

---------------------------------------------------------------------------------------------------*/

public class FiscalYearAmount {
	
	public static void sumFicalYearAmount(){
        Integer year;
        Double amount;
		List<AggregateResult> opportunityList = [SELECT Sum(Amount),FiscalYear FROM Opportunity WHERE StageName = 'Closed Won' group by FiscalYear];
        system.debug( opportunityList );
       
        Map < Integer, Double> sumAmount= new Map < Integer, Double>();
        for(AggregateResult o : opportunityList)
        {
            amount = (Double)o.get('expr0');
            year = (Integer)o.get('FiscalYear');
            sumAmount.put(year, amount);
        }
        system.debug( sumAmount );

	}
    
}