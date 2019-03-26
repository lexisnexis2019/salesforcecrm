/*
Class Name  : AddressCreationforAccountTriggerHandler
Description : This class is taking care of the functionalities : Assigning Admin Owner as owner of the account, if new address created
              making it primary after confirming no existing address on the Address object.  And if updated address available in address object
              then making it primary and previous primary address to non-primary.
Author      : Madhavi Valavala
*/
public with sharing class AddressCreationforAccountTriggerHandler {
    /*******************************************************************************************************
    * @description This method is doing functionality of assigning admin owner as account record owner.
    * @param It takes list of new account records as a parameter.
    * @return This method does not returns anything.  Return type is void.    
    */
    public static void onBeforeInsertAccount(List<Account> listofnewAccounts)
    {   
        Profile prof = [Select Name from Profile where Id =: userinfo.getProfileid()];
        List<Account> updateAccounts = new List<Account>();
        if(prof.name != 'Integration User')
        {
            for(Account acc : listofnewAccounts)
            {
                acc.OwnerId = System.Label.Admin_Owner; 
            }   
        }
    }
    /*******************************************************************************************************
    * @description This method is doing functionality of updating or creating primary address.
    * @param It takes list of newly updated accounts and old accounts and flag (Insert or Update) as parameters.
    * @return This method does not returns anything.  Return type is void.    
    */
    public static void onBeforeUpdateAccount(List<Account> listofnewAccounts, List<Account> listofoldAccounts, String flag)
    {
        Set<String> newBillingStreet = new Set<String>();
        Set<String> newBillingCity = new Set<String>();
        Set<String> newBillingState = new Set<String>();
        Set<String> newBillingCountry = new Set<String>();
        Set<String> newBillingPostalCode = new Set<String>();
        Set<String> newAddressLine1 = new Set<String>();
        Set<String> newAddressLine2 = new Set<String>();
        Set<String> newPOBPGUID = new Set<String>();
        Set<Id> parentAccount = new Set<Id>();
        Set<Id> newNonPrimary = new Set<Id>();
        Boolean addressChanged = False;
        Boolean phoneChanged = False;
        for(Account acc : listofoldAccounts)
        {
            if(acc.Primary_Address__c != null)
            {
                newNonPrimary.add(acc.Primary_Address__c);                
            }            
        }
        for(Account acc : listofnewAccounts)
        {
            for(Account oldacc : listofoldAccounts)
            {
                if(acc.Id == oldacc.Id && oldacc.POBPGUID__c != acc.POBPGUID__c)
                {
                    addressChanged = True;
                    newPOBPGUID.add(acc.POBPGUID__c);
                    parentAccount.add(acc.Id);
                }
                if((acc.Id == oldacc.Id && oldacc.POBPGUID__c == acc.POBPGUID__c) && oldacc.Phone != acc.Phone)
                {
                    phoneChanged = True;
                    newPOBPGUID.add(acc.POBPGUID__c);
                    parentAccount.add(acc.Id);
                }
            }            
        }
        if(addressChanged)
        {
            // Fetch if the newly updated address is already exists
            List<Address__c> listexistAddress = new List<Address__c>();
            listexistAddress = [SELECT Id, Name, Account__c, Address_Line_1_ECM__c, Address_Line_2_ECM__c, AddressPGUID__c, Billing_Street__c,
                                Billing_City__c, Billing_State_Province__c, Billing_Country__c, Billing_Zip_Postal_Code__c, Primary__c,
                                OCPGUID__c, PhonePOB__c, POBPGUID__c, User_Validated__c FROM Address__c WHERE POBPGUID__c IN: newPOBPGUID
                                AND Account__c IN: parentAccount];
            
            List<Address__c> listnewNonPrimary = new List<Address__c>();
            listnewNonPrimary = [SELECT ID, Primary__c, Account__c, POBPGUID__c From Address__c Where POBPGUID__c NOT IN: newPOBPGUID
                                 AND Account__c IN: parentAccount];
            
            List<Account> accToUpdate = new List<Account>();
            List<Address__c> addToUpdate = new List<Address__c>();
            if(listexistAddress != null && listexistAddress.size() >0)
            {
                //  yes, address already existing
                for(Address__c addRec : listexistAddress)           
                {
                    for(Account accRec : listofnewAccounts)
                    {
                        if(accRec.POBPGUID__c == addRec.POBPGUID__c && accRec.Primary_Address__c != addRec.Id){
                            addRec.Primary__c = True;
                            accRec.Phone = (addRec.PhonePOB__c != null ? addRec.PhonePOB__c : '');
                            addRec.County__c = (accRec.County__c != null ? accRec.County__c : '');
                            accRec.Primary_Address__c = (addRec.Id != null ? addRec.Id : '');
                            accRec.BillingStreet = (addRec.Billing_Street__c != null ? addRec.Billing_Street__c : '');
                            accRec.BillingCity = (addRec.Billing_City__c != null ? addRec.Billing_City__c : '');
                            accRec.BillingState = (addRec.Billing_State_Province__c != null ? addRec.Billing_State_Province__c : '');
                            accRec.BillingCountry = (addRec.Billing_Country__c != null ? addRec.Billing_Country__c : '');
                            accRec.BillingPostalCode = (addRec.Billing_Zip_Postal_Code__c != null ? addRec.Billing_Zip_Postal_Code__c : ''); 
                            accRec.User_Validated__c = addRec.User_Validated__c;                                       
                            accToUpdate.add(accRec);
                            addToUpdate.add(addRec);
                        }
                    }                
                }
                
                if(listnewNonPrimary != null && listnewNonPrimary.size() >0)
                {
                    for(Address__c addRec : listnewNonPrimary)
                    {
                        addRec.Primary__c = False;
                        addToUpdate.add(addRec);
                    }    
                }
                if(addToUpdate != null && addToUpdate.size() >0)
                {
                    Update addToUpdate;
                }
            }else if(listexistAddress.isEmpty())
            {
                List<Address__c> listAddresses = new List<Address__c>();
                for(Account acc : listofnewAccounts)
                {
                    if(acc.POBPGUID__c != null)
                    {
                        Address__c addressRecord = new Address__c();                     
                        addressRecord.Account__c = acc.Id;                    
                        addressRecord.POBPGUID__c = acc.POBPGUID__c;
                        addressRecord.OCPGUID__c = acc.OCPGUID__c;
                        addressRecord.PhonePOB__c = (acc.Phone != null ? acc.Phone : '');
                        addressRecord.Address_Line_1_ECM__c = acc.Address_Line_1__c;
                        addressRecord.Address_Line_2_ECM__c = acc.Address_Line_2__c;
                        addressRecord.Billing_Street__c = acc.BillingStreet;
                        addressRecord.Billing_City__c = acc.BillingCity;
                        addressRecord.Billing_State_Province__c = acc.BillingState;
                        addressRecord.Billing_Country__c = acc.BillingCountry;
                        addressRecord.Billing_Zip_Postal_Code__c = acc.BillingPostalCode;
                        addressRecord.County__c = acc.County__c;
                        addressRecord.User_Validated__c = acc.User_Validated__c;
                        addressRecord.Primary__c = True;                        
                        listAddresses.add(addressRecord);
                    }
                }
                Insert listAddresses;
                
                for(Account acc : [SELECT Id, POBPGUID__c, Primary_Address__c From Account Where POBPGUID__c IN: newPOBPGUID])
                {
                    for(Address__c add : [SELECT Id, Primary__c, Account__c, POBPGUID__c From Address__c Where POBPGUID__c IN: newPOBPGUID AND Primary__c = True])
                    {
                        if(acc.Id == add.Account__c)
                        {
                            acc.Primary_Address__c = add.id;
                        }     
                    }                    
                }            
            }
        }
        if(phoneChanged)
        {
            List<Address__c> listPrimaryAddresses = new List<Address__c>();
            List<Address__c> listaddresstobeUpdated = new List<Address__c>();
            listPrimaryAddresses = [SELECT Id, Account__c, PhonePOB__c, POBPGUID__c, Primary__c From Address__c Where 
                                    Account__c IN: parentAccount AND POBPGUID__c IN: newPOBPGUID];
            for(Address__c add : listPrimaryAddresses)
            {
                for(Account acc : listofnewAccounts)
                {
                    if(add.PhonePOB__c != acc.Phone)
                    {
                        add.PhonePOB__c = acc.Phone;
                    }
                }
                listaddresstobeUpdated.add(add);
            }
            update listaddresstobeUpdated;
        }
    }
    /*******************************************************************************************************
    * @description This method is doing functionality of updating or creating primary address.
    * @param It takes list of newly inserted accounts and old accounts as parameters.
    * @return This method does not returns anything.  Return type is void.    
    */
    public static void onAfterInsertAccount(List<Account> listofnewAccounts, List<Account> listofoldAccounts, String flag)
    {
        Set<String> newBillingStreet = new Set<String>();
        Set<String> newBillingCity = new Set<String>();
        Set<String> newBillingState = new Set<String>();
        Set<String> newBillingCountry = new Set<String>();
        Set<String> newBillingPostalCode = new Set<String>();
        Set<String> newAddressLine1 = new Set<String>();
        Set<String> newAddressLine2 = new Set<String>();
        Set<String> newPOBPGUID = new Set<String>();
        Set<Id> parentAccount = new Set<Id>();
        Set<Id> newNonPrimary = new Set<Id>();
        List<AccountTeamMember> listAccTeaMembers = new List<AccountTeamMember>();
        Boolean addressChanged = False;
        
        Profile prof = [Select Name from Profile where Id =: userinfo.getProfileId()];
        User u = [select Id, username, UserRole.Name from User where Id = :UserInfo.getUserId()];
            
            for(Account acc : listofnewAccounts)
            {
                if(acc.POBPGUID__c != null)
                    {
                        //addressChanged = True;
                        newPOBPGUID.add(acc.POBPGUID__c);
                        parentAccount.add(acc.Id);               
                    }      
                if(prof.Name != 'Integration User')
                {
                 AccountTeamMember newMember = new AccountTeamMember();
                 newMember.AccountId = acc.Id;
                 newMember.UserId = u.Id;
                 newMember.TeamMemberRole = u.UserRole.Name; 
                 listAccTeaMembers.add(newMember);
                }
            }
            if(listAccTeaMembers.size() > 0 && listAccTeaMembers != null)
            {
                Insert listAccTeaMembers;
            }
        
        // Fetch if the newly updated address is already exists
        List<Address__c> listexistAddress = new List<Address__c>();
        listexistAddress = [SELECT Id, Name, Account__c, Address_Line_1_ECM__c, Address_Line_2_ECM__c, AddressPGUID__c, Billing_Street__c,
                            Billing_City__c, Billing_State_Province__c, Billing_Country__c, Billing_Zip_Postal_Code__c, Primary__c,
                            OCPGUID__c, POBPGUID__c FROM Address__c WHERE POBPGUID__c IN: newPOBPGUID
                            AND Account__c IN: parentAccount];
        
        List<Address__c> listnewNonPrimary = new List<Address__c>();
        listnewNonPrimary = [SELECT ID, Primary__c, Account__c, POBPGUID__c From Address__c Where POBPGUID__c NOT IN: newPOBPGUID
                             AND Account__c IN: parentAccount];
        
        List<Account> accToUpdate = new List<Account>();
        List<Address__c> addToUpdate = new List<Address__c>();
        if(listexistAddress != null && listexistAddress.size() >0)
        {
            //  yes, address already existing
            for(Address__c addRec : listexistAddress)           
            {
                for(Account accRec : listofnewAccounts)
                {
                    if(accRec.POBPGUID__c == addRec.POBPGUID__c){
                    addRec.Primary__c = True;
                    addRec.PhonePOB__c = (accRec.Phone != null ? accRec.Phone : ' ');
                    addRec.County__c = accRec.County__c;
                    accRec.Primary_Address__c = addRec.Id;
                    accRec.OCPGUID__c = addRec.OCPGUID__c;
                    accRec.BillingStreet = addRec.Billing_Street__c;
                    accRec.BillingCity = addRec.Billing_City__c;
                    accRec.BillingStateCode = addRec.Billing_State_Code__c;
                    accRec.BillingState = addRec.Billing_State_Province__c;
                    accRec.BillingCountry = addRec.Billing_Country__c;
                    accRec.BillingPostalCode = addRec.Billing_Zip_Postal_Code__c;
                    accRec.User_Validated__c = addRec.User_Validated__c;
                    accToUpdate.add(accRec);
                    addToUpdate.add(addRec);
                    }
                }                
            }
            
            if(listnewNonPrimary != null && listnewNonPrimary.size() >0)
            {
                for(Address__c addRec : listnewNonPrimary)
                {
                    addRec.Primary__c = False;
                    addToUpdate.add(addRec);
                }    
            }
            if(addToUpdate != null && addToUpdate.size() >0)
            {
                Update addToUpdate;
            }
        }else if(listexistAddress.isEmpty())
        {
            List<Address__c> listAddresses = new List<Address__c>();
            for(Account acc : listofnewAccounts)
            {
                if(acc.POBPGUID__c != null)
                {
                    Address__c addressRecord = new Address__c();                     
                    addressRecord.Account__c = acc.Id;                    
                    addressRecord.POBPGUID__c = acc.POBPGUID__c;
                    addressRecord.OCPGUID__c = acc.OCPGUID__c;
                    addressRecord.PhonePOB__c = (acc.Phone != null ? acc.Phone : '');
                    addressRecord.Address_Line_1_ECM__c = acc.Address_Line_1__c;
                    addressRecord.Address_Line_2_ECM__c = acc.Address_Line_2__c;
                    addressRecord.Billing_Street__c = acc.BillingStreet;
                    addressRecord.Billing_City__c = acc.BillingCity;
                    addressRecord.Billing_State_Province__c = acc.BillingState;
                    addressRecord.Billing_Country__c = acc.BillingCountry;
                    addressRecord.Billing_Zip_Postal_Code__c = acc.BillingPostalCode;
                    addressRecord.County__c = acc.County__c;
                    addressRecord.User_Validated__c = acc.User_Validated__c;
                    addressRecord.Primary__c = True;
                    listAddresses.add(addressRecord);
                }
            }
            Insert listAddresses;
            
            for(Account acc : [SELECT Id, POBPGUID__c, Primary_Address__c From Account Where POBPGUID__c IN: newPOBPGUID])
                {
                    for(Address__c add : [SELECT Id, Primary__c, Account__c, POBPGUID__c From Address__c Where POBPGUID__c IN: newPOBPGUID AND Primary__c = True])
                    {
                        if(acc.Id == add.Account__c)
                        {
                            acc.Primary_Address__c = add.id;
                        }     
                    }                    
               }            
        }
    }
    public static void onBeforeUpdateLock(List<Account> listofnewAccounts)
    {
        Set<Id> setAccIds = new Set<Id>();
        Boolean accLocked;
        Map<String, Id> mapRecIds = new Map<String, Id>();

        for(RecordType rcType : [SELECT Id, DeveloperName From RecordType ])
        {
                if(rcType.DeveloperName == 'Account_Locked')
                {
                   mapRecIds.put(rcType.DeveloperName, rcType.Id);
                 }

                if(rcType.DeveloperName == 'Account')
                {
                   mapRecIds.put(rcType.DeveloperName, rcType.Id);
                 }
        }
       
        for(Account acc : listofnewAccounts)
        {
            if(acc.OC_Repair_Flag__c == 'Y')
            {
                acc.RecordTypeId = mapRecIds.get('Account_Locked');
                accLocked = True;             
            }else if(acc.OC_Repair_Flag__c == 'N')
            {
                acc.RecordTypeId = mapRecIds.get('Account');
                accLocked = False;
            }
        } 
    }    
}