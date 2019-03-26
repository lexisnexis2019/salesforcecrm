/*
Author: Raghav Kulkani
Description:
    This is Test Class for POB Merge- The Inputs are MasterPOBPGUID  as Master POB and  VictimPOBPGUID as Victim POB
*/	

@isTest
public class LNTestClass_LNPerformPOBMerge {
    static testmethod void LNPerformPOBMergetest(){
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
       
        Address__c MasterAddress = new Address__c();    
        Address__c VictimAddress = new Address__c();
        String MasterPOBPGUID = 'urn:ecm:pobtest';
        String VictimPOBPGUID = 'urn:ecm:pobtest1';    
           
           MasterAddress.Billing_Street__c = '9443 Springboro Pike Miamisburg ohio 45458';
           MasterAddress.Billing_City__c    = 'Miamisburg';
           MasterAddress.Billing_Country__c = 'United States';
           MasterAddress.Account__c = MasterAccount.Id;
           MasterAddress.POBPGUID__c = MasterPOBPGUID;
            insert MasterAddress;
            
           VictimAddress.Billing_Street__c = '1801 Varsity Drive Raleigh NC 27606';
           VictimAddress.Billing_City__c    = 'Raleigh';
           VictimAddress.Billing_Country__c = 'United States';
           VictimAddress.Account__c = MasterAccount.Id;
           VictimAddress.POBPGUID__c = VictimPOBPGUID;
            insert VictimAddress;
               
        Contact MasterContact = new Contact();
        String MasterAPPGUID = 'urn:ecm:contest';    
        MasterContact.LastName = 'Test';
    	MasterContact.FirstName = 'Test';
        MasterContact.Phone = '1111111111';    
    	MasterContact.AccountId = MasterAccount.Id;
    	MasterContact.APPGUID__c = MasterAPPGUID;
        MasterContact.Address__c = VictimAddress.Id;    
    	 insert  MasterContact;       
        
        Task TK1 = new Task();
        //TK1.WhatId = MasterAccount.Id;
        TK1.Type__c = 'Call';
        TK1.Status = 'Open';
        TK1.WhatId = VictimAddress.Id;
        TK1.Subject = 'Test';    
         insert  TK1;           
         
         Event EK1 = new Event();
        //EK1.WhatId = MasterAccount.Id;
        EK1.WhatId = VictimAddress.Id;
        EK1.Subject = 'Test';
        EK1.StartDateTime = datetime.now();
        EK1.EndDateTime = datetime.now();    
         insert  EK1;              
            
			LNPerformPOBMerge.PerformPOBMerge(MasterPOBPGUID,VictimPOBPGUID);
        }//End of Try
        catch(Exception e){
            
        }
    }//End of Method
}