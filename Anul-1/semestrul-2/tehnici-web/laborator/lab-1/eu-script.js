var slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("slides");
  if (n > slides.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";  
  }
  slides[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " active";
}


// function f(){
//     var nume = prompt("salut");
//     document.querySelector("title").innerHTML = "!" + nume + "!";
// }
//  f();







// function f2(){
//     var ob = document.querySelector("h1>span"),
//     ob.innerHTML = v[Math.floor()]
// }
// asta nu merge ca nu e complet








