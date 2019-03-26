/*
Class Name  : BatchUpdateAddressOCPGUID
Description : This batch class taking care of updating address OCPGUIDs for unlocked Accounts.
Author      : Madhavi Valavala
*/
public class BatchUpdateAddressOCPGUID implements Database.Batchable<sObject>
{
    public List<Address__c> listAddressRecords = new List<Address__c>();
    public BatchUpdateAddressOCPGUID(List<Address__c> listAddresses)
    {
        listAddressRecords = listAddresses;
    }
    public List<SObject> start(Database.BatchableContext context)
    {
        return listAddressRecords;
    }
    public void execute(Database.BatchableContext BC,List<Address__c> lstIncorrectAddresses)
    {   
        List<Address__c> addrlis2Update = new List<Address__c>();
        for(Address__c addr : lstIncorrectAddresses)
        {
            for(Account acc : [SELECT Id, Name, OCPGUID__C From Account Where Id =: addr.Account__c])
            {
                if(acc.OCPGUID__c != addr.OCPGUID__c)
                {
                    addr.OCPGUID__c = acc.OCPGUID__c;
                }
            }
            addrlis2Update.add(addr);
        }
        
        if(!addrlis2Update.isEmpty() && addrlis2Update.size() > 0) 
        {
            Upsert addrlis2Update;
        }
    }
    
    public void finish(Database.BatchableContext BC)
    {
        
    }    
}