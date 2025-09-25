public with sharing class InventoryCheckerController {
    @AuraEnabled(cacheable=true)
    public static Decimal getStockLevel(Id inventoryId) {
        Inventory__c inv = [
            SELECT Stock_Level__c 
            FROM Inventory__c 
            WHERE Id = :inventoryId 
            LIMIT 1
        ];
        return inv.Stock_Level__c;
    }
}
