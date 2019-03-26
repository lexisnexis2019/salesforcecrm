/*
Class Name  : Test_AddrCreationAccountTriggerHandler
Description : This is test class for AddressCreationforAccountTriggerHandler batch class
*/
@isTest
public class Test_AddrCreationAccountTriggerHandler{
    /*******************************************************************************************************
    * @description This method is to cover or test the functionality of address creation for account after insert.
    * @param 
    * @return This method returns sobject record.    
    */
    public static testmethod void addressCreationForAccountafterInsert(){   
        Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
        triggerOff.Name = 'TurnOffAllTriggers';
        triggerOff.Turn_Off__c = False;
        Insert triggerOff;
        
        Account vAccount = new Account();
        vAccount.Name='General Motors';
        vAccount.OCPGUID__c='urn:ecm:1010980I8';
        vAccount.POBPGUID__c='urn:ecm:1003980I8';
        vAccount.Address_Line_1__c='Line00';
        vAccount.Address_Line_2__c='Line01';
        vAccount.BillingCity='Ohio';
        vAccount.BillingState='Ohio';
        vAccount.BillingCountry='United States';
        vAccount.BillingPostalCode='45824';
        insert vAccount;
        
        Address__c vAddress = new Address__c();
        vAddress.Account__c=vAccount.Id;
        vAddress.Address_Line_1_ECM__c='Lane3';  
        vAddress.Address_Line_2_ECM__c='street34';
        vAddress.Billing_City__c='Ohio';
        vAddress.Billing_Country__c='United States';
        vAddress.Billing_State_Province__c='Ohio';
        vAddress.Billing_Zip_Postal_Code__c='45324';
        vAddress.Primary__c=true;
        insert vAddress;
        
        //Creating test data for Account object
        List<Account> vLstOldAccounts = new List<Account>();
        Account vAccountOld = new Account();
        vAccountOld.Name='General Motors Step1';
        vAccountOld.Primary_Address__c=vAddress.Id;
        vAccountOld.OCPGUID__c='urn:ecm:1000980I8';
        vAccountOld.POBPGUID__c='urn:ecm:1100980I8';
        vAccountOld.Address_Line_1__c='Line1';
        vAccountOld.Address_Line_2__c='Line2';
        vAccountOld.BillingCity='Ohio';
        vAccountOld.BillingState='Ohio';
        vAccountOld.BillingCountry='United States';
        vAccountOld.BillingPostalCode='45624'; 
        vLstOldAccounts.add(vAccountOld);     
        insert vLstOldAccounts;
         
        List<Account> vLstNewAccounts = new List<Account>();
        Account vAccountNew = new Account();
        vAccountNew.Name='General Motors Step2';
        vAccountNew.Primary_Address__c=vAddress.Id;
        vAccountNew.OCPGUID__c='urn:ecm:1000032I8';
        vAccountNew.POBPGUID__c='urn:ecm:1200980I8';
        vAccountNew.Address_Line_1__c='Line3';
        vAccountNew.Address_Line_2__c='Line4';
        vAccountNew.BillingCity='Ohio';
        vAccountNew.BillingState='Ohio';
        vAccountNew.BillingCountry='United States';
        vAccountNew.BillingPostalCode='45324'; 
        vLstNewAccounts.add(vAccountNew);     
        insert vLstNewAccounts;
        
        //invoke class methods
        AddressCreationforAccountTriggerHandler.onAfterInsertAccount(vLstNewAccounts,vLstOldAccounts,'true');
    }
    /*******************************************************************************************************
    * @description This method is doing functionality of address creation for account before update.
    * @param 
    * @return This method returns sobject record.    
    */
    public static testmethod void addressCreationForAccountBeforeUpdate1(){  
        Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
        triggerOff.Name = 'TurnOffAllTriggers';
        triggerOff.Turn_Off__c = False;
        Insert triggerOff;
        Account vAccount = new Account();
        vAccount.Name='General Motors12';
        vAccount.OCPGUID__c='urn:ecm:1010280I8adsf';
        vAccount.POBPGUID__c='urn:ecm:1003580I8asfd';
        vAccount.Address_Line_1__c='Line00';
        vAccount.Address_Line_2__c='Line01';
        vAccount.BillingCity='Ohio';
        vAccount.BillingState='Ohio';
        vAccount.BillingCountry='United States';
        vAccount.BillingPostalCode='45824';
        insert vAccount;
        
        Address__c vAddress = new Address__c();
        vAddress.Account__c=vAccount.Id;
        vAddress.Address_Line_1_ECM__c='Lane3';  
        vAddress.Address_Line_2_ECM__c='street34';
        vAddress.Billing_City__c='Ohio';
        vAddress.Billing_Country__c='United States';
        vAddress.Billing_State_Province__c='Ohio';
        vAddress.Billing_Zip_Postal_Code__c='45324';
        vAddress.Primary__c=true;
        insert vAddress;
        
        //Creating test data for Account object
        List<Account> vLstOldAccounts = new List<Account>();
        Account vAccountOld = new Account();
        vAccountOld.Name='General Motors1 Step1';
        vAccountOld.Primary_Address__c=vAddress.Id;
        vAccountOld.OCPGUID__c='urn:ecm:1000910I8';
        vAccountOld.POBPGUID__c='urn:ecm:1100880I8';
        vAccountOld.Phone='9837625413';
        vAccountOld.Address_Line_1__c='Line1';
        vAccountOld.Address_Line_2__c='Line2';
        vAccountOld.BillingCity='Ohio';
        vAccountOld.BillingState='Ohio';
        vAccountOld.BillingCountry='United States';
        vAccountOld.BillingPostalCode='45624'; 
        insert vAccountOld;
        vAccountOld.POBPGUID__c='urn:ecm:1200880I8';
        vLstOldAccounts.add(vAccountOld);
        update vLstOldAccounts;
        
        //invoke class methods
        AddressCreationforAccountTriggerHandler.onBeforeUpdateAccount(vLstOldAccounts,vLstOldAccounts,'true');
        Test_AddrCreationAccountTriggerHandler.addressCreationForAccountafterInsert();
        Test_AddrCreationAccountTriggerHandler.addressCreationForAccountBeforeUpdate2();
    }
    /*******************************************************************************************************
    * @description This method is doing functionality of address creation before update.
    * @param 
    * @return This method returns sobject record.    
    */
    public static testmethod void addressCreationForAccountBeforeUpdate2(){      
        Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
        triggerOff.Name = 'TurnOffAllTriggers';
        triggerOff.Turn_Off__c = False;
        Insert triggerOff;
        
        
        Account vAccount1 = new Account();
        vAccount1.Name='General Motors1';
        vAccount1.OCPGUID__c='urn:ecm:1010280IG';
        vAccount1.POBPGUID__c='urn:ecm:1003580I';
        vAccount1.Address_Line_1__c='Line00';
        vAccount1.Address_Line_2__c='Line01';
        vAccount1.BillingCity='Ohio';
        vAccount1.BillingState='Ohio';
        vAccount1.BillingCountry='United States';
        vAccount1.BillingPostalCode='45824';
        insert vAccount1;
        
        Address__c vAddress = new Address__c();
        vAddress.Account__c=vAccount1.Id;
        vAddress.Address_Line_1_ECM__c='Lane3';  
        vAddress.Address_Line_2_ECM__c='street34';
        vAddress.Billing_City__c='Ohio';
        vAddress.Billing_Country__c='United States';
        vAddress.Billing_State_Province__c='Ohio';
        vAddress.Billing_Zip_Postal_Code__c='45324';
        vAddress.Primary__c=true;
        insert vAddress;
        
        
        //Creating test data for Account object
        List<Account> vLstOldAccounts1 = new List<Account>();
        Account vAccountOld = new Account();
        vAccountOld.Name='General Motors1 Step1';
        vAccountOld.Primary_Address__c=vAddress.Id;
        vAccountOld.OCPGUID__c='urn:ecm:1000910I815';
        vAccountOld.POBPGUID__c='urn:ecm:1100880I815';
        vAccountOld.Phone='9837625413';
        vAccountOld.Address_Line_1__c='Line1';
        vAccountOld.Address_Line_2__c='Line2';
        vAccountOld.BillingCity='Ohio';
        vAccountOld.BillingState='Ohio';
        vAccountOld.BillingCountry='United States';
        vAccountOld.BillingPostalCode='45624'; 
        vAccountOld.OC_Repair_Flag__c = 'Y';
        insert vAccountOld;
        vAccountOld.POBPGUID__c='urn:ecm:1100880I815';
        vAccountOld.Phone='9839825413';
        vLstOldAccounts1.add(vAccountOld);
        update vLstOldAccounts1;
        
        Contact vContact = new Contact();
        vContact.FirstName='Lexis';
        vContact.LastName='Nexis';
        vContact.AccountId=vAccountOld.Id;
        vContact.Address_Line_1__c='Lane3';  
        vContact.Address_Line_2__c='street34';
        vContact.MailingCity ='Ohio';
        vContact.MailingCountry='United States';
        vContact.MailingState='Ohio';
        vContact.MailingPostalCode='45324';
        vContact.Phone = '0000000000';
        insert vContact;
        
        opportunity oppr = new opportunity(Name='testing DIE 4/6/2015' ,  AccountId= vAccountOld.Id,StageName = 'Prospecting', 
                                           CloseDate = Date.Today());
        insert oppr;
        
        /*Task tsk = new Task(WhatId = vAccountOld.Id, Subject = 'Test Subject', Status = 'In Progress');
        insert tsk;
        
        Event eventRecord = new Event(WhatId = vAccountOld.Id);
        insert eventRecord;*/
        
        update vLstOldAccounts1;
        //invoke class methods
        AddressCreationforAccountTriggerHandler.onBeforeUpdateAccount(vLstOldAccounts1,vLstOldAccounts1,'true');
    }
}