public  class StringOperations {
	
	public static void stringOperations(String testString)
	{
		String replaceString = testString.replace('@','A'); 
		system.debug('Replaced String:'+replaceString);	
		
		String substr = replaceString.substring(11); 
		system.debug('Substring:'+substr);
		
		String[] stringSpilt = replaceString.split(' ');
		system.debug('String split:');
		for(String index:stringSpilt)
		{ 
			system.debug(index);	 
		}  
		
		String removeSpaces= replaceString.remove(' '); 
		system.debug('String without whitespaces:'+removeSpaces);
		
		String upperCase= replaceString.toUpperCase(); 
		system.debug('String in uppercase:'+upperCase);
		
		String lowerCase= replaceString.toLowerCase(); 
		system.debug('String in lowercase:'+lowerCase);
		
			
	} 
    
}