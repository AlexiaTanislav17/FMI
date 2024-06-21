

function openNav() {
    document.getElementById("myNav").style.height = "100%";
}

function closeNav() {
    document.getElementById("myNav").style.height = "0%";
}


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
  var slides = document.getElementsByClassName("slide");
  if (n > slides.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";  
  }

  slides[slideIndex-1].style.display = "block"; 
}


function getRandomColor() {
    const colors = ['#D9F2FF', '#78c093', '#1abc9c', '#DCB5FF', '#77529e'];
    const randomIndex = Math.floor(Math.random() * colors.length);
    return colors[randomIndex];
}

function startChangingColors() {
    let intervalId;
    intervalId = setInterval(function() {
        document.getElementById('title').style.color = getRandomColor();
    }, 3000); 
}

document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("title").click();
});


document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("myNav").click();
});

