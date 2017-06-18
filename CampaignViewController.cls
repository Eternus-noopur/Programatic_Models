public with sharing class CampaignViewController {
    public String queryForRecentlyModified = 'SELECT Name,Status,Type,StartDate,LastModifiedDate FROM Campaign ORDER BY LastModifiedDate DESC';
    public String queryForAllCampaigns = 'SELECT Name,Status,Type,StartDate,LastModifiedDate FROM Campaign ORDER BY StartDate DESC';
    public String queryForAllActivecampaigns = 'SELECT Name,Status,Type,StartDate,LastModifiedDate FROM Campaign WHERE isActive=true ORDER BY StartDate DESC';
    public String queryForAllInactivecampaigns = 'SELECT Name,Status,Type,StartDate,LastModifiedDate FROM Campaign WHERE isActive=false ORDER BY StartDate DESC';
    public Map<String,String> mapListView = new Map<String,String>();
    public String campaignFilterId {get; set;}
    public integer pageSize=Integer.valueOf(system.label.pageSize);
    public ApexPages.StandardSetController campaignSetController;
    
    public CampaignViewController() {
        if(campaignSetController == null){
            campaignSetController = new ApexPages.StandardSetController(Database.getQueryLocator(queryForRecentlyModified));
            campaignSetController.setPageSize(pageSize);
        }
        for(System.SelectOption selectOptionobj: campaignSetController.getListViewOptions()){
            mapListView.put(selectOptionobj.getValue(),selectOptionobj.getLabel());
        }
        if(campaignFilterId == null){
            for(String cam : mapListView.keySet())
            {
                if(mapListView.get(cam)=='Recently Modified') {
                campaignFilterId = cam;
                }
            }
         }
    }
    public void next(){
        if(campaignSetController.getHasNext()){
            campaignSetController.next();
        }
    }
    public void prev(){
        if(campaignSetController.getHasPrevious()){
        campaignSetController.previous();
        }
    }
    public List<Campaign> getCampaigns(){
        return (List<Campaign>)campaignSetController.getRecords();
    }
    public SelectOption[] getCampaignExistingViews(){
        return campaignSetController.getListViewOptions();
    }
    public pageReference resetFilter(){
        if(mapListView.get(campaignFilterId)=='Recently Modified')
        {
            campaignSetController = new ApexPages.StandardSetController(Database.getQueryLocator(queryForRecentlyModified));
            campaignSetController.setPageSize(pageSize);
        }
        else if(mapListView.get(campaignFilterId)=='All Campaigns')
        {
            campaignSetController = new ApexPages.StandardSetController(Database.getQueryLocator(queryForAllCampaigns));
            campaignSetController.setPageSize(pageSize);
        }
        else if(mapListView.get(campaignFilterId)=='All Active Campaigns')
        {
            campaignSetController = new ApexPages.StandardSetController(Database.getQueryLocator(queryForAllActivecampaigns));
            campaignSetController.setPageSize(pageSize);
        }
        else if(mapListView.get(campaignFilterId)=='Inactive Campaigns')
        {
            campaignSetController = new ApexPages.StandardSetController(Database.getQueryLocator(queryForAllInactivecampaigns));
            campaignSetController.setPageSize(pageSize);
        }
        campaignSetController.setPageNumber(1);
        return null;
    }
}