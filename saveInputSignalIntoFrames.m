function [xFrameN] = saveInputSignalIntoFrames(x1,winLen,shiftLen,TotFrames,numSamples)
    indx = 0;
    counter = 1;
    xFrameN = zeros(winLen,TotFrames);
    while indx + winLen <= numSamples   
        xFrameN(:,counter) = (x1(indx+1:indx+winLen));
        indx = indx + shiftLen;
        counter = counter+1;
    end
end
