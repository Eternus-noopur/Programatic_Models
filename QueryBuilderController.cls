public class QueryBuilderController {
    public List<SelectOption> objects {set;get;}
    public List<SelectOption> fsoptions{set;get;}
    public List<SelectOption> feildOptions{set;get;}
    public String selectedObj {set;get;}
    public List<String> objlst {set;get;}
    public List<String> fields{set;get;}
    public Set<String> fselected{set;get;}
    public List<String> fieldsTobeRetrieved{set;get;}
    public Set<string> fnotselected{set;get;}
    public Map<String, Schema.SObjectField> mfields{set;get;}
    public Map<String, Schema.SObjectType> mobjects{set;get;}
    public String objDescription {set;get;}
    public List<String> selectfields{set;get;}
    public List<String> rfields{set;get;}
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
        rfields = new List<String>();
        fields = new List<String>();
        fselected = new Set<String>();
        fnotselected = new Set<String>();
        fsoptions = new List<SelectOption>();
        feildOptions = new List<SelectOption>();
        
        mobjects = Schema.getGlobalDescribe();
        for(Schema.SObjectType objToken : mobjects.values())
        {
            Schema.DescribeSObjectResult objDescribe = objToken.getDescribe();
            if (objDescribe.isAccessible() && objDescribe.isQueryable()){
                objlst.add(objDescribe.getName());
            }
        }
    
        objlst.sort();
        SelectOption none = new SelectOption('None','-None-');
        objects.add(none);
        for(String s : objlst)
        {
            SelectOption option = new SelectOption(s,s);
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
            Schema.DescribeSObjectResult myObj = mobjects.get(selectedObj).getDescribe();
            objDescription = ' '+myObj;
            mfields = mobjects.get(selectedObj).getDescribe().fields.getMap();
            fields.clear();
            for(Schema.SObjectField fieldToken : mfields.values())
            {
                Schema.DescribeFieldResult fieldDescribe = fieldToken.getDescribe();
                if(fieldDescribe.isAccessible())
                {
                    fields.add(fieldDescribe.getName());
                }
            }
            fields.sort();
            fnotselected.clear();
            fselected.clear();
            fnotselected.addAll(fields);
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
        fsoptions.clear();
        System.debug('Inside Show ::: fnotselected:::'+fnotselected);
        System.debug('Inside Show ::: fnsoptions:::'+feildOptions);
        for(String s : fnotselected)
        {
            SelectOption op = new SelectOption(s,s);
            feildOptions.add(op);
        }
        System.debug('After Show ::: fnsoptions:::'+feildOptions);
        for(String s : fselected)
        {
            SelectOption op = new SelectOption(s,s);
            fsoptions.add(op);
        }
    }
    
  public void addFields(){
        fnotselected.removeAll(selectfields);
        fselected.addAll(selectfields);
        show();
    }

    public void removeFields(){
        System.debug('Rfields:::'+rfields);
        fnotselected.addAll(rfields);
        System.debug('fnotselected:::'+fnotselected);
        fselected.removeAll(rfields);
        show();
    }
    
public void queryData(){
        fieldsTobeRetrieved.clear();
        fieldsTobeRetrieved.addAll(fselected);
        query = 'SELECT ';
        query += String.join(fieldsTobeRetrieved, ',');
        query += ' FROM '+ selectedObj +' ORDER BY Id '+selectedOrder+' LIMIT '+ selectedLimit;
        if(fieldsTobeRetrieved.size()>=1)
        {
            try{
                dataFromQuery = Database.query(query);
                if(dataFromQuery.size()<1){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'No records to show for query'));
                }
                isQueryExecuted = true;
            }catch(Exception e)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
            }
        } 
        else
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select few fields to query'));
        }
        System.debug('query is:::'+query);
        System.debug('Data is:::'+dataFromQuery);
    }
}