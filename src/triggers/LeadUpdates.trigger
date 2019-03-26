/************************************************************************************
Trigger Name    :    LeadUpdates

Description   :    This trigger runs for before update.

Version          Developed By           Description          Last Modified Date
------------------------------------------------------------------------------------
Version1.0       Madhavi              Initial Version      03/21/2018
*************************************************************************************/
trigger LeadUpdates on Lead (before update) {
    // To avoid recursive fire
    if(avoidRecursive.firstRun)
    {
        //changed from TurnOffAllTriggers to Turn_Off__c    
        Trigger_Turn_Off__c triggerOff = Trigger_Turn_Off__c.getValues('TurnOffAllTriggers');
        if(!triggerOff.Turn_Off__c)
        {
            if(trigger.isUpdate)
            {
                LeadUpdates_TriggerHandler.leadBeforeUpdate(Trigger.oldMap, Trigger.new);
            }
        }        
        avoidRecursive.firstRun = False;
    }
}