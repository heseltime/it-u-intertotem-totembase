// Boot the server
s.boot;

// Define a global buffer to hold the new audio file
~newFileBuffer = nil;

// Function to play the buffer
~playNewFile = {
    if (~newFileBuffer.notNil, {
        // Free the buffer if it is already loaded
        ~newFileBuffer.free;
    });

    // Load the new file into a buffer
    ~newFileBuffer = Buffer.read(s, ~newFilePath);

    // Define a simple SynthDef to play the buffer
    SynthDef(\playNewBuffer, {
        arg speed = 1, direction = 1;
        var sig;

        sig = PlayBuf.ar(1, ~newFileBuffer, rate: speed * direction, loop: 0);

        Out.ar(0, sig);
        Out.ar(1, sig);
    }).add;

    // Play the Synth with the new buffer
    Synth(\playNewBuffer, [\speed, 1]);
};

// Set up OSC responder to react to the '/file/copied' message
OSCFunc.new({ |msg, time, addr, port|
    // Extract the remote_path from the OSC message
    ~newFilePath = msg[1].asString;
    "New file path received: %\n".format(~newFilePath).postln;

    // Play the new file
    ~playNewFile.value;
}, '/file/copied').add;
