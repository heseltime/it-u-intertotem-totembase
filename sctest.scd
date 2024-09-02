s.boot

// abs path needed
(
~cwd = thisProcess.nowExecutingPath.dirname;
~seismo_relpath = "input/earthquake_2024-09-01T15_32_06.711000Z_IU_ANMO_9908km.wav";
~seismo_path = ~cwd +/+ ~seismo_relpath;
)

~seismo_path.postln;

~seismo = Buffer.read(s, ~seismo_path);

// Synthdef
(
SynthDef.new(\seismoPlayer, {
	arg speed = 0.1, direction = 1;

	var sig;
	//speed = LFNoise0.kr(1) * 0.2 + 1;
	//direction = LFClipNoise.kr(1);

	sig = PlayBuf.ar(numChannels: 1,
		bufnum: ~seismo,
		rate: speed * direction,
		loop: 1);
	Out.ar(0, sig);
	Out.ar(1, sig);
}).add;
)

b = Synth.new(\seismoPlayer, [\speed, 0.5]);
b.set(\speed, 0.05);
b.free;