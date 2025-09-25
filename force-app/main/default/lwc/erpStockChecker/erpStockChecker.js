import { LightningElement, api } from 'lwc';
import checkERPStock from '@salesforce/apex/ERPStockController.checkERPStock';

export default class ErpStockChecker extends LightningElement {
    @api recordId; // assume placed on Inventory record page
    erpMessage;

    handleCheckStock() {
        checkERPStock({ inventoryId: this.recordId })
            .then(result => {
                this.erpMessage = result;
            })
            .catch(error => {
                this.erpMessage = 'Error: ' + error.body.message;
            });
    }
}
