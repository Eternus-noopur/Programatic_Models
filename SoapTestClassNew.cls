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
private class SoapTestClassNew {
    @testSetup
    
    public static void testSetup()
    {
        List<lead> leads= LeadFactory.createAndInsertLeads(2);    
    }
    
    static testMethod void testForPostMethod() {
        
    system.test.startTest();
        SoapServiceForManupulatingLeads.Response responseObj = new SoapServiceForManupulatingLeads.Response(); 
        responseObj = SoapServiceForManupulatingLeads.createLead('Neha','Garg','neha@gmail.com','222722','espl');
    system.test.stopTest();
    List<lead> leadList = [Select firstname, lastname, email, phone, company from lead];
    system.assertEquals(true , responseObj.isSuccess );
    system.assertNotEquals(null , responseObj.LeadId );
    system.assertNotEquals('Success', responseObj.LeadId );
    system.assertEquals(3,leadList.size());        
   }
   
   static testMethod void testForDeleteMethod() {
        
    system.test.startTest();
        SoapServiceForManupulatingLeads.Response responseObj = new SoapServiceForManupulatingLeads.Response(); 
        responseObj = SoapServiceForManupulatingLeads.deleteLeadRecord('Lead1','Lead#1','abc1@gmail.com','123451','ESPL');
    system.test.stopTest();
    
    List<lead> leadList = [Select firstname, lastname, email, phone, company from lead];
    system.assertEquals(true , responseObj.isSuccess );
    system.assertNotEquals(null , responseObj.LeadId );
    system.assertNotEquals('Success', responseObj.LeadId );
    system.assertEquals(1,leadList.size());        
   }
   
   static testMethod void testForUpdateMethod() {
        
    system.test.startTest();
        SoapServiceForManupulatingLeads.Response responseObj = new SoapServiceForManupulatingLeads.Response(); 
        responseObj = SoapServiceForManupulatingLeads.updateLead('Lead1','Lead#1','abc@gmail.com','1234','ESP');
    system.test.stopTest();
    
    List<lead> leadList = [Select firstname, lastname, email, phone, company from lead];
    system.assertEquals(true , responseObj.isSuccess );
    system.assertNotEquals(null , responseObj.LeadId );
    system.assertNotEquals('Success', responseObj.LeadId );
    system.assertEquals(2,leadList.size());        
   }
}