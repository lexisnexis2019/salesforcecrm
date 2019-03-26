/*
Author: Raghav Kulkani
Description:This is a Trigger on Merge Custom Object. After a record is inserted via REST API call from MW, this trigger
			calls an APEX Class. The called APEX class performs the Merge and sends a message back to MW.
*/ 

trigger LNPerformMergeTrigger on Merge__c (after insert) {
if (Trigger.isInsert) {
    LNPerformMergeClass LNPerformMerge = new LNPerformMergeClass();
    List<Merge__c > listMerges = new  List<Merge__c > ();
    Set<Id> setid = new Set<id>();
   
            for(Merge__c MerId:trigger.new){
            setid.add(MerId.id);
            }
List<Merge__c > listMer = [Select id, ProcessFlag__c,Incoming_XML__c from Merge__c where id In : Setid];
      for(Merge__c Mer:listMer){
          if(Mer.ProcessFlag__c == false && (Mer.Incoming_XML__c != null || Mer.Incoming_XML__c != '')){
            String XMLMessage = Mer.Incoming_XML__c;
            List<String> MergeResponse =  new List<String>();
            //String MergeResponse = LNPerformMerge.doPost(XMLMessage);
            MergeResponse = LNPerformMerge.doPost(XMLMessage);
            
            Mer.ProcessFlag__c = true;           
            Mer.MergeError__c = MergeResponse[0];
            Mer.OutgoingXML__c = MergeResponse[1];
            Mer.MWResponse__c = MergeResponse[2];
            listMerges.add(Mer);
            }
          update listMerges;
        }
	} //end if
}//end of trigger