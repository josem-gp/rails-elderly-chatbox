
const selectShop = () => {
  const form = document.querySelector('.hidden > input');
  const imgContainer = document.querySelector('.shop-show');
  document.querySelectorAll('.marker').forEach((shop) => {
    shop.addEventListener('click', (event) => {
      event.preventDefault();
      const fullId = event.currentTarget.id;
      const id = fullId.match(/(marker-shop-)(\d+)/)[2];
      form.value = id;


      const markers = JSON.parse(document.getElementById('map').dataset.markers);
      const marker = markers.find(marker => marker.id == id);
      const markerImg = marker.info_window.split('\n')[0];
      const markerTitle = marker.info_window.split('\n')[1];
      if (imgContainer.innerHTML === "") {
        imgContainer.insertAdjacentHTML('beforeend', markerImg);
        imgContainer.insertAdjacentHTML('beforeend', markerTitle);
      } else {
        imgContainer.firstElementChild.remove();
        imgContainer.firstElementChild.remove();
        imgContainer.insertAdjacentHTML('beforeend', markerImg);
        imgContainer.insertAdjacentHTML('beforeend', markerTitle);
      }
    })
  });
}

export { selectShop};
