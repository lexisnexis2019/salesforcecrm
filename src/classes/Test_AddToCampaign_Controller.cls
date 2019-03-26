@isTest
public class Test_AddToCampaign_Controller {
    public static testMethod void testMethod1() 
    {           
        Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
        triggerOff.Name = 'TurnOffAllTriggers';
        triggerOff.Turn_Off__c = False;
        Insert triggerOff;
        
        Account testAccount = new Account();
        testAccount.Name='Test Account' ;
        testAccount.BillingCountry = 'United States';
        insert testAccount;
        
        Contact cont = new Contact();
        cont.FirstName ='Test';
        cont.LastName ='Test';
        cont.Accountid = testAccount.id;
        cont.Phone = '0100100100100';
        insert cont;
        
        Campaign camp = new Campaign();
        camp.Name= 'Test Campaign';
        Insert camp;
       
        Test.StartTest();         
        ApexPages.StandardController sc = new ApexPages.StandardController(camp);
        AddToCampaign_Controller acc = new AddToCampaign_Controller(sc);
        acc.callLookup();
        acc.goAddCampaign();
        acc.campaignName = 'Test Campaign';
        acc.callLookup();
        Test.StopTest();
    }
}