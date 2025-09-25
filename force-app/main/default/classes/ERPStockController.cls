public with sharing class ERPStockController {
    @AuraEnabled
    public static String checkERPStock(Id inventoryId) {
        //  For now, just simulate ERP call
        Inventory__c inv = [
            SELECT Name, Stock_Level__c
            FROM Inventory__c
            WHERE Id = :inventoryId
            LIMIT 1
        ];

        // In real world → callout to ERP system here
        return 'ERP confirms stock for ' + inv.Name + ': ' + inv.Stock_Level__c;
    }
}
