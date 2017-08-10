/*********************************************************************************

B. Removal of duplicate Leads
1. During the Campaigning, It might happen that representative creates duplicate leads in an org.
2. So admin want to build a process which will run every 3 hours/day & remove the duplicate leads from
the org.
3. The criteria to find the duplicate records should be configurable.


*********************************************************************************/

global class RemoveDuplicateLeads implements Database.Batchable<sObject> , Database.Stateful{
    global set<string> uniqueSet = new set<string>(); 
    global set<Lead> duplicateSet = new set<Lead>();
    global List<Lead> duplicateList = new List<Lead>();
    
    global Database.QueryLocator start(Database.BatchableContext BC){
         return Database.getQueryLocator('Select id, name, email,phone from lead');
    }
    global void execute(Database.BatchableContext BC, List<Lead> leadList){
        EliminateDuplicateRecords__c eliminateRecord = EliminateDuplicateRecords__c.getinstance();
        for(Lead leadObject : leadList)
        {
            if(eliminateRecord.Email__c)
            {
                if(leadObject.Email!=null)
                {
                    if(!uniqueSet.contains(leadObject.Email))
                    {
                        uniqueSet.add(leadObject.Email);
                    }
                    else
                    {
                        if(!duplicateSet.contains(leadObject)){
                            duplicateSet.add(leadObject);
                        }
                    }
                }       
            }
            if(eliminateRecord.Phone_Number__c )
            {
                if(leadObject.Phone!=null)
                {
                    if(!uniqueSet.contains(leadObject.Phone))
                    {
                        uniqueSet.add(leadObject.Phone);
                    }
                    else
                    {
                        if(!duplicateSet.contains(leadObject)){
                            duplicateSet.add(leadObject);
                        }
                    }
                }       
            }
            if(eliminateRecord.Name__c )
            {
                if(leadObject.name!=null)
                {
                    if(!uniqueSet.contains(leadObject.name))
                    {
                        uniqueSet.add(leadObject.name);
                    }
                    else
                    {
                        if(!duplicateSet.contains(leadObject)){
                            duplicateSet.add(leadObject);
                        }
                    }
                }       
            }
        }
        duplicateList.addAll(duplicateSet);
        if(!duplicateList.IsEmpty())
        {
            delete duplicateList;
        }
    }
    global void finish(Database.BatchableContext BC){
    }
}