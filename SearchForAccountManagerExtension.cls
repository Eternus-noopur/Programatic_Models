public with sharing class SearchForAccountManagerExtension {
    private ApexPages.StandardSetController stdController;
    public List<Account> accounts {get; set;}
    public String searchText {get; set;}
    transient public Integer countOfRows {get; set;}
    transient public Boolean show {get; set;}
    public SearchForAccountManagerExtension(ApexPages.StandardSetController stdController)
    {
        this.stdController = stdController;
        this.accounts = stdController.getRecords();
        countOfRows = accounts.size();
        show = true;
    }
    public void searchRecords()
    {
        if(searchText.length()<3)
        {
            show = false;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,system.label.minimumWordLimitLabel));
        }
        else
        {
            show = true;
            searchText = searchText + '%';
            accounts = [Select Id, Name, AccountNumber, Phone from Account where Name Like :searchText];
            if(accounts.size()>0)
            {
                countOfRows = accounts.size();
            }
            else
            {
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,system.label.RecordNotFound));   
            }
            
        }
    }
    public void clearSearch()
    {
        show = true;
        accounts = [Select Id, Name, AccountNumber, Phone from Account order by Name];
        countOfRows = accounts.size();
    }
}