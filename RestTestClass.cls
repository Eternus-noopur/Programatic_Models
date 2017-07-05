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
private class RestTestClass {
   static testMethod void testForPostMethod() {
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    restContext.response =res;
    req.httpMethod = 'POST';
    List<lead> leads= LeadFactory.createAndInsertLeads(2);
    system.test.startTest();
        RestServiceForManupulatingLeads.createLead('Neha','Garg','neha@gmail.com','222722','espl');
    system.test.stopTest();
    List<lead> leadList = [Select firstname, lastname, email, phone, company from lead];
    system.assertEquals(3,leadList.size());        
   }
   
   static testMethod void testForDeleteMethod() {
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    restContext.request =req;
    restContext.response =res;
    req.requestURI = '/services/apexrest/Leads?';
    List<lead> leads= LeadFactory.createAndInsertLeads(3);
    req.addParameter('FirstName', 'Lead1');
    req.addParameter('LastName', 'Lead#1');
    req.addParameter('Email', 'abc1@gmail.com');
    req.addParameter('Phone', '123451');
    req.httpMethod = 'DELETE';
    system.test.startTest();
        RestServiceForManupulatingLeads.deleteLeadRecord();
    system.test.stopTest();
        List<lead> leadList = [Select firstname, lastname, email, phone, company from lead];
    system.assertEquals(2,leadList.size());
   }
   
   static testMethod void testForPatchMethod() {
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    restContext.response =res;
    req.httpMethod = 'PATCH';
    List<lead> leads= LeadFactory.createAndInsertLeads(2);
    system.test.startTest();
        RestServiceForManupulatingLeads.updateLead('Lead1','Lead#1','abc@gmail.com','22222','epl');
    system.test.stopTest();
    List<lead> leadList = [Select firstname, lastname, email, phone, company from lead];
    system.assertEquals(2,leadList.size());
   }

}