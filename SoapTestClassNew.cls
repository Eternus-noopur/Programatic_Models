@isTest
private class SoapTestClassNew {

    static testMethod void testForPostMethod() {
        List<lead> leads= LeadFactory.createAndInsertLeads(2);
        system.test.startTest();
            SoapServiceForManupulatingLeads.Response responseObj = new SoapServiceForManupulatingLeads.Response(); 
            responseObj = SoapServiceForManupulatingLeads.createLead('Neha','Garg','neha@gmail.com','222722','espl');
        system.test.stopTest();
        List<lead> leadList = [Select firstname, lastname, email, phone, company from lead];
        system.assertEquals(true , responseObj.isSuccess );
        system.assertNotEquals(null , responseObj.LeadId );
        system.assertNotEquals('Success', responseObj.LeadId );
        system.assertEquals((leads.size())+1,leadList.size());        
    }
    static testMethod void testForDeleteMethod() {
        List<lead> leads= LeadFactory.createAndInsertLeads(2);
        system.test.startTest();
            SoapServiceForManupulatingLeads.Response responseObj = new SoapServiceForManupulatingLeads.Response(); 
            responseObj = SoapServiceForManupulatingLeads.deleteLeadRecord('Lead1','Lead#1','abc1@gmail.com','123451','ESPL');
        system.test.stopTest();
        List<lead> leadList = [Select firstname, lastname, email, phone, company from lead];
        system.assertEquals(true , responseObj.isSuccess );
        system.assertNotEquals(null , responseObj.LeadId );
        system.assertNotEquals('Success', responseObj.LeadId );
        system.assertEquals((leads.size())-1,leadList.size());        
    }
    static testMethod void testForUpdateMethod() {
        List<lead> leads= LeadFactory.createAndInsertLeads(2);
        system.test.startTest();
            SoapServiceForManupulatingLeads.Response responseObj = new SoapServiceForManupulatingLeads.Response(); 
            responseObj = SoapServiceForManupulatingLeads.updateLead('Lead1','Lead#1','abc@gmail.com','1234','ESP');
        system.test.stopTest();
        List<lead> leadList = [Select firstname, lastname, email, phone, company from lead];
        system.assertEquals(true , responseObj.isSuccess );
        system.assertNotEquals(null , responseObj.LeadId );
        system.assertNotEquals('Success', responseObj.LeadId );
        system.assertEquals(leads.size(),leadList.size());        
    }
}