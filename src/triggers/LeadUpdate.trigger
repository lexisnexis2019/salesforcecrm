trigger LeadUpdate on Lead (before update) {
    Trigger_Turn_Off__c triggerOff = Trigger_Turn_Off__c.getValues('TurnOffAllTriggers');
    
    if(!triggerOff.Turn_Off__c)
    {
        for(Lead leadRecord : Trigger.new)
        {
            if(leadRecord.IsConverted)
            {
                Account acc = [SELECT Id, OC_Repair_Flag__c FROM Account WHERE Account.Id =: leadRecord.ConvertedAccountId];
                if(acc.OC_Repair_Flag__c == 'Y')
                {
                    leadRecord.addError(Label.Lead_Convert_Merge_Error);
                }
            }
        }
    }
}