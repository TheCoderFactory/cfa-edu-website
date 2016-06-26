var originalPrice, currentDiscount, currentSection;
$(document).ready(function() {
  price = $('#course-price').text();
  if (originalPrice === undefined) originalPrice = parseInt(price.replace(/[$]/, ""));
  currentSection = 1;
  currentDiscount = 0;
  $('#section-2').hide();
  $('#section-3').hide();
  $('#prev-btn').hide();
  $('#submit-btn').hide();
  $('#next-btn').show();
  $('#validate-promo-btn').hide();
});
function nextSection() {
  $('#section-'+currentSection).hide();
  if (currentSection != 3) currentSection++;
  $('#section-'+currentSection).show();
  var selected_intake = $('#booking_intake_id').find(":selected").text();
  var people_attending = $('#booking_people_attending').find(":selected").text();
  var first_name = $('#booking_firstname').val();
  var last_name = $('#booking_lastname').val();
  var age = $('#booking_age').val();
  var email = $('#booking_email').val();
  var phone = $('#booking_phone').val();
  var city = $('#booking_city').val();
  var country = $('#booking_country').find(":selected").text();
  $('#selected-intake').text(selected_intake);
  $('#amount-attending').text(people_attending);
  $('#name').text(first_name+' '+last_name);
  $('#age').text(age);
  $('#email').text(email);
  $('#phone').text(phone);
  $('#city').text(city);
  $('#country').text(country);
  var per_person_cost = originalPrice;
  var given_promo_code = $('#booking_promo_code').val();
  var discount = currentDiscount;
  var total_price = (originalPrice*people_attending*(1-discount*0.01)).toFixed(2);
  var gst = (total_price*0.1).toFixed(2);
  var total_gst_price = (parseFloat(total_price)+parseFloat(gst)).toFixed(2);
  $('#per-person-cost').text(per_person_cost);
  $('#given-promo-code').text(given_promo_code);
  $('#promo-discount').text(discount);
  $('#total-price').text(total_price);
  $('#gst').text(gst);
  $('#total-gst-price').text(total_gst_price);
  showButtons();
}
function prevSection() {
  $('#section-'+currentSection).hide();
  if (currentSection != 1) currentSection--;
  $('#section-'+currentSection).show();
  showButtons();
}
function showButtons() {
  if (currentSection === 1) {
    $('#next-btn').show();
    $('#validate-promo-btn').hide();
    $('#submit-btn').hide();
    $('#prev-btn').hide();
  }
  if (currentSection === 2) {
    $('#next-btn').hide();
    $('#validate-promo-btn').show();
    $('#submit-btn').hide();
    $('#prev-btn').show();
  }
  if (currentSection === 3) {
    $('#next-btn').hide();
    $('#validate-promo-btn').hide();
    $('#submit-btn').show();
    $('#prev-btn').show();
  }
}
function validatePromoCode(){
  $.ajax({
    type: "GET",
    url: "/validate-promo-code",
    data: {promocode: $('#booking_promo_code').val()},
    success: function(data){
      if(data.success){
        price = parseInt($('#course-price').text());
        currentDiscount = data.percent;
        $('#course-price').text(originalPrice*(1-currentDiscount*0.01));
        $('#promo-code-status').text("Valid");
        nextSection();
      } else {
        currentDiscount = 0;
        $('#course-price').text(originalPrice);
        $('#promo-code-status').text("Invalid.");
      }
    },
    dataType: 'json'
  });
}
