trigger AddressUpdateforContact on Contact (before insert, before update) {
    Trigger_Turn_Off__c triggerOff = Trigger_Turn_Off__c.getValues('TurnOffAllTriggers');
    if(!triggerOff.Turn_Off__c)
    {
        if(trigger.isBefore){
            if(trigger.isInsert)
            {
                AddressUpdateforContactTriggerHandler.onBeforeInsertUpdateContact(Trigger.new);     		            
            }
            if(trigger.isUpdate)
            {            
                AddressUpdateforContactTriggerHandler.onBeforeInsertUpdateContact(Trigger.new);
            }
        } 
    }
}