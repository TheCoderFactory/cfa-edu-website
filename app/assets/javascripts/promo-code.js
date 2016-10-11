$(document).ready(function() {
  var code_type = $('#promo_code_code_type').find(":selected").text();
  var expiry_date = $('.expiry-date');
  var number_of_uses = $('.number-of-uses');
  if (code_type === "Expiry Date") {
    number_of_uses.hide();
  } else {
    expiry_date.hide();
  }
  $("#promo_code_code_type").on("change",function() {
    var code_type = this.value;
    if (code_type === "Expiry Date") {
      number_of_uses.hide();
      expiry_date.show();
    } else {
      number_of_uses.show();
      expiry_date.hide();
    }
  });
});
