// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

// show demo on click
$( document ).ready(function() {



  if (!('webkitSpeechRecognition' in window)) {
    alert("Sorry, this page only works in Google Chrome v. 25 and up, or Safari v. 7.1 and up");
    upgrade();
  } else {
    //console.log("Upgrade not needed.")
    var recognition = new webkitSpeechRecognition();
    recognition.lang = "en-US";
    var recognizing = false;
    var final_transcript = '';

    // Sets the default to 5 mins unbroken recording
    recognition.continuous = false;
    // Allows user to see interim transcription results
    recognition.interimResults = true;

    // Prompts user to allow mic, starts the actual recording
    $("#big-mic-home").click(function(event){
      $("#bio-form").fadeIn();
      recognition.start();
    });

    // Fires when recognition.start is called
    recognition.onstart = function() {
      console.log("I'm starting.");
      recognizing = true;
    }

    // This gets run after recognition.stop processes
    recognition.onend = function() {
      recognizing = false;
    }

    // In the event of an error, this will get called
    recognition.onerror = function(e) {
      alert(e.error + " \n" + e.message);
    }

    // Generates transcription results
    recognition.onresult = function(event) {
      // note it accesses the mic, but not this on mobile.
      var interim_transcript = '';
      for (var i = event.resultIndex; i < event.results.length; ++ i) {
        if (event.results[i].isFinal) {
          final_transcript += event.results[i][0].transcript;
          // final_transcript = capitalize(final_transcript) + " ";
          $('#bio-form').val(final_transcript);
          
        } else {
          interim_transcript += event.results[i][0].transcript;
          $('#bio-form').val(interim_transcript);
        }
      }
    }

    // Ends the recording session
    // $('.endRecording').click(function(){
    //   console.log("End recording");
    //   recognition.stop();
    // });

  } // Ends the else block if window contains webkit Speech API

});
