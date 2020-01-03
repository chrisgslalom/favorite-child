({
	setCriticalPath : function(component, event, helper) {
		var action = component.get("c.setCriticalPathTask");
        action.setParams({"taskId":component.get("v.recordId")});
        
        action.setCallback(this, function(data) {
            component.set("v.criticalPathTask",data.getReturnValue());
            if(component.get("v.criticalPathTask").Id==component.get("v.recordId"))
            {
                var resultsToast = $A.get("e.force:showToast"); 
                resultsToast.setParams({ 
                    "title": "Success" , 
                    "message": "Critical path updated"
                });
            	resultsToast.fire();
            }
            var dismissActionPanel = $A.get("e.force:closeQuickAction"); 
        	dismissActionPanel.fire();
        });
        $A.enqueueAction(action);
	},
    
    doInit : function(component, event, helper) {
        console.log("###### doInit invoked");
    	var action = component.get("c.getCriticalPathTaskOnRelatedWO");
        console.log("###### recordId: "+component.get("v.recordId"));
        action.setParams({"taskId":component.get("v.recordId")});
        action.setCallback(this, function(data) {
            console.log("###### doInit callback invoked");
             component.set("v.criticalPathTask",data.getReturnValue());
        });
        $A.enqueueAction(action);
        
        var action2 = component.get("c.getTaskDetails");
        action2.setParams({"taskId":component.get("v.recordId")});
        action2.setCallback(this, function(data) {
             component.set("v.currentTask",data.getReturnValue());
        });
        $A.enqueueAction(action2);
	}
})