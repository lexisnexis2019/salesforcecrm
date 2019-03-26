public class AddToCampaign_Controller {
    public String campaignName{get;set;}
    public Id CampaignId{get;set;}
    public String listHeader {get;set;}
    public String ParentRecordId {get;set;}
    public List<Campaign> campaignList{get;set;}
    public Campaign campaignRec {get;set;}
    public String campListMsg {get;set;}
    
   public AddToCampaign_Controller(ApexPages.StandardController stdController) {
        this.campaignRec = (Campaign)stdController.getRecord();
       	campaignList = [SELECT Id, Name, Marketing_Level__c, Owner.Name, Type, Mkt_Level_Code__c, StartDate, EndDate FROM Campaign Where Marketing_Level__c = 'Campaign' AND IsActive = True Order By Name Limit 20];
        listHeader = 'Campaigns List';
       	campListMsg = System.Label.Add_To_Campaign_List_Message;
    }
    
    public void callLookup(){
        if(!String.isBlank(CampaignName))
        {
        	campaignList = [SELECT Id, Name, Marketing_Level__c, Owner.Name, Type, Mkt_Level_Code__c, StartDate, EndDate FROM Campaign Where Marketing_Level__c = 'Campaign' AND IsActive = True AND Name LIKE :('%'+ CampaignName +'%') Order By Name ASC];        	                   
        }else
        {
            campaignList = [SELECT Id, Name, Marketing_Level__c, Owner.Name, Type, Mkt_Level_Code__c, startDate, EndDate FROM Campaign Where Marketing_Level__c = 'Campaign' AND IsActive = True Order By Name Limit 20];
        }
        listHeader = 'Search Results';
        campListMsg = System.Label.Add_To_Campaign_Result_Message;
    }
    
    public PageReference goAddCampaign(){
        PageReference toCampMem = new PageReference('/00v/e?c_id='+CampaignId+'&parent_id='+ParentRecordId+'&retURL=%2F'+ParentRecordId);
        toCampMem.setRedirect(false);
        return toCampMem;
    }
}