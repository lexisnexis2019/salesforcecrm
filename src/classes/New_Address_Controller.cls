/*
Class Name  : New_Address_Controller
Description : This class is controller class for New_Address_VF
Author      : Madhavi Valavala
*/
public class New_Address_Controller {
    public Address__c address{get; set;}
    //Public Address__c selectedCountry{get;set;}    
    //Public string selectedState{get;set;}    
    Public Boolean showField {get;set;}
    Public Boolean showOutputAddress {get;set;}
    Public Boolean showInputAddress {get;set;}
    Public Boolean showOutputCity {get;set;}
    Public Boolean showInputCity {get;set;}
    Public Boolean showOutputState {get;set;}
    Public Boolean showInputState {get;set;}
    Public Boolean showOutputEndDate {get;set;}
    Public Boolean showInputEndDate {get;set;}
    Public Boolean showOutputCountry {get;set;}
    Public Boolean showInputCountry {get;set;}
    Public Boolean showOutputZipcode {get;set;}
    Public Boolean showInputZipcode {get;set;}
    Public Boolean showInputAccountName {get;set;}
    Public Boolean showOutputAccountName {get;set;}
    Public Boolean showInputCounty {get;set;}
    Public Boolean showOutputCounty {get;set;}
    Public Boolean showInputPhone {get;set;}
    Public Boolean showOutputPhone {get;set;}
    Public Boolean showOutputPrimary {get;set;}
    Public Boolean showInputPrimary {get;set;}
    /*******************************************************************************************************
    * @description This is constructor which controls fields visibility during visualforce page load.  Example: Account Name.
    *               
    */
    public New_Address_Controller(ApexPages.StandardController stdController) {
        this.address = (Address__c)stdController.getRecord();
        System.debug('address'+address);
        System.debug('address'+address.POBPGUID__c);
        if(address.Id != null && address.Primary__c == True && address.POBPGUID__c != null)
        {
            showOutputAddress = True;
            showInputAddress = False;
            showOutputCity = True;
            showInputCity = False;
            showOutputState = True;
            showInputState = False;
            showOutputCountry = True;            
            showInputCountry = False;
            showOutputZipcode = True;
            showInputZipcode = False;
            showOutputAccountName = True;
            showInputAccountName = False;
            showOutputCounty = True;
            showInputCounty = False;
            showOutputEndDate = True;
            showInputEndDate = False;
            showInputPhone = True;
            showOutputPhone  = False;
            showOutputPrimary = True;
            showInputPrimary = False;
        }
        else if(address.Id != null && address.Primary__c != True && address.POBPGUID__c != null && address.End_Date__c == null)
        {
            System.debug('address.Primary__c'+address.Primary__c);
            showOutputAddress = True;
            showInputAddress = False;
            showOutputCity = True;
            showInputCity = False;
            showOutputState = True;
            showInputState = False;
            showOutputCountry = True;            
            showInputCountry = False;
            showOutputZipcode = True;
            showInputZipcode = False;
            showOutputAccountName = True;
            showInputAccountName = False;
            showOutputCounty = True;
            showInputCounty = False;
            showOutputEndDate = False;
            showInputEndDate = True;
            showInputPhone = True;
            showOutputPhone  = False;
            showOutputPrimary = False;
            showInputPrimary = True;
        }
        else if(address.Id != null && address.Primary__c != True && address.POBPGUID__c != null && address.End_Date__c != null)
        {
            System.debug('address.Primary__c'+address.Primary__c);
            showOutputAddress = True;
            showInputAddress = False;
            showOutputCity = True;
            showInputCity = False;
            showOutputState = True;
            showInputState = False;
            showOutputCountry = True;            
            showInputCountry = False;
            showOutputZipcode = True;
            showInputZipcode = False;
            showOutputAccountName = True;
            showInputAccountName = False;
            showOutputCounty = True;
            showInputCounty = False;
            showOutputEndDate = True;
            showInputEndDate = False;
            showInputPhone = False;
            showOutputPhone  = True;
            showOutputPrimary = True;
            showInputPrimary = False;
        }
        else
        {
            System.debug('address.Primary__c'+address.Primary__c);
            showOutputAddress = False;
            showInputAddress = True;
            showOutputCity = False;
            showInputCity = True;
            showOutputState = False;
            showInputState = True;
            showOutputCountry = False;
            showInputCountry = True;            
            showOutputZipcode = False;
            showInputZipcode = True;
            showOutputAccountName = False;
            showInputAccountName = True;
            showOutputCounty = False;
            showInputCounty = True;
            showOutputEndDate = False;
            showInputEndDate = False;
            showInputPhone = True;
            showOutputPhone  = False;            
            address.Billing_Country__c = 'United States';
        }        
    }
     /*******************************************************************************************************
    * @description This is getCountries method which retrives the countries list to be populated in the country picklist on the visualforce page..    
    * @param It does not take any parameters.
    * @return This return type is List<SelectOption>.
    */
    public List<SelectOption> getCountries() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('None','--None--'));
        Schema.DescribeFieldResult fieldResult = Schema.Address__c.Billing_Country__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry p : ple)
        options.add(new SelectOption(p.getValue(), p.getValue()));        
        return options;
    }
    
    /*******************************************************************************************************
    * @description This is getStates method which retrives the countries list to be populated in the state picklist on the visualforce page..    
    * @param It does not take any parameters.
    * @return This return type is List<SelectOption>.
    */
    public List<SelectOption> getStates() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('None','--None--'));
        Schema.DescribeFieldResult fieldResult = Schema.Address__c.Billing_State_Province__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry p : ple)
        options.add(new SelectOption(p.getValue(), p.getValue()));        
        return options;
    }
    
     /*******************************************************************************************************
    * @description This is save method which take cares of updates usings visualforce page which gets saved.    
    * @param It does not take any parameters.
    * @return This return type is Page Reference.
    */
    public PageReference save(){
        Address__c addressRecord = new Address__c();
        PageReference pageRef;        
        try{
            if(address !=  null && address.Id != null)
            {                
                address.Is_Create__c = False;
                Upsert address;  
                pageRef = new PageReference('/' + address.Id);
                pageRef.setRedirect(true);
            }else if(address != null && address.Id == null)
            {
                addressRecord = RESTService_AddressValidation.getAddressRecordValidateAddress(address);
                addressRecord.Is_Create__c = True;
                Insert addressRecord;                
                pageRef = new PageReference('/' + addressRecord.Id);
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
        PageReference pageRef = new PageReference('/a00/o');
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    /*******************************************************************************************************
    * @description This is save_new method which saves the updates on the visualforce page and redirects to create page.    
    * @param It does not take any parameters.
    * @return This return type is Page Reference.
    */
    public PageReference save_new(){
        Address__c addressRecord = new Address__c();
        addressRecord = RESTService_AddressValidation.getAddressRecordValidateAddress(address);
        try{
            if(addressRecord !=  null && addressRecord.Id != null)
            {
                Upsert addressRecord;  
            }else
            {
                Insert addressRecord;         
            }
        }catch (Exception ex)
        {
            ApexPages.addMessages(ex);
        }
        PageReference pg = new PageReference('/apex/New_Address_VF');
        pg.setRedirect(true);
        return pg;
    }
}