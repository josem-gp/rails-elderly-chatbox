console.log("hi");

const callAPI = () => {
  fetch("https://good-neighbour-api.herokuapp.com/api/v1/shops")
    .then(response => response.json())
    .then((data) => {
      console.log(data);
    });
}

console.log("heya")

export { callAPI };
