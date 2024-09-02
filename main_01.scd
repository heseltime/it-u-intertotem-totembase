// Boot the server
s.boot;

// Define a global buffer to hold the new audio file
~in_buffer_01 = nil;
~in_buffer_02 = nil;

(
SynthDef(\playNewBuffer, {
	arg bufnum, speed = 1, direction = 1, amp = 0.5;
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
~in_buffer_01 = Buffer.read(s, "/home/totem/Desktop/intertotem/it-u-intertotem-totembase/input/earthquake_2024-09-01T15_46_33.512000Z_IU_ANMO_5904km.wav");
~in_buffer_02 = Buffer.read(s, "/home/totem/Desktop/intertotem/it-u-intertotem-totembase/input/earthquake_2024-09-02T03_16_39.768000Z_IU_ANMO_7939km.wav");
)

// Play the Synth with the new buffer
~player_01 = Synth(\playNewBuffer, [\bufnum, ~in_buffer_01, \speed, 1, \speed, 0.2]);
~player_02 = Synth(\playNewBuffer, [\bufnum, ~in_buffer_02, \speed, 1, \speed, 0.2]);

~player_01.set(\amp, 0)
~player_01.set(\speed, 0.2)

~player_02.set(\amp, 0.2)
~player_02.set(\speed, 0.05)

~in_buffer_02 = Buffer.read(s, "/home/totem/Desktop/intertotem/it-u-intertotem-totembase/input/earthquake_2024-09-01T16_31_05.632000Z_IU_ANMO_10635km.wav");


~in_buffer_02 = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");
~player_02.set(\bufnum, ~in_buffer_02);



~player_01.free
~player_02.free








// Function to load and play the buffer
~playNewFile = {
    if (~newFileBuffer.notNil) {
        // Free the buffer if it is already loaded
        ~newFileBuffer.free;
    };

    // Load the new file into a buffer
    ~newFileBuffer = Buffer.read(s, ~newFilePath, {
        // When the buffer is fully loaded, play the audio
    });
};

// Set up OSC responder to react to the '/file/copied' message
OSCFunc.new({ |msg, time, addr, port|
    // Extract the remote_path from the OSC message
    ~newFilePath = msg[1].asString;
    "New file path received: %\n".format(~newFilePath).postln;

    // Load and play the new file
    ~playNewFile.value;
}, '/file/copied').add;
