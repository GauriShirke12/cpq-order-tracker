global class RecalculateStockBatch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // Select only fields you need
        return Database.getQueryLocator('SELECT Id, Stock_Level__c, Reorder_Point__c FROM Inventory__c');
    }
    global void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Inventory__c> invs = (List<Inventory__c>) scope;
        for (Inventory__c inv : invs) {
            Decimal stock = inv.Stock_Level__c == null ? 0 : inv.Stock_Level__c;
            Decimal reorder = inv.Reorder_Point__c == null ? 0 : inv.Reorder_Point__c;
            if (stock < reorder) {
                inv.Stock_Level__c = reorder; // simple rule: top up to reorder point
            }
        }
        if (!invs.isEmpty()) update invs;
    }
    global void finish(Database.BatchableContext bc) {
        // Optionally send notification or log stats
    }
}
