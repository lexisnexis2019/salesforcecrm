/*
Class Name  : batchContactAddressLineConcatenation
Description : This class is used for Concatenating the Address Line1 and Address Line2 on Contact Object.
              Place the result in Sreet Address field in Contact Object
*/
global class batchContactAddressLineConcatenation implements Database.Batchable<sObject> {
   List<Account> vLstAccount = new  List<Account>();
    global Database.QueryLocator start(Database.BatchableContext BC) {
      return Database.getQueryLocator([select OCPGUID__c,Id,Address_Line_1__c,Address_Line_2__c from Contact]);             
    }
   
    global void execute(Database.BatchableContext BC, List<Contact> scope) {
    List<Contact> vLstContacts = new List<Contact>(); 
    for(Contact c:scope){
        if(c.Address_Line_1__c==null){
           c.Address_Line_1__c='';
        }
        if(c.Address_Line_2__c==null){
           c.Address_Line_2__c='';
        }      
        c.MailingStreet = c.Address_Line_1__c +' '+ c.Address_Line_2__c;            
       vLstContacts.add(c);           
     }
     update vLstContacts;
    }                            
    global void finish(Database.BatchableContext BC) {
   
    }
}