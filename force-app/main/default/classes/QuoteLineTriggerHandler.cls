public with sharing class QuoteLineTriggerHandler {
    
    public static void checkInventory(List<SBQQ__QuoteLine__c> quoteLines) {
        // Collect Inventory IDs from the Quote Lines
        Set<Id> inventoryIds = new Set<Id>();
        for (SBQQ__QuoteLine__c ql : quoteLines) {
            if (ql.Inventory_Lookup__c != null) {
                inventoryIds.add(ql.Inventory_Lookup__c);
            }
        }
        
        // Fetch Inventory records
        Map<Id, Inventory__c> inventoryMap = new Map<Id, Inventory__c>(
            [SELECT Id, Name, Stock_Level__c 
             FROM Inventory__c 
             WHERE Id IN :inventoryIds]
        );
        
        // Compare stock with requested quantity
        for (SBQQ__QuoteLine__c ql : quoteLines) {
            if (ql.Inventory_Lookup__c != null && inventoryMap.containsKey(ql.Inventory_Lookup__c)) {
                Inventory__c inv = inventoryMap.get(ql.Inventory_Lookup__c);
                
                if (ql.SBQQ__Quantity__c > inv.Stock_Level__c) {
                    ql.addError(
                        'Requested quantity (' + ql.SBQQ__Quantity__c + 
                        ') exceeds available stock (' + inv.Stock_Level__c + 
                        ') for Inventory: ' + inv.Name
                    );
                }
            }
        }
    }
}
