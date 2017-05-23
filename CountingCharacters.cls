public class CountingCharacters {
	
	public static void countOccurance(String testString)
	{
		
		testString= testString.toLowerCase(); 
		testString= testString.remove(' '); 
		String[] stringSpilt = testString.split('');
		system.debug(stringSpilt);
		Set<String> uniqueString = new Set<String>(stringSpilt);
		for(String ch:uniqueString)
		{
			system.debug(ch+'\t'+testString.countMatches(ch));
		}
		
		
			
		
		
	
	
	}
    
}