const newscontainer = document.querySelector(".container");
function rendernews(data) {
  const html = `
  
  <div class="content">
        <div class="img"><img src=${data.imageurl} alt="" srcset="" /></div>
        <div class="text">
          <h1 class="title">
            ${data.title}
          </h1>
          <p class="tags">${data.categories}</p>
          <p class="body">${data.body}</p>
          <a href=${data.url}  target="_blank"><p>Read more</p></a>
        </div>
      </div>

`;
  newscontainer.insertAdjacentHTML("beforeend", html);
}
const request = fetch(
  `https://min-api.cryptocompare.com/data/v2/news/?lang=EN`
).then(function (response) {
  return response.json().then(function (data) {
    console.log("Welcome to my website ...");


    for (i = 0; i <= 50; i++) {
      rendernews(data["Data"][i]);
    }
  });
});
