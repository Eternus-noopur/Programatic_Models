public with sharing class DatabaseSearch {
      public static void searchDemo(){
  
    String searchQuery = 'FIND \'nis*\' IN ALL FIELDS RETURNING Account(id,name),Employee__c';
    List<List<sObject>> searchList = search.query(searchQuery);
    List<Account> acc = ((List<Account>)searchList[0]);
    List<Employee__c> emp = ((List<Employee__c>)searchList[1]);
    System.debug('List of account is:'+acc);
    System.debug('List of Employee is:'+emp);
   }
}