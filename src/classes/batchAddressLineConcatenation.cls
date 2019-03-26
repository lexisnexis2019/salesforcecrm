/*
Class Name  : batchAddressLineConcatenation 
Description : This class is used for Concatenating the Address Line1 and Address Line2 on Address Object.
              Place the result in Street Address field in Address Object
*/
global class batchAddressLineConcatenation implements Database.Batchable<sObject> {
   List<Account> vLstAccount = new  List<Account>();
    global Database.QueryLocator start(Database.BatchableContext BC) {
      return Database.getQueryLocator([select OCPGUID__c,Id,Address_Line_1_ECM__c,Address_Line_2_ECM__c from Address__c]);             
    }
   
    global void execute(Database.BatchableContext BC, List<Address__c> scope) {
    List<Address__c> vLstAccounts = new List<Address__c>(); 
    for(Address__c a:scope){
        if(a.Address_Line_1_ECM__c==null){
           a.Address_Line_1_ECM__c='';
        }
        if(a.Address_Line_2_ECM__c==null){
           a.Address_Line_2_ECM__c='';
        }      
        a.Billing_Street__c = a.Address_Line_1_ECM__c+' '+ a.Address_Line_2_ECM__c;            
       vLstAccounts.add(a);           
     }
     update vLstAccounts;
    }                            
    global void finish(Database.BatchableContext BC) {
   
    }
}