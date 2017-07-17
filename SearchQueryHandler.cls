/**
* @description: This is the handler for SearchQueryTrigger.In this the List of newly 
                created records are of Email haindler are fetched using trigger and 
                web service callout is made to search the results from google custom 
                search and fetch the related links to the search query.
* @author: Noopur Naik
*
* @revision:
* Version      Date            Description
* ------------------------------------------------
* 1.0          29-Jun-2017     Initial revision.
**/


public class SearchQueryHandler {
    
    public static String searchQuery;
    public static List<String> searchQueryIdList;
    public static String resultString; 
    public static Search_Result__c searchResult;
    public static void searchQueryMethod(List<Email_Handler__c>  emailhandlerList)
    {
        for(Email_Handler__c emailHandlerObj : emailhandlerList)
        {
            searchQueryIdList = new List<String>();
            searchQuery = emailHandlerObj.Email_Body__c;
            searchQueryIdList.add(emailHandlerObj.id);
        }
        googleSearchResults(searchQueryIdList);    
    }
    @future(callout= True)
    public static void googleSearchResults(List<id> newRecordId)
    {
      
        String emailHandlerId;
        String queryFromEmailBody;
        List<String> listofLinks;
        String customSearchLink = 'https://www.googleapis.com/customsearch/v1?key=AIzaSyAXfFEnmvaAGXwjkrUoUwnpfWwTi9ppcdQ&cx=017576662512468239146:omuauf_lfve&q=';
        
        list<Email_Handler__c> emailhandlerLst = [Select id
                                              , Email_Body__c 
                                           from Email_Handler__c 
                                          where id =: newRecordId];
                                          
        for(Email_Handler__c emailhandlerObj : emailhandlerLst){
            searchQuery = emailhandlerObj.Email_Body__c;
            emailHandlerId = emailhandlerObj.id;
            queryFromEmailBody = EncodingUtil.urlEncode(searchQuery, 'UTF-8');
      
            HttpRequest request = new  HttpRequest();
            request.setEndpoint (customSearchLink+queryFromEmailBody); 
            request.setMethod('GET');
            request.setTimeout(30000);
        
            Http http = new Http(); 
            HttpResponse response = http.send(request);
            String reponseBody = response.getBody();
            if(!String.isEmpty(reponseBody))
            {
                Map<String, Object> responseJsonMap = (Map<String, Object>)JSON.deserializeUntyped(reponseBody);
                List<object> objectName = (List<object>)responseJsonMap.get('items');
                if(!objectName.isEmpty())
                {
                    listOfLinks = new List<String> ();
                    for(object itemObj : objectName)
                    { 
                        Map<String,Object> itemMap = (Map<String,Object>)itemObj;
                        String typeConversionOfLink = (String)itemMap.get('link');
                        if(typeConversionOfLink!=null)
                            listOfLinks.add(typeConversionOfLink);
                    }
                    String resultString = String.join( listOfLinks, ' \n ' );
                    searchResult = new Search_Result__c();
                    searchResult.Links__c  = resultString;
                    searchResult.Search_Query__c = emailHandlerId;
                }
            }
        }
        insert searchResult;
        
    }
}