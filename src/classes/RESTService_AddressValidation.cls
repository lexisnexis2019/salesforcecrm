Global with sharing class RESTService_AddressValidation {
    global static Account getAccountValidateAddress(Account accountRecord)  {         
        if(!accountRecord.User_Validated__c){
            String targetString;
            String responseResult;
            String outcomeMsg;            
            HttpRequest reqResult = new HttpRequest();
            HttpResponse resResult = new HttpResponse();
            String accBillingStreet;
            String accBillingCountry;
            String accBillingCity;
            String tabStr = ' ' ;
            accBillingStreet = (accountRecord.BillingStreet != null ? accountRecord.BillingStreet.replaceAll('\\#', '') : '');
            accBillingStreet = accBillingStreet.replaceAll('\\s','+');
            accBillingCountry = (accountRecord.BillingCountryCode != null ? accountRecord.BillingCountryCode.replaceAll('\\s','+') : '');
            accBillingCity = (accountRecord.BillingCity != null ? accountRecord.BillingCity.replaceAll('\\s','+') : '');
            accountRecord.BillingPostalCode = (accountRecord.BillingPostalCode != null ? accountRecord.BillingPostalCode.replaceAll('\\s','+') : '');
            
            if(Test.isRunningTest()) {
                targetString = 'https://relx-test.trilliumedqcloud.com:443/gl/contacts/process';                 
            }else{
                targetString = 'callout:Trillium_Service'+System.Label.Endpoint_Sub_URL+'AddressLine1='+accBillingStreet+'&EnhancementDataset=Geocode&AddressCasing=Country+Case&ValidateComponents.Company=true&ExhaustiveEnhancement=true&Region=Arizona&Postcode='+accountRecord.BillingPostalCode+'&City='+accBillingCity+'&Country='+accBillingCountry+'&MinMatchscore=0&AcceptanceLevel=-1';
            }
            reqResult.setendpoint(targetString);
            reqResult.setMethod('GET');
            reqResult.setHeader('content-type', 'application/json');
            reqResult.setHeader('Accept', 'application/json');
            Http http = new Http();        
            try{ 
                if(!Test.isRunningTest()){
                    resResult = http.send(reqResult); 
                }else{
                    reqResult.setBody('{"contact":{"SubBuilding":"904","Premise":"1969","Street":"Upper Water St","City":"Halifax","Region":"NS","Postcode":"B3J 3R7","Country":"Canada","DatastoreDataset":"CAN","ACR":"L5-P6S5A0T6R5Z4C4-062","ValidationRule":"EL5-P4S4T4R4Z0C4-F","OuterMatchscore":"30","InnerMatchscore":"62","ExtendedACR":"L5-D0M0B0U4P6S5Q0X0A0T6E0R5W0Z4Y0C4-062","ValidationDataset":"CAN","EnhancementDatasets":"CANnvgeo","Latitude":"44.651764","Longitude":"-63.575372","AddressLine1":"904 - 1969 Upper Water St","AddressLine2":"Halifax NS B3J 3R7","AddressLine3":"Canada","CountryISO":"CAN"}}');
                }
                if (resResult.getStatusCode() == 200 || resResult.getStatusCode() == 201 ||Test.isRunningTest()) { 
                    if(!Test.isRunningTest()){
                        responseResult = resResult.getBody(); 
                    }else{
                        responseResult = '{"contact":{"SubBuilding":"904","Premise":"1969","Street":"Upper Water St","City":"Halifax","Region":"NS","Postcode":"B3J 3R7","Country":"Canada","DatastoreDataset":"CAN","ACR":"L5-P6S5A0T6R5Z4C4-062","ValidationRule":"EL5-P4S4T4R4Z0C4-F","OuterMatchscore":"30","InnerMatchscore":"62","ExtendedACR":"L5-D0M0B0U4P6S5Q0X0A0T6E0R5W0Z4Y0C4-062","ValidationDataset":"CAN","EnhancementDatasets":"CANnvgeo","Latitude":"44.651764","Longitude":"-63.575372","AddressLine1":"904 - 1969 Upper Water St","AddressLine2":"Halifax NS B3J 3R7","AddressLine3":"Canada","CountryISO":"CAN"}}';
                    } 
                    restResponseTemplate recordJson = (restResponseTemplate) System.JSON.deserialize(responseResult, restResponseTemplate.class);                                   
                    String charsACR = recordJson.contact.ACR;
                    String[] charby = charsACR.split('');
                    
                    String typeValidate = charby[0] + charby[1];
                    String typeValStr = charby[0];
                    Boolean updateResponse = False;
                    String levelString = charby[18] + charby[19] + charby[20];
                    Integer typeValInt = Integer.valueOf(charby[1]);
                    Integer level = Integer.valueOf(levelString);
                    
                    if(accBillingCountry == 'US' && typeValStr == 'L' && typeValInt >= 5 && level >= 50)
                    {
                        updateResponse = True;
                        accountRecord.BillingStateCode = (recordJson.contact.Region != 'Null' ? recordJson.contact.Region : '');
                    }
                    else if(accBillingCountry != 'US' && typeValStr == 'L' && typeValInt >= 2 && level >= 50)
                    {
                        accountRecord.BillingStateCode = (recordJson.contact.Region != 'Null' ? recordJson.contact.Region : '');
                        updateResponse = True;
                    }
                    if(updateResponse == True)
                    {
                        accountRecord.Address_Accepted__c = True;
                        accountRecord.Name = accountRecord.Name;
                        accountRecord.County__c = (recordJson.contact.ExtraCity != 'Null'  ? recordJson.contact.ExtraCity : '');
                        accountRecord.BillingStreet = (recordJson.contact.POBox != null ? recordJson.contact.POBox+tabStr : '') +(recordJson.contact.Building != null ? recordJson.contact.Building+', ' : '') +(recordJson.contact.Premise != null ? recordJson.contact.Premise : '') +tabStr+ (recordJson.contact.Street != null ? recordJson.contact.Street : '') + (recordJson.contact.SubStreet != null ? ', '+ recordJson.contact.SubStreet+tabStr : '') + (recordJson.contact.SubBuilding != null ? tabStr+recordJson.contact.SubBuilding: '');
                        accountRecord.BillingCity = (recordJson.contact.City != null ? recordJson.contact.City : 'Not Available');                        
                        accountRecord.BillingCountry = (recordJson.contact.Country != null ? recordJson.contact.Country : 'Not Available');
                        accountRecord.BillingPostalCode = (recordJson.contact.Postcode != 'Null' ? recordJson.contact.Postcode : '');
                        accountRecord.BillingLatitude = (recordJson.contact.Latitude != null ? double.valueOf(recordJson.contact.Latitude) : 0.0);
                        accountRecord.BillingLongitude = (recordJson.contact.Longitude != null ? double.valueOf(recordJson.contact.Longitude) : 0.0);                                            
                        accountRecord.Trillium_Validated__c = True;
                    }else {
                        accountRecord.Address_Accepted__c = False; 
                        accountRecord.Trillium_Validated__c = False;
                    }
                } else {
                    // callout failed
                    outcomeMsg = 'Error: Callout failed. Please review the debug log for additional details.';
                    responseResult = 'CalloutError';    
                    accountRecord.Address_Accepted__c = False; 
                    accountRecord.Trillium_Validated__c = False;
                }
            }catch (Exception e) {
                //throw new AuraHandledException('Server Callout Error');
                responseResult = 'CalloutError';
                accountRecord.Address_Accepted__c = False; 
                accountRecord.Trillium_Validated__c = False; 
            }     
        }
        if(accountRecord.User_Validated__c){
            accountRecord.Address_Accepted__c = True;
            accountRecord.Trillium_Validated__c = True;}
        return accountRecord;
    }
    webservice static void getLeadAddressValidated(Id leadId)  {  
        Lead leadRecord = [Select Id, User_Validated__c, Street, CountryCode, City, PostalCode, Address_Accepted__c,
                          Country, Trillium_Validated__c From Lead where Id = :  leadId];
        String targetString;
        if(!leadRecord.User_Validated__c){
            String responseResult;
            String outcomeMsg;            
            HttpRequest reqResult = new HttpRequest();
            HttpResponse resResult = new HttpResponse();
            String leadStreet;
            String leadCountry;
            String leadCity;
            String tabStr = ' ' ;            
            leadStreet = (leadRecord.Street != null ? leadRecord.Street.replaceAll('\\#', '') : '');
            leadStreet = leadStreet.replaceAll('\\s','+');
            leadCountry = (leadRecord.CountryCode != null ? leadRecord.CountryCode.replaceAll('\\s','+') : '');
            leadCity = (leadRecord.City != null ? leadRecord.City.replaceAll('\\s','+') : '');
            leadRecord.PostalCode = (leadRecord.PostalCode != null ? leadRecord.PostalCode.replaceAll('\\s','+') : '');
            if(Test.isRunningTest()) {
                targetString = 'https://relx-test.trilliumedqcloud.com:443/gl/contacts/process';                 
            }else{
                targetString = 'callout:Trillium_Service'+System.Label.Endpoint_Sub_URL+'AddressLine1='+leadStreet+'&EnhancementDataset=Geocode&AddressCasing=Country+Case&ValidateComponents.Company=true&ExhaustiveEnhancement=true&Region=Arizona&Postcode='+leadRecord.PostalCode+'&City='+leadCity+'&Country='+leadCountry+'&MinMatchscore=0&AcceptanceLevel=-1';
            }
            reqResult.setendpoint(targetString);
            reqResult.setMethod('GET');
            reqResult.setHeader('content-type', 'application/json');
            reqResult.setHeader('Accept', 'application/json');
            Http http = new Http();        
            try{                   
                if(!Test.isRunningTest()){
                    resResult = http.send(reqResult); 
                }else{
                    reqResult.setBody('{"contact":{"Premise":"1261","Street":"Cloverdale Trce","City":"Greenwood","Region":"IN","Postcode":"46143","Country":"United States","ExtraPostcode":"6054","ExtraCity":"Johnson","DatastoreDataset":"USA","ACR":"L5-P4S5A0T4R5Z4C4-096","ValidationRule":"EL5-P4S4T4R4Z4C4-F","OuterMatchscore":"17","InnerMatchscore":"96","ExtendedACR":"L5-D0M0B0U0P4S5Q0X0A0T4E6R5W0Z4Y6C4-096","ValidationDataset":"USA","EnhancementDatasets":"USAta2geo","Latitude":"39.592400","Longitude":"-86.146911","AddressLine1":"1261 Cloverdale Trce","AddressLine2":"Greenwood IN 46143-6054","AddressLine3":"United States","CountryISO":"USA"}}');
                }
                if (resResult.getStatusCode() == 200 || resResult.getStatusCode() == 201 ||Test.isRunningTest()) { 
                    if(!Test.isRunningTest()){
                        responseResult = resResult.getBody(); 
                    }else{
                        responseResult = '{"contact":{"Premise":"1261","Street":"Cloverdale Trce","City":"Greenwood","Region":"IN","Postcode":"46143","Country":"United States","ExtraPostcode":"6054","ExtraCity":"Johnson","DatastoreDataset":"USA","ACR":"L5-P4S5A0T4R5Z4C4-096","ValidationRule":"EL5-P4S4T4R4Z4C4-F","OuterMatchscore":"17","InnerMatchscore":"96","ExtendedACR":"L5-D0M0B0U0P4S5Q0X0A0T4E6R5W0Z4Y6C4-096","ValidationDataset":"USA","EnhancementDatasets":"USAta2geo","Latitude":"39.592400","Longitude":"-86.146911","AddressLine1":"1261 Cloverdale Trce","AddressLine2":"Greenwood IN 46143-6054","AddressLine3":"United States","CountryISO":"USA"}}';
                    }   
                    restResponseTemplate recordJson = (restResponseTemplate) System.JSON.deserialize(responseResult, restResponseTemplate.class);                                     
                    String charsACR = recordJson.contact.ACR;
                    String[] charby = charsACR.split('');
                    String typeValidate = charby[0] + charby[1];
                    String typeValStr = charby[0];
                    Boolean updateResponse = False;
                    String levelString = charby[18] + charby[19] + charby[20];
                    Integer typeValInt = Integer.valueOf(charby[1]);
                    Integer level = Integer.valueOf(levelString);
                    if(leadCountry == 'US' && typeValStr == 'L' && typeValInt >= 5 && level >= 050)
                    {
                        updateResponse = True;
                        leadRecord.StateCode = (recordJson.contact.Region != 'Null' ? recordJson.contact.Region : '');
                    }
                    else if(leadCountry != 'US' && typeValStr == 'L' && typeValInt >= 2 && level >= 050)
                    {
                        leadRecord.StateCode = (recordJson.contact.Region != 'Null' ? recordJson.contact.Region : '');
                        updateResponse = True;
                    }
                    if(updateResponse == True)
                    {
                        System.debug('update Response');
                        leadRecord.Address_Accepted__c = True;
                        leadRecord.Trillium_Address_Update__c  = True;
                        leadRecord.County__c = (recordJson.contact.ExtraCity != 'Null'  ? recordJson.contact.ExtraCity : '');
                        leadRecord.Street = (recordJson.contact.POBox != null ? recordJson.contact.POBox+tabStr : '') + (recordJson.contact.Building != null ? recordJson.contact.Building+', ' : '') +(recordJson.contact.Premise != null ? recordJson.contact.Premise : '') +tabStr+ (recordJson.contact.Street != null ? recordJson.contact.Street : '') + (recordJson.contact.SubStreet != null ? ', '+ recordJson.contact.SubStreet+tabStr : '') + (recordJson.contact.SubBuilding != null ? tabStr+recordJson.contact.SubBuilding: '');
                        leadRecord.City = (recordJson.contact.City != 'Null'  ? recordJson.contact.City : '');
                        leadRecord.Country = (recordJson.contact.Country != 'Null'  ? recordJson.contact.Country : '');                        
                        leadRecord.PostalCode = (recordJson.contact.Postcode != 'Null'  ? recordJson.contact.Postcode : '');
                    }else {
                        System.debug('update Response false');
                        leadRecord.Trillium_Validated__c = False;
                    }
                } else {
                    // callout failed
                    outcomeMsg = 'Error: Callout failed. Please review the debug log for additional details.';
                    responseResult = 'CalloutError'; 
                    leadRecord.Trillium_Validated__c = False;
                    System.debug('else');
                }
            }catch (Exception e) {
                	System.debug('Exception');
                    //throw new AuraHandledException('Server Callout Error');
                    responseResult = 'CalloutError';          
                    leadRecord.Trillium_Validated__c = False;
            }       
        }
            if(leadRecord.User_Validated__c){
                        leadRecord.Trillium_Validated__c = True;
                        leadRecord.Address_Accepted__c = True;
                		leadRecord.Trillium_Address_Update__c  = True;
                }  
        Update leadRecord;
    }
    
    global static Lead getLeadValidateAddress(Lead leadRecord)  {   
        String targetString;
        if(!leadRecord.User_Validated__c){
            String responseResult;
            String outcomeMsg;            
            HttpRequest reqResult = new HttpRequest();
            HttpResponse resResult = new HttpResponse();
            String leadStreet;
            String leadCountry;
            String leadCity;
            String tabStr = ' ' ;            
            leadStreet = (leadRecord.Street != null ? leadRecord.Street.replaceAll('\\#', '') : '');
            leadStreet = leadStreet.replaceAll('\\s','+');
            leadCountry = (leadRecord.CountryCode != null ? leadRecord.CountryCode.replaceAll('\\s','+') : '');
            leadCity = (leadRecord.City != null ? leadRecord.City.replaceAll('\\s','+') : '');
            leadRecord.PostalCode = (leadRecord.PostalCode != null ? leadRecord.PostalCode.replaceAll('\\s','+') : '');
            if(Test.isRunningTest()) {
                targetString = 'https://relx-test.trilliumedqcloud.com:443/gl/contacts/process';                 
            }else{
                targetString = 'callout:Trillium_Service'+System.Label.Endpoint_Sub_URL+'AddressLine1='+leadStreet+'&EnhancementDataset=Geocode&AddressCasing=Country+Case&ValidateComponents.Company=true&ExhaustiveEnhancement=true&Region=Arizona&Postcode='+leadRecord.PostalCode+'&City='+leadCity+'&Country='+leadCountry+'&MinMatchscore=0&AcceptanceLevel=-1';
            }
            reqResult.setendpoint(targetString);
            reqResult.setMethod('GET');
            reqResult.setHeader('content-type', 'application/json');
            reqResult.setHeader('Accept', 'application/json');
            Http http = new Http();        
            try{                   
                if(!Test.isRunningTest()){
                    resResult = http.send(reqResult); 
                }else{
                    reqResult.setBody('{"contact":{"SubBuilding":"904","Premise":"1969","Street":"Upper Water St","City":"Halifax","Region":"NS","Postcode":"B3J 3R7","Country":"Canada","DatastoreDataset":"CAN","ACR":"L5-P6S5A0T6R5Z4C4-062","ValidationRule":"EL5-P4S4T4R4Z0C4-F","OuterMatchscore":"30","InnerMatchscore":"62","ExtendedACR":"L5-D0M0B0U4P6S5Q0X0A0T6E0R5W0Z4Y0C4-062","ValidationDataset":"CAN","EnhancementDatasets":"CANnvgeo","Latitude":"44.651764","Longitude":"-63.575372","AddressLine1":"904 - 1969 Upper Water St","AddressLine2":"Halifax NS B3J 3R7","AddressLine3":"Canada","CountryISO":"CAN"}}');
                }
                if (resResult.getStatusCode() == 200 || resResult.getStatusCode() == 201 ||Test.isRunningTest()) { 
                    if(!Test.isRunningTest()){
                        responseResult = resResult.getBody(); 
                    }else{
                        responseResult = '{"contact":{"SubBuilding":"904","Premise":"1969","Street":"Upper Water St","City":"Halifax","Region":"NS","Postcode":"B3J 3R7","Country":"Canada","DatastoreDataset":"CAN","ACR":"L5-P6S5A0T6R5Z4C4-062","ValidationRule":"EL5-P4S4T4R4Z0C4-F","OuterMatchscore":"30","InnerMatchscore":"62","ExtendedACR":"L5-D0M0B0U4P6S5Q0X0A0T6E0R5W0Z4Y0C4-062","ValidationDataset":"CAN","EnhancementDatasets":"CANnvgeo","Latitude":"44.651764","Longitude":"-63.575372","AddressLine1":"904 - 1969 Upper Water St","AddressLine2":"Halifax NS B3J 3R7","AddressLine3":"Canada","CountryISO":"CAN"}}';
                    }   
                    restResponseTemplate recordJson = (restResponseTemplate) System.JSON.deserialize(responseResult, restResponseTemplate.class);                                     
                    String charsACR = recordJson.contact.ACR;
                    String[] charby = charsACR.split('');
                    String typeValidate = charby[0] + charby[1];
                    String typeValStr = charby[0];
                    Boolean updateResponse = False;
                    String levelString = charby[18] + charby[19] + charby[20];
                    Integer typeValInt = Integer.valueOf(charby[1]);
                    Integer level = Integer.valueOf(levelString);
                    if(leadCountry == 'US' && typeValStr == 'L' && typeValInt >= 5 && level >= 050)
                    {
                        updateResponse = True;
                        leadRecord.StateCode = (recordJson.contact.Region != 'Null' ? recordJson.contact.Region : '');
                    }
                    else if(leadCountry != 'US' && typeValStr == 'L' && typeValInt >= 2 && level >= 050)
                    {
                        leadRecord.StateCode = (recordJson.contact.Region != 'Null' ? recordJson.contact.Region : '');
                        updateResponse = True;
                    }
                    if(updateResponse == True)
                    {
                        leadRecord.Address_Accepted__c = True;
                        leadRecord.County__c = (recordJson.contact.ExtraCity != 'Null'  ? recordJson.contact.ExtraCity : '');
                        leadRecord.Street = (recordJson.contact.POBox != null ? recordJson.contact.POBox+tabStr : '') + (recordJson.contact.Building != null ? recordJson.contact.Building+', ' : '') +(recordJson.contact.Premise != null ? recordJson.contact.Premise : '') +tabStr+ (recordJson.contact.Street != null ? recordJson.contact.Street : '') + (recordJson.contact.SubStreet != null ? ', '+ recordJson.contact.SubStreet+tabStr : '') + (recordJson.contact.SubBuilding != null ? tabStr+recordJson.contact.SubBuilding: '');
                        leadRecord.City = (recordJson.contact.City != 'Null'  ? recordJson.contact.City : '');
                        leadRecord.Country = (recordJson.contact.Country != 'Null'  ? recordJson.contact.Country : '');                        
                        leadRecord.PostalCode = (recordJson.contact.Postcode != 'Null'  ? recordJson.contact.Postcode : '');                        
                        leadRecord.Trillium_Validated__c = True;
                    }else {
                        leadRecord.Address_Accepted__c = False; 
                        leadRecord.Trillium_Validated__c = False;
                    }
                } else {
                    // callout failed
                    outcomeMsg = 'Error: Callout failed. Please review the debug log for additional details.';
                    responseResult = 'CalloutError'; 
                    leadRecord.Address_Accepted__c = False; 
                    leadRecord.Trillium_Validated__c = False;
                }
            }catch (Exception e) {
                //throw new AuraHandledException('Server Callout Error');
                responseResult = 'CalloutError';                
                leadRecord.Address_Accepted__c = False; 
                leadRecord.Trillium_Validated__c = False;
            }       
        }
        if(leadRecord.User_Validated__c){
            leadRecord.Address_Accepted__c = True;
            leadRecord.Trillium_Validated__c = True;}
        return leadRecord;
    }
    global static Address__c getAddressRecordValidateAddress(Address__c addressRecord)  {        
        String targetString;
        if(!addressRecord.User_Validated__c){
            String responseResult;
            String outcomeMsg;            
            HttpRequest reqResult = new HttpRequest();
            HttpResponse resResult = new HttpResponse();
            String addressStreet;
            String addressCountry;
            String addressCity;
            String tabStr = ' ' ;
            addressStreet = (addressRecord.Billing_Street__c != null ? addressRecord.Billing_Street__c.replaceAll('\\#', '') : '');
            addressStreet = addressStreet.replaceAll('\\s','+');
            addressRecord.Billing_Zip_Postal_Code__c = (addressRecord.Billing_Zip_Postal_Code__c != null ? addressRecord.Billing_Zip_Postal_Code__c.replaceAll('\\s','+') : '');
         
            addressCountry = (addressRecord.Billing_Country__c != null ? addressRecord.Billing_Country__c.replaceAll('\\s','+') : '');
            addressCity = (addressRecord.Billing_City__c != null ? addressRecord.Billing_City__c.replaceAll('\\s','+') : '');
            //reqResult.setEndpoint('callout:Trillium'); 
            if(Test.isRunningTest()) {
                targetString = 'https://relx-test.trilliumedqcloud.com:443/gl/contacts/process?AddressLine2=State+Office+Complex&AddressLine1=400+W+Congress+St&EnhancementDataset=Geocode&AddressCasing=Country+Case&ValidateComponents.Company=true&ExhaustiveEnhancement=true&Region=Arizona&Postcode=85701-1352&City=Tucson&Country=US&MinMatchscore=0&AcceptanceLevel=-1';                 
            }else{
                targetString = 'callout:Trillium_Service'+System.Label.Endpoint_Sub_URL+'AddressLine1='+addressStreet+'&EnhancementDataset=Geocode&AddressCasing=Country+Case&ValidateComponents.Company=true&ExhaustiveEnhancement=true&Region=Arizona&Postcode='+addressRecord.Billing_Zip_Postal_Code__c+'&City='+addressCity+'&Country='+addressCountry+'&MinMatchscore=0&AcceptanceLevel=-1';
            }
            reqResult.setendpoint(targetString);
            reqResult.setMethod('GET');
            reqResult.setHeader('content-type', 'application/json');
            reqResult.setHeader('Accept', 'application/json');
            Http http = new Http();        
            try{                   
                if(!Test.isRunningTest()){
                    resResult = http.send(reqResult); 
                }else{
                    reqResult.setBody('{"contact":{"SubBuilding":"904","Premise":"1969","Street":"Upper Water St","City":"Halifax","Region":"NS","Postcode":"B3J 3R7","Country":"Canada","DatastoreDataset":"CAN","ACR":"L5-P6S5A0T6R5Z4C4-062","ValidationRule":"EL5-P4S4T4R4Z0C4-F","OuterMatchscore":"30","InnerMatchscore":"62","ExtendedACR":"L5-D0M0B0U4P6S5Q0X0A0T6E0R5W0Z4Y0C4-062","ValidationDataset":"CAN","EnhancementDatasets":"CANnvgeo","Latitude":"44.651764","Longitude":"-63.575372","AddressLine1":"904 - 1969 Upper Water St","AddressLine2":"Halifax NS B3J 3R7","AddressLine3":"Canada","CountryISO":"CAN"}}');
                }
                if (resResult.getStatusCode() == 200 || resResult.getStatusCode() == 201 ||Test.isRunningTest()) { 
                    if(!Test.isRunningTest()){
                        responseResult = resResult.getBody(); 
                    }else{
                        responseResult = '{"contact":{"SubBuilding":"904","Premise":"1969","Street":"Upper Water St","City":"Halifax","Region":"NS","Postcode":"B3J 3R7","Country":"Canada","DatastoreDataset":"CAN","ACR":"L5-P6S5A0T6R5Z4C4-062","ValidationRule":"EL5-P4S4T4R4Z0C4-F","OuterMatchscore":"30","InnerMatchscore":"62","ExtendedACR":"L5-D0M0B0U4P6S5Q0X0A0T6E0R5W0Z4Y0C4-062","ValidationDataset":"CAN","EnhancementDatasets":"CANnvgeo","Latitude":"44.651764","Longitude":"-63.575372","AddressLine1":"904 - 1969 Upper Water St","AddressLine2":"Halifax NS B3J 3R7","AddressLine3":"Canada","CountryISO":"CAN"}}';
                    } 
                    restResponseTemplate recordJson = (restResponseTemplate) System.JSON.deserialize(responseResult, restResponseTemplate.class);                 
                    
                    String charsACR = recordJson.contact.ACR;
                    String[] charby = charsACR.split('');
                    String typeValidate = charby[0] + charby[1];
                    String typeValStr = charby[0];
                    Boolean updateResponse = False;
                    String levelString = charby[18] + charby[19] + charby[20];
                    Integer typeValInt = Integer.valueOf(charby[1]);
                    Integer level = Integer.valueOf(levelString);
                    if(addressRecord.Billing_Country__c == 'United States' && typeValStr == 'L' && typeValInt >= 5 && level >= 50)
                    {
                        updateResponse = True;
                        State_Code_Settings__c myCS2 = State_Code_Settings__c.getInstance(recordJson.contact.Region);
                        addressRecord.Billing_State_Province__c = (myCS2.State__c != null ? myCS2.State__c : recordJson.contact.Region);
                    }
                    else if(addressRecord.Billing_Country__c != 'United States' && typeValStr == 'L' && typeValInt >= 2 && level >= 50)
                    {
                        addressRecord.Billing_State_Code__c = (recordJson.contact.Region != 'Null' ? recordJson.contact.Region : '');
                        updateResponse = True;
                        State_Code_Settings__c myCS2 = State_Code_Settings__c.getInstance(recordJson.contact.Region);
                        addressRecord.Billing_State_Province__c = (myCS2.State__c != null ? myCS2.State__c : recordJson.contact.Region);
                    }
                    if(updateResponse == True)
                    {
                        addressRecord.Address_Accepted__c = True;
                        addressRecord.County__c = (recordJson.contact.ExtraCity != 'Null'  ? recordJson.contact.ExtraCity : '');
                        addressRecord.Billing_Street__c = (recordJson.contact.POBox != null ? recordJson.contact.POBox+tabStr : '') + (recordJson.contact.Building != null ? recordJson.contact.Building+', ' : '') +(recordJson.contact.Premise != null ? recordJson.contact.Premise : '') +tabStr+ (recordJson.contact.Street != null ? recordJson.contact.Street : '') + (recordJson.contact.SubStreet != null ? ', '+ recordJson.contact.SubStreet+tabStr : '') + (recordJson.contact.SubBuilding != null ? tabStr+recordJson.contact.SubBuilding: '');
                        addressRecord.Billing_City__c = (recordJson.contact.City != 'Null'  ? recordJson.contact.City : '');                        
                        addressRecord.Billing_Country__c = (recordJson.contact.Country != 'Null'  ? recordJson.contact.Country : '');
                        addressRecord.Billing_Zip_Postal_Code__c = (recordJson.contact.Postcode != 'Null'  ? recordJson.contact.Postcode : '');                        
                        addressRecord.Trillium_Validated__c = True;
                        
                    }else {
                        addressRecord.Address_Accepted__c = False; 
                        addressRecord.Trillium_Validated__c = False;
                        
                    }
                } else {
                    // callout failed
                    outcomeMsg = 'Error: Callout failed. Please review the debug log for additional details.';
                    responseResult = 'CalloutError'; 
                    addressRecord.Address_Accepted__c = False; 
                    addressRecord.Trillium_Validated__c = False;
                    
                }
            }catch (Exception e) {
                //throw new AuraHandledException('Server Callout Error');
                responseResult = 'CalloutError';                        
                addressRecord.Address_Accepted__c = False; 
                addressRecord.Trillium_Validated__c = False;
                
            }                  
        }
        if(addressRecord.User_Validated__c){
            
            addressRecord.Address_Accepted__c = True;
            addressRecord.Trillium_Validated__c = True;}
        return addressRecord;
    }
    public class restResponseTemplate{
        public fromJSON contact;
        
        /*public static fromJSON parse(String json){
return (fromJSON) System.JSON.deserialize(json, fromJSON.class);
}*/       
    }
    public class fromJSON{
        public String Building;
        public String SubBuilding;
        public String Premise;  //9443
        public String Street;   //Springboro Pike
        public String SubStreet; 
        Public String POBox;
        public String City; //Miamisburg
        public String Region;   //OH
        public String Postcode; //45342
        public String Country;  //United States
        public String ExtraCity;    //Montgomery
        public String DatastoreDataset; //USA
        public String ACR;  //L5-P4S5A0T4R5Z4C4-081
        public String ValidationRule;   //EL5-P4S4T4R4Z4C4-F
        public String OuterMatchscore;  //2
        public String InnerMatchscore;  //81
        public String ExtendedACR;  //L5-D0M0B0U0P4S5Q0X0A0T4E6R5W0Z4Y0C4-081
        public String ValidationDataset;    //USA
        public String EnhancementDatasets;  //USAtatr3geo
        public String Latitude; //39.613758
        public String Longitude;    //-84.230427
        public String AddressLine1; //9443 Springboro Pike
        public String AddressLine2; //Miamisburg OH 45342
        public String AddressLine3; //United States
        public String CountryISO;   //USA
    }
}