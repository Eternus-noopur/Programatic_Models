public class QueryBuilderController {
    public List<SelectOption> objects {set;get;}
    public List<SelectOption> selectedFieldOptions{set;get;}
    public List<SelectOption> feildOptions{set;get;}
    public String selectedObj {set;get;}
    public List<String> objLst {set;get;}
    public List<String> fields{set;get;}
    public Set<String> fieldSelected{set;get;}
    public List<String> fieldsTobeRetrieved{set;get;}
    public Set<string> fieldNotSelected{set;get;}
    public Map<String, Schema.SObjectField> sObjectFields{set;get;}
    public Map<String, Schema.SObjectType> sObjectType{set;get;}
    public String objDescription {set;get;}
    public List<String> selectFields{set;get;}
    public List<String> selectedFields{set;get;}
    public String query{set;get;}
    public List<SObject> dataFromQuery{set;get;}
    public Boolean isObjSelected{set;get;}
    public Boolean isQueryExecuted{set;get;}
    public List<SelectOption> limitOptions {set;get;}
    public String selectedLimit {set;get;}
    public String selectedOrder{set;get;}
    public List<SelectOption> orderOptions{set;get;}

    public QueryBuilderController() 
    {
        isObjSelected = false;
        isQueryExecuted = false;
        limitOptions = new List<SelectOption>();
        orderOptions = new List<SelectOption>();
        objects = new List<SelectOption>();
        fieldsTobeRetrieved = new List<String>();
        objLst = new List<String>();
        dataFromQuery = new List<SObject>();
        selectFields = new List<String>();
        selectedFields = new List<String>();
        fields = new List<String>();
        fieldSelected = new Set<String>();
        fieldNotSelected = new Set<String>();
        selectedFieldOptions = new List<SelectOption>();
        feildOptions = new List<SelectOption>();
        sObjectType = Schema.getGlobalDescribe();
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
            Schema.DescribeSObjectResult myObj = sobjectType.get(selectedObj).getDescribe();
            objDescription = ' '+myObj;
            sObjectFields = sObjectType.get(selectedObj).getDescribe().fields.getMap();
            fields.clear();
            for(Schema.SObjectField fieldToken : sObjectFields.values())
            {
                Schema.DescribeFieldResult fieldDescribe = fieldToken.getDescribe();
                if(fieldDescribe.isAccessible())
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