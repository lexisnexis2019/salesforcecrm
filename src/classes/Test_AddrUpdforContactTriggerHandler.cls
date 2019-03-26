/*
Class Name  : Test_AddrUpdforContactTriggerHandler
Description : This is test class for AddrUpdforContactTriggerHandler
*/
@isTest
public class Test_AddrUpdforContactTriggerHandler{
    /*******************************************************************************************************
    * @description This method is to cover or test the functionality of address update based on account selected
    * @param 
    * @return This method returns void.    
    */
    public static testmethod void addressUpdateForContact(){        
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
        List<Contact> vLstContacts = new List<Contact>();
        Contact con = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = acc.Id, Address__c = address.Id, Email = 'test1.email@gmail.com');
        vLstContacts.add(con);
        Insert vLstContacts;
        List<Contact> vLQstContacts = new List<Contact>();
        Contact contactRec = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = acc.Id, Email = 'test.email@gmail.com');
        vLQstContacts.add(contactRec);
        Insert vLQstContacts;
        
        con.FirstName = 'Tested';
        Update con;
        
        contactRec.FirstName = 'TestedRecord';
        Update contactRec;
        
        
        //Execute the class method
        avoidRecursive.firstRun = True;
        AddressUpdateforContactTriggerHandler.onBeforeInsertUpdateContact(vLstContacts);
        AddressUpdateforContactTriggerHandler.onBeforeInsertUpdateContact(vLQstContacts);
    }
}