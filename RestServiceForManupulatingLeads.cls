@RestResource(urlMapping='/Leads/*')
global with sharing class RestServiceForManupulatingLeads {

    @HttpPost
    
    global static void createLead(String firstName, String lastName,String email, String phone, String Company)
    {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        try
        {
            Lead newLead = new Lead(
            FirstName=firstName,
            LastName=lastName,
            Email=email,
            Phone=phone,
            Company=company);
            insert newLead;
            if(newLead.Id!= null){
                response.addHeader('Content-Type', 'application/json');
                String jsonResponse = '{"response": {"isSuccess": "True", "Lead":"' +newLead.id+'","Status":"Success" }}';
                response.responseBody = blob.valueOf(jsonResponse);
            }
        }
        catch(DMLException e){
                response.addHeader('Content-Type', 'application/json');
                String jsonResponse = '{"response": {"isSuccess": "False","Status":"Failure" }}';
                response.responseBody = blob.valueOf(jsonResponse);
        }
    }
     
    @HttpDelete
 
    global static void deleteLeadRecord()
    {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String firstName = request.params.get('FirstName');
        String lastName = request.params.get('LastName');
        String email = request.params.get('Email');
        String phone = request.params.get('Phone');
        try
        {
            List<Lead> newLead = [Select FirstName,LastName,Email,Phone from Lead where FirstName=:firstName AND LastName=:lastName AND 
                                  Email=: email AND Phone =: phone];
            delete newlead[0];
        }
        catch(DMLException e)
        {
            response.addHeader('Content-Type', 'application/json');
            String jsonResponse = '{"response": {"isSuccess": "False","Status":"Failure" }}';
            response.responseBody = blob.valueOf(jsonResponse);
        }
        response.addHeader('Content-Type', 'application/json');
        String jsonResponse = '{"response": {"isSuccess": "True", "Lead":"' +firstname+Lastname+'","Status":"Success" }}';
        response.responseBody = blob.valueOf(jsonResponse);
    }
     
    @HttpPatch
     
    global static void updateLead(String firstName, String lastName,String email, String phone, String Company)
    {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        try
        {
            List<Lead> updatelead=[Select FirstName,LastName,Email,Phone from Lead where FirstName=:firstName AND LastName=:lastName];
            updatelead[0].Email=email;
            updatelead[0].Phone=phone;
            update updatelead[0];
            response.addHeader('Content-Type', 'application/json');
            String jsonResponse = '{"response": {"isSuccess": "True", "Lead":"' +updatelead[0].id+'","Status":"Success" }}';
            response.responseBody = blob.valueOf(jsonResponse);
         }
         catch(DMLException e)
         {
            response.addHeader('Content-Type', 'application/json');
            String jsonResponse = '{"response": {"isSuccess": "False","Status":"Failure" }}';
            response.responseBody = blob.valueOf(jsonResponse);
         }   
    }
}