var currTestimonial;

function changeTestimonial(testimonial) {
  if (currTestimonial === undefined) currTestimonial = 3;
  if (testimonial > 5 || testimonial < 1) testimonial = 3;
  $("#testimonial-"+currTestimonial).removeClass('active-testimonial');
  $("#testimonial-"+currTestimonial).addClass('inactive-testimonial');
  $("#testimonial-"+currTestimonial+"-content").addClass('inactive-testimonial-content');
  $("#testimonial-"+currTestimonial+"-content").removeClass('active-testimonial-content');
  $("#testimonial-"+testimonial).removeClass('inactive-testimonial');
  $("#testimonial-"+testimonial).addClass('active-testimonial');
  $("#testimonial-"+testimonial+"-content").removeClass('inactive-testimonial-content');
  $("#testimonial-"+testimonial+"-content").addClass('active-testimonial-content');
  currTestimonial = testimonial;
}

function nextTestimonial(direction) {
  if (direction === "left") {
    if (currTestimonial === 1) changeTestimonial(5);
    else changeTestimonial(currTestimonial-1);
  } else if (direction === "right") {
    if (currTestimonial === 5) changeTestimonial(1);
    else changeTestimonial(currTestimonial+1);
  } else {
    changeTestimonial(3);
  }
}
