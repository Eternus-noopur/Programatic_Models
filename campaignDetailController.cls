public with sharing class campaignDetailController {
    public ApexPages.StandardController stdController;
    public string actionList {get; set;}
    public String link;
    public campaign campaign{get;set;} 
    public List<SelectOption> options {get; set;}

    public campaignDetailController(ApexPages.StandardController stdController)
    {
        this.stdController = stdController;
        this.campaign = (Campaign) stdController.getRecord();
        options = new List<SelectOption>();
        options.add(new SelectOption('Select Action','Select Action'));
        options.add(new SelectOption('Manage Members','Manage Members'));
        options.add(new SelectOption('Add members from mailing list','Add members from mailing list'));
    }

    public PageReference listViewAction() {
        if(actionlist =='Manage Members' || actionlist =='Add members from mailing list')
        {
            PageReference pageRef= new PageReference('/ui/campaign/CampaignManageMembersAddTab?campaignId=7017F0000008zQr');
            pageRef.setredirect(true);
            return pageRef;
        }
    return null;
    }
}