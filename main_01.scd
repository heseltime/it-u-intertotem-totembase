// Boot the server
s.boot;

// Define a global buffer to hold the new audio file
~newFileBuffer = nil;

// Function to load and play the buffer
~playNewFile = {
    if (~newFileBuffer.notNil) {
        // Free the buffer if it is already loaded
        ~newFileBuffer.free;
    };

    // Load the new file into a buffer
    ~newFileBuffer = Buffer.read(s, ~newFilePath, {
        // When the buffer is fully loaded, play the audio
        SynthDef(\playNewBuffer, {
            arg speed = 1, direction = 1;
            var sig;

            // Use PlayBuf to play the loaded buffer, with looping enabled
            sig = PlayBuf.ar(1, ~newFileBuffer.bufnum, rate: speed * direction, loop: 1);

            // Output the signal to both stereo channels
            Out.ar(0, sig ! 2);
        }).add;

        // Play the Synth with the new buffer
        Synth(\playNewBuffer, [\speed, 1]);
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
