/*
Class Name  : UpdateAccountActivity_Handler
Description : This class is handler class for the Trigger "UpdateAccountDataTask" 
used to update the total task count on account filed "Activity_Indicator_Task__c"              
Author      : Madhavi Valavala
*/
public class UpdateAccountActivity_Handler 
{
    public static void afterInsUpdDel_TaskCount(Map<Id, Task> mapTasks)
    {
        Set<Id> setAccIds = new Set<Id>();
        for(Task tsk : mapTasks.Values())
        {
            if(tsk.AccountId != null)
            {
                setAccIds.add(tsk.AccountId);
            }
        }
        try {
            AggregateResult[] groupedResults = [SELECT Count(Id), WhatID FROM Task Where WhatID IN: setAccIds group by WhatID];
            List<Account> listAccounts = [SELECT Id, Activity_Indicator_Task__c From Account Where Id IN: setAccIds];
            Map<Id,Integer> tasksCountMap = new Map<Id,Integer>();
            for (AggregateResult ar : groupedResults)  {
                tasksCountMap.put((Id)ar.get('WhatID'),Integer.valueOf(ar.get('expr0')));
            }
            
            List<Account> accUpdLst = new List<Account>();
            //Updating the count field
            for(Account acc: listAccounts) {   
                if(tasksCountMap.containsKey(acc.Id))
                {
                    acc.Activity_Indicator_Task__c = tasksCountMap.get(acc.Id);
                }else if(!tasksCountMap.containsKey(acc.Id))
                {
                    acc.Activity_Indicator_Task__c = 0;   
                }                    
                accUpdLst.add(acc);
            }
            
            if(accUpdLst.size() > 0) {
                update accUpdLst;
            }
        }Catch(Exception ex)
        {
            System.debug('Exception occurred'+ex);
        }
    }
    public static void afterInsUpdDel_EventCount(Map<Id, Event> mapEvents)
    {
        Set<Id> setAccIds = new Set<Id>();
        for(Event evt : mapEvents.Values())
        {
            if(evt.AccountId != null)
            {
                setAccIds.add(evt.AccountId);
            }
        }
        try {
            AggregateResult[] groupedResults = [SELECT Count(Id), WhatID FROM Event Where WhatID IN: setAccIds group by WhatID];
            List<Account> listAccounts = [SELECT Id, Activity_Indicator_Event__c From Account Where Id IN: setAccIds];
            Map<Id,Integer> eventsCountMap = new Map<Id,Integer>();
            for (AggregateResult ar : groupedResults)  {
                eventsCountMap.put((Id)ar.get('WhatID'),Integer.valueOf(ar.get('expr0')));
            }
            
            List<Account> accUpdLst = new List<Account>();
            //Updating the count field
            for(Account acc: listAccounts) {   
                if(eventsCountMap.containsKey(acc.Id))
                {
                	acc.Activity_Indicator_Event__c = eventsCountMap.get(acc.Id);   
                }else if(!eventsCountMap.containsKey(acc.Id))
                {
                    acc.Activity_Indicator_Event__c = 0;   
                }
                accUpdLst.add(acc);
            }
            
            if(accUpdLst.size() > 0) {
                update accUpdLst;
            }
        }Catch(Exception ex)
        {
            System.debug('Exception occurred'+ex);
        }
    }
}