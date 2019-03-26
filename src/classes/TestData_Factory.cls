/************************************************************************************
Class Name    :    TestData_Factory

Description   :    Utility Class for Test Record Creation

Version          Developed By           Description          Last Modified Date
------------------------------------------------------------------------------------
Version1.0       Madhavi		      Initial Version      03/21/2018
**************************************************************************************/
@isTest
public class TestData_Factory {    
    //Method to create and get test user records
    public static List<User> createUsers(String profileName,Integer noOfUser)
    {
        List<User> usersList = new List<User>(); 
        String Country = 'en_US'; 
        ID admProfileID = [select id,name from Profile where Name =: profileName].ID;        
        for(integer i=0;i<noOfUser;i++)
        {
            User userObj = new User(ProfileId = admProfileID, LastName = 'Test'+i,FirstName='Test User'+i, Alias = 'test2', Email = 'Test_User'+i+'@example.com', Username = 'Test_MonInTouch_user'+profileName.left(3)+i+'@example.com', 
                                    TimeZoneSidKey = 'GMT', LanguageLocaleKey = Country, EmailEncodingKey = 'UTF-8', LocaleSidKey = Country,country = 'India');
            usersList.add(userObj);
        } 
        system.debug('usersListusersList'+usersList[0].Username );         
        insert usersList;  
        return usersList;
    }
    
    //Method to create and get test lead records
    public static List<Lead> createLeads(String firstName, String lastName, Integer noOfLeads)
    {
        // create a Lead
        Id recordType = [SELECT Id FROM RecordType WHERE sObjectType = 'Lead' AND DeveloperName = 'Convert_Lead' Limit 1].Id;
        System.debug('recordType'+recordType);
        List<Lead> listOfLeads = new List<Lead>();
        for(integer i=0;i<noOfLeads;i++)
        {            
            Lead lead=new Lead(LastName='Doe'+i,FirstName='John'+i,Company='Test',Status='Converted', RecordTypeId = recordType, Phone = '000000000',
                              Trillium_Address_Update__c = True, Street = '1261 Cloverdale Trce', City = 'Greenwood', Country = 'United States', 
                              PostalCode = '46143', State = 'Indiana');
            listOfLeads.add(lead);
        } 
        Insert listOfLeads;
		return listOfLeads;
    }
}