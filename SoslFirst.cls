/*-----------------------------------------------------------------------------------------------------
DML Operation

Q1.Create a custom object as log. Create a long text area field as error. Create the 100 lead records using
   DML operations having unique name.For all records which were not interested into lead object, insert a record in log object
   along with reason why a record was not inserted.Also,execute assignment rules to auto allocate lead records 
   to correct owner.
--------------------------------------------------------------------------------------------------------*/
public with sharing class SoslFirst {
	public static void insertLeadRecords()
    {
       List<Lead> leadList = new List<Lead>();
       Lead leadRecord;
       AssignmentRule AR = new AssignmentRule();
       AR = [select id from AssignmentRule where SobjectType = 'Lead' and Active = true limit 1];
       Database.DMLOptions dmlOpts = new Database.DMLOptions();
       dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;

       for(Integer record = 11; record <= 18; record++)
       {
           leadRecord = new Lead(FirstName='Lead#'+string.valueOf(record),
                                 LastName='Record#'+string.valueOf(record),
                                 Company='ESPL',
                                 City='Pune',
                                 Status='Open - Not Contacted');
           leadRecord.setOptions(dmlOpts);
           leadList.add(leadRecord);
       }
       for(Integer record = 19; record <= 20; record++)
       {
           leadRecord = new Lead(FirstName='Lead#'+string.valueOf(record),
                                 Company='ESPL',
                                 Status='Open - Not Contacted');
           leadRecord.setOptions(dmlOpts);
           leadList.add(leadRecord);
       }
       Database.SaveResult[] saveList = Database.insert(leadList,false);
       List<Log__c> logList = new List<Log__c>();
       Log__c logRecord;
       for(Database.SaveResult saveRecord : saveList)
       {
            if(!saveRecord.isSuccess())
            {
                String errorMessage;
                for(Database.Error error : saveRecord.getErrors())
                {
                    errorMessage =+ error.getMessage();
                }
                logRecord = new Log__c(Error__c=errorMessage);
                logList.add(logRecord);
            }
        }
        insert logList;
    }
}