/*--------------------------------------------------------------------------------------------------------

Aggregate function
Q3. Write asoql query to find the total number of lead records by status by lead source. Store this information
    in map and display the same.

----------------------------------------------------------------------------------------------------------*/

public class statusByLeadSource {
    public static void mappingLeadRecords()
    {
        List<AggregateResult> leadRecords = [SELECT status,LeadSource,count(Name) FROM Lead
                                            group by status,LeadSource];
        Map<String,Map<String,Integer>> leadMap = new Map<String,Map<String,Integer>>();
        for(AggregateResult r : leadRecords)
        {
           String status = (String) r.get('Status');
           if(!leadMap.containsKey(status))
           {
               leadMap.put(status, new Map<String,Integer>());
           }
           String source = (String) r.get('LeadSource');
           Integer leadCount = (Integer) r.get('expr0');
           leadMap.get(status).put(source,leadCount);
       }
       System.debug(leadMap);
    }

}