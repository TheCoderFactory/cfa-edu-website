$(document).ready(function() {
  var selected_campus = $('#campus').find(":selected").text();
  var syd_intakes = $('.syd-intakes');
  var mel_intakes = $('.mel-intakes');
  if (selected_campus === "Sydney") {
    mel_intakes.hide();
  } else {
    syd_intakes.hide();
  }
  $("#campus").on("change",function() {
    var change_campus = this.value;
    if (change_campus === "Sydney") {
      mel_intakes.hide();
      syd_intakes.show();
    } else {
      mel_intakes.show();
      syd_intakes.hide();
    }
  });
});
