/*
Class Name  : Test_batchContactAddressLineConcate
Description : This is test class for batchContactAddressLineConcatenation batch class
*/
@isTest
public class Test_batchContactAddressLineConcate{
    public static testmethod void ContactAddressLineConcate(){        
       
        //Creating custom setting for trigger active
        Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
        triggerOff.Name = 'TurnOffAllTriggers';
        triggerOff.Turn_Off__c = False;
        Insert triggerOff;
        
        //Creating test data for Account object
        Account vAccount = new Account();
        vAccount.Name='General Motors';
        vAccount.OCPGUID__c='urn:ecm:1010970I8';
        vAccount.POBPGUID__c='urn:ecm:1003hg80I8';
        vAccount.Address_Line_1__c='Line1';
        vAccount.Address_Line_2__c='Line2';
        vAccount.BillingCity='Ohio';
        vAccount.BillingState='Ohio';
        vAccount.BillingCountry='United States';
        vAccount.BillingPostalCode='45324';      
        insert vAccount;
        
        //Creating test data for Contact object
        Contact vContact = new Contact();
        vContact.FirstName='Lexis';
        vContact.LastName='Nexis';
        vContact.AccountId=vAccount.Id;
        vContact.Address_Line_1__c='Lane3';  
        vContact.Address_Line_2__c='street34';
        vContact.MailingCity ='Ohio';
        vContact.MailingCountry='United States';
        vContact.MailingState='Ohio';
        vContact.MailingPostalCode='45324';
        vContact.Phone = '0000000000';
        insert vContact;
        
        //Initialize and Execute the batch class
        Test.StartTest();
        batchContactAddressLineConcatenation objConAddressLine = new batchContactAddressLineConcatenation();
        ID batchprocessid = Database.executeBatch(objConAddressLine);
        Test.StopTest();
    }
}