global class SoapServiceForManupulatingLeads {
    global class Response{
        webservice Boolean isSuccess;
        webservice Id leadId;
        webservice String status;
    }
    webservice static Response createLead(String firstName, String lastName,String email, String phone, String company)
    {
        try
        {
            Lead newLead = new Lead(
            FirstName = firstName,
            LastName = lastName,
            Email = email,
            Phone = phone,
            Company = company);

            insert newLead;
            Response response = new Response();
            response.isSuccess = True;
            response.leadId = newLead.Id;
            response.status = 'Success';
            return response;
         }
         catch(Exception exp)
         {
            Response response = new Response();
            response.isSuccess = False;
            response.status = exp.getMessage();
            return response;
         }
    }
    webservice static Response deleteLeadRecord(String firstName, String lastName,String email, String phone, String company)
    {
        try
        {
            List<Lead> lead = [Select FirstName,LastName,Email,Phone from Lead where FirstName=:firstName AND LastName=:lastName AND 
                                  Email=: email AND Phone =: phone];
         
            delete lead[0];
            Response response = new Response();
            response.isSuccess = True;
            response.leadId = lead[0].Id;
            response.status = 'Success';
            return response;
         }
         catch(Exception exp){
             Response response = new Response();
             response.isSuccess = False;
             response.status = exp.getMessage();
             return response;
          }
    }
    webservice static Response updateLead(String firstName, String lastName,String email, String phone, String company)
    {
        try
        {
            List<Lead> updateLead=[Select FirstName,LastName,Email,Phone from Lead where FirstName=:firstName AND LastName=:lastName];
            updatelead[0].Email=email;
            updatelead[0].Phone=phone;
            update updateLead[0];
            Response response = new Response();
            response.isSuccess = True;
            response.leadId = updateLead[0].Id;
            response.status = 'Success';
            return response;
         }
         catch(Exception exp)
         {
            Response response = new Response();
            response.isSuccess = False;
            response.status = exp.getMessage();
            return response;
         }   
    }
}