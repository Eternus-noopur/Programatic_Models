public with sharing class ApplicationSettingOneController {
   public String selectedCountry{get;set;}
   public String selectedCity{get;set;}
   public List<SelectOption> listSelectedCity{get;set;}
   public ApplicationSettingOneController(){
       listSelectedCity = new List<SelectOption>();
       List<SelectOption> options = new List<SelectOption>();
       if(City__c.getAll().values().size()>0){
           selectedCountry = City__c.getAll().values()[0].Country__c;
           fetchCity();
       }
   }
   public List<SelectOption> getCountryList(){
       List<SelectOption> options = new List<SelectOption>();
       set<String> setCountry = new set<String>();
       for(City__c c:City__c.getAll().values()){
       System.debug(c);
           if(!setCountry.contains(c.Country__c)){
               options.add(new SelectOption(c.Country__c,c.Country__c));
               setCountry.add(c.Country__c);
           }
       }
       return options;
   }
   public void fetchCity(){
       listSelectedCity = new List<SelectOption>();
       for(City__c c:City__c.getAll().values()){
           if(c.Country__c == this.selectedCountry){
               listSelectedCity.add(new SelectOption(c.Name,c.Name));
           }
       }
   }
   
}