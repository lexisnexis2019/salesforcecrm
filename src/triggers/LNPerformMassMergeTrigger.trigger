/*
Author: Raghav Kulkani
Description:This is a Trigger on Mass Merge Custom Object. After a record is inserted via Data Loader, this trigger
      calls different APEX Classes to perform the Merge on OC,AP,POB.
*/ 

trigger LNPerformMassMergeTrigger on Mass_Merge__c (after insert) {
    try{
    if (Trigger.isInsert) {
    //LNPerformMergeClass LNPerformMerge = new LNPerformMergeClass();
    List<Mass_Merge__c > listMerges = new  List<Mass_Merge__c > ();
    Set<Id> setid = new Set<id>();
   
            for(Mass_Merge__c MerId:trigger.new){
            setid.add(MerId.id);
            }
List<Mass_Merge__c > listMer = [Select id, ProcessFlag__c,Merge_Type__c,Survivor_PGUID__c,Victim_PGUID__c from Mass_Merge__c where id In : Setid];
      for(Mass_Merge__c Mer:listMer){
          if(Mer.ProcessFlag__c == false && Mer.Survivor_PGUID__c != null && Mer.Survivor_PGUID__c != '' && Mer.Victim_PGUID__c != null && Mer.Victim_PGUID__c != ''){
            
            String Merge_Type = Mer.Merge_Type__c;
            String Survivor_PGUID = Mer.Survivor_PGUID__c;
            String Victim_PGUID = Mer.Victim_PGUID__c;  
            List<String> MergeResponse =  new List<String>();
              if(Merge_Type == 'OC Merge'){
            LNPerformOCMerge.PerformOCMerge(Survivor_PGUID, new list<String>{Victim_PGUID});
            Mer.ProcessFlag__c = true;           
            listMerges.add(Mer);
              }
              if(Merge_Type == 'AP Merge'){
           LNPerformAPMerge.PerformAPMerge(Survivor_PGUID,Victim_PGUID);
           Mer.ProcessFlag__c = true;           
           listMerges.add(Mer);      
              }
              if(Merge_Type == 'POB Merge'){
            LNPerformPOBMerge.PerformPOBMerge(Survivor_PGUID,Victim_PGUID);      
            Mer.ProcessFlag__c = true;        
            listMerges.add(Mer);
              }
            }
          
        }//End of For loop of Mass Merge Records
    update listMerges;
  } //end if
    }//End of Try
    catch(Exception e){
        
    }
}//end of trigger