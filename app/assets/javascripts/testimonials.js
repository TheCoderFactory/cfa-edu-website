var currTestimonial, mCurrentTestimonial;

function changeTestimonial(testimonial) {
  if (currTestimonial === undefined) currTestimonial = 3;
  if (testimonial > 5 || testimonial < 1) testimonial = 3;
  switchTestimonial("#testimonial-"+currTestimonial, "remove");
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

function nextTestimonial(direction) {
  if (currTestimonial === undefined) currTestimonial = 3;
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

function mobileNextTestimonial(direction) {
  if (mCurrentTestimonial === undefined) mCurrentTestimonial = 3;
  if (direction === "left") {
    if (mCurrentTestimonial === 1) changeMobileTestimonial(5);
    else changeMobileTestimonial(mCurrentTestimonial-1);
  } else if (direction === "right") {
    if (mCurrentTestimonial === 5) changeMobileTestimonial(1);
    else changeMobileTestimonial(mCurrentTestimonial+1);
  } else {
    changeMobileTestimonial(3);
  }
}

function switchTestimonial(t, status, mobile) {
  if (mobile === undefined) mobile = "";
  var add = (status === "active" ? "active-testimonial" : "inactive-testimonial" )
  var remove = (status === "active" ? "inactive-testimonial" : "active-testimonial")
  console.log(t);
  $(t).removeClass(mobile+remove);
  $(t).addClass(mobile+add);
  $(t+"-content").removeClass(mobile+remove+"-content");
  $(t+"-content").addClass(mobile+add+"-content");
}
