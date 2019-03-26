/*
Class Name  : LEXNEX_AccountHandler
Description : This class taking care of updating child OCPGUIDs for unlocked Accounts.
Author      : Madhavi Valavala
*/
public class LEXNEX_AccountHandler {
    public static void unlockAccountChilds(List<Account> listOfOldAccs, List<Account> listOfNewAccs)        
    {
        Map<Id, Account> mapUnlockedAccs = new Map<Id, Account>();
        List<Contact> listOfVictimCts = new List<Contact>();
        List<Address__c> listOfVictimAddrs = new List<Address__c>();
        
        // Fetching unlocked accounts only.
        for(Account oldAcc: listOfOldAccs)
        {
            for(Account newAcc : listOfNewAccs)
            {
                if(oldAcc.OC_Repair_Flag__c == 'Y' && newAcc.OC_Repair_Flag__c == 'N')
                {
                    if(newAcc.OCPGUID__c != null && !mapUnlockedAccs.containsKey(newAcc.Id))
                    {
                        mapUnlockedAccs.put(newAcc.Id, newAcc);
                    }
                }
            }
        }
        
        // Fetching Contacts of Merged and Unlocked Accounts Where Contacts OCPGUID not matches with Account OCPGUID
        for(Contact con : [SELECT Id, Name, AccountId, OCPGUID__c From Contact Where AccountId IN: mapUnlockedAccs.KeySet()])
        {
            if(mapUnlockedAccs.containsKey(con.AccountId) && mapUnlockedAccs.get(con.AccountId).OCPGUID__c != con.OCPGUID__c)
            {
                listOfVictimCts.add(con);
            }
        }
        
        // Fetching Addresses of Merged and Unlocked Accounts Where Addresses OCPGUID not matches with Account OCPGUID
        for(Address__c addr : [SELECT Id, Name, Account__c, OCPGUID__c From Address__c Where Account__c IN: mapUnlockedAccs.KeySet()])
        {
            if(mapUnlockedAccs.containsKey(addr.Account__c) && mapUnlockedAccs.get(addr.Account__c).OCPGUID__c != addr.OCPGUID__c)
            {
                listOfVictimAddrs.add(addr);
            }
        }
        
        // Calling contact batch class to update
        if(!listOfVictimCts.isEmpty() && listOfVictimCts.size() > 0)
        {
            Database.executeBatch(new BatchUpdateContactOCPGUID(listOfVictimCts), 1);
        }

		// Calling address batch class to update        
        if(!listOfVictimAddrs.isEmpty() && listOfVictimAddrs.size() > 0)
        {
            Database.executeBatch(new BatchUpdateAddressOCPGUID(listOfVictimAddrs), 1);
        }        
    }
}