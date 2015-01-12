jQuery(function($) {
  $('#purchaseButton').click(function(e) {
    e.preventDefault();
    var $form = $(this);

    // Disable the submit button to prevent repeated clicks
    $form.find('button').prop('disabled', true);

    // Stripe.card.createToken($form, stripeResponseHandler);

    // Prevent the form from submitting with the default action

    
    balanced.init('/v1/marketplaces/TEST-MP3hv19s9WbPESuP8W2kKoqu/transactions');
    // balanced.init('/v1/marketplaces/MP2zvxosS3lVYf0xYghItBbO/transactions');
    var $form = $('.new_purchase');
    // var creditCardData = {
    //     card_number: 
    //     expiration_month: 
    //     expiration_year: 
    //     security_code: 
    //  };
        //  };
    var select_id, item;
    var item_list = ["price","cc_name","card_number","card_month","card_year","card_code","postal_code","email"];
    for( i in item_list){
      select_id = "#"+item_list[i];
      item = $(select_id).val();
      // var item = $('#cc_name').val()
      console.log('item?')
      console.log(item);
      if(item == ""){
        $('label[for='+item_list[i]+']').css('color','red')
      } else {
        $('label[for='+item_list[i]+']').css('color','black')
      }  
    }
    var payload = {
      name: $('#cc_name').val(),
      number: $form.find('#card_number').val(),
      expiration_month: $form.find('#card_month').val(),
      expiration_year: $form.find('#card_year').val(),
      cvv: $form.find('#card_code').val(),
      address: {
        postal_code: $('#postal_code').val()
      }    
    }



    console.log(payload, "creditCardData");
    
    // 
    // balanced.card.create(payload, function(response) {
    // console.log(response)

    // console.log(response.cards,"response.cards",response.cards[0].href);
    //  })

    balanced.card.create(payload, function(response) {
      console.log(response.status_code, "balanced response status");
      // console.log("balanced Card Create!");
  
      switch (response.status_code) {
        case 201:
            // WOO HOO! MONEY!
            // response.data.uri == URI of the bank account resource you
            // can store this card URI in your database
            // console.log(response.data);
            // var $form = $("#credit-card-form");
            // the uri is an opaque token referencing the tokenized card
            // var cardTokenURI = response.data['uri'];
            superAwesome  = response
            console.log(response.cards,"response.cards");
            // append the token as a hidden field to submit to the server
            // $('<input>').attr({
            //    type: 'hidden',
            //    value: cardTokenURI,
            //    name: 'balancedCreditCardURI'
            // }).appendTo($form);

           $('<input>').attr({
               type: 'hidden',
               value: response.cards[0].href,
               name: 'balancedCreditCardURI'
            }).appendTo($form);
           $('.new_purchase').submit()
            break;
        case 400:
            // missing field - check response.error for details
            console.log(response.error);
            break;
        case 402:
            // we couldn't authorize the buyer's credit card
            // check response.error for details
            console.log(response.error);
            break
        case 404:
            // your marketplace URI is incorrect
            console.log(response.error);
            break;
        case 500:
            // Balanced did something bad, please retry the request
        break;
      }     
    });     
  });
});