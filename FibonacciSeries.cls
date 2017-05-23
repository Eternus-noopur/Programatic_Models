public class FibonacciSeries {
	
	public static void fibonacciSeries(Integer n){
		
		Integer firstNumber=0,secondNumber=1,i,nextNumber;
		System.debug('Fibonacci Series:');
		System.debug(firstNumber);
		System.debug(secondNumber);
		for(i=2;i<n;i++)
		{
			nextNumber=firstNumber+secondNumber;
			firstNumber=secondNumber;
			secondNumber=nextNumber;
			
			System.debug(nextNumber);
		}
		
	}
    
}