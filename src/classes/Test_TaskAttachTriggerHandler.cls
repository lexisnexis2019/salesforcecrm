@isTest
public class Test_TaskAttachTriggerHandler {
public static testmethod void TaskAttachTriggerHandler(){    
        
        Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
        triggerOff.Name = 'TurnOffAllTriggers';
        triggerOff.Turn_Off__c = False;
        Insert triggerOff;
        
        //Creating test data for Account object
        Account a1 = new Account();
        a1.Name='General Motors1';
        a1.OCPGUID__c='urn:ecm:1000000I9';
        a1.Address_Line_1__c='Line2';
        a1.Address_Line_2__c='Line3';
        a1.BillingCity='Ohio';
        a1.BillingState='Ohio';
        a1.BillingCountry='United States';
        a1.BillingPostalCode='45324';      
        insert a1;
            
        //Creating test data for Task object
        List<Task> allTask=new List<Task>();
        Task t1 = new Task();
        t1.WhatId = a1.Id;
        t1.Subject='Call';
        t1.Status='Completed';
        t1.Priority='Normal';
        t1.Description='Test';
        t1.OwnerId = userinfo.getuserid();
        t1.Street__c='Lane3 street34';
        t1.City__c='Ohio';
        t1.State__c='Ohio';
        t1.Country__c='United States';
        t1.Zip_Postal_Code__c='45324';
        t1.Attachment__c = false;
        allTask.add(t1);
    
     Task t2 = new Task();
        t2.WhatId = a1.Id;
        t2.Subject='Call';
        t2.Status='Completed';
        t2.Priority='Normal';
        t2.Description='Test';
        t2.OwnerId = userinfo.getuserid();
        t2.Street__c='Lane3 street34';
        t2.City__c='Ohio';
        t2.State__c='Ohio';
        t2.Country__c='United States';
        t2.Zip_Postal_Code__c='45324';
        t2.Attachment__c = false;
        allTask.add(t2);
    
        insert allTask;
    
    
        Attachment attach=new Attachment(); 
        attach.Name='Unit Test Attachment'; 
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body'); 
        attach.body=bodyBlob; 
        attach.parentId=t1.Id; 
        insert attach;        

    
    List<Task> upTask = new List<Task>();
    for(Task ta:allTask)
    {
        ta.Description = 'Test1';
        ta.Attachment__c = True;
          upTask.add(ta);
    }
         Test.startTest();
        update upTask;
         Test.stopTest();
    }
}