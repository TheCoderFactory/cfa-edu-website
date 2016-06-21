var originalPrice, currentSection;
$(document).ready(function() {
  currentSection = 1;
  $('#section-2').hide();
  $('#section-3').hide();
  $('#prev-btn').hide();
  $('#submit-btn').hide();
});
function nextSection() {
  $('#section-'+currentSection).hide();
  if (currentSection != 3) currentSection++;
  $('#section-'+currentSection).show();
  if (currentSection === 3) {
    $('#next-btn').hide();
    $('#submit-btn').show();
  }
  $('#prev-btn').show();
  // window.scrollTo(0, 0);
}
function prevSection() {
  $('#section-'+currentSection).hide();
  $('#submit-btn').hide();
  if (currentSection != 1) currentSection--;
  $('#section-'+currentSection).show();
  if (currentSection === 1) $('#prev-btn').hide();
  $('#next-btn').show();
  // window.scrollTo(0, 0);
}
function validatePromoCode(){
  if (originalPrice === undefined) originalPrice = parseInt($('#course-price').text());
  $.ajax({
    type: "POST",
    url: "/validate-promo-code",
    data: {promocode: $('#booking_promo_code').val()},
    success: function(data){
      if(data.success){
        price = parseInt($('#course-price').text());
        discount = data.percent
        $('#course-price').text(originalPrice*(100-discount)/100);
        $('#promo-code-status').text("Valid");
        $('#discount-amount').text(discount);
      } else {
        $('#course-price').text(originalPrice);
        $('#promo-code-status').text("Invalid.");
        $('#discount-amount').text(0);
      }
    },
    dataType: 'json'
  });
}
