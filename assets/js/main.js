var sectionHeight = function() {
  var total    = $(window).height(),
      $section = $('section').css('height','auto');

  if ($section.outerHeight(true) < total) {
    var margin = $section.outerHeight(true) - $section.height();
    $section.height(total - margin - 20);
  } else {
    $section.css('height','auto');
  }
}

$(window).resize(sectionHeight);

$(function() {
  $("section h1, section h2, section h3").each(function(){
    $("nav ul").append("<li class='tag-" + this.nodeName.toLowerCase() + "'><a href='#" + $(this).text().toLowerCase().replace(/ /g, '-').replace(/[^\w-]+/g,'') + "'>" + $(this).text() + "</a></li>");
    $(this).attr("id",$(this).text().toLowerCase().replace(/ /g, '-').replace(/[^\w-]+/g,''));
    $("nav ul li:first-child a").parent().addClass("active");
  });

  $("nav ul li").on("click", "a", function(event) {
    var position = $($(this).attr("href")).offset().top - 190;
    $("html, body").animate({scrollTop: position}, 400);
    $("nav ul li a").parent().removeClass("active");
    $(this).parent().addClass("active");
    event.preventDefault();
  });

  sectionHeight();

  $('img').on('load', sectionHeight);
});

const info = '[info]'
const debug = '[debug]'
/**
 * Triggers On DOM Load
 */
$(function () {
  const defaultHeight = 130;
  let headerHeight = $('header').height()
  headerHeight = headerHeight || defaultHeight;
  headerHeight = headerHeight > 0 ? headerHeight : defaultHeight;

  console.info('%s header-height: %s', info, headerHeight);

  $(window).scroll(function () {
    if ($(this).scrollTop() > headerHeight) { // Check if page is scrolled
      //console.debug('%s Scrolling Down: %s', debug, $(this).scrollTop())
      $('header').addClass('hidden'); // Hide the div
    } else {
      $('header').removeClass('hidden'); // Show the div
      //console.debug('%s Scrolled Top: %s', debug, $(this).scrollTop())
    }
  });
});
