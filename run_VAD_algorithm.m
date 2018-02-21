winLen = 1024; 
shiftLen = 128;
fs = 16000;

audioFileName = 'dev1_male4_liverec_250ms_5cm_mix.wav';
[audio1meter3source,sampleRate] = audioread(audioFileName);%data used in GCC-NMF
x1 = audio1meter3source(:,1);
x2 = audio1meter3source(:,2);
numSamples = fs*10;
TotFrames = 1+fix((numSamples-winLen)/shiftLen);
[x1FrameN] = saveInputSignalIntoFrames(x1,winLen,shiftLen,TotFrames,numSamples);
[x2FrameN] = saveInputSignalIntoFrames(x2,winLen,shiftLen,TotFrames,numSamples);
winFunction = hanning(winLen);

timS = (1:numSamples)/fs;
vad = zeros(1,TotFrames);
for frameN =  1:TotFrames

        x1FrameWindowed =  x1FrameN(:,frameN).*winFunction;
        x2FrameWindowed =  x2FrameN(:,frameN).*winFunction;
       
        [val0,val1] = VAD_algorithm(x1FrameWindowed,x2FrameWindowed,winLen);
        if val0 > val1
            vad(frameN) = 1;        
        end
end

    subplot(311);
    hold on,
    grid on,plot(timS,x1,'r'),xlabel('time (sec)');
    plot(timS,x2,'b');legend('ch1','ch2');

    subplot(312),
    plot(vad),  xlim([0 TotFrames]),ylim([-.1 1.1]),legend('vad');xlabel('Frames');
    drawnow;
    