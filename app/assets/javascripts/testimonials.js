var currTestimonial = 3;
var mCurrentTestimonial = 3;

function changeTestimonial(testimonial) {
  if (testimonial > 5 || testimonial < 1) testimonial = 3;
  switchTestimonial("#testimonial-"+currTestimonial, "inactive");
  switchTestimonial("#testimonial-"+testimonial, "active");
  currTestimonial = testimonial;
}

function changeMobileTestimonial(testimonial) {
  if (testimonial > 5 || testimonial < 1) mCurrentTestimonial = 3;
  switchTestimonial("#mobile-testimonial-"+mCurrentTestimonial, "inactive", "mobile-");
  switchTestimonial("#mobile-testimonial-"+testimonial, "active", "mobile-");
  mCurrentTestimonial = testimonial;
}

function nextTestimonial(direction, mobile) {
  var t = (mobile ? mCurrentTestimonial : currTestimonial);
  var fun = (mobile ? changeMobileTestimonial : changeTestimonial);
  if (direction === "left") {
    if (t === 1) t=6;
    fun(t-1);
  } else {
    if (t === 5) t=0;
    fun(t+1);
  }
}

function switchTestimonial(t, status, mobile) {
  if (mobile === undefined) mobile = "";
  var add = (status === "active" ? "active-testimonial" : "inactive-testimonial" )
  var remove = (status === "active" ? "inactive-testimonial" : "active-testimonial")
  $(t).removeClass(mobile+remove);
  $(t).addClass(mobile+add);
  $(t+"-content").removeClass(mobile+remove+"-content");
  $(t+"-content").addClass(mobile+add+"-content");
}
