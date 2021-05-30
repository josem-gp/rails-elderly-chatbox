console.log("Hi there 3!");

const form = document.querySelector('.shop-show');

const selectShop = () => {
  document.querySelectorAll('.marker').forEach((shop) => {
    shop.addEventListener('click', (event) => {
      event.preventDefault();
      const fullId = event.currentTarget.id;
      const id = fullId.match(/(marker-shop-)(\d)/)[2];
      console.log(id);
    })
  });
}

export { selectShop};
