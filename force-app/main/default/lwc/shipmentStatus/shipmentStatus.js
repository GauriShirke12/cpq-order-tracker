import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = [
    'Shipment__c.Status__c',
    'Shipment__c.Expected_Date__c'
];

export default class ShipmentStatus extends LightningElement {
    @api recordId;   // Salesforce automatically passes the current record Id
    status;
    expectedDate;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wiredShipment({ error, data }) {
        if (data) {
            this.status = data.fields.Status__c.value;
            this.expectedDate = data.fields.Expected_Date__c.value;
        } else if (error) {
            this.status = 'Error';
        }
    }
}
