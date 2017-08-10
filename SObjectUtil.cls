public with sharing class SObjectUtil {
    public static boolean isObjectExist(String objectNameParam){
     for (Schema.SObjectType sObjectType : Schema.getGlobalDescribe().values()) {
        String sObjName = String.valueOf(sObjectType).toLowerCase();
        if (sObjName.equals(objectNameParam) ) {
            return true;
        }
     }
     return false;
   }
}