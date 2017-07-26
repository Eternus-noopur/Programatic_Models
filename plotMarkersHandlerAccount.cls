public with sharing class plotMarkersHandlerAccount {
    public static List<String> accountIdList;
    public static void plotMarkersMethod(List<Account> accountLst)
    {
           accountIdList = new List<String>();
           for(Account accounts : accountLst)
           {
                accountIdList.add(accounts.id);
           } 
           googleCallout(accountIdList);
    }
    
    @future(callout= True)
    
    public static void googleCallout(List<id> newRecordId)
    {
        
        List<double> locationList = new List<double>();
        String searchQuery;
        String queryFromAccountAddress;
        List<String> listofLinks;
        

        List<Account> accountParametersList = [Select id, Name ,BillingAddress ,BillingLatitude,BillingLongitude
                                           from Account where id =: newRecordId];
        for(Account acc:accountParametersList ){        
            Address addr = acc.BillingAddress;
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
            system.debug('+++++++++++++'+itemMap);
            double lat = double.valueof(itemMap.get('lat'));
            double lng = double.valueof(itemMap.get('lng'));
        
            acc.BillingLatitude = lat;
            acc.BillingLongitude = lng;
            system.debug('+++++++++++++'+acc.BillingLatitude);
            system.debug('+++++++++++++'+acc.BillingLongitude);
        }
        update accountParametersList;
        
    }
    
}