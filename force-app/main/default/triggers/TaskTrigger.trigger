trigger TaskTrigger on Task (before insert, after insert) {

    if(Trigger.isBefore && Trigger.isInsert) {
        Map<Id,List<Task>> woTasks = new Map<Id,List<Task>>(); //tasks indexed by work order
        Set<Id> woIdSet = new Set<Id>();
        for(Task t : Trigger.new)
        {
            if(((String)t.WhatId).startsWith('0WO'))
            {
                woIdSet.add(t.WhatId);
                if(woTasks.get(t.WhatId)==null)
                    woTasks.put(t.WhatId, new List<Task>{t});
                else
                    woTasks.get(t.WhatId).add(t);
            }
        }
        //List<Task> forUpdate = new List<Task>();
        for(WorkOrder wo : [SELECT Id, Contact.User_ID__c FROM WorkOrder WHERE Id IN :woIdSet])
        {
            for(Id mapIndex : woTasks.keySet())
            {
                if(wo.Contact.User_ID__c != null)
                    for(Task t : woTasks.get(mapIndex))
                    {
                        t.OwnerId = wo.Contact.User_ID__c;
                        //forUpdate.add(t);
                    }
            }
        }
        //update forUpdate;
    }
}