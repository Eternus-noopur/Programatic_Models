public class QueryBuilderController {
    public List<SelectOption> objects {set;get;}
    public List<SelectOption> selectedfieldOptions{set;get;}
    public List<SelectOption> feildOptions{set;get;}
    public String selectedObj {set;get;}
    public List<String> objlst {set;get;}
    public List<String> fields{set;get;}
    public Set<String> fieldselected{set;get;}
    public List<String> fieldsTobeRetrieved{set;get;}
    public Set<string> fieldnotselected{set;get;}
    public Map<String, Schema.SObjectField> sObjectFields{set;get;}
    public Map<String, Schema.SObjectType> sobjectType{set;get;}
    public String objDescription {set;get;}
    public List<String> selectfields{set;get;}
    public List<String> selectedfields{set;get;}
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
        objlst = new List<String>();
        dataFromQuery = new List<SObject>();
        selectfields = new List<String>();
        selectedfields = new List<String>();
        fields = new List<String>();
        fieldselected = new Set<String>();
        fieldnotselected = new Set<String>();
        selectedfieldOptions = new List<SelectOption>();
        feildOptions = new List<SelectOption>();
        sobjectType = Schema.getGlobalDescribe();
        for(Schema.SObjectType objToken : sobjectType.values())
        {
            Schema.DescribeSObjectResult objDescribe = objToken.getDescribe();
            if (objDescribe.isAccessible() && objDescribe.isQueryable()){
                objlst.add(objDescribe.getName());
            }
        }
        objlst.sort();
        SelectOption none = new SelectOption('None','-None-');
        objects.add(none);
        for(String stringObj : objlst)
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
            sObjectFields = sobjectType.get(selectedObj).getDescribe().fields.getMap();
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
            fieldnotselected.clear();
            fieldselected.clear();
            fieldnotselected.addAll(fields);
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
        selectedfieldOptions.clear();
        for(String s : fieldnotselected)
        {
            SelectOption op = new SelectOption(s,s);
            feildOptions.add(op);
        }
        System.debug('After Show ::: '+feildOptions);
        for(String s : fieldselected)
        {
            SelectOption op = new SelectOption(s,s);
            selectedfieldOptions.add(op);
        }
    }
    public void addFields(){
        fieldnotselected.removeAll(selectfields);
        fieldselected.addAll(selectfields);
        show();
    }
    public void removeFields(){
        fieldnotselected.addAll(selectedfields);
        fieldselected.removeAll(selectedfields);
        show();
    }
    public void queryData(){
        fieldsTobeRetrieved.clear();
        fieldsTobeRetrieved.addAll(fieldselected);
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
            }catch(Exception e)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
            }
        } 
        else
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,system.label.FieldSelectionMessage));
        }
    }
}