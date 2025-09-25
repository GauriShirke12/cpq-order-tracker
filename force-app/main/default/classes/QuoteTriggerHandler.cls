public with sharing class QuoteTriggerHandler {
    public static void afterUpdate(List<SBQQ__Quote__c> newQuotes, Map<Id, SBQQ__Quote__c> oldMap) {
        // Find quotes that just moved into 'Accepted' (adjust status value as per your org)
        Set<Id> acceptedQuoteIds = new Set<Id>();
        for (SBQQ__Quote__c q : newQuotes) {
            SBQQ__Quote__c oldQ = oldMap.get(q.Id);
            if (oldQ != null 
                && oldQ.SBQQ__Status__c != q.SBQQ__Status__c 
                && q.SBQQ__Status__c == 'Accepted') {
                acceptedQuoteIds.add(q.Id);
            }
        }
        if (acceptedQuoteIds.isEmpty()) return;

        // Query related Quote Lines that have the correct Inventory lookup
        List<SBQQ__QuoteLine__c> qlines = [
            SELECT Id, SBQQ__Quantity__c, Inventory_Lookup__c
            FROM SBQQ__QuoteLine__c
            WHERE SBQQ__Quote__c IN :acceptedQuoteIds AND Inventory_Lookup__c != NULL
        ];

        // Aggregate quantities by Inventory Id
        Map<Id, Integer> qtyByInventory = new Map<Id, Integer>();
        for (SBQQ__QuoteLine__c ql : qlines) {
            if (ql.Inventory_Lookup__c == null || ql.SBQQ__Quantity__c == null) continue;
            Integer qty = Integer.valueOf(ql.SBQQ__Quantity__c);
            qtyByInventory.put(
                ql.Inventory_Lookup__c, 
                (qtyByInventory.containsKey(ql.Inventory_Lookup__c) ? qtyByInventory.get(ql.Inventory_Lookup__c) : 0) + qty
            );
        }

        if (!qtyByInventory.isEmpty()) {
            InventoryHelper.reduceInventory(qtyByInventory);
        }
    }
}
