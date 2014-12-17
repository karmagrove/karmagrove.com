 jQuery(function($) {
   $('.edit_purchase').submit(function(event) {
     var $form = $(this);

     // Disable the submit button to prevent repeated clicks
     $form.find('button').prop('disabled', true);

     // Stripe.card.createToken($form, stripeResponseHandler);

     // Prevent the form from submitting with the default action


     balanced.init('/v1/marketplaces/TEST-MP3hv19s9WbPESuP8W2kKoqu/transactions');
     
     var $form = $('.edit_purchase');
     var creditCardData = {
         card_number: $form.find('#card_number').val(),
         expiration_month: $form.find('#card_month').val(),
         expiration_year: $form.find('#card_year').val(),
         security_code: $form.find('#card_code').val()
      };
     
      balanced.card.create(creditCardData, function(response) {
       console.log(response.status, "response status");
       console.log("balanced Card Create!");

       switch (response.status) {
         case 201:
             // WOO HOO! MONEY!
             // response.data.uri == URI of the bank account resource you
             // can store this card URI in your database
             console.log(response.data);
             // var $form = $("#credit-card-form");
             // the uri is an opaque token referencing the tokenized card
             var cardTokenURI = response.data['uri'];
             console.log(cardTokenURI,"cardTokenURI");
             // append the token as a hidden field to submit to the server
             $('<input>').attr({
                type: 'hidden',
                value: cardTokenURI,
                name: 'balancedCreditCardURI'
             }).appendTo($form);
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
       /*
         response.data:
           Contains the body of the card resource, which you can find
           in the API reference.
     
           This data is an object, i.e. hash, that can be identified by
           its uri field. You may store this uri in your data store (e.g.
           postgresql, mysql, mongodb, etc) since it's perfectly safe and
           can only be retrieved by your secret key.
     
           More on this in the API reference.
        */
       console.log(response.data);
     });     
     return false;
   });
 });

// var stripeResponseHandler = function(status, response) {
//   var $form = $('.edit_purchase');

//   if (response.error) {
//     // Show the errors on the form
//     $form.find('.payment-errors').text(response.error.message);
//     $form.find('button').prop('disabled', false);
//   } else {
//     // token contains id, last4, and card type
//     var token = response.id;
//     // Insert the token into the form so it gets submitted to the server
//     $form.append($('<input type="hidden" name="stripeToken" />').val(token));
//     // and submit
//     $form.get(0).submit();
//   }
// };
jQuery(function($) {


});