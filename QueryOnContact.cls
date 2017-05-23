public class QueryOnContact {
	
	public static void printingContactRecords(){
	
	List<Contact> contactRecords = new List<Contact>([SELECT Name, MobilePhone, Email FROM Contact]);
	system.debug(contactRecords);
	
	}
}