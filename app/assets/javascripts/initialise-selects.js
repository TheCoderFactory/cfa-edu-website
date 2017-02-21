$(document).ready(function() {
  var syd_intakes = $('.syd-intakes');
  var mel_intakes = $('.mel-intakes');
  var expiry_date = $('.expiry-date');
  var number_of_uses = $('.number-of-uses');
  choose_selected(mel_intakes, syd_intakes, "#campus", "Sydney");
  choose_selected(number_of_uses, expiry_date, "#promo_code_code_type", "Expiry Date");
  var syd_intake_details = $('.intake-details-syd');
  choose_selected_intake_details(syd_intake_details, "#syd_intake")
  var mel_intake_details = $('.intake-details-mel');
  choose_selected_intake_details(mel_intake_details, "#mel_intake")
});

function choose_selected(opt1, opt2, id, value) {
  var selected = $(id).find(":selected").text();
  if (selected === value) {
    opt1.hide();
  } else {
    opt2.hide();
  }
  $(id).on("change",function() {
    var change_selected = this.value;
    if (change_selected === value) {
      opt1.hide();
      opt2.show();
    } else {
      opt1.show();
      opt2.hide();
    }
  });
}

function choose_selected_intake_details(options, id) {
  var selected = $(id).find(":selected").val();
  options.hide();
  $('#'+selected).show();
  $(id).on("change", function() {
    var change_selected = this.value;
    options.hide();
    $("#"+change_selected).show();
  });
}
