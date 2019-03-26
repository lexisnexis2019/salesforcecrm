@istest
public class LeadConvertedEmailNotificationTest {
    
    static testmethod void  testemail(){
        
 
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
        leadrecord.email = 'test@test.com';
        leadrecord.Select_Owner__c = userrecdup.id;
        Insert leadRecord; 
        
		list<lead> lstl = new list<lead>();
        lstl.add(leadrecord);
        
        leadconvertedemailnotification.LeadConvertEmail(lstl);
        
    }
}