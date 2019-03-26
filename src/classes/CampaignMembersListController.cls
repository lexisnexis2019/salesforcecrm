Public class CampaignMembersListController {
 Public List<Contact> conlst {get;set;}
 Public List<Lead> leadlst {get;set;}
 Public String contactId {get; set;}
 Public Static Set<ID> setConvLead = new Set<ID>();
 Public String userId = UserInfo.getUserID();
 
 Private integer counter=0;  //keeps track of the offset
 Private integer redCounter = 0;
 Private integer list_size=15; //sets the page size or number of rows
 Public integer total_size; //used to show user the total size of the list
 
    Public CampaignMembersListController () { 
        // Below lines changes made by Madhavi
        for(Lead leadRecord : [SELECT Id, Name, OwnerID, IsConverted From Lead Where OwnerId = :userId AND IsConverted = True Limit 30000])
        {
            setConvLead.add(leadRecord.Id);
        }
        total_size =[select count() FROM CampaignMember where LeadOrContactOwnerid =:userId AND LeadId NOT IN: setConvLead Limit 20000]; //set the total size in the constructor   
        string contactID=apexpages.currentpage().getparameters().get('conid');
        string LeadID=apexpages.currentpage().getparameters().get('leadid');
        String pageCounter = apexPages.currentPage().getParameters().get('redCounter');
        if(pageCounter != null && pageCounter != '')
        {
            counter = Integer.valueOf(pageCounter);
        }
        if(contactID != null && contactID != '')
        {
            conlst =[select Id,Account.name,Account.Phone,Contact.Contact_Status__c,Name,Email,phone from Contact Where Id =: contactID Limit 1];    
        }else if(LeadID != null && LeadID != '')
        {
            leadlst =[select Id, Name,Email, Phone, Company, IsConverted from Lead Where Id =: LeadID];
        }
    }
    
  
    public List<CampaignMember> getCampaignMembers (){ 
        String queryString;
        try{
            queryString = 'SELECT Id,name,CampaignID,contactId,LeadId,Status,Treatment__c,LeadOrContactOwnerid,Contact.Name,lead.Name,Campaign_Comment__c,Done__c,Outcome__c,Priority__c FROM CampaignMember where LeadOrContactOwnerid =:userId AND Lead.IsConverted = false AND LeadId NOT IN: setConvLead order by Name ASC limit : list_size offset :counter';            
            List<CampaignMember> userCM= Database.query(queryString);// Changes made by Madhavi
            system.debug('total size offset'+total_size );
            return userCM;        
        } 
        catch (QueryException e) {
            ApexPages.addMessages(e);  
            return null;
        }
    }

public PageReference Beginning() { //user clicked beginning
      counter = 0;
      return null;
   }
   
public PageReference Previous() { //user clicked previous button
      counter -= list_size;
      return null;
   }
 
   public PageReference Next() { //user clicked next button
      counter += list_size;
      return null;
   }
 
   public PageReference End() { //user clicked end
      // Below code is modified my manoj (11/21/2018)
      if(math.mod(total_size, list_size) != 0)
      counter = total_size - math.mod(total_size, list_size);
      else
      counter = total_size - list_size;
      // Till this added my manoj (11/21/2018)
      return null;
   }
 
   public Boolean getDisablePrevious() {
      //this will disable the previous and beginning buttons
      if (counter>0) return false; else return true;
   }
 
   public Boolean getDisableNext() { //this will disable the next and end buttons
       if (counter + list_size < total_size) return false; else return true;
   }
 
   public Integer getTotal_size() {
      return total_size;
   }
 
   public Integer getPageNumber() {
      return counter/list_size + 1;
   }
 
   public Integer getTotalPages() {
      if (math.mod(total_size, list_size) > 0) {
         return total_size/list_size + 1;
      } else {
         return (total_size/list_size);
      }
   }


 public PageReference selcon() {
   string getid=apexpages.currentpage().getparameters().get('cid');
   // Below lines changes made by Madhavi
   PageReference campMemwithContact = Page.CampaignMember_VFPage;
   campMemwithContact.getParameters().put('conid',getid); 
   campMemwithContact.getParameters().put('redCounter',String.valueOf(counter));
   campMemwithContact.setRedirect(true);
   return campMemwithContact;
  }
  
  public PageReference sellead() {
   string getid=apexpages.currentpage().getparameters().get('lid');
   // Below lines changes made by Madhavi
   PageReference campMemwithLead = Page.CampaignMember_VFPage;
   campMemwithLead.getParameters().put('leadid',getid); 
   campMemwithLead.getParameters().put('redCounter',String.valueOf(counter));
   campMemwithLead.setRedirect(true);
   return campMemwithLead;
  }  
}