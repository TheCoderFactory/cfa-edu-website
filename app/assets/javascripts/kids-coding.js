$(document).ready(function() {
  var weekend_prim = $('.weekend-primary-content');
  var weekend_sec = $('.weekend-secondary-content');
  weekend_sec.hide();
  var weekend_prim_btn = $('#weekend-prim-btn');
  weekend_prim_btn.addClass("active");
  var weekend_sec_btn = $('#weekend-sec-btn');
  $(weekend_prim_btn).on("click", function() {
    weekend_sec.hide();
    weekend_prim.fadeIn("slow");
    weekend_sec_btn.toggleClass("active");
    weekend_prim_btn.toggleClass("active");
  });
  $(weekend_sec_btn).on("click", function() {
    weekend_prim.hide();
    weekend_sec.fadeIn("slow");
    weekend_sec_btn.toggleClass("active");
    weekend_prim_btn.toggleClass("active");
  });
});
