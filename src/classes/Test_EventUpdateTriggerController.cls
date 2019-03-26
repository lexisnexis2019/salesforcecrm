@isTest
public class Test_EventUpdateTriggerController {
    static testMethod void testStandardUserwithEvent() 
    {
        Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
        triggerOff.Name = 'TurnOffAllTriggers';
        triggerOff.Turn_Off__c = False;
        Insert triggerOff;
        
        Profile integrationProf = [select id from profile where name='Integration User'];
        User su = new User(alias = 'standt',email='standarduser@azugatask.com',emailencodingkey='UTF-8',FirstName='task',                                                   
                           lastname='testing',languagelocalekey='en_US',localesidkey='en_US',profileid = integrationProf.Id,
                           timezonesidkey='America/Los_Angeles',username='standarduser@azzugatask.com');
        System.runAs(su) 
        {
            Account a = new Account(name='Testtask', OC_Repair_Flag__c = 'Y', BillingCountry = 'United States');
            insert a;
            Event e = new Event();
            e.WhatId=a.id;
            e.StartDateTime=system.today();
            e.EndDateTime=system.today()+5;            
            test.startTest();
            insert e;
            update e;
            test.stopTest();
        }
    }
}