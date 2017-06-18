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
private class CampaignDetailControllerTest {

    static testMethod void myUnitTest() {
        List<Campaign> campaign = CampaignTestFactory.createCampaignRecords(1 , True, True );
        ApexPages.StandardController stdController = new  ApexPages.StandardController (campaign[0]);
        system.test.startTest();
           campaignDetailController campaignObj = new campaignDetailController(stdController);
       system.test.stopTest();
       List<SelectOption> getOptions = campaignObj.options;
       System.assertEquals(3,getOptions.size());
    }
     
    static testMethod void nullpageReference() {
        List<Campaign> campaign = CampaignTestFactory.createCampaignRecords(1 , True, True );
        ApexPages.StandardController stdController = new  ApexPages.StandardController (campaign[0]);
        campaignDetailController campaignObj = new campaignDetailController(stdController);
        system.test.startTest();
           Pagereference getPageReference = campaignObj.listViewAction();
        system.test.stopTest();
        if(campaignObj.actionList!= 'Manage Members' || campaignObj.actionlist !='Add members from mailing list')
        {
            System.assertEquals(null,getPageReference);
        }
    }
}