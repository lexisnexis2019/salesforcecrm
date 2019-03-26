/*
Class Name  : batchAccountAddressLineConcatenation
Description : This class is used for Concatenating the Address Line1 and Address Line2 on Account Object.
              Place the result in Street Address field in Account Object
*/
global class batchAccountAddressLineConcatenation implements Database.Batchable<sObject> {
   List<Account> vLstAccount = new  List<Account>();
    global Database.QueryLocator start(Database.BatchableContext BC) {
      return Database.getQueryLocator([select OCPGUID__c,Id,Address_Line_1__c,Address_Line_2__c from Account]);             
    }
   
    global void execute(Database.BatchableContext BC, List<Account> scope) {
    List<Account> vLstAccounts = new List<Account>(); 
    for(Account a:scope){
        if(a.Address_Line_1__c==null){
           a.Address_Line_1__c='';
        }
        if(a.Address_Line_2__c==null){
           a.Address_Line_2__c='';
        }      
        a.BillingStreet = a.Address_Line_1__c +' '+ a.Address_Line_2__c;            
       vLstAccounts.add(a);           
     }
     update vLstAccounts;
    }                            
    global void finish(Database.BatchableContext BC) {
   
    }
}