@isTest
public class GenericTriggerTestClass {
	public static testMethod void validateTriggers()
    {
        Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
        triggerOff.Name = 'TurnOffAllTriggers';
        triggerOff.Turn_Off__c = False;
        Insert triggerOff;
        
        // validate Account Trigger
        Account acc = new Account(Name = 'Test Trigger', BillingCity = 'Texas', BillingPostalCode = '00000', BillingState = 'Arizona', BillingCountry = 'United States');
        Insert acc;
        acc.Name = 'Tested Trigger';
        acc.OCPGUID__c = '01Z010Z';
        update acc;
        
        // validate Address Trigger
        Address__c address = new Address__c(Account__c = acc.Id, Billing_City__c = 'Texas', Billing_State_Province__c = 'Arizona', Billing_Zip_Postal_Code__c = '00000');
        Insert address;
		address.Billing_City__c = 'Las Vegas';
        Update address;
           
        // validate Contact Trigger
        Contact con = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = acc.Id, Email = 'abc.def@gmail.com');
        Insert con;
        con.FirstName = 'Tested';
        Update con;
        
        // validate Task Trigger
        Task t = new Task();
        t.OwnerId = UserInfo.getUserId();
        t.Subject='Donni';
        t.Status='Not Started';
        t.Priority='Normal';
        Insert t;  
        t.State__c = 'Completed';
        Update t;
        
        // validate Event Trigger        
        Event events = new Event(Subject='test',WhatId=acc.Id, DurationInMinutes = 20, ActivityDateTime = System.now()+15);
        Insert events;     
        events.Subject = 'tested';
        Update events;
        
        // validate Lead Triggers
        List<Lead> listLeads = new List<Lead>();
        Lead lead = new Lead(FirstName = 'Test Lead1', LastName = 'Test Lead', Company = 'Infosys', Phone = '0000000000');
        listLeads.add(lead);
        Insert listLeads;
        listLeads[0].FirstName = 'Test Lead';
        Update listLeads;
        Delete listLeads;
    }
}