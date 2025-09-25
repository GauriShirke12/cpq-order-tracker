import { LightningElement, api, wire } from 'lwc';
import getStockLevel from '@salesforce/apex/InventoryCheckerController.getStockLevel';

export default class InventoryChecker extends LightningElement {
    @api recordId; // inventoryId passed from Quote Line
    stockLevel;

    @wire(getStockLevel, { inventoryId: '$recordId' })
    wiredStock({ error, data }) {
        if (data) {
            this.stockLevel = data;
        } else if (error) {
            this.stockLevel = null;
        }
    }
}
