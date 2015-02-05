// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$( document ).ready(function() {
  // sets submit button to hide at page load
  submit_display();

  if (!('webkitSpeechRecognition' in window)) {
    alert("Sorry, this page only works in Google Chrome v. 25 and up, or Safari v. 7.1 and up");
    upgrade();
  } else {
    console.log("Upgrade not needed.")
    var recognition = new webkitSpeechRecognition();
    recognition.lang = "en-US";
    var recognizing = false;
    var final_transcript = '';

    // Sets the default to 5 mins unbroken recording
    recognition.continuous = true;
    // Allows user to see interim transcription results
    recognition.interimResults = true;

    // Prompts user to allow mic, starts the actual recording
    $('#startRecording').click(function(){
      recognition.start()
    });

    // Fires when recognition.start is called
    recognition.onstart = function() {
      console.log("I'm starting.");
      recognizing = true;
    }

    // Generates transcription results
    recognition.onresult = function(event) {
      var interim_transcript = 'HI INTERIM TRANSCRIPT ';
      for (var i = event.resultIndex; i < event.results.length; ++ i) {
        if (event.results[i].isFinal) {
          final_transcript += event.results[i][0].transcript;
          // Fix capitalization at a later date. This only capitalizes first letter.
          final_transcript = capitalize(final_transcript);
          $('#results').val(final_transcript);
        } else {
          interim_transcript += event.results[i][0].transcript;
          $('#results').val(interim_transcript);
        }
        // Writes to form input

        console.log("Interim " + interim_transcript);
        console.log("Final " + final_transcript);
      }
    }

    // Ends the recording session
    $('#endRecording').click(function(){
      console.log("End recording");
      recognizing = false;
      recognition.stop();
      submit_display();
    });

  } // Ends the else block if window contains webkit Speech API

  ///~~** STRING FORMATTING FUNCTIONS **~~///

  // Capitalizes the first letter of a string.
  function capitalize(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
  };

  ///~~** PAGE FUNCTIONALITY FUNCTIONS **~~///

  // Controls visibility of submit button
  function submit_display() {
    console.log("The hide function is here!")
    $("#submit").toggle();
  }

}); // Ends the document.ready page load function
