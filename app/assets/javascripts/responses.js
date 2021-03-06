// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$( document ).ready(function() {
  // sets submit button to hide at page load
  //submit_display();

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
    recognition.continuous = true;
    // Allows user to see interim transcription results
    recognition.interimResults = true;

    // Prompts user to allow mic, starts the actual recording
    // Starts and pauses timer, pause the recording
    var playIconHtml = "<i class='fa fa-play fa-2x'></i>";
    var pauseIconHtml = "<i class='fa fa-pause fa-2x'></i>";
    $('#play').click(function(){
      var currentMode = $(this).attr('currentMode');
      if (currentMode == "play") {
        // get the current MM:SS, convert to seconds
        t = getTotalTime();
        if (t < 0) {
          alert('Use numbers only, < 5 minutes');
          return;
        }
        //update progress component
        totaltime = t;
        // lock out the inputs
        $('#userMin').prop("readonly",true);
        $('#userSec').prop("readonly",true);
        recognition.start();
        startTimer();
        $(this).attr('currentMode','pause');
        $(this).html(pauseIconHtml);
      }
      else {
        recognition.stop();
        pauseTimer();
        $(this).attr('currentMode','play');
        $(this).html(playIconHtml);
      }
    });

    $('#reset').click(function(){
      recognition.stop();
      $('#on-recording').html("");
      $('#results').html("");
      pauseTimer();
      resetTimer();
      $('#play').attr('currentMode','play');
      $('#play').html(playIconHtml);
      final_transcript = "";
      // unlock the inputs
      $('#userMin').prop("readonly",false);
      $('#userSec').prop("readonly",false);
    });

    // Fires when recognition.start is called
    recognition.onstart = function() {
      console.log("I'm starting.");
      recognizing = true;
    }

    // This gets run after recognition.stop processes
    recognition.onend = function() {
      recognizing = false;
      //submit_display();
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
          final_transcript = capitalize(final_transcript) + " ";
          $('#results').val(final_transcript);
          final_word_blocks(final_transcript);
          done_loading();
        } else {
          loading_icon();
          interim_transcript += event.results[i][0].transcript;
          $('#results').val(interim_transcript);
          word_blocks($('#results').val());
        }
      }
    }

    // Ends the recording session
    $('.endRecording').click(function(){
      console.log("End recording");
      recognition.stop();
      clearTimer();
    });

  } // Ends the else block if window contains webkit Speech API


  ///~~** STRING FORMATTING FUNCTIONS **~~///

  // Capitalizes the first letter of a string.
  function capitalize(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
  };

  function word_blocks(string) {
    var interim = ""
    var word_array = string.split(" ")
    string = "<span>" + string + "</span> ";
    $("#on-recording").html(string);
  };

  function final_word_blocks(string) {
    var final = "";
    var words = string.split(" ");
    for(var i = 0; i < words.length; i++ ) {
      var word = words[i];
      final += "<span>" + word + "</span> "
    }
    var blocks = $("#on-recording").html(final)
    blocks.hide();
    blocks.fadeIn();
  }
  ///~~** PAGE FUNCTIONALITY FUNCTIONS **~~///

  // Controls visibility of submit button
  function submit_display() {
    console.log("The hide function is here!")
    $("#submit").toggle();
  }

  // Controlls spinning icon when final transcript is not done loading
  function loading_icon() {
    $("#startRecording").removeClass("fa-microphone").addClass("fa-cog fa-spin")
  }

  // Sets the spinning icon back when done loading
  function done_loading() {
    $("#startRecording").removeClass("fa-cog fa-spin").addClass("fa-microphone")
  }

  // ~~** TIMER **~~ //
  // writes seconds to clock face
  var count = parseInt($('#time').text());

  var myCounter;

  //
  function getTotalTime(){
    mm = $('#userMin').val();
    if (mm == ""){
      mm = "0";
    }
    ss = $('#userSec').val();
    if (ss == ""){
      ss = "0";
    }
    // validation
    var mmNum = /^\d+$/.test(mm);
    var ssNum = /^\d+$/.test(ss);
    mmNum = mmNum && (parseInt(mm) < 5);
    if (mmNum && ssNum) {
      return parseInt(mm)*60+parseInt(ss);
    }
    else {
      return -1;
    }
  }

  // increments seconds
  function startTimer() {
    myCounter = setInterval(function () {
      count+=1;
      $('#time').html(count);
      // this stops it from showing bar for more than total time
      if (count <= totaltime) {
        update(count);
      }
    //if(count==totaltime)
    //clearInterval(myCounter); // stops counter altogether
    }, 1000);
    console.log(myCounter)
  }

  // total time is set by user
  var totaltime = 100;

  // this rotates clock face
  function update(percent){
    var deg;
    if(percent < (totaltime/2)){
      deg = 90 + (360*percent/totaltime);
      $('.pie').css('background-image', 'linear-gradient('+deg+'deg, transparent 50%, white 50%),linear-gradient(90deg, white 50%, transparent 50%)'
                  );
    } else if(percent >= (totaltime/2)){
      deg = -90 + (360*percent/totaltime);
      $('.pie').css('background-image', 'linear-gradient('+deg+'deg, transparent 50%, #F1C5B8 50%),linear-gradient(90deg, white 50%, transparent 50%)'
                  );
    }
  } // ends timer update function

  // clears out clock and writes 0 val to screen
  function pauseTimer() {
    clearInterval(myCounter);
  }

  function resetTimer() {
    count = 0;
    $('#time').html(count);
  }
}); // Ends the document.ready page load function
