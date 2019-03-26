/************************************************************************************
Class Name    :    Test_LeadUpdates_TriggerHandler

Description   :    Test Class for LeadUpdates_TriggerHandler

Version          Developed By           Description          Last Modified Date
------------------------------------------------------------------------------------
Version1.0       Madhavi		      Initial Version      03/21/2018
**************************************************************************************/
@isTest
public class Test_LeadUpdates_TriggerHandler {
    Public static List<Lead> listOldLeads;
    //This method used to do all the test data setup for the test class.
    @testSetup
    static void setup()
    {
        //added by tim
        Trigger_Turn_Off__c cs = new Trigger_Turn_Off__c();
        cs.Turn_Off__c = False;
        cs.Name = 'TurnOffAllTriggers';
        Insert cs;
        //
        List<User> sysuserList =  TestData_Factory.createUsers('System Administrator',1);
        System.RunAs(sysuserList[0])
        {
            Test.startTest();
            listOldLeads = new List<Lead>();
            listOldLeads = TestData_Factory.createLeads('firstOld','lastOld',5);
            //these leads needs to have Select_Owner__c field in them, and it doesn't
            //
            Test.stopTest();
        }        
    }
    
    //This method used to test the functionality of LeadTriggerHander -> leadBeforeUpdate
    public static testMethod void testleadBeforeUpdate()
    {
        List<Lead> Oldleads = new List<Lead>();
        Map<Id, Lead> mapOldLeads = new Map<Id, Lead>();
        List<Lead> updatedleads = new List<Lead>();
        Oldleads = [SELECT Id, FirstName, LastName, RecordTypeId, Street, City, State, Country, PostalCode, Trillium_Address_Update__c From Lead];        
        for(Lead ld: Oldleads)
        {
            mapOldLeads.put(ld.Id, ld);
            ld.Street = '1201';
            updatedleads.add(ld);
        }
        Test.startTest(); 
        try{
            Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
            triggerOff.Name = 'TurnOffAllTriggers';
            triggerOff.Turn_Off__c = False;
            Insert triggerOff;
            Update updatedleads;
            LeadUpdates_TriggerHandler.leadBeforeUpdate(mapOldLeads, updatedleads);
        }
        catch(DmlException e){
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
        Test.stopTest();        
    }    
}