/*
Trigger Name  : UpdateAccountDataEvent 
Description   : This trigger fires on Event after insert, update and delete.
Author        : Madhavi Valavala
*/
trigger UpdateAccountDataEvent on Event (after insert, after delete, after update) {
    Trigger_Turn_Off__c triggerOff = Trigger_Turn_Off__c.getValues('TurnOffAllTriggers');    
    if(!triggerOff.Turn_Off__c)
    {
        if(Trigger.isAfter)
        {
            if(Trigger.isInsert || Trigger.isUpdate)
            {
                UpdateAccountActivity_Handler.afterInsUpdDel_EventCount(Trigger.newMap);   
            }  
            if(Trigger.isDelete)
            {
                UpdateAccountActivity_Handler.afterInsUpdDel_EventCount(Trigger.oldMap);   
            }
        }
    }
}