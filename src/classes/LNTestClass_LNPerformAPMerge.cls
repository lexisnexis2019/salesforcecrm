/*
Author: Raghav Kulkani
Description:
    This is Test Class for AP Merge- The Inputs are MasterAPPGUID  as Master AP and  VictimAPPGUID as Victim AP
*/	

@isTest
public class LNTestClass_LNPerformAPMerge {
static testmethod void LNPerformAPMergetest(){
    try{
        
    Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
           triggerOff.Name = 'TurnOffAllTriggers';
           triggerOff.Turn_Off__c = False;
           Insert triggerOff;
        Account MasterAccount = new Account();
       
       String MasterOCPGUID = 'urn:ecm:Acctest';
       
       MasterAccount.Name = 'MasterAccount';
       MasterAccount.Address_Line_1__c = '1801 Varsity Drive Raleigh NC 27606';
       MasterAccount.Customer_Class__c = 'Academic';
       MasterAccount.Customer_Sub_Class__c = 'Law Schools';
       MasterAccount.Secondary_Sub_Class__c = 'Law Schools';
	   MasterAccount.Address_Line_1__c = '1801 Varsity Drive';
       MasterAccount.BillingCountry = 'United States';
       MasterAccount.OCPGUID__c = MasterOCPGUID;   
          
       insert  MasterAccount;
        
        
    Contact MasterContact = new Contact();
    Contact VictimContact = new Contact();
    
    String MasterAPPGUID = 'urn:ecm:test';
    String VictimAPPGUID = 'urn:ecm:test1';
    
    MasterContact.LastName = 'Test';
    MasterContact.FirstName = 'Test';
    MasterContact.Phone = '1111111111';    
    MasterContact.AccountId = MasterAccount.Id;
    MasterContact.APPGUID__c = MasterAPPGUID;
    
    insert  MasterContact;
    
    VictimContact.LastName = 'Test';
    VictimContact.FirstName = 'Test';
    VictimContact.Phone = '1111111111';
    VictimContact.AccountId = MasterAccount.Id;
    VictimContact.APPGUID__c = VictimAPPGUID;
    
    insert  VictimContact;
    LNPerformAPMerge.PerformAPMerge(MasterAPPGUID,VictimAPPGUID);
    }
    catch(Exception e){
        
    }    
}    
}