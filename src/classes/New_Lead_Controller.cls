public class New_Lead_Controller {
    public Lead lead{get; set;}
    Public string selectedReason{get;set;}  //SelectOption   
    Public Boolean showField {get;set;}
    
    public New_Lead_Controller(ApexPages.StandardController stdController) {
        this.lead = (Lead)stdController.getRecord();
    }
    
    public List<SelectOption> getRejectedReasonOptions() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('None','--None--'));
        Schema.DescribeFieldResult fieldResult = Schema.Lead.Lead_Reject_Reason__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry p : ple)
        options.add(new SelectOption(p.getValue(), p.getValue()));        
        return options;
    }
    
    public PageReference save(){
        Lead leadRecord = new Lead();
        PageReference pageRef;
        lead.Lead_Reject_Reason__c = selectedReason;
        leadRecord = RESTService_AddressValidation.getLeadValidateAddress(lead);
        try{
            if(leadRecord !=  null && leadRecord.Id != null)
            {
                Upsert leadRecord;  
                pageRef = new PageReference('/' + leadRecord.Id);
                pageRef.setRedirect(true);
            }else
            {
                Insert leadRecord;                
                pageRef = new PageReference('/' + leadRecord.Id);
                pageRef.setRedirect(true);
            }
        }catch (Exception ex)
        {
            ApexPages.addMessages(ex);                                  
            showField = True;
        }
        return pageRef;
    }
    
    public PageReference cancel()
    {
        PageReference pageRef = new PageReference('/00Q/o');
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference save_new(){
        Lead leadRecord = new Lead();
        lead.Lead_Reject_Reason__c = selectedReason;
        leadRecord = RESTService_AddressValidation.getLeadValidateAddress(lead);
        try{
            if(leadRecord !=  null && leadRecord.Id != null)
            {
                Upsert leadRecord;  
            }else
            {
                Insert leadRecord;         
            }
        }catch (Exception ex)
        {
            ApexPages.addMessages(ex);
        }
        PageReference pg = new PageReference('/apex/New_Lead_VF');
        pg.setRedirect(true);
        return pg;
    }
}