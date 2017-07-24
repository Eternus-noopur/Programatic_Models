public  class StudentRegistrationController {
    public Student__c student{get;set;}
    public List<SelectOption> langList{get; set;}
    public String selectedLang {get; set;}
    public String languageCode {get; set;}
    public StudentRegistrationController(ApexPages.StandardController controller)
    {
        student=(Student__c)controller.getRecord();
        langList = new  List<SelectOption>();
        if(LanguageCustomSetting__c.getAll().values().size()> 0)
        {
            for(LanguageCustomSetting__c setting : LanguageCustomSetting__c.getAll().values())
            {
                langList.add(new SelectOption(setting.Name, setting.Name));
            }
            selectedLang = LanguageCustomSetting__c.getAll().values()[0].Name;
            languageCode = LanguageCustomSetting__c.getAll().values()[0].Code__c;
        }
    }
    public void selectChange()
    {
        for(LanguageCustomSetting__c setting : LanguageCustomSetting__c.getAll().values())
        {
            if(setting.Name==selectedLang)
            {
                languageCode = setting.Code__c;
            }
        }
   }
   public pageReference saveMethod()
   {
        if(String.isNotBlank(student.City__c) && String.isNotBlank(student.Country__c) && String.isNotBlank(student.Course_Applying_For__c) && String.isNotBlank(student.Gender__c) &&  String.isNotBlank(student.State__c) &&  (student.Roll_Number__c!=null) && (student.SSC__c!=null)  && (student.HSC__c!=null) )
        {
            try
            {
                insert student;
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,System.Label.SuccessMessage));
            }
            catch(DMLException e){
            
            }
        }
        else
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,System.Label.EmptyFormMessage));
        return null; 
    }
}