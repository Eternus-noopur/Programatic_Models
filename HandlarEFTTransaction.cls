public  class HandlarEFTTransaction {
    public static void  EFTTransactionMethod(List<EFT_Transaction__c>  eftTransaction)
    {
        AssignmentRule AR=new AssignmentRule();
        AR=[Select id from AssignmentRule where sObjectType= 'Case' and Active=True LImit 1];
        Database.DMLOptions dmlOpts = new Database.DMLOptions();
        dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
        List<case> caseList=new List<case>();
        system.debug(eftTransaction);
        for(EFT_Transaction__c eftNew : [Select Id, Transaction_Method__c,
       Transaction_Status__c, SalesHeader__r.Status__c,
        SalesHeader__r.Account_Name__c, SalesHeader__r.Contact_Name__c,
        SalesHeader__r.Account_Name__r.Name, SalesHeader__r.id, SalesHeader__r.Name,
        Transaction_Date__c from EFT_Transaction__c where id In :eftTransaction])
        {
            if(((eftNew.Transaction_Method__c=='Credit Card Address Verify') && (eftNew.Transaction_Status__c=='Declined')) &&  (eftNew.SalesHeader__r.Status__c=='Open'))
            {
                System.debug('Allo');
                Case newCase=new case();
                newcase.Type='Address did not verify';
                //Id devRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Assignment').getRecordTypeId();
                newCase.AccountId=eftnew.SalesHeader__r.Account_Name__c;
                newCase.ContactId=eftnew.SalesHeader__r.Contact_Name__c;
                //newcase.RecordTypeId=devRecordTypeId;
                newcase.Origin='Internal';
                //newCase.Owner=AVS Queue;
                newCase.Reason='Address did not verify111';
                newCase.Status='New';
                newCase.Priority='High';
                newCase.Subject=eftnew.SalesHeader__r.Account_Name__r.Name+''+newCase.Type;
                newCase.Open_Sales_Order__c=eftnew.SalesHeader__r.id;
                newCase.Transaction_Status__c=eftnew.Transaction_Status__c;
                newCase.Sales_Order_Number__c=eftnew.SalesHeader__r.Name;
                newCase.Order_Date__c=eftnew.Transaction_Date__c;
                newCase.setOptions(dmlOpts);
                caseList.add(newCase);
             
        }
    }
    insert caseList;
   }
}