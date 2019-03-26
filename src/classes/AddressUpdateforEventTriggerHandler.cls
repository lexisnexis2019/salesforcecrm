/*
Class Name  : AddressUpdateforEventTriggerHandler
Description :  This class is used to updated addresses whenever address gets selected or updated from the address lookup.   This class is bening called by 
              AddressOperations trigger.
Author      : Madhavi Valavala
*/
public class AddressUpdateforEventTriggerHandler {
    /*******************************************************************************************************
    * @description This method called on after event insert or updated. 
    *               It checks the selected address with Address object during event creation or updation and maps the appropriate address.
    * @param It takes list of new Events as parameters.
    * @return This method does not returns anything.  Return type is void.    
    */
    public static void onAfterInsertUpdateEvent(List<Event> listnewEvents)
    {       
        List<Address__c> listOfAddresses = new List<Address__c>();  
        Set<ID> addressRecIds = new Set<ID>();
        
        //  iterating newly inserted or updated bulk events and fetching selected address ids.
        for(Event eventRec : listnewEvents){
            addressRecIds.add(eventRec.Address__c);
        }
        // querying the matching address records for address id fetched.
        listOfAddresses = [Select Account__c,Billing_City__c,Billing_Country__c,Billing_State_Province__c,Billing_Street__c,Billing_Zip_Postal_Code__c FROM Address__c Where ID IN:addressRecIds];
        
        for(Event eventRecs : listnewEvents)
        {
            for(Address__c addressRecord : listOfAddresses)
            {                         
                if(addressRecord.Id == eventRecs.Address__c)
                {
                    eventRecs.Street__c= (addressRecord.Billing_Street__c != null) ? addressRecord.Billing_Street__c : '';
                    eventRecs.City__c= (addressRecord.Billing_City__c != null) ? addressRecord.Billing_City__c : '';
                    eventRecs.State__c= (addressRecord.Billing_State_Province__c != null) ? addressRecord.Billing_State_Province__c : '';
                    eventRecs.Country__c= (addressRecord.Billing_Country__c != null) ? addressRecord.Billing_Country__c : '';
                    eventRecs.Zip_Postal_Code__c= (addressRecord.Billing_Zip_Postal_Code__c != null) ? addressRecord.Billing_Zip_Postal_Code__c : '';
                    //eventRecs.Address__c=null;//added for addrress values as null - Commented by madhavi on 04 November 2017
                }
            }       
        } 
    }
    // Added for sfo type field update
    public static void onBeforeInsertEvent(List<Event> listnewEvents)
    { 
        if((String.valueOf(URL.getCurrentRequestUrl()).toLowerCase().contains('services/soap') == true) || (String.valueOf(URL.getCurrentRequestUrl()).toLowerCase().contains('clients/sidepanel') == true))
                {
                    for(Event eve : listnewEvents)
                    {
                        System.debug('eve'+eve);
                        eve.Type__c = 'Client Meeting';                  
                    }                    
                }
    }
}