  in_zip_range = function(zip,range){
    // var i = 0;
    if(zip >= range[0] && zip <= range[1]){
      return true;  
    } else{
      return false
    }
  }
  in_texas = function (){
      // texas_zips = [73301,75001,75503-79999,88510-88589];
      var texas_zips  = [73301,75001]; 
      var zip_range_1 = [75503,79999];
      var zip_range_2 = [88510,88589];
      // zip_ranges = [79999,75503];
      var lives_in_texas = false
      var zip_code = $("#postal_code").val()
      var i = 0
      for( i in texas_zips){
        if(texas_zips[i] == zip_code){
          lives_in_texas = true;
        }
        i+=1
      }
      if(lives_in_texas == false){
        lives_in_texas = in_zip_range(zip_code,zip_range_1)
      }

      if(lives_in_texas == false){
        lives_in_texas = in_zip_range(zip_code,zip_range_2)
      }

    return lives_in_texas;
  };


jQuery(function($) {  
  $('#coupon_code').change(function(){
    console.log($(this).val());
    if (($(this).val() === "restofus" || $(this).val() === "therestofus") && in_texas() == false ){
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
    if ($(this).val() === "volunteerluminosa2014" ){
      $("#number_of_tickets").val(1)
      var new_price = 88.00;
      $('#price').val(new_price);
      $('#display_price').val(new_price);
    }
  }) 

  $('#number_of_tickets').change(function(){
    var price = 188.00; 
    var coupon_code = $('#coupon_code').val();
    if ((coupon_code === "restofus" || coupon_code === "therestofus") && in_texas() == false){
      price = 111.00;
    }     
    if (coupon_code=== "volunteerluminosa2014" ){
       $("#number_of_tickets").val(1)
       price = 88.00; 
    }
    var new_price = price * $(this).val();
    $('#price').val(new_price)
    $('#display_price').val(new_price)
  }) 
});