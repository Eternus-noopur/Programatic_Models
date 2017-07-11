public with sharing class PlotMarkerTriggerContactHandler {
    public static List<String> contactIdList;
    public static void plotMarkersMethod(List<Contact> contactLst)
    {
           contactIdList = new List<String>();
           for(Contact contacts : contactLst)
           {
                contactIdList.add(contacts.id);
           } 
           googleCallout(contactIdList);
    }
    
    @future(callout= True)
    
    public static void googleCallout(List<id> newRecordId)
    {
        
        List<double> locationList = new List<double>();
        String searchQuery;
        List<String> listofLinks;
        

        List<Contact> contactParametersList = [Select id, Name ,MailingAddress ,MailingLatitude,MailingLongitude
                                           from Contact where id =: newRecordId];
        for(Contact con : contactParametersList ){        
            Address addr = con.MailingAddress;
            String query = addr.getStreet()+','+addr.getCity()+','+addr.getState();
            query = String.join(query.split(' '),'+');
            query = String.join(query.split('\n'),'+');

            HttpRequest request = new  HttpRequest();
            request.setEndpoint ('https://maps.googleapis.com/maps/api/geocode/json?sensor=false&address='+query); 
            request.setMethod('GET');
            request.setTimeout(30000);
        
            Http http = new Http(); 
            HttpResponse response = http.send(request);
            String reponseBody = response.getBody();
        
            Map<String, Object> responseJsonMap = (Map<String, Object>)JSON.deserializeUntyped(reponseBody); 
            List<object> ObjectName = (List<object>)responseJsonMap.get('results'); 
            Map<String,Object> maplocation = (Map<String,Object>)ObjectName[0];
            Map<String,Object> geometry = (Map<String,Object>)maplocation.get('geometry');
            Map<String,Object> locationMap = (Map<String,Object>)geometry.get('location');
            Map<String,Object> itemMap = (Map<String,Object>)locationMap;
            double lat = double.valueOf(itemMap.get('lat'));
            double lng = double.valueOf(locationMap.get('lng'));
            con.MailingLatitude = lat;
            con.MailingLongitude = lng;
        }
        update contactParametersList;
        
    }
    
}