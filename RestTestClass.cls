@isTest

private class RestTestClass {
    static testMethod void testForPostMethod() {
        RestRequest request = new RestRequest(); 
        RestResponse response = new RestResponse();
        restContext.response = response;
        request.httpMethod = 'POST';
        List<lead> leads= LeadFactory.createAndInsertLeads(2);
        system.test.startTest();
            RestServiceForManupulatingLeads.createLead('Neha','Garg','neha@gmail.com','222722','espl');
        system.test.stopTest();
        List<lead> leadList = [Select firstname, lastname, email, phone, company from lead];
        system.assertEquals((leads.size())+1,leadList.size());        
    }
    static testMethod void testForPostException() {
        RestRequest request = new RestRequest(); 
        RestResponse response = new RestResponse();
        restContext.response = response;
        request.httpMethod = 'POST';
        List<lead> leads= LeadFactory.createAndInsertLeads(2);
        system.test.startTest();
            RestServiceForManupulatingLeads.createLead('Neha','Garg','neha','222722','espl');
        system.test.stopTest();
        List<lead> leadList = [Select firstname, lastname, email, phone, company from lead];
        system.assertEquals(leads.size(),leadList.size());        
    }
    static testMethod void testForDeleteMethod() {
        RestRequest request = new RestRequest(); 
        RestResponse response = new RestResponse();
        restContext.request = request;
        restContext.response = response;
        request.requestURI = system.label.URIForRest;
        List<lead> leads= LeadFactory.createAndInsertLeads(3);
        request.addParameter('FirstName', 'Lead1');
        request.addParameter('LastName', 'Lead#1');
        request.addParameter('Email', 'abc1@gmail.com');
        request.addParameter('Phone', '123451');
        request.httpMethod = 'DELETE';
        system.test.startTest();
            RestServiceForManupulatingLeads.deleteLeadRecord();
        system.test.stopTest();
        List<lead> leadList = [Select firstname, lastname, email, phone, company from lead];
        system.assertEquals((leads.size())-1,leadList.size());
    }
    static testMethod void testForDeleteException() {
        RestRequest request = new RestRequest(); 
        RestResponse response = new RestResponse();
        restContext.request = request;
        restContext.response = response;
        request.requestURI = system.label.URIForRest;
        List<lead> leads= LeadFactory.createAndInsertLeads(3);
        request.addParameter('FirstName', 'Lead2');
        request.addParameter('LastName', 'Lead#1');
        request.addParameter('Email', 'abc1@gmail.com');
        request.addParameter('Phone', '123451');
        request.httpMethod = 'DELETE';
        system.test.startTest();
            RestServiceForManupulatingLeads.deleteLeadRecord();
        system.test.stopTest();
        List<lead> leadList = [Select firstname, lastname, email, phone, company from lead];
        system.assertEquals(leads.size(),leadList.size());
    }
    static testMethod void testForPatchMethod() {
        RestRequest request = new RestRequest(); 
        RestResponse response = new RestResponse();
        restContext.response = response;
        request.httpMethod = 'PATCH';
        List<lead> leads= LeadFactory.createAndInsertLeads(2);
        system.test.startTest();
            RestServiceForManupulatingLeads.updateLead('Lead1','Lead#1','abc@gmail.com','22222');
        system.test.stopTest();
        List<lead> leadList = [Select firstname, lastname, email, phone from lead];
        system.assertEquals(leads.size(),leadList.size());
        system.assertNotEquals(leads[0].Phone,leadList[0].Phone);
    }
    static testMethod void testForPatchException() {
        RestRequest request = new RestRequest(); 
        RestResponse response = new RestResponse();
        restContext.response =response;
        request.httpMethod = 'PATCH';
        List<lead> leads= LeadFactory.createAndInsertLeads(2);
        system.test.startTest();
            RestServiceForManupulatingLeads.updateLead('Lead1','Lead#1','abc','22222');
        system.test.stopTest();
        List<lead> leadList = [Select firstname, lastname, email, phone from lead];
        system.assertEquals(leads.size(),leadList.size());
        system.assertEquals(leads[0].Phone,leadList[0].Phone);
    }
}
