public with sharing class OrderStatusController {
    @AuraEnabled(cacheable=true)
    public static String getOrderStatus(Id orderId) {
        Order ord = [
            SELECT Status 
            FROM Order 
            WHERE Id = :orderId 
            LIMIT 1
        ];
        return ord.Status;
    }
}
