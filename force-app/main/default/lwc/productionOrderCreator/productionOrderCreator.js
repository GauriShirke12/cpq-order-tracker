import { LightningElement } from 'lwc';
import createProductionOrder from '@salesforce/apex/ProductionOrderController.createProductionOrder';
import { NavigationMixin } from 'lightning/navigation';

export default class ProductionOrderCreator extends NavigationMixin(LightningElement) {
    handleCreateOrder() {
        createProductionOrder()
            .then(result => {
                // Navigate to the Production Order record page
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: result, // returned Production Order Id
                        objectApiName: 'Production_Order__c',
                        actionName: 'view'
                    }
                });
            })
            .catch(error => {
                console.error(error);
            });
    }
}
