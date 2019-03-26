@isTest
public class Test_TaskUpdateTriggerController 
{
    static testMethod void testStandardUserwithTask() 
    {
        Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
        triggerOff.Name = 'TurnOffAllTriggers';
        triggerOff.Turn_Off__c = False;
        Insert triggerOff;
        
        Profile integrationProf = [select id from profile where name='Integration User'];
        User su = new User(alias = 'standt',email='standarduser@azugatask.com',emailencodingkey='UTF-8',FirstName='task',                                                   
                           lastname='testing',languagelocalekey='en_US',localesidkey='en_US',profileid = integrationProf.Id,
                           timezonesidkey='America/Los_Angeles',username='standarduser@azugatask.com');
        System.runAs(su) 
        {
            Account a = new Account(name='Testtask', OC_Repair_Flag__c = 'Y', BillingCountry = 'United States');
            insert a;
            Task t = new Task(Subject='Donni',Status='New',Priority='Normal',CallType='Outbound', WhatId = a.Id);
            test.startTest();
            insert t;
            update t;
            test.stopTest();
        }
    }
}