s.doWhenBooted({
	~in_buffer = Buffer.read(s, "/home/totem/Desktop/intertotem/it-u-intertotem-totembase/startup/startup_dummy.wav"); // The buffer that will hold the currently playing audio file
	~player = nil;    // The synth instance that plays the audio

	SynthDef(\playBuffer, {
		arg bufnum = 0, speed = 1, direction = 1, amp = 0.5;
		var sig;

		// Use PlayBuf to play the loaded buffer, with looping enabled
		sig = PlayBuf.ar(1,
			bufnum: bufnum,
			rate: BufRateScale.kr(bufnum) * speed * direction,
			loop: 1);
		sig = sig * amp;

		// Output the signal to both stereo channels
		Out.ar(0, sig ! 2);
	}).add;

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
		//~in_buffer = Buffer.read(s, ~newFilePath);
		~in_buffer.read(~newFilePath);
		"Loaded new file to buffer.".postln();

	}, '/file/copied');

	s.sync;

	~player = Synth(\playBuffer, [\bufnum, ~in_buffer, \speed, 7]);
});

s.boot;