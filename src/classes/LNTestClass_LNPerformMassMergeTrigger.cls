/*
 Authir-Raghav Kulkarni- Test Class for Mass Merge Trigger
 */ 
@isTest
public class LNTestClass_LNPerformMassMergeTrigger {
    static testmethod void triggertest(){
        
    String Survivor_PGUID = 'urn:ecm:test';
    String Victim_PGUID = 'urn:ecm:test';   
    
        List<String> Type = new List<String>();
        Type.add('OC Merge');
        Type.add('AP Merge');
        Type.add('POB Merge');
        
        List<Mass_Merge__c> ListMassMerge = new List<Mass_Merge__c>();
        
        for(Integer i=0; i < Type.size(); i++){
            Mass_Merge__c Mer = new Mass_Merge__c ();
            Mer.Merge_Type__c = Type[i];
            Mer.Survivor_PGUID__c = Survivor_PGUID;
            Mer.Victim_PGUID__c = Victim_PGUID;
            Mer.ProcessFlag__c = False;        
            ListMassMerge.add(Mer);   
        }
        insert ListMassMerge;
 } 
	
            
}