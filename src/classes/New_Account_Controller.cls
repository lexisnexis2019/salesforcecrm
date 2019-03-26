/*
Class Name  : New_Account_Controller
Description : This class is controller class for New_Account_VF
Author      : Madhavi Valavala
*/
public with sharing class New_Account_Controller {
    public Account account{get; set;}
    Public string selectedname{get;set;}    
    Public Boolean showField {get;set;}
    Public Boolean showOutputAccountName {get;set;}
    Public Boolean showInputAccountName {get;set;}
    Public Boolean showOutputAttorney {get;set;}
    Public Boolean showInputAttorney {get;set;}
    Public Boolean showOutputCustomerClass {get;set;}
    Public Boolean showInputCustomerClass {get;set;}
    Public Boolean showInputBillingStreet {get;set;}
    Public Boolean showOutputBillingStreet {get;set;}   
    Public Boolean showInputBillingCity {get;set;}
    Public Boolean showOutputBillingCity {get;set;} 
    Public Boolean showInputBillingState {get;set;}
    Public Boolean showOutputBillingState {get;set;}
    Public Boolean showInputBillingCounty {get;set;}
    Public Boolean showOutputBillingCounty {get;set;}
    Public Boolean showInputBillingCountry {get;set;}
    Public Boolean showOutputBillingCountry {get;set;}
    Public Boolean showInputBillingZipCode {get;set;}
    Public Boolean showOutputBillingZipCode {get;set;}
    Public Boolean showOutputPhone {get;set;}
    Public Boolean showInputPhone {get;set;}
    /*******************************************************************************************************
    * @description This is constructor which controls fields visibility during visualforce page load.  Example: Account Name.
    *               
    */
    public New_Account_Controller(ApexPages.StandardController stdController) {
        this.account = (Account)stdController.getRecord();
        if(account.Id != null && account.Account_Status__c == 'TargetedProspect')
        {
            showOutputAccountName = False;
            showInputAccountName = True;
            showOutputAttorney = False;
            showInputAttorney = True;
            showOutputCustomerClass = False;
            showInputCustomerClass = True;            
            showInputBillingStreet = False;
            showOutputBillingStreet = True;
            showInputBillingState = False;
            showOutputBillingState = True;
            showInputBillingCity = False;
            showOutputBillingcity = True;
            showInputBillingCounty = False;
            showOutputBillingCounty = True;
            showInputBillingCountry = False;
            showOutputBillingCountry = True;
            showOutputPhone = True;
            showInputPhone = False;
            showInputBillingZipCode = False;
            showOutputBillingZipCode = True;
        }else if(account.Id != null && account.Account_Status__c != 'TargetedProspect')
                 {
                     showOutputAccountName = True;
                     showInputAccountName = False;
                     showOutputAttorney = True;
                     showInputAttorney = False;
                     showOutputCustomerClass = True;
                     showInputCustomerClass = False;                                
                     showInputBillingStreet = False;
                     showOutputBillingStreet = True;
                     showInputBillingState = False;
                     showOutputBillingState = True;
                     showInputBillingCity = False;
                     showOutputBillingcity = True;
                     showInputBillingCounty = False;
                     showOutputBillingCounty = True;
                     showInputBillingCountry = False;
                     showOutputBillingCountry = True;
                     showInputBillingZipCode = False;
                     showOutputBillingZipCode = True;
                     showOutputPhone = True;
                     showInputPhone = False;
                 }
        if(account.Id == null){
            showOutputAccountName = False;
            showInputAccountName = True;
            showOutputAttorney = False;
            showInputAttorney = True;
            showOutputCustomerClass = False;
            showInputCustomerClass = True;
            showInputBillingStreet = True;
            showOutputBillingStreet = False;
            showInputBillingState = True;
            showOutputBillingState = False;
            showInputBillingCity = True;
            showOutputBillingcity = False;
            showInputBillingCounty = True;
            showOutputBillingCounty = False;
            showInputBillingCountry = True;
            showOutputBillingCountry = False;
            showInputBillingZipCode = True;
            showOutputBillingzipCode = False;
            showOutputPhone = False;
            showInputPhone = True;
       }
    }
    /*******************************************************************************************************
    * @description This is save method which take cares of updates usings visualforce page which gets saved.    
    * @param It does not take any parameters.
    * @return This return type is Page Reference.
    */
    public PageReference save(){
        Account accountRecord = new Account();
        PageReference pageRef;        
        try{
            if(account !=  null && account.Id != null)
            {
                account.Is_Create__c = False;
                Upsert account;  
                pageRef = new PageReference('/' + account.Id);
                pageRef.setRedirect(true);
            }else if(account != null && account.Id == null)
            {
                accountRecord = RESTService_AddressValidation.getAccountValidateAddress(account);
                accountRecord.Is_Create__c = True;
                Insert accountRecord; 
                
                pageRef = new PageReference('/' + accountRecord.Id);
                pageRef.setRedirect(true);
            }
        }catch (Exception ex)
        {
            ApexPages.addMessages(ex);                                  
            showField = True;
        }
        return pageRef;
    }
    
    /*******************************************************************************************************
    * @description This is cancel method which cancels and goes back to the list view page.    
    * @param It does not take any parameters.
    * @return This return type is Page Reference.
    */    
    public PageReference cancel()
    {
        PageReference pageRef = new PageReference('/001/o');
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    /*******************************************************************************************************
    * @description This is save_new method which saves the updates on the visualforce page and redirects to create page.    
    * @param It does not take any parameters.
    * @return This return type is Page Reference.
    */
    public PageReference save_new(){
        Account accountRecord = new Account();
        accountRecord = RESTService_AddressValidation.getAccountValidateAddress(account);
        try{
            if(accountRecord !=  null && accountRecord.Id != null)
            {
                Upsert accountRecord;  
            }else
            {
                Insert accountRecord;         
            }
        }catch (Exception ex)
        {
            ApexPages.addMessages(ex);
        }
        PageReference pg = new PageReference('/apex/New_Account_VF');
        pg.setRedirect(true);
        return pg;
    }
}