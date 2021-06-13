import { hoverShop } from './init_hoverShop';


const selectShop = () => {
  const form = document.querySelector('.hidden > input');
  const shopContainer = document.querySelector('.shop-show');
  const imgContainer = document.querySelector('.shop-img');
  const infoContainer = document.querySelector('.shop-info');
  document.querySelectorAll('.marker').forEach((shop) => {
    // hoverShop(shop);
    shop.addEventListener('click', (event) => {
      event.preventDefault();
      const fullId = event.currentTarget.id;
      const id = fullId.match(/(marker-shop-)(\d+)/)[2];
      form.value = id;


      const markers = JSON.parse(document.getElementById('map').dataset.markers);
      const marker = markers.find(marker => marker.id == id);
      const markerImg = marker.info_window.split('\n')[0];
      const markerTitle = marker.info_window.split('\n')[1];
      const markerAddress = marker.info_window.split('\n')[2];
      const markerPhone = marker.info_window.split('\n')[3];
      const markerWebsite = marker.info_window.split('\n')[4];

      if (imgContainer.innerHTML === "") {
        imgContainer.insertAdjacentHTML('beforeend', markerImg);
        infoContainer.insertAdjacentHTML('beforeend', markerTitle);
        infoContainer.insertAdjacentHTML('beforeend', `<div class='icon-info'><i class="fas fa-map icon-descr"></i>${markerAddress}</div>`);
        infoContainer.insertAdjacentHTML('beforeend', `<div class='icon-info'><i class="fas fa-phone-square-alt icon-descr"></i>${markerPhone}</div>`);
        infoContainer.insertAdjacentHTML('beforeend', `<div class='icon-info'><i class="fas fa-info-circle icon-descr"></i>${markerWebsite}</div>`);

      } else {
        shopContainer.firstElementChild.remove();
        shopContainer.firstElementChild.remove();

        shopContainer.insertAdjacentHTML('beforeend', '<div class="shop-img"></div>');
        shopContainer.insertAdjacentHTML('beforeend', '<div class="shop-info"></div>');

        const newImgContainer = document.querySelector('.shop-img');
        const newInfoContainer = document.querySelector('.shop-info');

        newImgContainer.insertAdjacentHTML('beforeend', markerImg);
        newInfoContainer.insertAdjacentHTML('beforeend', markerTitle);
        newInfoContainer.insertAdjacentHTML('beforeend', `<div class='icon-info'><i class="fas fa-map icon-descr"></i>${markerAddress}</div>`);
        newInfoContainer.insertAdjacentHTML('beforeend', `<div class='icon-info'><i class="fas fa-phone-square-alt icon-descr"></i>${markerPhone}</div>`);
        newInfoContainer.insertAdjacentHTML('beforeend', `<div class='icon-info'><i class="fas fa-info-circle icon-descr"></i>${markerWebsite}</div>`);
      }
    })
  });
}

export { selectShop};
