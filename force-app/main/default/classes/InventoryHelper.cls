public with sharing class InventoryHelper {
    
    public static void reduceInventory(Map<Id, Integer> qtyByInventoryId) {
        if (qtyByInventoryId == null || qtyByInventoryId.isEmpty()) return;

       
        List<Inventory__c> invList = [
            SELECT Id, Stock_Level__c
            FROM Inventory__c
            WHERE Id IN :qtyByInventoryId.keySet()
            FOR UPDATE
        ];

        for (Inventory__c inv : invList) {
            Integer toReduce = qtyByInventoryId.get(inv.Id);
            Decimal current = (inv.Stock_Level__c == null) ? 0 : inv.Stock_Level__c;
            Decimal updated = current - (toReduce == null ? 0 : toReduce);
           
            if (updated < 0) updated = 0;
            inv.Stock_Level__c = updated;
        }

        if (!invList.isEmpty()) {
            update invList;
        }
    }
}
