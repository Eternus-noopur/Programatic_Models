public with sharing class CountryCityDependency {
    public String selectedCountry{get;set;}
    public String selectedCity{get;set;}
    public List<SelectOption> listSelectedCity{get;set;}
    public List<SelectOption> countryList {get;set;}
    public map<String,List<String>> countryCityMap{get;set;}
    public CountryCityDependency(){
        countryCityMapCreator();
        countryList = new List<SelectOption>();
        for(String country : countryCityMap.keySet())
        {
            countryList.add(new SelectOption(country, country));
        }
    }
    public void countryCityMapCreator()
    {
        countryCityMap = new map<String,List<String>>();
        for(City__c cityObject : City__c.getAll().values()) {
            if(!countryCityMap.containsKey(cityObject.Country__c))
            {
                countryCityMap.put(cityObject.Country__c, new List<String>{cityObject.Name});
            }
            else
            {
                countryCityMap.get(cityObject.Country__c).add(cityObject.Name);
            }
        }
    }
    public void fetchCity(){
        listSelectedCity = new List<SelectOption>();
        for(String cities : countryCityMap.get(selectedCountry))
        {
            listSelectedCity.add(new SelectOption(cities,cities));
        }
    }
}