public class StaticDemo {
	StaticDemo s;
	public static void staticMethod()
	{
		system.debug('In static method');
	}
	public void nonStaticMethod()
	{
		system.debug('In non static method');
		staticmethod();
	}
    
}