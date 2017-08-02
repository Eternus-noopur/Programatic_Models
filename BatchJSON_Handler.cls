public with sharing class BatchJSON_Handler {
    public static void createRecordsBasedOnEvents(List<Events__c> events) {
        List<sObject> recordList = new List<sObject>();
        Set<String> recordFields;
        Map<String,Schema.SObjectField> allFieldsOfObject;
        for(Events__c event : events) {
            Boolean isValidField = true, containsRequiredFields = true;
            if(event.JSON__c != NULL) {
                try {
                    Map<String, Object> jsonFieldMap = (Map<String, Object>)JSON.deserializeUntyped(event.JSON__c);
                    String ObjectName = (String)jsonFieldMap.get('Object Name');
                    if(ObjectName != NULL) {
                        if(SObjectUtil.isObjectExist(ObjectName)) {
                            if(jsonFieldMap.containsKey('JSON') && jsonFieldMap.get('JSON')!='') {
                                String objectJson = JSON.serialize(jsonFieldMap.get('JSON'));
                                Map<String,String> jsonMap = (Map<String, String>)JSON.deserialize
                                                          (objectJson, Map<String, String>.class);
                                Schema.SObjectType fetchedObjectType = Schema.getGlobalDescribe().get(ObjectName);
                                sObject record = fetchedObjectType.newSObject();
                                allFieldsOfObject = fetchedObjectType.getDescribe().fields.getMap() ;
                                for(String fieldProvided: jsonMap.keySet()) {
                                    if(allFieldsOfObject.keySet().contains(fieldProvided.toLowerCase())) {
                                        record.put(fieldProvided.toLowerCase() ,jsonMap.get(fieldProvided));
                                    } else {
                                        isValidField = false;
                                        event.Error_If_Any__c = System.Label.Event_InvalidField;
                                        break;
                                    }
                                }
                                if(isValidField) {
                                    recordFields=new Set<String>();
                                    for(string fieldProvided : jsonMap.keySet()) {
                                        recordFields.add(fieldProvided.toLowerCase());
                                    }
                                    for(String field : allFieldsOfObject.keyset()) {
                                        Schema.DescribeFieldResult desribeResult =
                                                                        allFieldsOfObject.get(field).getDescribe();
                                        if( desribeResult.isCreateable() && !desribeResult.isNillable()
                                            && !desribeResult.isDefaultedOnCreate()) {
                                            if(!recordFields.contains(field.toLowerCase())) {
                                                containsRequiredFields = false;
                                                event.Error_If_Any__c = System.Label.Event_RequiredNotProvided;
                                                break;
                                            }
                                        }
                                    }
                                    if(containsRequiredFields) {
                                        recordList.add(record);
                                        event.IsProcessed__c = true;
                                    }
                                }
                            } else {
                                event.Error_If_Any__c = System.Label.Event_NoJSON;
                            }
                        } else {
                            event.Error_If_Any__c = System.Label.Event_InvalidObjectName;
                        }
                    } else {
                        event.Error_If_Any__c = System.Label.Event_NoObjectName;
                    }
                } catch(Exception e) {
                    event.Error_If_Any__c = System.Label.Event_InvalidJSON;
                }
            } else {
                event.Error_If_Any__c = System.Label.Event_FieldEmpty;
            }
        }
        try {
            insert recordList;
            update events;
        } catch(Exception e) {
        }
    }
}