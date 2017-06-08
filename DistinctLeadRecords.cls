/*----------------------------------------------------------------------------------------------

Aggregate Function
Q2.Find the total number of distinct lead records on the basis of lead source having greater than 10 leads.
   print this information.

--------------------------------------------------------------------------------------------------*/

public class DistinctLeadRecords {
    public static void distinctLead()
     { 
    	List<AggregateResult> leadRecords = new   List<AggregateResult>([select COUNT_DISTINCT(name),  LeadSource from Lead group by LeadSource having  COUNT(LeadSource) > 2    ]);   
    	System.debug(leadRecords);
     }
}