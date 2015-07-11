console.log("Jquery Version:",$().jquery, "Rahul's custom JS loaded!");

// When the user clicks on the View Projects button, scroll down smoothly

$(window).scroll(onScroll);
  window.onscroll = function(){
}

//function to scroll
function onScroll(){

    var scrolled = $(window).scrollTop();

        console.log("Updating Visibility to Navbar");

        // add the class "navbar-shrink" if we scroll
    if (scrolled>0) {
        $('nav').addClass('navbar-shrink');
    } else {
        $('nav').removeClass('navbar-shrink');
    }

}