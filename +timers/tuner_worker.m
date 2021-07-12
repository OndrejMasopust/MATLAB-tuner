function [] = tuner_worker(recObj, guiElements, res)
%TUNER_WORKER is a timer function of the 'sampleProcessTimer'. It processes
%the recorded samples and updates the GUI
%
%   Input arguments:
%       recObj: is a pointer to the audiorecorder object currently used to
%          record the audio signal
%       guiElements: is a cell array containing pointers to the elements in
%           the GUI
%       res: is a double scalar representing the wanted resolution in Hz
%
%   See also: timer, audiorecorder, tuner_GUI_create
%
%   Author: Ondrej Masopust, CTU FEE, 2019-2020
%   MIT Licence


if recObj.TotalSamples > recObj.SampleRate/2
    data = getaudiodata(recObj);
    if max(data(end-round(recObj.SampleRate/2):end)) > 0.01
        % add trailing zeros to increase accuracy
        samples = [data(end-round(recObj.SampleRate/2):end);...
            zeros(recObj.SampleRate/res - recObj.SampleRate/2 - 1, 1)];
        [freqMeasured, noteName, properHz, higherHz] = process_sample.tuner_process_sample(samples, recObj.SampleRate);
    else
        [freqMeasured, properHz, higherHz] = deal(NaN);
        noteName = '-';
    end
    GUI.tuner_update_GUI(guiElements, freqMeasured, noteName, properHz, higherHz);
end
end
