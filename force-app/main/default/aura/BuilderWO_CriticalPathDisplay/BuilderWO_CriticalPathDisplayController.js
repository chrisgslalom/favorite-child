({
	doInit : function(component, event, helper) {

    	var action = component.get("c.getCriticalPathTaskForWO");
        action.setParams({"woId":component.get("v.recordId")});
        action.setCallback(this, function(data) {
             component.set("v.criticalPathTask",data.getReturnValue());
        });
        $A.enqueueAction(action);
	}
})