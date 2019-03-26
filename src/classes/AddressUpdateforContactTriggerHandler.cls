/*
Class Name  : AddressUpdateforContactTriggerHandler
Description : This class is used to updated addresses whenever address gets selected or updated from the address lookup.   This class is bening called by 
              AddressUpdateforContact trigger.
Author      : Madhavi Valavala
*/
public with sharing class AddressUpdateforContactTriggerHandler {
    /*******************************************************************************************************
    * @description This method called on after contact insert or updated. 
    *               Processes on updates or insert address on contact whenever contact inserted or updated object.
    * @param It takes list of new addresses as parameters
    * @return This method does not returns anything.  Return type is void.    
    */
    public static void onBeforeInsertUpdateContact(List<Contact> listnewContacts)
    {
        // avoidRecursive is used to prevent the recursive calling happens.
        if(avoidRecursive.firstRun)
        {
            List<Address__c> listOfAddresses = new List<Address__c>();  
            List<Account> listOfAccounts = new List<Account>();  
            Set<ID> addressRecIds = new Set<ID>();
            Set<ID> accountRecIds = new Set<ID>();
            for(Contact conRec : listnewContacts){
                if(conRec.Address__c != null)
                {
                    addressRecIds.add(conRec.Address__c);    
                }else{
                    accountRecIds.add(conRec.AccountId);   
                }
            }
            
            if(addressRecIds != null)
            {
                listOfAddresses = [Select Account__c,Billing_City__c,Billing_Country__c,Billing_State_Province__c,Billing_Street__c,Billing_Zip_Postal_Code__c,POBPGUID__c, County__c FROM Address__c Where ID IN:addressRecIds];    
            }
            if(accountRecIds != null)
            {
                listOfAccounts = [Select Id, Name, OCPGUID__c, County__c, POBPGUID__c From Account Where Id IN: accountRecIds];    
            }
            
            for(Contact contRec : listnewContacts)
            {
                if(listOfAddresses != null && contRec.Address__c != null)
                {
                    for(Address__c addressRecord : listOfAddresses)
                    {                         
                        if(addressRecord.Id == contRec.Address__c)
                        {
                            contRec.MailingStreet= (addressRecord.Billing_Street__c != null) ? addressRecord.Billing_Street__c : '';
                            contRec.MailingCity= (addressRecord.Billing_City__c != null) ? addressRecord.Billing_City__c : '';
                            contRec.MailingCountry = (addressRecord.Billing_Country__c != null) ? addressRecord.Billing_Country__c : '';
                            contRec.MailingState = (addressRecord.Billing_State_Province__c != null) ? addressRecord.Billing_State_Province__c : '';
                            contRec.MailingPostalCode= (addressRecord.Billing_Zip_Postal_Code__c != null) ? addressRecord.Billing_Zip_Postal_Code__c : '';
                            contRec.POBPGUID__c= (addressRecord.POBPGUID__c != null) ? addressRecord.POBPGUID__c : '';   
                            contRec.County__c = (addressRecord.County__c != null) ? addressRecord.County__c : '';
                            //contRec.Address__c=null;//added on 04/09 for making the address lookup value as null; - commented by Madhavi on 04th November
                        }
                    }    
                }else if(listOfAccounts != null && contRec.Address__c == null)
                {
                    for(Account accRec : listOfAccounts)
                    {
                        if(contRec.AccountId == accRec.Id)
                        {
                            contRec.POBPGUID__c = (accRec.POBPGUID__c != null) ? accRec.POBPGUID__c : '';  
                            contRec.County__c = (accRec.County__c != null) ? accRec.County__c : '' ;
                        }
                    }
                }
            } 
                  
        }
        avoidRecursive.firstRun = false; 
    }
  }