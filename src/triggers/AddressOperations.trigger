trigger AddressOperations on Address__c (before insert, before update, after insert, after update) {
    Trigger_Turn_Off__c triggerOff = Trigger_Turn_Off__c.getValues('TurnOffAllTriggers');    
    if(!triggerOff.Turn_Off__c)
    {  
        if(trigger.isAfter){
            if(trigger.isInsert)
            {
                AddressOperationsTriggerHandler.onAfterInsertUpdateAddress(Trigger.new);                        
            }
            if(trigger.isUpdate)
            {            
                AddressOperationsTriggerHandler.onAfterInsertUpdateAddress(Trigger.new);
            }
        }
        if(trigger.isBefore)
        {
            if(trigger.isInsert)
            {
                 AddressOperationsTriggerHandler.onBeforeInsertUpdateAddress(Trigger.new);
            }
            if(trigger.isUpdate)
            {
                 AddressOperationsTriggerHandler.onBeforeInsertUpdateAddress(Trigger.new);
            }
        }   
    }
}