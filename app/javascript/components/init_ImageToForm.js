console.log('heya there!!')

const AddImageToForm = () => {
  const imgContainer = document.querySelector('.shop-show');
  document.querySelectorAll('.marker').forEach((markup) => {
    markup.addEventListener('click', (event) => {
      event.preventDefault();
      const markupImg = document.querySelector('.mapboxgl-popup-content').innerHTML.split('\n')[0];
      if (imgContainer.innerHTML === "") {
        imgContainer.insertAdjacentHTML('beforeend', markupImg);
      } else {
      imgContainer.firstElementChild.remove().insertAdjacentHTML('beforeend', markupImg);
      }
    })
  });
}

export { AddImageToForm } ;
