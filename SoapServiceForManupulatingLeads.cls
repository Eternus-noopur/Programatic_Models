global class SoapServiceForManupulatingLeads {
    global class Response{
        webservice boolean isSuccess;
        webservice Id leadId;
        webservice String status;
    }

    webservice static Response createLead(String firstName, String lastName,String email, String phone, String Company)
    {
        try
        {
            Lead newLead = new Lead(
            FirstName=firstName,
            LastName=lastName,
            Email=email,
            Phone=phone,
            Company=company);

            insert newLead;
            Response response = new Response();
            response.isSuccess = True;
            response.leadId = newLead.Id;
            response.status = 'Success';
            return response;
         }
         catch(DMLException e)
         {
            Response response = new Response();
            response.isSuccess = False;
            response.status = 'Failure';
            return response;
         }
    }
     
    webservice static Response deleteLeadRecord(String firstName, String lastName,String email, String phone, String Company)
    {
        try
        {
            List<Lead> newLead = [Select FirstName,LastName,Email,Phone from Lead where FirstName=:firstName AND LastName=:lastName AND 
                                  Email=: email AND Phone =: phone];
         
            delete newlead[0];
            Response response = new Response();
            response.isSuccess = True;
            response.leadId = newLead[0].Id;
            response.status = 'Succes';
            return response;
         }
         catch(DMLException e){
             Response response = new Response();
             response.isSuccess = False;
             response.status = 'Failure';
             return response;
          }
    }
     
    webservice static Response updateLead(String firstName, String lastName,String email, String phone, String Company)
    {
        try
        {
            List<Lead> updatelead=[Select FirstName,LastName,Email,Phone from Lead where FirstName=:firstName AND LastName=:lastName];
            updatelead[0].Email=email;
            updatelead[0].Phone=phone;
            update updatelead[0];
            Response response = new Response();
            response.isSuccess = True;
            response.leadId = updatelead[0].Id;
            response.status = 'Succes';
            return response;
         }
         catch(DMLException e)
         {
            Response response = new Response();
            response.isSuccess = False;
            response.status = 'Failure';
            return response;
         }   
     }
}