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
private class ApplicationSettingSecondTestClass {

    @testSetup
    
    public static void createDataFactory() {
        LanguageCustomSetting__c languageObj = new LanguageCustomSetting__c();
        languageObj.Name = 'English';
        languageObj.Code__c = 'en_US';
        insert languageObj;
    }
    static testMethod void checkForLanguageCode() {
        system.test.startTest();
            Student__c studentObj = new Student__c();
            ApexPages.StandardController controller = new ApexPages.StandardController(studentObj);
            StudentRegistrationController studentRegistrationObject = new StudentRegistrationController(controller);
            studentRegistrationObject.selectedLang='English';
            studentRegistrationObject.selectChange();
            system.assertEquals('en_US',studentRegistrationObject.languageCode);
        system.test.stopTest();
    }
    static testMethod void checkForPageMessages() {
        system.test.startTest();
            Student__c studentObj = new Student__c(Name='Test',City__c='Shimla',Country__c='India',
                                                    Gender__c='Female');
            ApexPages.StandardController controller = new ApexPages.StandardController(studentObj);
            StudentRegistrationController studentRegistrationObject = new StudentRegistrationController(controller);
            studentRegistrationObject.saveMethod();
           
            List<ApexPages.message> message = ApexPages.getMessages();
            String successMsg=message[0].getDetail();
            system.assertEquals('Your admission application has been submitted successfully',successMsg);
        system.test.stopTest();
    }
}