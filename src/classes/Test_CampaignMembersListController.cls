@isTest
public class Test_CampaignMembersListController {
    public static testMethod void testMethod1() 
    {   
        // Changes by Madhavi.
        Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
        triggerOff.Name = 'TurnOffAllTriggers';
        triggerOff.Turn_Off__c = False;
        Insert triggerOff;       
        
        Test.StartTest();
        Account testAccount = new Account();
        testAccount.Name='Test Account cm' ;
        testAccount.BillingCountry = 'United States';
        insert testAccount;
        
       	Contact cont = new Contact();
        cont.FirstName ='Test';
        cont.LastName ='Testcm';
        cont.Accountid = testAccount.id;
        cont.Phone = '0100100100100';
        insert cont;
        
        List<contact> lstc = [Select id, Name, AccountId,Phone from contact where id=:cont.id];
        
        Campaign camp = new Campaign();
        camp.Name= 'Test Campaign cm';
        camp.status = 'In Progress';              
        insert camp;
        
        Lead l=new Lead(LastName='Doe',FirstName='John',Country = 'United States', Address_Accepted__c = True, User_Validated__c = True, Company='Test',Phone='0000000000',Status='Inquiry', Select_Owner__c = UserInfo.getUserId());        
        insert l;  
         
        List<Lead> lstl = [Select id, Name,Phone from Lead where id=:l.id];
        
        CampaignMember cm = new CampaignMember();
        cm.LeadId = l.id;
        cm.status = 'Sent';
        cm.campaignid = camp.id;
        insert cm;
        
        Contact c1 = [Select id, Campaign__c from contact where id=:cont.id];
        c1.Campaign__c = camp.id;
        update c1;
        
        CampaignMember cm1 = [SELECT Id,CampaignID,contactId,LeadId,Status,Treatment__c,LeadOrContactOwnerid,Contact.Name,lead.Name FROM CampaignMember];

        CampaignMembersListController acc = new CampaignMembersListController();
        acc.conlst = lstc;
        acc.getCampaignMembers();
        acc.leadlst =lstl;
        acc.selcon();
        acc.sellead();
        acc.contactId = c1.Id;
        acc.Beginning();
		acc.Previous();
		acc.Next();
        acc.End();
        acc.getDisableNext();
        acc.getDisablePrevious();
        acc.getPageNumber();
        acc.getPageNumber();
        acc.getTotal_size();
        acc.getTotalPages();
        
        PageReference pageRef = Page.CampaignMember_VFPage; 
        pageRef.getParameters().put('campaignid', String.valueOf(camp.id));
        Test.setCurrentPage(pageRef);
        Test.StopTest();       
	}
}