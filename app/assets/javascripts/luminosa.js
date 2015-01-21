jQuery(function($) {
  $('#coupon_code').change(function(){
    console.log($(this).val());
    if ($(this).val() === "restofus" ){
      var number_of_tickets = $("#number_of_tickets").val()
      var new_price = 111.00 * number_of_tickets;
      $('#price').val(new_price)
      $('#display_price').val(new_price)
    } else {

       var price = 188.00; 
       var new_price = price * $('#number_of_tickets').val();
       $('#price').val(new_price)
       $('#display_price').val(new_price)
    }

  }) 

  $('#number_of_tickets').change(function(){
    var price = 188.00; 
    var coupon_code = $('#coupon_code').val();
    if (coupon_code === "restofus" ){
      price = 111.00;
    }     
    var new_price = price * $(this).val();
    $('#price').val(new_price)
    $('#display_price').val(new_price)
  }) 
});