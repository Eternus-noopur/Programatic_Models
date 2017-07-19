/**
* @description: Test class for generating mock response for the web service callout.
* @author: Noopur Naik
*
* @revision:
* Version      Date            Description
* ------------------------------------------------
* 1.0          30-Jun-2017     Initial revision.
**/
@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    
     global HTTPResponse respond(HTTPRequest req){
         HttpResponse res = new HttpResponse();
         res.setHeader('Content-Type', 'application/json');
         res.setBody('{"items":[{"link":"https://developer.salesforce.com"}]}');
         res.setStatusCode(200);
         return res;
     }
}