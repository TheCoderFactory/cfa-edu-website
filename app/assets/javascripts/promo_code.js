function validatePromoCode(){
  $.ajax({
    type: "POST",
    url: '/validate-promo-code',
    data: {promocode: $('#get-promo-code').val()},
    success: function(data){
      console.log(data);
      if(data.success){
        console.log("WIN");
      } else {
        console.log("LOSE");
      }
    },
    dataType: 'json'
  });
}
