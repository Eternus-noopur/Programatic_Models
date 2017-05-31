/*----------------------------------------------------------------------------------------------

Q5.Write a soql queryto findall account records where billing state is not maharashtra and kerela.
   Order the result by billingstate in descending orderwith null values at end. Display first
   10000 records only. 

-----------------------------------------------------------------------------------------------*/

public class BillingState {
    public static void addMultipleOpportunityRecords()
    {
        List<Account> accountList1 = new List<Account>();
        Account accountRecord;
        for(Integer i=0;i<10000;i++)
        {
            accountRecord = new Account(Name='Account'+string.valueOf(i));
            accountList1.add(accountRecord);
        }
        try
        {
            insert accountList1;
        }catch(DmlException e)
        {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
        List<Account> accountList = new List<Account>([Select Id,Name from account where BillingState NOT IN ('Maharashtra' , 'Kerela' ) order by BillingState NULLS LAST limit 10000 ] );
        for(Account acc : accountList)
        {
            system.debug( accountList );
        }
    }
}