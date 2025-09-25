import { LightningElement } from 'lwc';

export default class GuidedSelling extends LightningElement {
    recommendedSeal;

    handleProductSelected(event) {
        const productId = event.detail.productId;

        if (productId === 'PumpX') {
            this.recommendedSeal = 'Seal Type Y';
        } else {
            this.recommendedSeal = 'Standard Seal';
        }
    }
}
