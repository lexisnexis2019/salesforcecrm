@isTest
public class Test_LEXNEX_AccountHandler {
    public static testMethod void testunlockAccountChilds() {  
        Trigger_Turn_Off__c triggerOff = new Trigger_Turn_Off__c();
        triggerOff.Name = 'TurnOffAllTriggers';
        triggerOff.Turn_Off__c = False;
        Insert triggerOff;
        
        
        // Create test account
        List<Account> listAccounts = new List<Account>();
        Account accountRecord = new Account();
        accountRecord.Name = 'Test Account';
        accountRecord.OCPGUID__c  = '0103xxc032102';
        accountRecord.BillingStreet = '78200 Miles Ave';
        accountRecord.BillingCity = 'Indian Wells';
        accountRecord.BillingState = 'California';
        accountRecord.BillingPostalCode = '92210';
        accountRecord.BillingCountry = 'United States';
        accountRecord.OC_Repair_Flag__c = 'Y';
        accountRecord.Trillium_Validated__c = True;
        accountRecord.User_Validated__c = False;
        accountRecord.Address_Accepted__c = False;
        Insert accountRecord;
        
        List<Address__c> vLstAddresses = new List<Address__c>();
        Address__c addressRecord = new Address__c();
        addressRecord.Account__c = accountRecord.Id;
        addressRecord.Billing_Street__c = '78200 Miles Ave';
        addressRecord.Billing_City__c = 'Indian Wells';
        addressRecord.Billing_State_Province__c = 'California';
        addressRecord.Billing_Zip_Postal_Code__c = '92210';
        addressRecord.Billing_Country__c = 'United States';
        addressRecord.POBPGUID__c = 'xadfafd132432';
        addressRecord.Primary__c = True;
        addressRecord.End_Date__c = System.today();
        addressRecord.Trillium_Validated__c = True;
        addressRecord.User_Validated__c = False;
        addressRecord.Address_Accepted__c = False;
        Insert addressRecord;
        vLstAddresses.add(addressRecord);
        
        List<Contact> vLstContacts = new List<Contact>();
        Contact con = new Contact(FirstName = 'Test', LastName = 'Contact', AccountId = accountRecord.Id, Address__c = addressRecord.Id, Email = 'test1.email@gmail.com');
        vLstContacts.add(con);
        Insert vLstContacts;
        
        accountRecord.OC_Repair_Flag__c = 'N';
        Upsert accountRecord;
        
        DataBase.executeBatch(new BatchUpdateContactOCPGUID(vLstContacts), 1);
        DataBase.executeBatch(new BatchUpdateAddressOCPGUID(vLstAddresses), 1);
        
    }
}