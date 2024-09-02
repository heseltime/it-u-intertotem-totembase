// Boot the server.
s.boot


// A simple sine tone synth.
(
SynthDef("one_tone_only", {
	var sig;
	var freq = 440;

	sig = SinOsc.ar(freq, mul:0.5);
	Out.ar(0, sig);
}).add
)

a = Synth("one_tone_only");
a.free