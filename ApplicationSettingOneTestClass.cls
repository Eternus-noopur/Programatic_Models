@isTest
private class ApplicationSettingOneTestClass {
    static testMethod void checkFortotalCountryList() {
        List<City__c> cityLst = UnitTestDataFactory.createRecordsInCityCustomSetting(4,True);
        system.test.startTest();
            PageReference pageRef = Page.ApplicationSettingsOne_Vf_page;
            system.test.setCurrentPage(pageRef);
            CountryCityDependency cityCountryObj = new CountryCityDependency();
        system.test.stopTest();
        system.assertEquals(Integer.ValueOf(System.label.noOfCountries),cityCountryObj.countryList.size());   
    }
    static testMethod void cityCountryDependenciesUnitTest() {
        List<City__c> cityLst = UnitTestDataFactory.createRecordsInCityCustomSetting(4,True);
        system.test.startTest();
            PageReference pageRef = Page.ApplicationSettingsOne_Vf_page;
            system.test.setCurrentPage(pageRef);
            CountryCityDependency cityCountryObj = new CountryCityDependency();
            cityCountryObj.selectedCountry = 'India';
            cityCountryObj.fetchCity();
        system.test.stopTest();
        system.assertEquals(cityLst.size(),cityCountryObj.listSelectedCity.size());   
    }
}