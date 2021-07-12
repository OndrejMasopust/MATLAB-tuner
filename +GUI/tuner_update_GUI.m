function [] = tuner_update_GUI(GUI, toneHz, toneName, toneHzProper, higherHz)
%TUNER_UPDATE_GUI This function updates the GUI with the given parameters
%
%   Input Arguments:
%       GUI: is a struct array with references to the GUI elements
%       toneHz: is a double scalar which tells the measured frequency in Hz
%       toneName: is a char with the name of the note
%       toneHzProper: is a double scalar which tells what is the perfect
%           frequency for the measured tone
%       higherHz: is a double scalar which indicates the upper limit of the
%           gauge
%
%   See also: uifigure, uigauge, uilabel
%
%   Author: Ondrej Masopust, CTU FEE, 2019-2020
%   MIT Licence

if ~isnan(toneHz)
    set(GUI(1).gauge, 'Enable', 'on');
    gaugeRadius = ceil(higherHz - toneHzProper);
    greenRadius = 0.1*gaugeRadius;
    yellowRadius = 0.5*gaugeRadius;
    set(GUI(1).gauge, 'Limits', [toneHzProper-gaugeRadius toneHzProper+gaugeRadius]);
    set(GUI(1).gauge, 'ScaleColorLimits', [toneHzProper-gaugeRadius toneHzProper-yellowRadius;...
        toneHzProper-yellowRadius toneHzProper-greenRadius;...
        toneHzProper-greenRadius toneHzProper+greenRadius;...
        toneHzProper+greenRadius toneHzProper+yellowRadius;...
        toneHzProper+yellowRadius toneHzProper+gaugeRadius]);
    set(GUI(1).gauge, 'MajorTicks', [toneHzProper-gaugeRadius toneHzProper-yellowRadius...
        toneHzProper toneHzProper+yellowRadius toneHzProper+gaugeRadius]);
    set(GUI(1).gauge, 'Value', toneHz);
else
    set(GUI(1).gauge, 'Enable', 'off');
end

set(GUI(1).label, 'Text', toneName);
end

