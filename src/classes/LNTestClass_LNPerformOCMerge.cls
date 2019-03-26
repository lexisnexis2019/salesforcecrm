@isTest
public class LNTestClass_LNPerformOCMerge {

   static testmethod void LNPerformOCMergetest(){
       try{
           // Madhavi Valavala
           Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
           triggerOff.Name = 'TurnOffAllTriggers';
           triggerOff.Turn_Off__c = False;
           Insert triggerOff;//*/
       
       Account MasterAccount = new Account();
       Account VictimAccount = new Account();
       
              
       String MasterOCPGUID = 'urn:ecm:test';
       String VictimOCPGUID = 'urn:ecm:test1';
       MasterAccount.Name = 'MasterAccount';
       MasterAccount.Address_Line_1__c = '1801 Varsity Drive Raleigh NC 27606';
       MasterAccount.Customer_Class__c = 'Academic';
       MasterAccount.Customer_Sub_Class__c = 'Law Schools';
       MasterAccount.Secondary_Sub_Class__c = 'Law Schools';
       MasterAccount.Address_Line_1__c = '1801 Varsity Drive';
       MasterAccount.BillingCountry = 'United States';
       MasterAccount.OCPGUID__c = MasterOCPGUID;   
          
       insert  MasterAccount;
           
       VictimAccount.Name = 'VictimAccount';
       VictimAccount.Address_Line_1__c = '1801 Varsity Drive Raleigh NC 27606';
       VictimAccount.Customer_Class__c = 'Academic';
       VictimAccount.Customer_Sub_Class__c = 'Law Schools';
       VictimAccount.Secondary_Sub_Class__c = 'Law Schools';
       VictimAccount.Address_Line_1__c = '1801 Varsity Drive';
       VictimAccount.BillingCountry = 'United States';
       VictimAccount.OCPGUID__c = VictimOCPGUID;
       insert  VictimAccount;    
         
        
       //String MasterOCPGUID = 'urn:ecm:D1424TJXVM9';
       //String VictimOCPGUID = 'urn:ecm:100004KCN';    
       List<String> ListVictimOCPGUID = new List<String>();
       ListVictimOCPGUID.add(VictimOCPGUID);       
       
       LNPerformOCMerge.PerformOCMerge(MasterOCPGUID,ListVictimOCPGUID);
       }
       catch(Exception e){
           
       }
   }// end of method
}