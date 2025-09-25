public with sharing class ShipmentTriggerHandler {
    public static void beforeSave(List<Shipment__c> shipments) {
        for (Shipment__c s : shipments) {
            if (s.Expected_Date__c != null && s.Expected_Date__c < Date.today()) {
                s.addError('Expected date cannot be in the past.');
            }
        }
    }
}
