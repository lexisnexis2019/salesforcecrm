trigger TaskAttachTrigger on Task (after insert, before update) {
Trigger_Turn_Off__c triggerOff = Trigger_Turn_Off__c.getValues('TurnOffAllTriggers');    
    if(!triggerOff.Turn_Off__c)
    {
     TaskAttachTriggerHandler.onAfterInsertUpdateTaskAttach(Trigger.new, Trigger.IsInsert);  
    } 
}