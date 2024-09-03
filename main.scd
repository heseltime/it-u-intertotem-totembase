//
// 0. BASIC SETUP: THIS NEEDS TO RUN EVERYTIME
//

// Instructions: ignore the comments/try not to uncomment.
// SC seems to work best when you place the cursor at the closing ";" or ")", then hit Strg/Ctrl + ENTER
// This process is going to be automated ideally, but hitting Ctrl + Enter 7 times is required for the setup of a totem SD ATM.

// Boot the server
s.boot;

// Define global buffers and synth placeholders
~in_buffer = nil; // The buffer that will hold the currently playing audio file
~player = nil;    // The synth instance that plays the audio
~fadeDuration = 2; // Duration of the crossfade in seconds

// SynthDef to play a buffer with amplitude control
(
SynthDef(\playBuffer, {
	arg bufnum = 0, speed = 1, direction = 1, amp = 0.5;
	var sig;

	// Use PlayBuf to play the loaded buffer, with looping enabled
	sig = PlayBuf.ar(1,
		bufnum: bufnum,
		rate: speed * direction,
		loop: 1);
	sig = sig * amp;

	// Output the signal to both stereo channels
	Out.ar(0, sig ! 2);
}).add;
)


(
// Set up OSC responder to react to the '/file/copied' message
~osc_handler = OSCFunc({
	arg msg, time, addr, port;

	// Extract the remote_path from the OSC message
	~newFilePath = msg[1].asString;
	"New file path received: %\n".format(~newFilePath).postln;

	// If there is an existing buffer and player, fade out the current synth
	if (~player.notNil) {
		//~player.set(\amp, 0); // Fade out by setting amplitude to 0
		// Free the synth after the fade duration
		//~player.free.defer(~fadeDuration);
	};

	// Load the new file into a buffer
	~in_buffer = Buffer.read(s, ~newFilePath);
	"Loaded new file to buffer.".postln();
	~player.set(\bufnum, ~in_buffer);

}, '/file/copied');
)



//
// 1. AUDIO-MANIPULATIONS <--- EDIT HERE FOR LIVE CODING: OPTIONAL
//
~player = Synth(\playBuffer, [\bufnum, ~in_buffer]);
~player.set(\speed, 0.1);


//
// 2. TURN-OFF-CODE
//

//~player.free; // RESET PLAYER
//~osc_handler.free; // RESET OSC SIGNAL LISTENER

//
// +. TEST CODE
//

//~in_buffer_1 = Buffer.read(s, "/home/totem/Desktop/intertotem/it-u-intertotem-totembase/input/earthquake_2024-09-01T20_13_34.205000Z_IU_COLA_9212km.wav");
//~in_buffer_2 = Buffer.read(s, "/home/totem/Desktop/intertotem/it-u-intertotem-totembase/input/earthquake_2024-09-01T17_09_14.231000Z_IU_ANMO_10840km.wav");
//~in_buffer_3 = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01-44_1.aiff");

//~player = Synth(\playBuffer, [\bufnum, ~in_buffer_3]);
//~player.set(\bufnum, ~in_buffer_1);
//~player.set(\bufnum, ~in_buffer_2);
//~player.set(\bufnum, ~in_buffer_3);

//Platform.resourceDir.postln