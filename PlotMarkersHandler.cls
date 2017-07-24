public with sharing class PlotMarkersHandler {
    public static void plotMarkersMethodForAccountAndContact(Map<Id,sObject> mapForFetchingIds)
    {
           googleCallout(mapForFetchingIds.keyset());
    }
    @future(callout= True)
    public static void googleCallout(Set<id> newRecordId1)
    {
        List<sObject> parametersList = new  List<sObject>();
        List<Id> newRecordId = new list<Id>();
        newRecordId.addAll(newRecordId1);
        List<double> locationList = new List<double>();
        String searchQuery;
        List<String> listofLinks;
        String googleMapEndPointUrl ='https://maps.googleapis.com/maps/api/geocode/json?sensor=false&address=';
        if(String.valueOf(newRecordId[0]).substring(0,3) == '001')
        {
             parametersList = [Select id, Name ,BillingAddress ,BillingLatitude,BillingLongitude from Account where id in : newRecordId];
        }
        else
        {
             parametersList = [Select id, Name ,MailingAddress ,MailingLatitude,MailingLongitude from Contact where id in : newRecordId];
        }
                                           
        for(sObject sObjectObj : parametersList ){   
             Address addr;
           
            if(String.valueOf(sObjectObj.id).substring(0,3) == '001')
            {     
                Account convertedAccount = (Account)sObjectObj;
                addr = convertedAccount.BillingAddress;
            }
            else
            {
                 Contact convertedContact = (Contact)sObjectObj;
                 addr = convertedContact.MailingAddress;
            }
            String query = addr.getStreet()+','+addr.getCity()+','+addr.getState();
            query = String.join(query.split(' '),'+');
            query = String.join(query.split('\n'),'+');

            HttpRequest request = new  HttpRequest();
            request.setEndpoint (googleMapEndPointUrl+query); 
            request.setMethod('GET');
            request.setTimeout(30000);
        
            Http http = new Http(); 
            HttpResponse response = http.send(request);
            String reponseBody = response.getBody();
            if(String.isNotEmpty(reponseBody))
            {
                Map<String, Object> responseJsonMap = (Map<String, Object>)JSON.deserializeUntyped(reponseBody); 
                List<object> ObjectName = (List<object>)responseJsonMap.get('results'); 
                if(!objectName.isEmpty())
                {
                    Map<String,Object> maplocation = (Map<String,Object>)ObjectName[0];
                    Map<String,Object> geometry = (Map<String,Object>)maplocation.get('geometry');
                    if(!geometry.isEmpty())
                    {
                        Map<String,Object> locationMap = (Map<String,Object>)geometry.get('location');
                        if(!locationMap.isEmpty())
                        {
                            Map<String,Object> itemMap = (Map<String,Object>)locationMap;
                            if(!itemMap.isEmpty())
                            {
                                double lat = double.valueOf(itemMap.get('lat'));
                                double lng = double.valueOf(itemMap.get('lng'));
                                if(String.valueOf(sObjectObj.id).substring(0,3) == '001')
                                {
                                    Account convertedAccount = (Account)sObjectObj;
                                    convertedAccount.BillingLatitude = lat;
                                    convertedAccount.BillingLongitude = lng;
                                }else{
                                    Contact convertedContact = (Contact)sObjectObj;
                                    convertedContact.MailingLatitude = lat;
                                    convertedContact.MailingLongitude = lng;
                                }
                            }
                        }
                    }
                }
            }
        }
     update parametersList;
    }

    
}