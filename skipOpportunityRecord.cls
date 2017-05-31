public  class skipOpportunityRecord {
	public static void addMultipleOpportunityRecords()
    {
        List<Opportunity> opportunityList = new List<Opportunity>();
        Opportunity opportunityRecord;
        for(Integer i=0;i<150;i++)
        {
            opportunityRecord = new Opportunity(Name='Opportunity'+string.valueOf(i),
                                                Amount=15000,
                                                StageName= 'Negotiation/Review',
                                                CloseDate= Date.valueOf('2017-03-03'));
            opportunityList.add(opportunityRecord);
        }
        try
        {
            insert opportunityList;
        }catch(DmlException e)
        {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
          List<Opportunity> opportunityList1 = new List<Opportunity>([Select Name,Amount,StageName from Opportunity where Amount>10000 order by CreatedDate offset 50 ALL ROWS]);
          system.debug(opportunityList1);
    } 
}