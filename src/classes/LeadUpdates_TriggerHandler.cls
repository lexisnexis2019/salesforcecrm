/************************************************************************************
Class Name    :    LeadUpdates_TriggerHandler

Description   :    This class is for LeadTrigger.

Version          Developed By           Description          Last Modified Date
------------------------------------------------------------------------------------
Version1.0       Madhavi		      Initial Version      03/21/2018
**************************************************************************************/
public class LeadUpdates_TriggerHandler {
    // This method used to set Trillium Address Update to false, if lead address changed by the user and Trillium Address Updated already true.
    public static void leadBeforeUpdate(Map<Id, Lead> mapOldLeads, List<Lead> listNewLeads)
    {
            RecordType recordTypes = [SELECT Id From RecordType Where sObjectType = 'Lead' AND DeveloperName = 'Convert_Lead' Limit 1];
            Id recordTypeId = recordTypes.Id;
            for(Lead newLead : listNewLeads)
            {
                if(mapOldLeads.containsKey(newLead.Id) && (newLead.Street != mapOldLeads.get(newLead.Id).Street || newLead.City != mapOldLeads.get(newLead.Id).City || newLead.State != mapOldLeads.get(newLead.Id).State || newLead.Country != mapOldLeads.get(newLead.Id).Country || newLead.PostalCode != mapOldLeads.get(newLead.Id).PostalCode)
                   && (newLead.RecordTypeId == recordTypeId && newLead.RecordTypeId == mapOldLeads.get(newLead.Id).RecordTypeId))
                {
                    if(newLead.Trillium_Address_Update__c == mapOldLeads.get(newLead.Id).Trillium_Address_Update__c && mapOldLeads.get(newLead.Id).Trillium_Address_Update__c == True)
                    {
                        newLead.Trillium_Address_Update__c = False;
                    }
                }
            }
        }         
}