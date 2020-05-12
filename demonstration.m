%Demo of the CVSD scripts
[pcm,fsOrig] = audioread('wasteLand.wav');
symbols= cvsdEncode(pcm,fsOrig);
reconstruction = cvsdDecode(symbols);
fReconstruction = 16000;
reconstructionResampled = resample(reconstruction,fsOrig,fReconstruction);
sound(reconstructionResampled,fsOrig)