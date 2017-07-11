global class DempPlotController {
    public String queryForFetchingAccountRecords = 'Select id,name from account ';
    public DempPlotController(ApexPages.StandardSetController controller) {}
    public list<Search_Result__c> historyList{get;set;}
    public String SearchString{get;set;} 
    public integer pageSize=4;
    public ApexPages.StandardSetController newSetController;
    public static list<list<sObject>> searchedRecord {get;set;}
    public static list<String> resultSet {get;set;}
    public Id getAccountId {get; set;}
    public Id getId {get; set;}
    public Id getContactId {get; set;}
    public String searchText{get;set;}
    public List<Account> accounts {get; set;}
    public List<Contact> contacts {get; set;}
    transient public Integer countOfRows {get; set;}
    public boolean show{get;set;}
    public static String responseBody;
    public Boolean allBool {get;set;}
    
    public DempPlotController()
    {
        System.debug('Inside Controller');
        newSetController = new ApexPages.StandardSetController(Database.getQueryLocator(queryForFetchingAccountRecords));
        newSetController.setPageSize(pageSize);
    }
    public void searchRecords()
    {
        if(searchText.length()<2)
        {
            show = false;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter atleast 2 characters...'));
        }
        else
        {
            show = true;
            searchText = searchText + '%';
            accounts = [Select Id, Name, AccountNumber, Phone, OwnerId from Account where Name Like :searchText];
            contacts = [Select Id, Name, Phone, OwnerId from Contact where Name Like :searchText]; 
            countOfRows = accounts.size();
       }
   }
   
   @RemoteAction
   public static void deleteRec(List<String> lstOfId)
   {
        List<Account> accountList = [Select id,name from Account where id in : lstOfId]; 
        delete accountlist;
        List<Contact> contactList = [Select id,name from Contact where id in : lstOfId]; 
        delete contactList;
   }
    @RemoteAction
    global static List<String> demo(Id accId) {
        Account account = [SELECT id
                                , BillingLatitude   
                                , BillingLongitude
                             FROM Account 
                            WHERE id =: accId];
        List<String> location = new list<String>();
        location.add(String.valueOf(account.BillingLatitude));
        location.add(String.valueOf(account.BillingLongitude));
        return location;
    }

    @RemoteAction
    global static list<String> getAccountContactRecords(String searchText) {
        resultSet = new list<String>();
        if(searchText.length() >0){
            List<List<SObject>> searchList = [FIND :searchText IN ALL FIELDS RETURNING Account (Id, Name,Description), Contact(Id, Name,Description)];
            List<Account> accountList = searchList[0];
            List<Contact> contactList = searchList[1];
            for(Account acc : accountList){
                resultSet.add(acc.name);
            }
            for(Contact con : contactList){
                resultSet.add(con.name);    
             }
        }
        return resultSet;
    }

}