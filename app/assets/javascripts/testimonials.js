var currTestimonial = 3;

$(document).ready(function () {
  $("#testimonial-1-content").hide();
  $("#testimonial-2-content").hide();
  $("#testimonial-3-content").show();
  $("#testimonial-4-content").hide();
  $("#testimonial-5-content").hide();
  $("#testimonial-3").removeClass('inactive-testimonial');
  $("#testimonial-3").addClass('active-testimonial');
});

function changeTestimonial(testimonial) {
  // console.log("#testimonial-"+currTestimonial);
  $("#testimonial-"+currTestimonial).addClass('inactive-testimonial');
  $("#testimonial-"+currTestimonial).removeClass('active-testimonial');
  $("#testimonial-"+currTestimonial+"-content").hide();
  $("#testimonial-"+testimonial).removeClass('inactive-testimonial');
  $("#testimonial-"+testimonial).addClass('active-testimonial');
  $("#testimonial-"+testimonial+"-content").show();
  console.log(testimonial);
  console.log(currTestimonial);
  currTestimonial = testimonial;
}

function nextTestimonial(direction) {
  if (direction === "left") {
    if (currTestimonial === 1) changeTestimonial(5);
    else changeTestimonial(currTestimonial-1);
  } else {
    if (currTestimonial === 5) changeTestimonial(1);
    else changeTestimonial(currTestimonial+1);
  }
}
