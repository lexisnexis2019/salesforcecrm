/*
Class Name  : Test_batchAccountAddressLineConcate
Description : This is test class for batchAccountAddressLineConcatenation batch class
*/
@isTest
public class Test_batchAccountAddressLineConcate {
    public static testmethod void AccountAddressLineConcate(){        
        
        //Creating custom setting for trigger active
        Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
        triggerOff.Name = 'TurnOffAllTriggers';
        triggerOff.Turn_Off__c = False;
        Insert triggerOff;
        
        //Creating test data for Account 
        Account vAccount = new Account();
        vAccount.Name='General Motors';
        vAccount.OCPGUID__c='urn:ecm:1070980I8';
        vAccount.POBPGUID__c='urn:ecm:1043980I8';
        vAccount.Address_Line_1__c='Line1';
        vAccount.Address_Line_2__c='Line2';
        vAccount.BillingCity='Ohio';
        vAccount.BillingState='Ohio';
        vAccount.BillingCountry='United States';
        vAccount.BillingPostalCode='40324';      
        insert vAccount;   
        
        //Initialize and Execute the batch class
        Test.StartTest();
        batchAccountAddressLineConcatenation objBatch = new batchAccountAddressLineConcatenation();
        ID batchprocessid = Database.executeBatch(objBatch);
        Test.StopTest();
    }
}