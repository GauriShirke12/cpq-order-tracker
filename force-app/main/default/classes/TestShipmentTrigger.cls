@isTest
private class TestShipmentTrigger {
    @isTest static void testShipmentDateValidation() {
        Shipment__c s = new Shipment__c(
            Expected_Date__c = Date.today().addDays(-1),
            Status__c = 'In Transit'
            // Add any other required writable fields here
        );

        Test.startTest();
        try {
            insert s;
            System.assert(false, 'Expected insert to fail due to validation');
        } catch (DmlException e) {
            // expected
        }
        Test.stopTest();
    }
}
