/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class ApplicationSettingOneTestClass {
    @testSetup
    
    public static void createDataFactory() {
        list<City__c> cityList = new list <City__c>();
        for(integer index = 1; index <= 4; index++) {
            City__c record = new city__c();
            record.Name = 'Pune'+index;
            record.Country__c = 'India';
            cityList.add(record);
        }
        for(integer index = 1; index <= 3; index++) {
            City__c record = new city__c();
           record.Name = 'Newyork'+index;
           record.Country__c = 'USA';
           cityList.add(record);
       }

       insert cityList;
   }
    static testMethod void cityCountryDependenciesUnitTest() {
        system.test.startTest();
            ApplicationSettingOneController cityCountryObj = new ApplicationSettingOneController();
            cityCountryObj.selectedCountry = 'India';
            cityCountryObj.getCountryList();
            cityCountryObj.fetchCity();
            system.assertEquals(4,cityCountryObj.listSelectedCity.size());

            cityCountryObj.selectedCountry = 'USA';
            cityCountryObj.getCountryList();
            cityCountryObj.fetchCity();
            system.assertEquals(3,cityCountryObj.listSelectedCity.size());
            
        system.test.stopTest();
    }
}