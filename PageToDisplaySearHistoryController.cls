/**
* @description: Controller for visual force page which is used to display
                the history or the links of the queries asked by the users.
* @author: Noopur Naik
*
* @revision:
* Version      Date            Description
* ------------------------------------------------
* 1.0          2-July-2017     Initial revision.
**/

public with sharing class PageToDisplaySearHistoryController {
    
    public String queryForFetchingEmailContents = 'SELECT id, Email_Subject__c,Email_Body__c from Email_Handler__c limit 1000';
    public PageToDisplaySearHistoryController(ApexPages.StandardSetController controller) {}
    public list<Search_Result__c> historyList{get;set;}
    public String SearchString{get;set;} 
    public integer pageSize=Integer.valueOf(system.label.pageSize);
    public ApexPages.StandardSetController newSetController;
    public Id queryId {get; set;}
    
    public PageToDisplaySearHistoryController(){
        System.debug('Inside Controller');
        newSetController = new ApexPages.StandardSetController(Database.getQueryLocator(queryForFetchingEmailContents));
        newSetController.setPageSize(pageSize);
    }

    public List<Email_Handler__c> getEmailContentList() {
        System.debug('Inside getemailContentList');
        return (List<Email_Handler__c>) newSetController.getRecords();
    }
    
    public void showHistory() {
       System.debug('*****'+queryId);
       historyList=[SELECT Links__c FROM Search_Result__c where Search_Query__c  =:queryId];
    }
    public void next(){
        if(newSetController.getHasNext()){
            newSetController.next();
        }
    }
    public void previous(){
        if(newSetController.getHasPrevious()){
            newSetController.previous();
        }
    }
}