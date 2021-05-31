
const selectShop = () => {
  const form = document.querySelector('.hidden > input');
  document.querySelectorAll('.marker').forEach((shop) => {
    shop.addEventListener('click', (event) => {
      event.preventDefault();
      const fullId = event.currentTarget.id;
      const id = fullId.match(/(marker-shop-)(\d)/)[2];
      form.value = id;
    })
  });
}

export { selectShop};
