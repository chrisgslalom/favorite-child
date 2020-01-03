({
	doInit : function(component, event, helper) {
		var action = component.get("c.fetchWOTaskList");
        action.setParams({"woId":component.get("v.recordId")});
        action.setCallback(this, function(data) {
            component.set("v.taskList",data.getReturnValue());
        });
        $A.enqueueAction(action);
	}
})