function [name, properHz, higherHz] = tuner_get_key_name(freq)
%TUNER_GET_KEY_NAME This function determines the name of the note based on
%it's frequency, finds the frequency of the closest pure note and also
%returns the frequency of the closest pure note that is higher than the
%wanted note for the sake of gauge limits display
%
%   Input parameters:
%       freq: is a float number representing the frequency of the note
%   Output parameters:
%       name: is a char with the name of the note
%       properHz: is a double scalar representing the frequency of the
%           closest pure note
%       higherHz: is a double scalar representing the frequency of the
%           closest pure note higher then properHz
%
%   This function uses the formula found on
%   "https://en.wikipedia.org/wiki/Piano_key_frequencies" to calculate the
%   key number on a piano keyboard. Based on this number, the name of the
%   note is then returned.
%
%   Author: Ondrej Masopust, CTU FEE, 2019-2020
%   MIT Licence

notes = ["A" "A#" "B" "C" "C#" "D" "D#" "E" "F" "F#" "G" "G#"];
keyNumber = round(12*log2(freq/440) + 49);
name = notes(mod(keyNumber - 1, 12) + 1);
properHz = get_Hz(keyNumber);
higherHz = get_Hz(keyNumber + 1);

end

function [Hz] = get_Hz(keyNumber); Hz = (2^((keyNumber-49)/12)) * 440; end

