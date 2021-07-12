function [freqMeasured, noteName, properHz, higherHz] = tuner_process_sample(sample, Fs)
%TUNER_PROCESS_SAMPLE This function finds the base note of the audio sample
%given.
%
%   Input parameters:
%       sample: is an N by 1 matrix containing the sound sample
%       Fs: is an integer denoting the sample rate used to record the
%          sample
%   Output parameters:
%       freqMeasured: is a float number denoting the measured base
%           frequency value
%       noteName: is a char with the name of the note
%       properHz: is a double scalar representing the frequency of the
%           closest pure tone
%       higherHz: is a double scalar representing the frequency of the
%           closest pure note higher than 'properHz'
%
%   This function wraps the process of finding the base frequency in the
%   audio sample. It uses functions from the 'process_sample' folder and
%   ensures correct data flow.
%
%   See also: tuner_ft, tuner_base_freq_detect, tuner_get_key_name
%
%   Author: Ondrej Masopust, CTU FEE, 2019-2020
%   MIT Licence

freq_charac = process_sample.tuner_ft(sample);
freqMeasured = process_sample.tuner_base_freq_detect(freq_charac, Fs);
if ~isnan(freqMeasured)
    [noteName, properHz, higherHz] = process_sample.tuner_get_key_name(freqMeasured);
else
    noteName = '-';
    properHz = NaN;
    higherHz = NaN;
end
end
