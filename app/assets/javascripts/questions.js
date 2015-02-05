//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/
$( document ).ready(function() {
  // Adds another input field for talking point
  $("#addMore").click(function(event){
    event.preventDefault();
    $("#morePoints").append( '<input type="text" name="talking_point[phrase][]" id="talking_point_phrase" class="form-control spaced simple-form">' )
  });
});
