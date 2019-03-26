trigger AddressUpdateforEvent on Event (before insert, before update) {
    Trigger_Turn_Off__c triggerOff = Trigger_Turn_Off__c.getValues('TurnOffAllTriggers');
    if(!triggerOff.Turn_Off__c)
    { 
        if(trigger.isBefore){
            if(trigger.isInsert)
            {
                AddressUpdateforEventTriggerHandler.onAfterInsertUpdateEvent(Trigger.new);
                // Added for sfo type field update
                AddressUpdateforEventTriggerHandler.onBeforeInsertEvent(Trigger.new);
            }
            if(trigger.isUpdate)
            {            
                AddressUpdateforEventTriggerHandler.onAfterInsertUpdateEvent(Trigger.new);
            }
        }        
    }
}