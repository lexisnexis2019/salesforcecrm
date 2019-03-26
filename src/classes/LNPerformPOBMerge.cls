public class LNPerformPOBMerge {
/*
Author: Raghav Kulkani
Description:
    This is POB Merge- The Inputs are MasterPOBPGUID  as Master POB and  VictimPOBPGUID as Victim POB
*/	
    
@future
public static void PerformPOBMerge(String MasterPOBPGUID, String VictimPOBPGUID){//main method start

    try{
String masterAddress1Id = null;
String mergeAddress1Id = null;
    
    List<Address__c> masterAddress = [SELECT Id FROM Address__c WHERE POBPGUID__c =: MasterPOBPGUID LIMIT 1];
                                        if(masterAddress.Size() == 1){
                                            masterAddress1Id = masterAddress[0].Id;
                                            }
    List<Address__c> mergeAddress = [SELECT Id FROM Address__c WHERE POBPGUID__c =: VictimPOBPGUID LIMIT 1];
                                    if(mergeAddress.Size() == 1){
                                    mergeAddress1Id = mergeAddress[0].Id;    
                                            }    
    //Ther is No Out of the box Merge for POB- So Query Contacts and Activities of Victim POB and assign them to Master POB and Delete the Victim POB
    						if (masterAddress1Id  != null || mergeAddress1Id != null) 
                            {
                                //Contacts associated to POB     
                                List<Contact> Contact1 = [SELECT Id FROM Contact WHERE Address__c =: mergeAddress1Id];
                                        if(Contact1.size() > 0)
                                            {
                                            for(Contact Con1:Contact1){
                                            Con1.Address__c = masterAddress1Id;
                                            }
                                             update Contact1;   
                                        }
        								//code for Task Update
                                        List<Task> Task1 = [SELECT Id FROM Task WHERE WhatId =: mergeAddress1Id];
                                        if (Task1.size() > 0)
                                            {
                                            for(Task TK: Task1){
                                            TK.WhatId = masterAddress1Id;
                                            }   
                                            update Task1;    
                                        }
        								//code for Event Update
                                        List<Event> Event1 = [SELECT Id FROM Event WHERE WhatId =: mergeAddress1Id];
                                        if(Event1.size() > 0)
                                        {
                                            for(Event ET:Event1){
                                            ET.WhatId = masterAddress1Id;
                                            }
                                            update Event1;      
                                        }    
        					// Delete POB
                            delete mergeAddress;
                            }   				           
   // System.debug('Master ID:'+ masterAddress1Id + ':' + 'Victom ID:' + mergeAddress1Id);
    }
    catch(Exception e){}
    
}// main method end
}