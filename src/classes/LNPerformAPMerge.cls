public class LNPerformAPMerge {
    
/*
Author: Raghav Kulkani
Description:
    This is AP Merge- The Inputs are MasterAPPGUID  as Master AP and  VictimAPPGUID as Victim AP
*/	
@future
public static void PerformAPMerge(String MasterAPPGUID, String VictimAPPGUID){//main method start

    try{
Contact masterCont1;
Contact mergeCont1;
    
    List<Contact> masterContact = [SELECT Id FROM Contact WHERE APPGUID__c =: MasterAPPGUID LIMIT 1];
                                    if(masterContact.Size() == 1){
                                    masterCont1 = masterContact[0];  
                                        }
    List<Contact> mergeContact = [SELECT Id FROM Contact WHERE APPGUID__c =: VictimAPPGUID LIMIT 1];
                                    if(mergeContact.Size() == 1){
                                    mergeCont1 = mergeContact[0];  
                                        }
    //This is Merge Class and calling Merge Method.
                                    Database.MergeResult apresults = Database.merge(masterCont1, mergeCont1, false);
                                        if(apresults.isSuccess()){
                                        System.assertEquals(masterCont1.Id, apresults.getId());
                                        }
    }
    catch(Exception e){
        
    }
    
}// main method end
}// Class end