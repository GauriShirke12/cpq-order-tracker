public class ShipmentNotifier implements Queueable {
    public void execute(QueueableContext qc) {
        List<Shipment__c> delayed = [
            SELECT Id, Name, Expected_Date__c
            FROM Shipment__c
            WHERE Expected_Date__c < :Date.today() AND Status__c != 'Shipped'
        ];
        // For demo, just log; in real org call notification logic or platform event
        for (Shipment__c s : delayed) {
            System.debug('ShipmentNotifier: delayed -> ' + s.Id + ' / ' + s.Name);
        }
    }
}
