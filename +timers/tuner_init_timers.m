function [recCreateTimer,sampleProcessTimer] = tuner_init_timers()
%TUNER_INIT_TIMERS initializes the timers needed for the tuner and returns
%their handles. Some paramters need to be initialized in the main function.
%See the main function for further details.
%
%   Output arguments:
%       recCreateTimer: is a pointer to the timer which takes care of
%           recreating the audiorecorder object for the sake of memory
%           space
%       sampleProcessTimer: is a pointer to the timer which takes care of
%           the sample processing
%
%   See also: timer, audiorecorder
%
%   Author: Ondrej Masopust, CTU FEE, 2019-2020
%   MIT Licence

%init the timer which is creating the audiorecorder instances
recTimerPeriod = 8;
recCreateTimer = timer('BusyMode', 'drop',...
    'ExecutionMode', 'fixedSpacing',...
    'Name', 'Audiorecorder instance creator',...
    'Period', recTimerPeriod,...
    'TasksToExecute', Inf,...
    'StartDelay', recTimerPeriod);

%init the timer which processes the samples and updates the GUI
sampleProcessTimer = timer('BusyMode', 'drop',...
    'ExecutionMode', 'fixedSpacing',...
    'Period', 0.1,...
    'TasksToExecute', Inf,...
    'Name', 'Samples Processing Timer',...
    'StartDelay', 1);

recCreateTimer.StartFcn = {@startHandle sampleProcessTimer};
end

function [] = startHandle(~, ~, sampleProcessTimer); start(sampleProcessTimer); end
