function [hFig] = tuner_GUI_init_screen()
%TUNER_GUI_INIT_SCREEN This function creates the window for the timer with
%initial message for the user to wait.
%
%   Output arguments:
%       hFig: is an uifigure instance to which the GUI was created
%
%   See also: uifigure, uilabel
%
%   Author: Ondrej Masopust, CTU FEE, 2019-2020
%   MIT Licence

winSize = [350 200];
sreenSize = get(groot, 'ScreenSize');
hFig = uifigure('Position', [(sreenSize(3:4) - winSize)/2 winSize],...
    'Name', 'Tuner');
labelHeight = 80;
uilabel(hFig,...
    'Text', ['Please wait for' newline 'initialization'],...
    'HorizontalAlignment', 'center',...
    'FontSize', 30,...
    'Position', [10 (winSize(2)-labelHeight)/2 winSize(1) labelHeight]);
end

