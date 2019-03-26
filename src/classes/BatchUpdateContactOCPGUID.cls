/*
Class Name  : BatchUpdateContactOCPGUID
Description : This batch class taking care of updating contact OCPGUIDs for unlocked Accounts.
Author      : Madhavi Valavala
*/
public class BatchUpdateContactOCPGUID implements Database.Batchable<sObject>
{
    public List<Contact> listContactRecords = new List<Contact>();
    public BatchUpdateContactOCPGUID(List<Contact> listContacts)
    {
        listContactRecords = listContacts;
    }
    public List<SObject> start(Database.BatchableContext context)
    {
        return listContactRecords;
    }
    public void execute(Database.BatchableContext BC,List<Contact> lstIncorrectContacts)
    {   
        List<Contact> conlis2Update = new List<Contact>();
        for(Contact con : lstIncorrectContacts)
        {
            for(Account acc : [SELECT Id, Name, OCPGUID__C From Account Where Id =: con.AccountId])
            {
                if(acc.OCPGUID__c != con.OCPGUID__c)
                {
                    con.OCPGUID__c = acc.OCPGUID__c;
                }
            }
            conlis2Update.add(con);
        }
        
        if(!conlis2Update.isEmpty() && conlis2Update.size() > 0) 
        {
            Upsert conlis2Update;
        }
    }
    
    public void finish(Database.BatchableContext BC)
    {
        
    }    
}