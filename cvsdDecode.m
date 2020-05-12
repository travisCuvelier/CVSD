%Input a wrapped (left MSB) CVSD encoding
%at the cvsd rate of 16000 bits/second
%output is PCM at 16000 bits/second. 
function outputSignal = cvsdDecode(inputBits)

    Fs = 16000; 
    betaSyllabic = 0.9;

    deltaMax = .1;
    deltaMin = deltaMax/20;
    deltaNaught = deltaMax*(1-betaSyllabic);

    betaReconstruction = 0.9394;
    alphaReconstruction = 1;


    %standard compluant output IIR filter 

    Fpass = 3500;        % Passband Frequency
    Fstop = 4000;        % Stopband Frequency
    Apass = 1;           % Passband Ripple (dB)
    Astop = 50;          % Stopband Attenuation (dB)
    match = 'stopband';  % Band to match exactly

    % Construct an FDESIGN object and call its BUTTER method.
    h  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
    Houtput = design(h, 'butter', 'MatchExactly', match);

    syllabicOut = 0;
    shiftReg = [0,0,0];
    reconstruction(1) = 0;
    reconstruction(2) = 0;
    reconstruction(3) = 0;


    for idx = 3:length(inputBits)

       shiftReg(3) = shiftReg(2);
       shiftReg(2) = shiftReg(1);
       shiftReg(1) = inputBits(idx);

       runOfThrees = double((shiftReg(1)&shiftReg(2)&shiftReg(3))|((~shiftReg(1))&(~shiftReg(2))&(~shiftReg(3))));


       syllabicOut = deltaNaught*runOfThrees+betaSyllabic*syllabicOut;

       psMag = syllabicOut + deltaMin;

       if(shiftReg(1) ==0)
           pamSymbol = -1*psMag;
       else
           pamSymbol = psMag;
       end

       reconstruction(idx+1) = alphaReconstruction*pamSymbol + betaReconstruction*reconstruction(idx);

    end

    outputSignal = filter(Houtput,reconstruction);
end
