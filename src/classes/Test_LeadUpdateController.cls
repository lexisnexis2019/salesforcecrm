@IsTest (SeeAllData=true) 
public class Test_LeadUpdateController{    
    public static testMethod void myUnitTest() {   
        // query RecordType
        Id conLeadType;
        conLeadType = [Select id from RecordType where sObjectType = 'Lead' and developerName ='Convert_Lead' ].id;
        
        // create a Lead
        Lead lead=new Lead(LastName='Doe',FirstName='John',Country = 'United States', RecordTypeId = conLeadType, Address_Accepted__c = True, User_Validated__c = True, Company='Test',Phone='0000000000',Status='Inquiry', Select_Owner__c = UserInfo.getUserId());        
        insert lead;                
        
        Database.LeadConvert lc = new database.LeadConvert();
        lc.setLeadId(lead.id);
        lc.setDoNotCreateOpportunity(false);
        lc.setConvertedStatus('Converted');
        
        Database.LeadConvertResult lcr = Database.convertLead(lc);
        System.assert(lcr.isSuccess());
    }}