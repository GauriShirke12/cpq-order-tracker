@isTest
private class TestInventoryHelper {
    @isTest static void testReduceInventory() {
        Inventory__c inv = new Inventory__c(
            Stock_Level__c = 10,
            Reorder_Point__c = 2
            // Add any other required writable fields here
        );
        insert inv;

        Map<Id, Integer> qtyMap = new Map<Id, Integer>{ inv.Id => 4 };

        Test.startTest();
            InventoryHelper.reduceInventory(qtyMap);
        Test.stopTest();

        Inventory__c updated = [SELECT Stock_Level__c FROM Inventory__c WHERE Id = :inv.Id];
        System.assertEquals(6, Integer.valueOf(updated.Stock_Level__c));
    }
}
