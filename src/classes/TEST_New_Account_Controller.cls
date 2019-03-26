/*
Class Name  : TEST_New_Account_Controller
Description : This is test class for New_Account_Controller
*/
@isTest
public class TEST_New_Account_Controller {
    /*******************************************************************************************************
    * @description This method is to cover or test the functionality of New Account Page Controller
    * @param 
    * @return This method returns void.    
    */
    public static testMethod void testMyController()
    {
        PageReference pageRef = Page.New_Account_VF;
        Test.setCurrentPage(pageRef);
        
        Test.startTest();
        Trigger_Turn_Off__c cs = new Trigger_Turn_Off__c();
        cs.Turn_Off__c = False;
        cs.Name = 'TurnOffAllTriggers';
        Insert cs;
        
        String selectedname = 'selected';
        Account accountRecord = new Account();
        accountRecord.Name = 'Test Account';
        accountRecord.OCPGUID__c  = '0103xx032102';
        accountRecord.BillingStreet = '78200 Miles Ave';        
        accountRecord.BillingCity = 'Indian Wells';
        accountRecord.BillingState = 'California';
        accountRecord.BillingPostalCode = '92210';
        accountRecord.BillingCountry = 'United States';
        accountRecord.Trillium_Validated__c = True;
        accountRecord.User_Validated__c = False;
        accountRecord.Address_Accepted__c = False;
        Insert accountRecord; 
        ApexPages.StandardController sc = new ApexPages.StandardController(accountRecord);
        New_Account_Controller sc1 = new New_Account_Controller(sc);
        PageReference pageRefer = sc1.save();        
        sc1.save_new();
        sc1.Cancel();
        Account accountRecord2 = new Account();
        accountRecord2.Name = 'Test Accountg';
        accountRecord2.OCPGUID__c  = '0103xc032102';
        accountRecord2.BillingStreet = '7820 Miles Ave';        
        accountRecord2.BillingCity = 'Indian Wells';
        accountRecord2.BillingState = 'California';
        accountRecord2.BillingPostalCode = '92210';
        accountRecord2.BillingCountry = 'United States';
        accountRecord2.Trillium_Validated__c = True;
        accountRecord2.User_Validated__c = False;        
        accountRecord2.Account_Status__c = 'TargetedProspect';
        accountRecord2.Address_Accepted__c = False;
        Insert accountRecord2; 
        Account accountRecord1 = new Account(Name = 'Test', BillingPostalCode = '92210');
        ApexPages.StandardController sc2 = new ApexPages.StandardController(accountRecord2);
        New_Account_Controller sc3 = new New_Account_Controller(sc2);
        PageReference pageRef5 = sc3.save();
        sc3.save_new();
        sc3.Cancel();
        ApexPages.StandardController scz = new ApexPages.StandardController(accountRecord1);
        New_Account_Controller scg = new New_Account_Controller(scz);  
        scg.save();
        scg.save_new();
        scg.Cancel();
        Test.stopTest();
    }
}