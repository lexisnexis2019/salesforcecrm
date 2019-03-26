/*
Class Name  : Test_batchAddressLineConcatenation
Description : This is test class for batchAddressLineConcatenation batch class
*/
@isTest
public class Test_batchAddressLineConcatenation {
    public static testmethod void AddressLineConcatenation(){        
        
        
        //Creating custom setting for trigger active
        Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
        triggerOff.Name = 'TurnOffAllTriggers';
        triggerOff.Turn_Off__c = False;
        Insert triggerOff;
        
        //Creating test data for Account object
        Account vAccount = new Account();
        vAccount.Name='General Motors';
        vAccount.OCPGUID__c='urn:ecm:1310980I8';
        vAccount.POBPGUID__c='urn:ecm:1093980I8';
        vAccount.Address_Line_1__c='Line1';
        vAccount.Address_Line_2__c='Line2';
        vAccount.BillingCity='Ohio';
        vAccount.BillingState='Ohio';
        vAccount.BillingCountry='United States';
        vAccount.BillingPostalCode='45324';      
        insert vAccount;
        
        //Creating test data for Address object
        Address__c vAddress = new Address__c();
        vAddress.Account__c=vAccount.Id;
        vAddress.Address_Line_1_ECM__c='Lane3';  
        vAddress.Address_Line_2_ECM__c='street34';
        vAddress.Billing_City__c='Ohio';
        vAddress.Billing_Country__c='United States';
        vAddress.Billing_State_Province__c='Ohio';
        vAddress.Billing_Zip_Postal_Code__c='45324';
        insert vAddress;
        
        Trigger_Turn_Off__c cs = new Trigger_Turn_Off__c();
        cs.Turn_Off__c = False;
        cs.Name = 'TurnOffAllTriggers';
        Insert cs;
        
        //Initialize and Execute the batch class
        Test.StartTest();
        batchAddressLineConcatenation objAddressLine = new batchAddressLineConcatenation();
        ID batchprocessid = Database.executeBatch(objAddressLine);
        Test.StopTest();
    }
}