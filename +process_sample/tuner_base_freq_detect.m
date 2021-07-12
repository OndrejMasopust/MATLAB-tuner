function [baseFreq] = tuner_base_freq_detect(ftSound, sampleRate)
%TUNER_BASE_FREQ_DETECT This function finds the base frequency of the
%fourier-transformed sound 'ftSound'
%   Input parameters:
%       ftSound: is an (N x 1) matrix containing a Fourier transformation of
%           some sound. The content might be complex.
%       sampleRate: is an integer containig the information about the
%          sample rate with which the sound was recorded
%   Output parameters:
%       baseFreq: is an integer containing the base frequency of the passed
%           sound. If the input signal is too quiet, the function returns
%           NaN
%
%   Author: Ondrej Masopust, CTU FEE, 2019-2020
%   MIT Licence

ftSound = abs(ftSound);
% 100*mean is ok based on the graph examination
ftSound(ftSound < 100*mean(ftSound)) = 0;
if all(ftSound == 0)
    baseFreq = NaN;
    return;
end
% we take only half of the ftSound to avoid mirrored frequencies
ftSound(round(end/2):end) = 0;
% collect the indexes of maxims in the for cycle
harmonicsIdxs = NaN(30, 1);
muteRadius = 10; % Hz
% muteRadius converted from Hz to indexes
idxRadius = ceil((muteRadius*length(ftSound))/sampleRate);
for n = 1:30
    [~, harmonicsIdxs(n)] = max(ftSound());
    % mute surroundings with radius of 10 Hz
    ftSound(harmonicsIdxs(n) - idxRadius:harmonicsIdxs(n) + idxRadius) = 0;
    if all(ftSound == 0); break; end
end

% process the collected indexes
harmonicsIdxs(isnan(harmonicsIdxs)) = [];
harmonicsIdxs = sort(harmonicsIdxs);

harmonicsIdxs = [0; (harmonicsIdxs - 1)*sampleRate/length(ftSound)];
diffs = diff(harmonicsIdxs);
diffs = sort(diffs);
diffs = diffs./round(diffs/diffs(1));
baseFreq = mean(diffs);
end
