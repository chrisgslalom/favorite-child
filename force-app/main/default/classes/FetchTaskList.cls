public class FetchTaskList {
    
    @AuraEnabled
    public static List<Task> fetchWOTaskList(Id woId){
        return [SELECT Id, Subject, Owner.Name, Responsible_Party__c, ActivityDate, IsClosed from Task WHERE WhatId = :woId ORDER BY ActivityDate LIMIT 10 ];
    }

}