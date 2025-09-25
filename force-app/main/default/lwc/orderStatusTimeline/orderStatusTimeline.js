import { LightningElement, api, wire } from 'lwc';
import getOrderStatus from '@salesforce/apex/OrderStatusController.getOrderStatus';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class OrderStatusTimeline extends LightningElement {
    @api recordId;
    status;
    previousStatus;

    @wire(getOrderStatus, { orderId: '$recordId' })
    wiredOrder({ error, data }) {
        if (data) {
            // Detect status change
            if (this.previousStatus !== data) {
                this.status = data;

                // Fire toast when status becomes Shipped
                if (data === 'Shipped') {
                    this.showShippedToast();
                }

                this.previousStatus = data;
            }
        } else if (error) {
            this.status = 'Error fetching status';
        }
    }

    showShippedToast() {
        const event = new ShowToastEvent({
            title: 'Order Shipped ',
            message: 'This order has been successfully shipped!',
            variant: 'success',
        });
        this.dispatchEvent(event);
    }
}
