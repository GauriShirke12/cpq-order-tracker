public with sharing class ProductionOrderController {
    @AuraEnabled
    public static Id createProductionOrder() {
        Production_Order__c po = new Production_Order__c(
            Name = 'Auto Created Order',
            Status__c = 'Planned',
            Scheduled_Date__c = Date.today().addDays(7)
        );
        insert po;
        return po.Id;
    }
}
