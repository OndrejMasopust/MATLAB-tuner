function [] = tuner_main()
%TUNER_MAIN This is the main Tuner function. This function starts the tuner
%
%   Author: Ondrej Masopust, CTU FEE, 2019-2020
%   MIT Licence

% init the GUI
% hFig is a uifigure object
hFig = GUI.tuner_GUI_init_screen();

tunerResolution = 0.3; % in Hz
% audio device parameters to use
sampleRate = 44100;
bitsPerSample = 16;
noChannels = 1;
audioDevID = 0;

% check if the audio device chosen by the auioDevID supports the required
% parameters
audioDevSupp = audiodevinfo(1, audioDevID, sampleRate, bitsPerSample, noChannels);
if audioDevSupp == 0
    hFig.Position(3:4) = [420 200];
    uialert(hFig, 'The parameters don`t fit the wanted audio device. Cannot proceed.',...
        'Error',...
        'Icon', 'error',...
        'CloseFcn', @delWrap);
else
    % init the timers
    [recCreateTimer,sampleProcessTimer] = timers.tuner_init_timers();
    recCreateTimer.UserData = audiorecorder(sampleRate, bitsPerSample, noChannels, audioDevID);
    
    % change the GUI appearance
    guiElements = GUI.tuner_GUI_create(hFig, sampleProcessTimer, recCreateTimer);
    
    % set the timer handle functions
    recCreateTimer.TimerFcn = {@timers.tuner_create_rec_obj, sampleRate,...
        bitsPerSample, noChannels, audioDevID};
    sampleProcessTimer.TimerFcn =...
        @(~, ~) timers.tuner_worker(recCreateTimer.UserData, guiElements,...
        tunerResolution);
    
    %run the timer
    start(recCreateTimer);
    record(recCreateTimer.UserData);
end
end

function [] = delWrap(obj, ~); delete(obj); end
