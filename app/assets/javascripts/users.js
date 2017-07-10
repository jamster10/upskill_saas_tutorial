// Document ready
/* global $ */
/* global Stripe */

$(document).on('turbolinks:load', function(){
  var theForm = $('#pro_form');
  var submitBtn = $('#form-submit-btn');
  
  //set Stripe public key
  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
  
  //When user clicks form submit prevent default submission behavior
  submitBtn.click(function(event){
    event.preventDefault();
    
     //collect credi card fields
     var ccNum = $('#card_number').val(),
         cvcNum =$('#card_code').val(),
         expMonth  = $('#card_month').val(),
         expYear = $('#card_year').val();
         
  //send info to Stripe
  
  Stripe.createToken({
    number: ccNum,
    cvc: cvcNum,
    exp_month: expMonth,
    exp_year: expYear
  }, stripeResponseHandler);
  //receive card token and inject.
    
  });
  
 
  //submit form

})