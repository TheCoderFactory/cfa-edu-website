var originalPrice;
function validatePromoCode(){
  if (originalPrice === undefined) originalPrice = parseInt($('#course-price').text());
  $.ajax({
    type: "POST",
    url: "/validate-promo-code",
    data: {promocode: $('#get-promo-code').val()},
    success: function(data){
      if(data.success){
        price = parseInt($('#course-price').text());
        discount = data.percent
        $('#course-price').text(originalPrice*(100-discount)/100);
        $('#promo-code-error').text("");
      } else {
        $('#course-price').text(originalPrice);
        $('#promo-code-error').text("Promo code invalid.");
      }
    },
    dataType: 'json'
  });
}
