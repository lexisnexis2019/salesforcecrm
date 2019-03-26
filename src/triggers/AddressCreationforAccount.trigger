trigger AddressCreationforAccount on Account (after insert, after update, before insert, before update) {    
    Trigger_Turn_Off__c triggerOff = Trigger_Turn_Off__c.getValues('TurnOffAllTriggers');
    
    if(!triggerOff.Turn_Off__c)
    {     
        if(trigger.isBefore){
            if(trigger.isInsert)
            {            
                AddressCreationforAccountTriggerHandler.onBeforeInsertAccount(Trigger.new);
            }
            if(trigger.isUpdate)
            {            
                AddressCreationforAccountTriggerHandler.onBeforeUpdateAccount(Trigger.new, Trigger.old, 'Update');
                // Added for record lock
                AddressCreationforAccountTriggerHandler.onBeforeUpdateLock(Trigger.new);
            }
        }
        if(trigger.isAfter)
        {
            if(trigger.isInsert)
            {
                AddressCreationforAccountTriggerHandler.onAfterInsertAccount(Trigger.new, Trigger.old, 'insert');
            }
            if(trigger.isUpdate)
            {
                // calling handler class unlockAccountChilds to handle OCPGUIDs update.
                LEXNEX_AccountHandler.unlockAccountChilds(Trigger.old, Trigger.new);
            }
        }
    }
}