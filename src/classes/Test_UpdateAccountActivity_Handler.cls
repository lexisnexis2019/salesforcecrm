/*
Class Name  : Test_UpdateAccountActivity_Handler
Description : This class is test class for "UpdateAccountActivity_Handler" 
Author      : Madhavi Valavala
*/
@isTest
public class Test_UpdateAccountActivity_Handler {
    public static testMethod void test_afterInsUpdDel_TaskOrEventCount()
    {
        Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
        triggerOff.Name = 'TurnOffAllTriggers';
        triggerOff.Turn_Off__c = False;
        Insert triggerOff;
        
        Account acc = new Account(Name = 'Test Trigger', BillingCity = 'Texas', BillingPostalCode = '00000', BillingState = 'Arizona', BillingCountry = 'United States');
        Insert acc;
        acc.Name = 'Tested Trigger';
        acc.OCPGUID__c = '01Z010Z';
        update acc;
        
        // validate Task 
        Map<Id, Task> mapOfTasks = new Map<Id, Task>();
        Task t = new Task();
        t.OwnerId = UserInfo.getUserId();
        t.Subject='Donni';
        t.WhatId = acc.Id;
        t.Status='Not Started';
        t.Priority='Normal';
        Insert t;
        mapOfTasks.put(t.Id, t);
        UpdateAccountActivity_Handler.afterInsUpdDel_TaskCount(mapOfTasks);
        
        // validate Event     
        Map<Id, Event> mapOfEvents = new Map<Id, Event>();
        Event events = new Event(Subject='test',WhatId=acc.Id, DurationInMinutes = 20, ActivityDateTime = System.now()+15);
        Insert events;
        mapOfEvents.put(events.Id, events);
        UpdateAccountActivity_Handler.afterInsUpdDel_EventCount(mapOfEvents); 
    }
}