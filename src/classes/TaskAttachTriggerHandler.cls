public with sharing class TaskAttachTriggerHandler {
    
public static void onAfterInsertUpdateTaskAttach(List<Task> listofTasks1, boolean isInsert){
List<ID> pId = new List<ID>();
List<Attachment> Attach = new List<Attachment>();
Set<Id> P1 = new Set<ID>();
Set<Id> allAttach = new Set<Id>();

for(Task t: listofTasks1)
    {
        pId.add(t.Id);
    }
    
Attach = [select id, parentId from Attachment where parentID IN : pId];

for(Attachment A1:Attach)
{
    P1.add(A1.parentID);
}

if(!IsInsert){
   for(task t2: listofTasks1){
        if (P1.contains(t2.id))
          {
            t2.Attachment__c= true;
          }
        else
          {
            t2.Attachment__c= false;
          }
    }
}
    else{
        List<Task> newTask = new List<Task>();
              
        for(task t2: listofTasks1){
            if (P1.contains(t2.id))
            {
                Task obj = new Task();
                obj.Id = t2.Id;
                obj.Attachment__c= true;
                newTask.add(obj);
            }
            else{
                Task obj = new Task();
                obj.Id = t2.Id;
                obj.Attachment__c=false;
                 newTask.add(obj);
            }
        }
          update newTask;
    }
  }
}