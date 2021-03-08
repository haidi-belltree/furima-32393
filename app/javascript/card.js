const pay = () => {
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    
  });
};

window.addEventListener("load", pay)