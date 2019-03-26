/*
Class Name  : Test_AddressUpdateforEventTriggerHandler
Description : This is test class for AddressUpdateforEventTriggerHandler
*/
@isTest
public class Test_AddressUpdateforEventTriggerHandler{
    /*******************************************************************************************************
    * @description This method is to cover or test the functionality of address update based on account selected for event
    * @param 
    * @return This method returns void.     
    */
    public static testmethod void addressUpdateForEvent(){   
        
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
        
        //Creating test data for Event object
        List<Event> vLstEvents=new List<Event>();
        Event vEvent = new Event();
        vEvent.WhatId = vAccount.Id;
        vEvent.OwnerId = userinfo.getuserid();
        vEvent.Subject='Call';
        vEvent.Address__c=vAddress.Id;
        vEvent.DurationInMinutes=120;
        vEvent.ActivityDateTime=Date.today();  
        vEvent.Street__c='Lane3 street34';
        vEvent.City__c='Ohio';
        vEvent.State__c='Ohio';
        vEvent.Country__c='United States';
        vEvent.Zip_Postal_Code__c='45324';
        vLstEvents.add(vEvent);
        insert vLstEvents;
        
        //Execute the class method
        AddressUpdateforEventTriggerHandler.onAfterInsertUpdateEvent(vLstEvents);
        AddressUpdateforEventTriggerHandler.onBeforeInsertEvent(vLstEvents);
    }
}