import { LightningElement } from 'lwc';

export default class ProductSelector extends LightningElement {
    handleSelect(event) {
        const selectedProduct = event.target.value;

        // Fire a custom event with productId
        const customEvent = new CustomEvent('productselected', {
            detail: { productId: selectedProduct }
        });
        this.dispatchEvent(customEvent);
    }
}
