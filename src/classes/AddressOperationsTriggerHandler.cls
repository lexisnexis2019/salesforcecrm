/*
Class Name  : AddressOperationsTriggerHandler
Description : This class is used to updated primary addresses whenever address gets created or updted.   This class is bening called by 
              AddressOperations trigger.
Author      : Madhavi Valavala
*/
public with sharing class AddressOperationsTriggerHandler {
    /*******************************************************************************************************
    * @description This method called on after address insert or updated. 
    *               Process address updates or insert address on account whenever address gets inserted or updated in the Address object.
    * @param It takes list of new addresses as parameters
    * @return This method does not returns anything.  Return type is void.    
    */
    public static void onAfterInsertUpdateAddress(List<Address__c> listofnewAddresses)
    {
        if(avoidRecursive.firstRun)
        {
            Set<Id> parentAccount = new Set<Id>();
            Set<Id> currentPrimaryAddress = new Set<Id>();
            for(Address__c address : listofnewAddresses)
            {
                if(address.Account__c != null && address.Primary__c == True)
                {
                    parentAccount.add(address.Account__c);
                    currentPrimaryAddress.add(address.Id);
                }
            }
            List<Address__c> listallAddress = new List<Address__c>();
            List<Account> listAccounts = new List<Account>();
            listallAddress = [SELECT Id, Account__c, Primary__c From Address__c Where Account__c IN: parentAccount AND Primary__c = True
                              AND Id NOT IN: currentPrimaryAddress];
            listAccounts = [SELECT Id, POBPGUID__c, BillingStreet, BillingCity, BillingState, BillingStateCode, BillingPostalCode, BillingCountry From Account 
                           Where ID IN: parentAccount];
            List<Address__c> listupdate = new List<Address__c>();
            List<Account> listAccountupdate = new List<Account>();
            
            for(Address__c addr : listallAddress)
            {
                if(addr.Primary__c == True)
                    {
                        addr.Primary__c = False; 
                }
                listupdate.add(addr);
            }
            Update listupdate;
            avoidRecursive.firstRun = False;
        }
    }
    /*******************************************************************************************************
    * @description This method called on before address insert or updated. 
    *               Process address updates or insert address on account whenever address gets inserted or updated in the Address object.
    * @param It takes list of new addresses as parameters
    * @return This method does not returns anything.  Return type is void.    
    */    
    public static void onBeforeInsertUpdateAddress(List<Address__c> listofnewAddresses)
    {
            Set<Id> addrAccountIds = new Set<Id>();
            Set<Id> addrIds = new Set<Id>();
                for(Address__c addr : listofnewAddresses)
                {
                    if(addr.Account__c != null)
                    {
                        addrAccountIds.add(addr.Account__c);
                    }
                }   
                List<Account> listAccounts = new List<Account>();
                listAccounts = [SELECT Id, OCPGUID__c From Account Where Id IN: addrAccountIds];
                List<Address__c> listAddresses = new List<Address__c>();
                for(Address__c addr : listofnewAddresses)
                {
                    if(addr.Primary__c == False)
                    {
                        addrIds.add(addr.Id);
                        for(Account acc : listAccounts)
                        {
                            if(acc.Id == addr.Account__c && acc.OCPGUID__c == null)
                            {
                                addr.addError('Address linked Account does not have OCPGUID ID. Address cannot be created');
                            }
                        }
                    }                        
                }
                /*listAddresses = [SELECT Id, Primary__c From Address__c Where Id IN: addrIds AND Primary__c != False];
                if(listAddresses.size() < 0 || listAddresses.isEmpty())
                {
                    for(Address__c addr : listofnewAddresses)
                    {
                        addr.addError('Atleast One Primary Address Is Must');
                    }
                }*/        
    }    
}