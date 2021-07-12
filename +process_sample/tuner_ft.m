function [fTransform] = tuner_ft(sound)
%TUNER_FT This function is a wrapper for the fft MATLAB function
%   Input parameters:
%       sound: is an (N x 1) matrix consisting of the sound samples
%   Output parameters:
%       fTransorm: is an (N x 1) matrix of complex numbers containing
%           the Fourier transformation of the matrix 'sound'
% 
%   This function just wraps the fft MATLAB function. Additionally, the
%   transformed signal magnitude is divided by the size of the 'sound'
%   matrix (i.e. divided by number N) for the sake of more convenient
%   results.
%
%   See also: fft
%
%   Author: Ondrej Masopust, CTU FEE, 2019-2020
%   MIT Licence

fTransform = fft(sound) / length(sound);

end

