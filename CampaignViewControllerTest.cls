/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class CampaignViewControllerTest {
    @testSetup
        
    public static void campaignTestSetUp() {
        List<Campaign> campaignListActive = CampaignTestFactory.createCampaignRecords(10 , True, True );
        List<Campaign> campaignListDeactivated = CampaignTestFactory.createCampaignRecords(20 , True, False );
    }
    
    static testMethod void defaultListView() {
        system.test.startTest();
            CampaignViewController campaignObj = new CampaignViewController();
        system.test.stopTest();     
        String setDefaultValue = campaignObj.mapListView.get(campaignObj.campaignFilterId);
        system.assertEquals(2,campaignObj.pageSize);
        system.assertEquals('Recently Modified',setDefaultValue);
    }
    
    static testMethod void inActiveRecords() {
        CampaignViewController campaignObj = new CampaignViewController();
        for(String cam : campaignObj.mapListView.keySet())
        {
            if(campaignObj.mapListView.get(cam)=='Inactive Campaigns') {
            campaignObj.campaignFilterId = cam;
            }
        }
        system.test.startTest();
            campaignObj.pageSize = 100;
            campaignObj.resetFilter();
            List<Campaign> campaigns= campaignObj.getCampaigns();
        system.test.stopTest();
        List<Campaign> inactiveCampaigns = [Select isActive from Campaign where id in :campaigns];
        for(Campaign c : inactiveCampaigns)
        {
            system.assertEquals(false,c.isActive);
        }
        system.assertEquals(20,campaigns.size());
    }
    
    static testMethod void activeRecords() {
        CampaignViewController campaignObj = new CampaignViewController();
        for(String cam : campaignObj.mapListView.keySet())
        {
            if(campaignObj.mapListView.get(cam)=='All Active Campaigns') {
            campaignObj.campaignFilterId = cam;
            }
        }
        system.test.startTest();
            campaignObj.pageSize = 100;
            campaignObj.resetFilter();
            List<Campaign> campaigns= campaignObj.getCampaigns();
        system.test.stopTest();
        List<Campaign> inactiveCampaigns = [Select isActive from Campaign where id in :campaigns];
        for(Campaign c : inactiveCampaigns)
        {
            system.assertEquals(true,c.isActive);
        }
        system.assertEquals(10,campaigns.size());
    }
    
    static testMethod void allRecords() {
        CampaignViewController campaignObj = new CampaignViewController();
        for(String cam : campaignObj.mapListView.keySet())
        {
            if(campaignObj.mapListView.get(cam)=='All Campaigns') {
            campaignObj.campaignFilterId = cam;
            }
        }
        system.test.startTest();
            campaignObj.pageSize = 100;
            campaignObj.resetFilter();
            List<Campaign> campaigns= campaignObj.getCampaigns();
        system.test.stopTest();
            List<Campaign> inactiveCampaigns = [Select isActive from Campaign where id in :campaigns];
    system.assertEquals(30,campaigns.size());
    }
    
    static testMethod void recentlyModifiedRecords() {
        CampaignViewController campaignObj = new CampaignViewController();
        for(String cam : campaignObj.mapListView.keySet())
        {
            if(campaignObj.mapListView.get(cam)=='Recently Modified') {
            campaignObj.campaignFilterId = cam;
            }
        }
        system.test.startTest();
            campaignObj.pageSize = 100;
            campaignObj.resetFilter();
            List<Campaign> campaigns= campaignObj.getCampaigns();
        system.test.stopTest();
            List<Campaign> inactiveCampaigns = [Select isActive from Campaign where id in :campaigns];
        system.assertEquals(30,campaigns.size());
    }
    
    static testMethod void hasNext() {
        CampaignViewController campaignObj = new CampaignViewController();
        system.test.startTest();
            campaignObj.resetFilter();
            List<Campaign> campaigns= campaignObj.getCampaigns();
            campaignObj.next();
        system.test.stopTest();
        system.assertEquals(2,campaigns.size());
    }
    
    static testMethod void hasPrevious() {
        CampaignViewController campaignObj = new CampaignViewController();
        system.test.startTest();
          campaignObj.resetFilter();
          List<Campaign> campaigns= campaignObj.getCampaigns();
          campaignObj.next();
          campaignObj.prev();
        system.test.stopTest();
        system.assertEquals(2,campaigns.size());
    }
    
    static testMethod void getListViews() {
        CampaignViewController campaignObj = new CampaignViewController();
        system.test.startTest();
            SelectOption[] existingviews = campaignObj.getCampaignExistingViews();
        system.test.stopTest();
        system.assertEquals(6,existingviews.size());
    }
}