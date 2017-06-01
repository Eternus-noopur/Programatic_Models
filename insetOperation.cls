public class insetOperation {
    public static void insertOp(){
    	
    try{
    	Lead newrecord     = new Lead();
		newrecord.FirstName = 'Divya';
		newrecord.LastName  = 'Sharma';
		newrecord.Company   = 'Unemployed';
		insert newrecord;
		
		Account newRec=new Account();
		newRec.Name='Abhishek singh';
		insert newRec;
		
		Contact contactRecord=new Contact();
		contactRecord.FirstName='Shikha';
		contactRecord.Lastname='Mishra';
		
		insert newRecord;
		
		Opportunity newRecord1=new Opportunity();
		newRecord1.Name='Sneha';
		insert newRec;
    }catch(DmlException e){
    
    }
   }
}