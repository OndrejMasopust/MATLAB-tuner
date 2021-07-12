function [] = tuner_create_rec_obj(timer, ~, sampleRate, bitsPerSample, noChannels, audioDevID)
%TUNER_CREATE_REC_OBJ is a timer function of the 'recCreateTimer'. It
%periodically recreates new audiorecorder object for the sake of memory
%space
%
%   Input arguments:
%       timer: is a pointer to the 'recCreateTimer' which contains a
%          pointer to the audiorecorder object in his 'UserData' property
%       sampleRate: is a double scalar representing the wanted sapmle rate
%       bitsPerSample: is an integer representing the number of bits per
%          one sample
%       noChannels: is an integer representing the number of channels to be
%           recorder form by the audiorecorder
%       audioDevID: is an integer representing which device to use for
%           recording the audio
%
%   See also: timer, audiorecorder
%
%   Author: Ondrej Masopust, CTU FEE, 2019-2020
%   MIT Licence

stop(timer.UserData);
delete(timer.UserData);
timer.UserData = audiorecorder(sampleRate, bitsPerSample, noChannels, audioDevID);
record(timer.UserData);
end
