trigger QuoteTrigger on SBQQ__Quote__c (after update) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        QuoteTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }
}
