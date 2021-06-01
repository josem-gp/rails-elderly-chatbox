
const selectShop = () => {
  const form = document.querySelector('.hidden > input');
  document.querySelectorAll('.marker').forEach((shop) => {
    shop.addEventListener('click', (event) => {
      event.preventDefault();
      const fullId = event.currentTarget.id;
      const id = fullId.match(/(marker-shop-)(\d)/)[2];
      form.value = id;

      const markers = JSON.parse(document.getElementById('map').dataset.markers);
      const marker = markers.find(marker => marker.id == id);
      console.log(marker);
    })
  });
}

export { selectShop};
