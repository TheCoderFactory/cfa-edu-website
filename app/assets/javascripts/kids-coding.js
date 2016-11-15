$(document).ready(function() {
  $(".weekend-secondary-content").hide();
  $("#weekend-prim-btn").addClass("active");
  showSelected("#weekend-prim", "#weekend-sec", ".weekend-primary", ".weekend-secondary");
  showSelected("#weekend-sec", "#weekend-prim", ".weekend-secondary", ".weekend-primary");
  $(".school-h-secondary-content").hide();
  $("#school-h-prim-btn").addClass("active");
  showSelected("#school-h-prim", "#school-h-sec", ".school-h-primary", ".school-h-secondary");
  showSelected("#school-h-sec", "#school-h-prim", ".school-h-secondary", ".school-h-primary");
});

function showSelected(show_btn, hide_btn, show_content, hide_content) {
  $(show_btn+"-btn").on("click", function() {
    $(hide_content+"-content").hide();
    $(show_content+"-content").fadeIn("slow");
    $(show_btn+"-btn").addClass("active");
    $(hide_btn+"-btn").removeClass("active");
  });
}
