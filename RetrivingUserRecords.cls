public class RetrivingUserRecords {
	public static void retUserRecords()
	{
		Map< Id , User > userRecords = new Map<Id,user>([Select Name from User where IsActive=TRUE]);
		system.debug(userRecords);
	
	}
    
}