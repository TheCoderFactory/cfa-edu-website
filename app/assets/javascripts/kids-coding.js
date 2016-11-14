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
  var sh_prim = $('.school-h-primary-content');
  var sh_sec = $('.school-h-secondary-content');
  sh_sec.hide();
  var sh_prim_btn = $('#school-h-prim-btn');
  sh_prim_btn.addClass("active");
  var sh_sec_btn = $('#school-h-sec-btn');
  $(sh_prim_btn).on("click", function() {
    sh_sec.hide();
    sh_prim.fadeIn("slow");
    sh_sec_btn.toggleClass("active");
    sh_prim_btn.toggleClass("active");
  });
  $(sh_sec_btn).on("click", function() {
    sh_prim.hide();
    sh_sec.fadeIn("slow");
    sh_sec_btn.toggleClass("active");
    sh_prim_btn.toggleClass("active");
  });
});
