/*
Class Name  : TEST_New_Address_Controller
Description : This is test class for New_Address_Controller class
*/
@isTest
public class TEST_New_Address_Controller {
     /*******************************************************************************************************
    * @description This method is to cover or test the functionality of New Address Page Controller
    * @param 
    * @return This method returns void.     
    */
    public static testMethod void testMyController()
    {
        PageReference pageRef = Page.New_Address_VF;
        Test.setCurrentPage(pageRef);
        
        Test.startTest();
        Trigger_Turn_Off__c cs = new Trigger_Turn_Off__c();
        cs.Turn_Off__c = False;
        cs.Name = 'TurnOffAllTriggers';
        Insert cs;
        
        Account accountRecord = new Account();
        accountRecord.Name = 'Test Account';
        accountRecord.OCPGUID__c  = '0103xxc032102';
        accountRecord.BillingStreet = '78200 Miles Ave';
        accountRecord.BillingCity = 'Indian Wells';
        accountRecord.BillingState = 'California';
        accountRecord.BillingPostalCode = '92210';
        accountRecord.BillingCountry = 'United States';
        accountRecord.Trillium_Validated__c = True;
        accountRecord.User_Validated__c = False;
        accountRecord.Address_Accepted__c = False;
        Insert accountRecord; 
        
        Address__c addressRecord = new Address__c();
        Address__c addressRecord2 = new Address__c();
        Address__c address1Record = new Address__c();
        addressRecord.Account__c = accountRecord.Id;
        addressRecord.Billing_Street__c = '78200 Miles Ave';
        addressRecord.Billing_City__c = 'Indian Wells';
        addressRecord.Billing_State_Province__c = 'California';
        addressRecord.Billing_Zip_Postal_Code__c = '92210';
        addressRecord.Billing_Country__c = 'United States';
        addressRecord.POBPGUID__c = 'xadfafd132432';
        addressRecord.Primary__c = True;
        addressRecord.End_Date__c = System.today();
        addressRecord.Trillium_Validated__c = True;
        addressRecord.User_Validated__c = False;
        addressRecord.Address_Accepted__c = False;
        Insert addressRecord;
        ApexPages.StandardController sc = new ApexPages.StandardController(addressRecord);
        New_Address_Controller sc1 = new New_Address_Controller(sc);
        sc1.save();
        sc1.save_new();
        sc1.Cancel();
        sc1.getStates();
        sc1.getCountries();
        addressRecord2.Account__c = accountRecord.Id;
        addressRecord2.Billing_Street__c = '78200 Miles Ave';
        addressRecord2.Billing_City__c = 'Indian Wells';
        addressRecord2.Billing_State_Province__c = 'California';
        addressRecord2.Billing_Zip_Postal_Code__c = '92210';
        addressRecord2.Billing_Country__c = 'United States';
        addressRecord2.POBPGUID__c = 'xfafd132432';
        addressRecord2.End_Date__c = System.today();
        addressRecord2.Trillium_Validated__c = True;
        addressRecord2.User_Validated__c = False;
        addressRecord2.Address_Accepted__c = False;
        addressRecord.Primary__c = False;
        Insert addressRecord2;
        
        ApexPages.StandardController sc5 = new ApexPages.StandardController(addressRecord2);
        New_Address_Controller sc0 = new New_Address_Controller(sc5);
        sc0.save();
        sc0.save_new();
        sc0.Cancel();
        sc0.getStates();
        sc0.getCountries();
        ApexPages.StandardController sc2 = new ApexPages.StandardController(address1Record);
        New_Address_Controller sc3 = new New_Address_Controller(sc2);
        sc3.save();
        sc3.save_new();
        sc3.Cancel();
        sc3.getStates();
        sc3.getCountries();
        Test.stopTest();
    }
}