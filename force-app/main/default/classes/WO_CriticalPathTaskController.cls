public class WO_CriticalPathTaskController {

    @AuraEnabled
    public static Task setCriticalPathTask(Id taskId)
    {
        Task t = getTaskDetails(taskId);
        WorkOrder woToUpdate = new WorkOrder(Id=t.WhatId, Critical_Path_Activity__c = taskId);
		update woToUpdate;
        return t;
    }
    
    @AuraEnabled
    public static Task getCriticalPathTaskOnRelatedWO(Id taskId)
    {
        Task t = getTaskDetails(taskId);
        Task criticalPathTask;
        WorkOrder woForTask = [SELECT Id, Critical_Path_Activity__c, Title__c FROM WorkOrder WHERE Id = :t.WhatId LIMIT 1];
        if(woForTask!=null && woForTask.Critical_Path_Activity__c != null)
            criticalPathTask = getTaskDetails(woForTask.Critical_Path_Activity__c);
        else
            criticalPathTask = new Task(Subject='<none>');
        return criticalPathTask;
    }
    
    @AuraEnabled
    public static Task getTaskDetails(Id taskId)
    {
        System.debug('##### Task ID: '+taskId);
        Task currentTask = [SELECT Id, Subject, Owner.Name, Responsible_Party__c, ActivityDate, IsClosed, WhatId FROM Task WHERE Id = :taskId];
        return currentTask;
    }

    @AuraEnabled
    public static Task getCriticalPathTaskForWO(Id woId)
    {        
        Task criticalPathTask;
        WorkOrder woForTask = [SELECT Id, Critical_Path_Activity__c FROM WorkOrder WHERE Id = :woId LIMIT 1];
        if(woForTask!=null && woForTask.Critical_Path_Activity__c != null)
            criticalPathTask = getTaskDetails(woForTask.Critical_Path_Activity__c);
        else
            criticalPathTask = new Task(Subject='<none>');
        return criticalPathTask;
    }
}