@isTest
public class TEST_RESTService_Address_Validation {
    public static testMethod void testgetAccountValidateAddress()
    {
        
        Trigger_Turn_Off__c cs1 = new Trigger_Turn_Off__c();
        cs1.Turn_Off__c = False;
        cs1.Name = 'TurnOffAllTriggers';
        Insert cs1;
        
        
        Account accountRecord1 = new Account();
        accountRecord1.Name = 'Test Account';
        accountRecord1.BillingStreet = '78200 Miles Ave';
        accountRecord1.BillingCity = 'Indian Wells';
        accountRecord1.BillingState = 'California';
        accountRecord1.BillingPostalCode = '92210';
        accountRecord1.BillingCountry = 'United States';
        accountRecord1.Trillium_Validated__c = True;
        accountRecord1.User_Validated__c = False;
        accountRecord1.Address_Accepted__c = False;
        Insert accountRecord1;

        Lead leadRecord1 = new Lead();
        leadRecord1.FirstName = 'Test';
        leadRecord1.LastName = 'Lead';
        leadRecord1.Street = '78200 Miles Ave';
        leadRecord1.City = 'Indian Wells';
        
        leadRecord1.State = 'California';
        leadRecord1.PostalCode = '92210';
        leadRecord1.Email = 'test.address@gmail.com';
        leadRecord1.Country = 'United States';
        leadRecord1.Trillium_Validated__c = True;
        leadRecord1.User_Validated__c = False;
        leadRecord1.Address_Accepted__c = False;
        leadRecord1.Company = 'Testing';
        Insert leadRecord1; 
        Map<String,String> responseHeaders1 = new Map<String, String>();
        responseHeaders1.put('Content-Type','application/json');  
        responseHeaders1.put('Accept', 'application/json');
        Account accountRec1 = new Account();
        accountRec1.Name = 'Test Account';
        accountRec1.OCPGUID__c  = '0103xxc0321021234';
        accountRec1.BillingStreet = '78200 Miles Ave';
        accountRec1.BillingCity = 'Indian Wells';
        accountRec1.BillingState = 'California';
        accountRec1.BillingPostalCode = '92210';
        accountRec1.BillingCountry = 'United States';
        accountRec1.Trillium_Validated__c = True;
        accountRec1.User_Validated__c = False;
        accountRec1.Address_Accepted__c = False;
        Insert accountRec1; 
        
        Address__c addressRecord1 = new Address__c();
        addressRecord1.Account__c = accountRec1.Id;
        addressRecord1.Billing_Street__c = '78200 Miles Ave';
        addressRecord1.Billing_City__c = 'Indian Wells';
        addressRecord1.Billing_State_Province__c = 'California';
        addressRecord1.Billing_Zip_Postal_Code__c = '92210';
        addressRecord1.Billing_Country__c = 'United States';
        addressRecord1.Trillium_Validated__c = True;
        addressRecord1.User_Validated__c = False;
        addressRecord1.Address_Accepted__c = False;
        Insert addressRecord1;   
        
        RestRequest req1 = new RestRequest(); 
        RestResponse res1 = new RestResponse();
        String addressStreet1;
            String addressCountry1;
            String addressCity1;
            String tabStr1 = ' ';
            addressStreet1 = (addressRecord1.Billing_Street__c != null ? addressRecord1.Billing_Street__c.replaceAll('\\#', '') : '');
            addressStreet1 = addressStreet1.replaceAll('\\s','+');
            addressRecord1.Billing_Zip_Postal_Code__c = addressRecord1.Billing_Zip_Postal_Code__c.replaceAll('\\s','+');
            addressCountry1 = (addressRecord1.Billing_Country__c != null ? addressRecord1.Billing_Country__c.replaceAll('\\s','+') : '');
            addressCity1 = (addressRecord1.Billing_City__c != null ? addressRecord1.Billing_City__c.replaceAll('\\s','+') : '');
            /*SingleRequestMock responseResults1 = new SingleRequestMock(200,
                                                  'Complete',
                                                  '{"contact":{"SubBuilding":"904","Premise":"1969","Street":"Upper Water St","City":"Halifax","Region":"NS","Postcode":"B3J 3R7","Country":"Canada","DatastoreDataset":"CAN","ACR":"L5-P6S5A0T6R5Z4C4-062","ValidationRule":"EL5-P4S4T4R4Z0C4-F","OuterMatchscore":"30","InnerMatchscore":"62","ExtendedACR":"L5-D0M0B0U4P6S5Q0X0A0T6E0R5W0Z4Y0C4-062","ValidationDataset":"CAN","EnhancementDatasets":"CANnvgeo","Latitude":"44.651764","Longitude":"-63.575372","AddressLine1":"904 - 1969 Upper Water St","AddressLine2":"Halifax NS B3J 3R7","AddressLine3":"Canada","CountryISO":"CAN"}}',responseHeaders1);
            Map<String, HttpCalloutMock> endPointResults1 = new Map<String,HttpCalloutMock>();
            system.debug('responseResults=>'+responseResults1);
            endPointResults1.put('https://relx-test.trilliumedqcloud.com:443/gl/contacts/process',responseResults1);
            HttpCalloutMock multiCalloutMock1 =  new TESTMockHttpResponseGeneratorClass(endPointResults1);
            Test.setMock(HttpCalloutMock.class,multiCalloutMock1) ;   */
        RESTService_AddressValidation.getAccountValidateAddress(accountRec1);     
        accountRec1.User_Validated__c = True;
        RESTService_AddressValidation.getAccountValidateAddress(accountRec1);     
        RESTService_AddressValidation.restResponseTemplate obj1 = new RESTService_AddressValidation.restResponseTemplate();
        RESTService_AddressValidation.fromJSON rewrapper1 = new RESTService_AddressValidation.fromJSON();   
        RESTService_AddressValidation.getAddressRecordValidateAddress(addressRecord1);  
        addressRecord1.Billing_Country__c = 'Argentina';
        addressRecord1.Billing_State_Province__c = '';
        Address__c addressRecord2 = new Address__c();
        RESTService_AddressValidation.getAddressRecordValidateAddress(addressRecord1);
        RESTService_AddressValidation.getAddressRecordValidateAddress(addressRecord2);
    }
    public static testMethod void testgetLeadAccountValidateAddress()
    {
        Test.startTest();
        Trigger_Turn_Off__c cs = new Trigger_Turn_Off__c();
        cs.Turn_Off__c = False;
        cs.Name = 'TurnOffAllTriggers';
        Insert cs;
        
        Account accountRecord = new Account();
        accountRecord.Name = 'Test Account';
        accountRecord.BillingStreet = '78200 Miles Ave';
        accountRecord.BillingCity = 'Indian Wells';
        accountRecord.BillingState = 'California ';
        accountRecord.BillingPostalCode = '92210';
        accountRecord.BillingCountry = 'United States';
        accountRecord.Trillium_Validated__c = True;
        accountRecord.User_Validated__c = False;
        accountRecord.Address_Accepted__c = False;
        Insert accountRecord;        
        RESTService_AddressValidation.getAccountValidateAddress(accountRecord);
        accountRecord.BillingCountry = 'US';
        Account accRecord = new Account();
        RESTService_AddressValidation.getAccountValidateAddress(accountRecord);
        RESTService_AddressValidation.getAccountValidateAddress(accRecord);

        Lead leadRecord = new Lead();
        leadRecord.FirstName = 'Test';
        leadRecord.LastName = 'Lead';
        leadRecord.Street = '310 Morris Street';
        leadRecord.City = 'Mountain View,';
        leadRecord.State = 'California';
        leadRecord.PostalCode = '94043';
        leadRecord.Email = 'test.address@gmail.com';
        leadRecord.Country = 'United States';
        leadRecord.Trillium_Validated__c = True;
        leadRecord.User_Validated__c = False;
        leadRecord.Address_Accepted__c = False;
        leadRecord.Company = 'Testing';
        Insert leadRecord; 
        Map<String,String> responseHeaders = new Map<String, String>();
        responseHeaders.put('Content-Type','application/json');  
        responseHeaders.put('Accept', 'application/json');
        Account accountRec = new Account();
        accountRec.Name = 'Test Account';
        accountRec.OCPGUID__c  = '0103xxc0321023324';
        accountRec.BillingStreet = '78200 Miles Ave';
        accountRec.BillingCity = 'Indian Wells';
        accountRec.BillingState = 'California';
        accountRec.BillingPostalCode = '92210';
        accountRec.BillingCountry = 'United States';
        accountRec.Trillium_Validated__c = True;
        accountRec.User_Validated__c = False;
        accountRec.Address_Accepted__c = False;
        Insert accountRec;
        
        Address__c addressRecord = new Address__c();
        addressRecord.Account__c = accountRec.Id;
        addressRecord.Billing_Street__c = '78200 Miles Ave';
        addressRecord.Billing_City__c = 'Indian Wells';
        addressRecord.Billing_State_Province__c = 'California';
        addressRecord.Billing_Zip_Postal_Code__c = '92210';
        addressRecord.Billing_Country__c = 'United States';
        addressRecord.Trillium_Validated__c = True;
        addressRecord.User_Validated__c = False;
        addressRecord.Address_Accepted__c = False;
        Insert addressRecord;   
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        String addressStreet;
            String addressCountry;
            String addressCity;
            String tabStr = ' ';
            addressStreet = (addressRecord.Billing_Street__c != null ? addressRecord.Billing_Street__c.replaceAll('\\#', '') : '');
            addressStreet = addressStreet.replaceAll('\\s','+');
            addressRecord.Billing_Zip_Postal_Code__c = addressRecord.Billing_Zip_Postal_Code__c.replaceAll('\\s','+');
            addressCountry = (addressRecord.Billing_Country__c != null ? addressRecord.Billing_Country__c.replaceAll('\\s','+') : '');
            addressCity = (addressRecord.Billing_City__c != null ? addressRecord.Billing_City__c.replaceAll('\\s','+') : '');
            /*SingleRequestMock responseResults = new SingleRequestMock(200,
                                                  'Complete',
                                                  '{"contact":{"SubBuilding":"904","Premise":"1969","Street":"Upper Water St","City":"Halifax","Region":"NS","Postcode":"B3J 3R7","Country":"Canada","DatastoreDataset":"CAN","ACR":"L5-P6S5A0T6R5Z4C4-062","ValidationRule":"EL5-P4S4T4R4Z0C4-F","OuterMatchscore":"30","InnerMatchscore":"62","ExtendedACR":"L5-D0M0B0U4P6S5Q0X0A0T6E0R5W0Z4Y0C4-062","ValidationDataset":"CAN","EnhancementDatasets":"CANnvgeo","Latitude":"44.651764","Longitude":"-63.575372","AddressLine1":"904 - 1969 Upper Water St","AddressLine2":"Halifax NS B3J 3R7","AddressLine3":"Canada","CountryISO":"CAN"}}',responseHeaders);
            Map<String, HttpCalloutMock> endPointResults = new Map<String,HttpCalloutMock>();
            endPointResults.put('https://relx-test.trilliumedqcloud.com:443/gl/contacts/process',responseResults);
            HttpCalloutMock multiCalloutMock =  new TESTMockHttpResponseGeneratorClass(endPointResults);
            Test.setMock(HttpCalloutMock.class, multiCalloutMock);   */
        
        RESTService_AddressValidation.getLeadValidateAddress(leadRecord);
        RESTService_AddressValidation.getLeadAddressValidated(leadRecord.Id);
        leadRecord.User_Validated__c = True;
        RESTService_AddressValidation.getLeadValidateAddress(leadRecord);
        RESTService_AddressValidation.getLeadAddressValidated(leadRecord.Id);
        RESTService_AddressValidation.restResponseTemplate obj = new RESTService_AddressValidation.restResponseTemplate();
        RESTService_AddressValidation.fromJSON rewrapper = new RESTService_AddressValidation.fromJSON();           
        rewrapper.Building = 'gjgjhgj';
        TEST_RESTService_Address_Validation.testgetAccountValidateAddress();
        TEST_RESTService_Address_Validation.testgetAddressValidateAddress();
        Test.stopTest();
    }
    public static testMethod void testgetAddressValidateAddress()
    {
        Trigger_Turn_Off__c cs2 = new Trigger_Turn_Off__c();
        cs2.Turn_Off__c = False;
        cs2.Name = 'TurnOffAllTriggers';
        Insert cs2;
        
        Account accountRecord2 = new Account();
        accountRecord2.Name = 'Test Account';
        accountRecord2.BillingStreet = '78200 Miles Ave';
        accountRecord2.BillingCity = 'Indian Wells';
        accountRecord2.BillingState = 'California ';
        accountRecord2.BillingPostalCode = '92210';
        accountRecord2.BillingCountry = 'United States';
        accountRecord2.Trillium_Validated__c = True;
        accountRecord2.User_Validated__c = False;
        accountRecord2.Address_Accepted__c = False;
        Insert accountRecord2;        

        Lead leadRecord2 = new Lead();
        leadRecord2.FirstName = 'Test';
        leadRecord2.LastName = 'Lead';
        leadRecord2.Street = '78200 Miles Ave';
        leadRecord2.City = 'Indian Wells';
        leadRecord2.State = 'California';
        leadRecord2.PostalCode = '92210';
        leadRecord2.Email = 'test.address@gmail.com';
        leadRecord2.Country = 'United States';
        leadRecord2.Trillium_Validated__c = True;
        leadRecord2.User_Validated__c = False;
        leadRecord2.Address_Accepted__c = False;
        leadRecord2.Company = 'Testing';
        Insert leadRecord2; 
        Map<String,String> responseHeaders2 = new Map<String, String>();
        responseHeaders2.put('Content-Type','application/json');  
        responseHeaders2.put('Accept', 'application/json');
        Account accountRec2 = new Account();
        accountRec2.Name = 'Test Account';
        accountRec2.OCPGUID__c  = '0103xxc0321021234234';
        accountRec2.BillingStreet = '78200 Miles Ave';
        accountRec2.BillingCity = 'Indian Wells';
        accountRec2.BillingState = 'California';
        accountRec2.BillingPostalCode = '92210';
        accountRec2.BillingCountry = 'United States';
        accountRec2.Trillium_Validated__c = True;
        accountRec2.User_Validated__c = False;
        accountRec2.Address_Accepted__c = False;
        Insert accountRec2; 
        
        Address__c addressRecord2 = new Address__c();
        addressRecord2.Account__c = accountRec2.Id;
        addressRecord2.Billing_Street__c = '78200 Miles Ave';
        addressRecord2.Billing_City__c = 'Indian Wells';
        addressRecord2.Billing_State_Province__c = 'California';
        addressRecord2.Billing_Zip_Postal_Code__c = '92210';
        addressRecord2.Billing_Country__c = 'United States';
        addressRecord2.Trillium_Validated__c = True;
        addressRecord2.User_Validated__c = False;
        addressRecord2.Address_Accepted__c = False;
        Insert addressRecord2;   
        
        RestRequest req2 = new RestRequest(); 
        RestResponse res2 = new RestResponse();
        String addressStreet2;
            String addressCountry2;
            String addressCity2;
            String tabStr2 = ' ';
            addressStreet2 = (addressRecord2.Billing_Street__c != null ? addressRecord2.Billing_Street__c.replaceAll('\\#', '') : '');
            addressStreet2 = addressStreet2.replaceAll('\\s','+');
            addressRecord2.Billing_Zip_Postal_Code__c = addressRecord2.Billing_Zip_Postal_Code__c.replaceAll('\\s','+');
            System.debug('addressStreet2'+addressStreet2);
            System.debug('Billing_Country__c'+addressRecord2.Billing_Country__c);
            addressCountry2 = (addressRecord2.Billing_Country__c != null ? addressRecord2.Billing_Country__c.replaceAll('\\s','+') : '');
            addressCity2 = (addressRecord2.Billing_City__c != null ? addressRecord2.Billing_City__c.replaceAll('\\s','+') : '');
            /*SingleRequestMock responseResults2 = new SingleRequestMock(200,
                                                  'Complete',
                                                  '{"contact":{"SubBuilding":"904","Premise":"1969","Street":"Upper Water St","City":"Halifax","Region":"NS","Postcode":"B3J 3R7","Country":"Canada","DatastoreDataset":"CAN","ACR":"L5-P6S5A0T6R5Z4C4-062","ValidationRule":"EL5-P4S4T4R4Z0C4-F","OuterMatchscore":"30","InnerMatchscore":"62","ExtendedACR":"L5-D0M0B0U4P6S5Q0X0A0T6E0R5W0Z4Y0C4-062","ValidationDataset":"CAN","EnhancementDatasets":"CANnvgeo","Latitude":"44.651764","Longitude":"-63.575372","AddressLine1":"904 - 1969 Upper Water St","AddressLine2":"Halifax NS B3J 3R7","AddressLine3":"Canada","CountryISO":"CAN"}}',responseHeaders2);
            Map<String, HttpCalloutMock> endPointResults2 = new Map<String,HttpCalloutMock>();
            endPointResults2.put('https://relx-test.trilliumedqcloud.com:443/gl/contacts/process?',responseResults2);
            HttpCalloutMock multiCalloutMock2 =  new TESTMockHttpResponseGeneratorClass(endPointResults2);
            Test.setMock(HttpCalloutMock.class, multiCalloutMock2);   */
        
        RESTService_AddressValidation.getAddressRecordValidateAddress(addressRecord2);
        addressRecord2.User_Validated__c = True;
        RESTService_AddressValidation.getAddressRecordValidateAddress(addressRecord2);
        RESTService_AddressValidation.restResponseTemplate obj2 = new RESTService_AddressValidation.restResponseTemplate();
        RESTService_AddressValidation.fromJSON rewrapper2 = new RESTService_AddressValidation.fromJSON(); 
        
            } 
}