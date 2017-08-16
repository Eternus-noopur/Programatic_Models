public class DataQuery {
     public static void databaseQueryDemo()
    {
        try{
            
            string a= 'select id,name from employee__c';
            list<sObject> dblist = Database.query(a);
            System.debug(dblist);   
            
            
        }catch(exception e){
            
        }
    }

}