trigger QuoteLineTrigger on SBQQ__QuoteLine__c (before insert, before update) {
    if (Trigger.isBefore) {
        QuoteLineTriggerHandler.checkInventory(Trigger.new);
    }
}
