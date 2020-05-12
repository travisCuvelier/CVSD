# CVSD
CVSD implementation
This is an implementation of Continously Variable Slope Delta modulation, a speech codec in MATLAB. CVSD is essentially a joint source/channel codec- the output of the encoder is a 16 kilobit/sec bitstream. The bitstream can be transmitted uncoded using a binary antipodal modulation (which requires a channel (passband) bandwidth of at least 16 KHz, assuming Nyquist pulse shaping). CVSD encoded speech is still intelligable in environements where the bit error rate is 10% (eg. BPSK with an SNR of 2.15 dB). These scripts currently requires the Signal Processing Toolbox to build input/output filters. If you don't have this toolbox, you'll need to implement your own filters: suggested parameters are there if you read the code. 

The sample audio is a recording of "The Burial of the Dead" from T.S. Elliot's "The Waste Land", read by Nathaniel Krause. The audio is licensed under the Creative Commons Attribution-Share Alike 3.0 Unported license. The recording is available at: https://en.wikipedia.org/wiki/File:The_Waste_Land.ogg. I used Audacity to trim the original .ogg file, and then converted to .wav.

The software is copyright 2016 Travis Cuvelier. 

Important Information:

1) This source code is freely redistributable under the terms of the GNU General Public License (GPL) as published by the Free Software Foundation.

2) If you are thinking of contacting us, please do not e-mail the author to ask for download instructions, installation guidelines, or the toolbox itself. 
The code itself is documented and the package contains a README.txt file providing the essential information about the software. 
Note that we will NOT help to debug user-generated code that was not included in the provided software package. 
If, however, you notice a bug in our code or a mistake in our documentation, please be so kind to contact Travis Cuvelier at tcuvelier@utexas.edu.

3) The software package is supplied "as is", without any accompanying support services, maintenance, or future updates. 

4) We make no warranties, explicit or implicit, that the software contained in this package is free of error or that it will meet your requirements for any particular application. 

5) This software should not be relied on for any purpose where incorrect results could result in loss of property, personal injury, liability or whatsoever. 
If you do use our software for any such purpose, it is at your own risk. 

6) The author (Travis Cuvelier), as well as the University of Texas at Austin, disclaim all liability of any kind, either direct or consequential, resulting from your use of these programs.

How to use this software:
(This guide is incomplete and under construction)

Mess around with demo.m and you'll figure it out. 
