trigger ShipmentTrigger on Shipment__c (before insert, before update) {
    if (Trigger.isBefore) {
        ShipmentTriggerHandler.beforeSave(Trigger.new);
    }
}
