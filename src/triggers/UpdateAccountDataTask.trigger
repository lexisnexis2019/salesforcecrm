/*
Trigger Name  : UpdateAccountDataTask 
Description   : This trigger fires on Task after insert, update and delete.
Author        : Madhavi Valavala
*/
trigger UpdateAccountDataTask on Task (after insert, after delete, after update) {
    Trigger_Turn_Off__c triggerOff = Trigger_Turn_Off__c.getValues('TurnOffAllTriggers');    
    if(!triggerOff.Turn_Off__c)
    {
        if(Trigger.isAfter)
        {
            if(Trigger.isInsert || Trigger.isUpdate)
            {
                UpdateAccountActivity_Handler.afterInsUpdDel_TaskCount(Trigger.newMap);   
            }  
            if(Trigger.isDelete)
            {
                UpdateAccountActivity_Handler.afterInsUpdDel_TaskCount(Trigger.oldMap);   
            }
        }
    }
}