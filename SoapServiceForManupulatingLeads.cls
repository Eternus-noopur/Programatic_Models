global class SoapServiceForManupulatingLeads {
    
    global class Response{
        webservice boolean isSuccess;
        webservice Id LeadId;
        webservice String Status;
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
            Response res = new Response();
            res.isSuccess = True;
            res.LeadId = newLead.Id;
            res.Status = 'Success';
            return res;
         }
         catch(DMLException e)
         {
            Response res = new Response();
            res.isSuccess = False;
            res.Status = 'Failure';
            return res;
         }
    }
     
    webservice static Response deleteLeadRecord(String firstName, String lastName,String email, String phone, String Company)
    {
        try
        {
            List<Lead> newLead = [Select FirstName,LastName,Email,Phone from Lead where FirstName=:firstName AND LastName=:lastName AND 
                                  Email=: email AND Phone =: phone];
         
            delete newlead[0];
            Response res = new Response();
            res.isSuccess = True;
            res.LeadId = newLead[0].Id;
            res.Status = 'Succes';
            return res;
         }
         catch(DMLException e){
             Response res = new Response();
             res.isSuccess = False;
             res.Status = 'Failure';
             return res;
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
            Response res = new Response();
            res.isSuccess = True;
            res.LeadId = updatelead[0].Id;
            res.Status = 'Succes';
            return res;
         }
         catch(DMLException e)
         {
            Response res = new Response();
            res.isSuccess = False;
            res.Status = 'Failure';
            return res;
         }   
     }
}