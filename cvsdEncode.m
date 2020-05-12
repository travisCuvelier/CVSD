%input is a column vector of signed PCM values (16 bit), FsIn is PCM sample
%rate. This function outputs a wrapped (left MSB)
%CVSD encoding of the inputPCM signal
%at the cvsd rate of 16000 bits/second
function outBits = cvsdEncode(inputPCM, FsIn)

    Fs = 16000;

    if(FsIn ~= Fs)
        inputSignal = resample(inputPCM,Fs,FsIn);
    else
        inputSignal = inputPCM;
    end

    betaSyllabic = 0.9;

    deltaMax = .1;
    deltaMin = deltaMax/20;
    deltaNaught = deltaMax*(1-betaSyllabic);

    betaReconstruction = 0.9394;
    alphaReconstruction = 1;


    %standard compliant input IIR filter 

    Fstop1 = 25;          % First Stopband Frequency
    Fpass1 = 50;          % First Passband Frequency
    Fpass2 = 2000;        % Second Passband Frequency
    Fstop2 = 4000;        % Second Stopband Frequency
    Astop1 = 24;          % First Stopband Attenuation (dB)
    Apass  = 1;           % Passband Ripple (dB)
    Astop2 = 36;          % Second Stopband Attenuation (dB)
    match  = 'stopband';  % Band to match exactly

    % Construct an FDESIGN object and call its BUTTER method.
    h  = fdesign.bandpass(Fstop1, Fpass1, Fpass2, Fstop2, Astop1, Apass, ...
                          Astop2, Fs);
    Hinput = design(h, 'butter', 'MatchExactly', match);

    %end standard compliant input IIR filter 



    inputSignal = filter(Hinput,inputSignal);

    syllabicOut = 0;
    shiftReg = [0,0,0];
    reconstruction(1) = 0;
    reconstruction(2) = 0;
    reconstruction(3) = 0;


    for idx = 3:length(inputSignal)

       shiftReg(3) = shiftReg(2);
       shiftReg(2) = shiftReg(1);
       shiftReg(1) =  inputSignal(idx) > reconstruction(idx);
       outBits(idx) = shiftReg(1);

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
end