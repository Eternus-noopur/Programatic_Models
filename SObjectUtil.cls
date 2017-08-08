public with sharing class SObjectUtil {

    public static boolean isObjectExist(String ObjectNameParam){
     for (Schema.SObjectType sObjectType : Schema.getGlobalDescribe().values() ) {
        String sobjName = String.valueOf(sObjectType);
        if (sobjName.equals(ObjectNameParam) ) {
            return true;
        }
     }
     return false;
   }
}