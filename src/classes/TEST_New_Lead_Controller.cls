@isTest
public class TEST_New_Lead_Controller {
    public static testMethod void testMyController()
    {
        PageReference pageRef = Page.New_Lead_VF;
        Test.setCurrentPage(pageRef);
        
        Test.startTest();
        Trigger_Turn_Off__c cs = new Trigger_Turn_Off__c();
        cs.Turn_Off__c = False;
        cs.Name = 'TurnOffAllTriggers';
        Insert cs;

        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User userRecdup = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduserd@testorg.com');
        Insert userRecdup;
        Lead leadRecord = new Lead();
        Lead leadRecord1 = new Lead();
        leadRecord.FirstName = 'Test';
        leadRecord.LastName = 'Lead';
        leadRecord.Street = '78200 Miles Ave';
        leadRecord.City = 'Indian Wells';
        leadRecord.State = 'California';
        leadRecord.PostalCode = '92210';
        leadRecord.Country = 'United States';
        leadRecord.Trillium_Validated__c = True;
        leadRecord.User_Validated__c = False;
        leadRecord.Address_Accepted__c = False;
        leadRecord.Company = 'Testing';
        leadRecord.OwnerId = userRecdup.Id;
        Insert leadRecord; 
        
        ApexPages.StandardController sc = new ApexPages.StandardController(leadRecord);
        New_Lead_Controller sc1 = new New_Lead_Controller(sc);
        sc1.save();
        sc1.save_new();
        sc1.Cancel();
        sc1.getRejectedReasonOptions();
        ApexPages.StandardController sc2 = new ApexPages.StandardController(leadRecord1);
        New_Lead_Controller sc3 = new New_Lead_Controller(sc2);
        sc3.save();
        sc3.save_new();
        sc3.Cancel();
        sc1.getRejectedReasonOptions();
        Test.stopTest();
    }
}