trigger AddressUpdateforTask on Task (before insert, before update) {    
    Trigger_Turn_Off__c triggerOff = Trigger_Turn_Off__c.getValues('TurnOffAllTriggers');
    if(!triggerOff.Turn_Off__c)
    {
        if(trigger.isBefore){
            if(trigger.isInsert)
            {
                AddressUpdateforTaskTriggerHandler.onAfterInsertUpdateTask(Trigger.new);                        
            }
            if(trigger.isUpdate)
            {            
                AddressUpdateforTaskTriggerHandler.onAfterInsertUpdateTask(Trigger.new);
            }
        }  
    }
}