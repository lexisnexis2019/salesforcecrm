/*
Class Name  : AddressUpdateforTaskTriggerHandler
Description :  This class is used to updated addresses whenever address gets selected or updated from the address lookup.   This class is bening called by 
              AddressOperations trigger.
Author      : Madhavi Valavala
*/
public with sharing class AddressUpdateforTaskTriggerHandler {
    /*******************************************************************************************************
    * @description This method called on after task insert or updated. 
    *               It checks the selected address with Address object during event creation or updation and maps the appropriate address.
    * @param It takes list of new Tasks as parameters.
    * @return This method does not returns anything.  Return type is void.    
    */
    public static void onAfterInsertUpdateTask(List<Task> listnewTasks)
    {       
        List<Address__c> listOfAddresses = new List<Address__c>();  
        Set<ID> addressRecIds = new Set<ID>();
        //  iterating newly inserted or updated bulk events and fetching selected address ids.
        for(Task taskRec : listnewTasks){
            addressRecIds.add(taskRec.Address__c);
        }
        listOfAddresses = [Select Account__c,Billing_City__c,Billing_Country__c,Billing_State_Province__c,Billing_Street__c,Billing_Zip_Postal_Code__c FROM Address__c Where ID IN:addressRecIds];
        
        for(Task taskRecs : listnewTasks)
        {
            for(Address__c addressRecord : listOfAddresses)
            {                         
                if(addressRecord.Id == taskRecs.Address__c)
                {
                    taskRecs.Street__c= (addressRecord.Billing_Street__c != null) ? addressRecord.Billing_Street__c : '';
                    taskRecs.City__c= (addressRecord.Billing_City__c != null) ? addressRecord.Billing_City__c : '';
                    taskRecs.State__c= (addressRecord.Billing_State_Province__c != null) ? addressRecord.Billing_State_Province__c : '';
                    taskRecs.Country__c= (addressRecord.Billing_Country__c != null) ? addressRecord.Billing_Country__c : '';
                    taskRecs.Zip_Postal_Code__c= (addressRecord.Billing_Zip_Postal_Code__c != null) ? addressRecord.Billing_Zip_Postal_Code__c : '';
                    //taskRecs.Address__c=null;//added for addrress values as null - Commented by madhavi on 04th November 2017
                }
            }       
        } 
    }
}