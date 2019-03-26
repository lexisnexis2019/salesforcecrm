/*
Author: Raghav Kulkani
Description:
    This is OC Merge- The Inputs are MasterOCPGUID  as Master Account and List of VictimOCPGUID as Victim Accounts
    The Queries are optimized. 1 query for Master OC ID, 1 Query for List of Victim ID, 1 Query to all victim Address, 
    1 Query to update all address. and Merge will have its own queries per each Victim.
*/ 


public class LNPerformOCMerge {
      
    
@future
public static void PerformOCMerge(String MasterOCPGUID, List<String> VictimOCPGUID){//main method start
    List<Account> masterAcct = new List<Account>();
    List<Account> mergeAcct = new List<Account>();
    Account masterAcct1;
    Account mergeAcct1;
    String masterAcctId;
    String mergeAcctId;
    
    try{
    if( MasterOCPGUID.length() > 0){ // This is imp to check if the attribute has any value or not.this ensures no nulls are passed tp SOQL later
        masterAcct = [SELECT Id FROM Account WHERE OCPGUID__c =: MasterOCPGUID  LIMIT 1];
        }
        
            if(masterAcct.Size() == 1){ //validation of master
                    
                    masterAcct1 = masterAcct[0];
                    masterAcctId = masterAcct1.Id;
            }//validation of master
        
 //Bulk Query of Victim OC ID using List of Victims       
 mergeAcct = [SELECT Id FROM Account WHERE OCPGUID__c =: VictimOCPGUID];
 // Bulk Query on Address__C and updating Primary using just one update.
 List<Address__c> AddressList = [Select Id, Primary__c FROM Address__c WHERE Account__c =: mergeAcct AND Primary__c = True];
    for(Address__c Addr : AddressList){
    Addr.Primary__c = False;
    }
    update AddressList;

  // loop the Database Merge for each victim.
  for(Integer x=0; x < mergeAcct.size(); x++){//start loop
        mergeAcctId = mergeAcct[x].Id;
        mergeAcct1 = mergeAcct[x];
      if(masterAcctId != null && mergeAcctId != null){
          //This is Merge Class and calling Merge Method.
                    Database.MergeResult results = Database.merge(masterAcct1, mergeAcct1, false);
                        if(results.isSuccess()){
                            System.assertEquals(masterAcct1.Id, results.getId());
                        }
          
            }
      
      
     }//End of loop
    }//end of try
    catch(Exception e)
    {}  
    

    }// main method end   
    
    
}