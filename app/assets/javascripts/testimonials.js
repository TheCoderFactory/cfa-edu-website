var currTestimonial, mCurrentTestimonial;

function changeTestimonial(testimonial) {
  if (currTestimonial === undefined) currTestimonial = 3;
  if (testimonial > 5 || testimonial < 1) testimonial = 3;
  switchTestimonial("#testimonial-"+currTestimonial, "inactive");
  switchTestimonial("#testimonial-"+testimonial, "active");
  currTestimonial = testimonial;
}

function changeMobileTestimonial(testimonial) {
  if (mCurrentTestimonial === undefined) mCurrentTestimonial = 3;
  if (testimonial > 5 || testimonial < 1) mCurrentTestimonial = 3;
  switchTestimonial("#mobile-testimonial-"+mCurrentTestimonial, "inactive", "mobile-");
  switchTestimonial("#mobile-testimonial-"+testimonial, "active", "mobile-");
  mCurrentTestimonial = testimonial;
}

function nextTestimonial(direction, mobile) {
  if (currTestimonial === undefined) currTestimonial = 3;
  if (mCurrentTestimonial === undefined) mCurrentTestimonial = 3;
  var t = (mobile ? mCurrentTestimonial : currTestimonial);
  var fun = (mobile ? changeMobileTestimonial : changeTestimonial);
  if (direction === "left") {
    if (t === 1) fun(5);
    else fun(t-1);
  } else if (direction === "right") {
    if (t === 5) fun(1);
    else fun(t+1);
  } else {
    fun(3);
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
