function calc (){
  const itemPrice = document.getElementById('item-price');
  itemPrice.addEventListener('keyup', () => {
    const priceVal = itemPrice.value;
    const priceTax = priceVal * 0.1;
    const addTaxPrice = document.getElementById("add-tax-price");
    addTaxPrice.innerHTML = `${priceTax}`;
    const profit = document.getElementById("profit");
    profit.innerHTML = `${priceVal - priceTax}`
  });
}

window.addEventListener('load', calc);