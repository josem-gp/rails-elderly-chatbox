
const hoverShop = (shop) => {
  shop.addEventListener('mouseover', (event) => {
    console.log('heya!');
    event.preventDefault();
    event.currentTarget.classList.toggle("marker-lg");
  })
}

export { hoverShop };
