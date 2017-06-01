/*trigger CloneRecords on Account (after insert) {
    
  if(CheckRecursion.runOnce())
  {
    List<Account> accountList= new List<Account>();
    accountList = trigger.new.deepClone();
   	insert accountList;
  }
    		
}
*/