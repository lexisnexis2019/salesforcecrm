/*
Class Name  : Test_AddressUpdateforTaskTriggerHandler
Description : This is test class forAddressUpdateforTaskTriggerHandler
*/
@isTest
public class Test_AddressUpdateforTaskTriggerHandler{
    /*******************************************************************************************************
    * @description This method is to cover or test the functionality of address update based on account selected
    * @param 
    * @return This method returns void.    
    */
    public static testmethod void addressUpdateForTask(){    
        
        Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
        triggerOff.Name = 'TurnOffAllTriggers';
        triggerOff.Turn_Off__c = False;
        Insert triggerOff;
        
        //Creating test data for Account object
        Account vAccount = new Account();
        vAccount.Name='General Motors';
        vAccount.OCPGUID__c='urn:ecm:1000000I8';
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
        
        //Creating test data for Task object
        List<Task> vLstTasks=new List<Task>();
        Task vTask = new Task();
        vTask.Address__c=vAddress.Id;
        vTask.WhatId = vAccount.Id;
        vTask.Subject='Call';
        vTask.Status='Completed';
        vTask.Priority='Normal';
        vTask.OwnerId = userinfo.getuserid();
        vTask.Street__c='Lane3 street34';
        vTask.City__c='Ohio';
        vTask.State__c='Ohio';
        vTask.Country__c='United States';
        vTask.Zip_Postal_Code__c='45324';
        vLstTasks.add(vTask);
        insert vLstTasks;
        
        //Execute the class method
        AddressUpdateforTaskTriggerHandler.onAfterInsertUpdateTask(vLstTasks);
    }
}