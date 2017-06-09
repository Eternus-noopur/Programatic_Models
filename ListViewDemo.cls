public with sharing class ListViewDemo {
    Private String baseQuery1 = 'Select ID, Name, Type, Status, StartDate FROM Campaign ORDER BY LastModifiedDate desc';
    Private String baseQuery2 = 'Select ID, Name, Type, Status, StartDate FROM Campaign Order by StartDate desc';
    Private String baseQuery3 = 'Select ID, Name, Type, Status, StartDate FROM Campaign where   IsActive=True   Order by StartDate desc';
    Private String baseQuery4 = 'Select ID, Name, Type, Status, StartDate FROM Campaign where   IsActive=False  Order by StartDate desc';
    Map<String, String> listViewMap = new Map<String, String>();
    
    public String camFilterId {get; set;}
    private Integer pageSize = 2;
    public ListViewDemo(){}
    public ApexPages.StandardSetController CamSetController {
        get{
            if(CamSetController == null){
             
                CamSetController = new ApexPages.StandardSetController(Database.getQueryLocator(baseQuery1));
                CamSetController.setPageSize(pageSize);
                if(camFilterId != null)
                {
                    CamSetController.setFilterId(camFilterId);
                    CamSetController.setFilterId(listViewMap.get('Recently Modified'));
                }
                else
                {
                    CamSetController.setFilterId(listViewMap.get('Recently Modified'));
                }
            }
            return CamSetController;
        }set;
    }
    public ListViewDemo(ApexPages.StandardSetController c) { 
        CamSetController.setFilterId(listViewMap.get('Recently Modified'));
    }
    public void next()
    {
        if(CamSetController.getHasNext())
        {
            CamSetController.next();
        }
    }
    public void prev()
    {
        if(CamSetController.getHasPrevious())
        {
            CamSetController.previous();
        }
    }
    public List<Campaign> getCampaigns()
    {
        return (List<Campaign>)CamSetController.getRecords();
    }
    //Get all available list view for Account
    public SelectOption[] getCampaignExistingViews(){
     
        return CamSetController.getListViewOptions();
    }
    public PageReference resetFilter()
    {
        for(System.selectOption s : CamSetController.getListViewOptions())
        {
            listViewMap.put(s.getLabel(),s.getValue());
        }
        
        if(listViewMap.get('Recently Modified')==camFilterId){
          CamSetController = new  ApexPages.StandardSetController(Database.getQueryLocator(baseQuery1));    
        }
        else if(listViewMap.get('All Campaigns')==camFilterId){
           CamSetController= new ApexPages.StandardSetController(Database.getQueryLocator(baseQuery2));    
        }
        else if(listViewMap.get('All Active Campaigns')==camFilterId){
           CamSetController= new ApexPages.StandardSetController(Database.getQueryLocator(baseQuery3));    
        }
        else if(listViewMap.get('Inactive Campaigns')==camFilterId){
           CamSetController= new ApexPages.StandardSetController(Database.getQueryLocator(baseQuery4));    
        }
        CamSetController = null;
        CamSetController.setPageNumber(1);
        return null;
    }
}