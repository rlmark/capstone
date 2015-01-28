// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$( document ).ready(function() {
  if (!('webkitSpeechRecognition' in window)) {
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

    // Generates results
    recognition.onresult = function(event) {
      var interim_transcript = '';
      for (var i = event.resultIndex; i < event.results.length; ++ i) {
        if (event.results[i].isFinal) {
          final_transcript += event.results[i][0].transcript;
          final_transcript = capitalize(final_transcript) + " ";
        } else {
          interim_transcript += event.results[i][0].transcript;
        }
        // fix capitalization at a later date. only capitalizes first letter.
        $('#results').val(final_transcript);

        console.log("Interim " + interim_transcript);
        console.log("Final " + final_transcript);
      }
    }

    // Ends the recording session
    $('#endRecording').click(function(){
      console.log("End recording")
      recognizing = false
      recognition.stop()
    });

  } // Ends the else block if window contains webkit Speech API

  /// FORMATTING FUNCTIONS ///

  // Capitalizes the first letter of a string.
  function capitalize(string) {
    console.log("Capitalize function gets called");
    console.log(string);
    console.log(string.charAt(0).toUpperCase());
    console.log(string.slice(1));
    console.log(string.charAt(0).toUpperCase() + string.slice(1));

    return string.charAt(0).toUpperCase() + string.slice(1);
  };

}); // Ends the document.ready page load function
