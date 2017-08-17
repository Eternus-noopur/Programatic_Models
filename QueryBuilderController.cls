public class QueryBuilderController {
    public List<SelectOption> objects {get;set;}
    public List<SelectOption> selectedFieldOptions {get;set;}
    public List<SelectOption> feildOptions {get;set;}
    public String selectedObj {get;set;}
    public List<String> objLst {get;set;}
    public List<String> fields {get;set;}
    public Set<String> fieldSelected {get;set;}
    public List<String> fieldsTobeRetrieved {get;set;}
    public Set<string> fieldNotSelected {get;set;}
    public Map<String, Schema.SObjectField> sObjectFields {get;set;}
    public Map<String, Schema.SObjectType> sObjectType {get;set;}
    public String objDescription {get;set;}
    public List<String> selectFields {get;set;}
    public List<String> selectedFields {get;set;}
    public String query {get;set;}
    public List<SObject> dataFromQuery {get;set;}
    public Boolean isObjSelected {get;set;}
    public Boolean isQueryExecuted {get;set;}
    public List<SelectOption> limitOptions {get;set;}
    public String selectedLimit {get;set;}
    public String selectedOrder {get;set;}
    public List<SelectOption> orderOptions {get;set;}

    public QueryBuilderController() 
    {
        sObjectType = Schema.getGlobalDescribe();
        objects = new List<SelectOption>();
        objLst = new List<String>();
        isObjSelected = false;
        isQueryExecuted = false;
        limitOptions = new List<SelectOption>();
        orderOptions = new List<SelectOption>();
        fieldsTobeRetrieved = new List<String>();
        dataFromQuery = new List<SObject>();
        selectFields = new List<String>();
        selectedFields = new List<String>();
        fields = new List<String>();
        fieldSelected = new Set<String>();
        fieldNotSelected = new Set<String>();
        selectedFieldOptions = new List<SelectOption>();
        feildOptions = new List<SelectOption>();
       
        for(Schema.SObjectType objToken : sObjectType.values())
        {
            Schema.DescribeSObjectResult objDescribe = objToken.getDescribe();
            if (objDescribe.isAccessible() && objDescribe.isQueryable()){
                objLst.add(objDescribe.getName());
            }
        }
        objLst.sort();
        SelectOption none = new SelectOption('None','-None-');
        objects.add(none);
        for(String stringObj : objLst)
        {
            SelectOption option = new SelectOption(stringObj,stringObj);
            objects.add(option);
        }
        limitOptions.add(new SelectOption('500','500'));
        limitOptions.add(new SelectOption('1000','1000'));
        limitOptions.add(new SelectOption('5000','5000'));
        limitOptions.add(new SelectOption('50000','50000'));
        selectedLimit = '500';
        orderOptions.add(new SelectOption('ASC','Ascending'));
        orderOptions.add(new SelectOption('DESC','Descending'));
        selectedOrder = 'ASC';
    }
    public void details(){
        isQueryExecuted = false;
        query = '';
        if(selectedObj != 'None')
        {
            Schema.DescribeSObjectResult resultObj = sobjectType.get(selectedObj).getDescribe();
            objDescription = ' '+resultObj;
            sObjectFields = sObjectType.get(selectedObj).getDescribe().fields.getMap();
            fields.clear();
            for(Schema.SObjectField fieldToken : sObjectFields.values())
            {
                Schema.DescribeFieldResult fieldDescribe = fieldToken.getDescribe();
                if(fieldDescribe.isAccessible() && String.valueOf(fieldDescribe.getSoapType())!= 'ADDRESS' )
                {
                    fields.add(fieldDescribe.getName());
                }
            }
            fields.sort();
            fieldNotSelected.clear();
            fieldSelected.clear();
            fieldNotSelected.addAll(fields);
            isObjSelected = true;
            show();
        } 
        else
        {
            isObjSelected = false;
        }
    }
    public void show()
    {
        feildOptions.clear();
        selectedFieldOptions.clear();
        for(String stringObj : fieldNotSelected)
        {
            SelectOption options = new SelectOption(stringObj,stringObj);
            feildOptions.add(options);
        }
        for(String stringObj : fieldSelected)
        {
            SelectOption options = new SelectOption(stringObj,stringObj);
            selectedFieldOptions.add(options);
        }
    }
    public void addFields(){
        fieldNotSelected.removeAll(selectFields);
        fieldSelected.addAll(selectFields);
        show();
    }
    public void removeFields(){
        fieldNotSelected.addAll(selectedFields);
        fieldSelected.removeAll(selectedFields);
        show();
    }
    public void queryData(){
        fieldsTobeRetrieved.clear();
        fieldsTobeRetrieved.addAll(fieldSelected);
        query = 'SELECT ';
        query += String.join(fieldsTobeRetrieved, ',');
        query += ' FROM '+ selectedObj +' ORDER BY Id '+selectedOrder+' LIMIT '+ selectedLimit;
        if(fieldsTobeRetrieved.size()>=1)
        {
            try{
                dataFromQuery = Database.query(query);
                if(dataFromQuery.size()<1){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,system.label.NoRecordAvailable));
                    
                }
                isQueryExecuted = true;
            }catch(Exception exp)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,exp.getMessage()));
            }
        } 
        else
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,system.label.FieldSelectionMessage));
        }
    }
}