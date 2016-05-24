var currTestimonial, mCurrentTestimonial;

function changeTestimonial(testimonial) {
  if (currTestimonial === undefined) currTestimonial = 3;
  if (testimonial > 5 || testimonial < 1) testimonial = 3;
  hideTestimonial(currTestimonial);
  showTestimonial(testimonial);
  currTestimonial = testimonial;
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
    mHideTestimonial(mCurrentTestimonial);
    if (mCurrentTestimonial === 1) {
      mShowTestimonial(5);
      mCurrentTestimonial = 5;
    } else {
      mShowTestimonial(mCurrentTestimonial-1);
      mCurrentTestimonial--;
    }
  } else if (direction === "right") {
    mHideTestimonial(mCurrentTestimonial);
    if (mCurrentTestimonial === 5) {
      mShowTestimonial(1);
      mCurrentTestimonial = 1;
    } else {
      mShowTestimonial(mCurrentTestimonial+1);
      mCurrentTestimonial++;
    }
  } else {
    mHideTestimonial(mCurrentTestimonial);
    mShowTestimonial(3);
    mCurrentTestimonial = 3;
  }
}

function showTestimonial(t) {
  $("#testimonial-"+t).removeClass('inactive-testimonial');
  $("#testimonial-"+t).addClass('active-testimonial');
  $("#testimonial-"+t+"-content").removeClass('inactive-testimonial-content');
  $("#testimonial-"+t+"-content").addClass('active-testimonial-content');
}

function hideTestimonial(t) {
  $("#testimonial-"+t).removeClass('active-testimonial');
  $("#testimonial-"+t).addClass('inactive-testimonial');
  $("#testimonial-"+t+"-content").addClass('inactive-testimonial-content');
  $("#testimonial-"+t+"-content").removeClass('active-testimonial-content');
}

function mShowTestimonial(t) {
  $("#mobile-testimonial-"+t).removeClass('mobile-inactive-testimonial');
  $("#mobile-testimonial-"+t).addClass('mobile-active-testimonial');
  $("#mobile-testimonial-"+t+"-content").removeClass('mobile-inactive-testimonial');
  $("#mobile-testimonial-"+t+"-content").addClass('mobile-active-testimonial');
}

function mHideTestimonial(t) {
  $("#mobile-testimonial-"+t).removeClass('mobile-active-testimonial');
  $("#mobile-testimonial-"+t).addClass('mobile-inactive-testimonial');
  $("#mobile-testimonial-"+t+"-content").addClass('mobile-inactive-testimonial');
  $("#mobile-testimonial-"+t+"-content").removeClass('mobile-active-testimonial');
}
