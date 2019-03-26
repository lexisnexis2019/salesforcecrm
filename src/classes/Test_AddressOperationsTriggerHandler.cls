/*
Class Name  : Test_AddressOperationsTriggerHandler
Description : This is test class for AddressOperationsTriggerHandler
*/
@isTest
public class Test_AddressOperationsTriggerHandler{
    /*******************************************************************************************************
    * @description This method is to cover or test the functionality of address creation for account after insert.
    * @param 
    * @return This method returns void.       
    */
    public static testmethod void addressOperations(){    
             
        Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
        triggerOff.Name = 'TurnOffAllTriggers';
        triggerOff.Turn_Off__c = False;
        Insert triggerOff;
        
        //Creating test data for Account object
        Account vAccount = new Account();
        vAccount.Name='General Motors';
        vAccount.OCPGUID__c='urn:ecm:1000000I8';
        vAccount.Address_Line_1__c='Line1';
        vAccount.Address_Line_2__c='Line2';
        vAccount.BillingCity='Ohio';
        vAccount.BillingState='Ohio';
        vAccount.BillingCountry='United States';
        vAccount.BillingPostalCode='45324';      
        insert vAccount;
        
        //Added
        Account vAccount1 = new Account();
        vAccount1.Name='General Motors';
        vAccount1.Address_Line_1__c='Line1';
        vAccount1.Address_Line_2__c='Line2';
        vAccount1.BillingCity='Ohio';
        vAccount1.BillingState='Ohio';
        vAccount1.BillingCountry='United States';
        vAccount1.BillingPostalCode='45324';      
        insert vAccount1;
        
        Account verAccount = new Account();
        verAccount.Name='General Motors';
        verAccount.Address_Line_1__c='Line1';
        verAccount.Address_Line_2__c='Line2';
        verAccount.BillingCity='Ohio';
        verAccount.BillingState='Ohio';
        verAccount.BillingCountry='United States';
        verAccount.BillingPostalCode='45324';      
        insert verAccount;
        
        //Creating test data for Address object
        List<Address__c > vLstAddresses = new List<Address__c >();   
        List<Address__c > updatevLstAddresses = new List<Address__c >();       
        Address__c vAddress = new Address__c();
        vAddress.Account__c=vAccount.Id;
        vAddress.Address_Line_1_ECM__c='Lane3';  
        vAddress.Address_Line_2_ECM__c='street34';
        vAddress.Billing_City__c='Ohio';
        vAddress.Billing_Country__c='United States';
        vAddress.Billing_State_Province__c='Ohio';
        vAddress.Billing_Zip_Postal_Code__c='45324';
        vAddress.Primary__c= True;
        vLstAddresses.add(vAddress);
        
        //Added
        Address__c vAddress2 = new Address__c();
        vAddress2.Account__c= vAccount1.Id;
        vAddress2.Address_Line_1_ECM__c='Lane3';  
        vAddress2.Address_Line_2_ECM__c='street34';
        vAddress2.Billing_City__c='Ohio';
        vAddress2.Billing_Country__c='United States';
        vAddress2.Billing_State_Province__c='Ohio';
        vAddress2.Billing_Zip_Postal_Code__c='45324';
        vAddress2.Primary__c= True;
        vLstAddresses.add(vAddress2);
        
        Address__c vAddress3 = new Address__c();
        vAddress3.Account__c= vAccount.Id;
        vAddress3.Address_Line_1_ECM__c='Lane3';  
        vAddress3.Address_Line_2_ECM__c='street34';
        vAddress3.Billing_City__c='Ohio';
        vAddress3.Billing_Country__c='United States';
        vAddress3.Billing_State_Province__c='Ohio';
        vAddress3.Billing_Zip_Postal_Code__c='45324';
        vAddress3.Primary__c= False;
        vLstAddresses.add(vAddress3);
        insert vLstAddresses;
        
        Address__c vAddress1 = new Address__c();
        vAddress1.Account__c=verAccount.Id;
        vAddress1.Address_Line_1_ECM__c='Lane3';  
        vAddress1.Address_Line_2_ECM__c='street34';
        vAddress1.Billing_City__c='Ohio';
        vAddress1.Billing_Country__c='United States';
        vAddress1.Billing_State_Province__c='Ohio';
        vAddress1.Billing_Zip_Postal_Code__c='45324';
        vAddress1.Primary__c= True;
        vLstAddresses.add(vAddress1);
        
        vAddress.Primary__c = False;
        vAddress2.Primary__c=False;
        updatevLstAddresses.add(vAddress);
        updatevLstAddresses.add(vAddress2);
        try{
        update updatevLstAddresses;
        }catch(Exception e){
            system.debug('*****'+e.getMessage());
            system.assert(e.getMessage().contains('Address linked Account does not have OCPGUID ID. Address cannot be created'));
        }
               
        //invoke class method
        AddressOperationsTriggerHandler.onAfterInsertUpdateAddress(vLstAddresses);
        
    }
}