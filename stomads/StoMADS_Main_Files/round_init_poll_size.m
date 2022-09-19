% Inspired by a segment of code of DMultiMADS-PB
% (see https://github.com/bbopt/DMultiMadsPB/blob/main/src/gmesh.jl),
% this function implements the 'rounding operation' mentioned below
% Eq. (3.3), Page 1173, in https://doi.org/10.1137/18M1175872

%%
%  Argonne National Laboratory (USA) / Polytechnique Montreal (Canada)

%  Kwassi Joseph Dzahini, PhD. September 2022.

%%

function z = round_init_poll_size(alpha_i_0)
exponent = floor(log10(abs(alpha_i_0)));
mantisse = alpha_i_0 * 10^(-exponent);
if mantisse < 1.5
    poll_size_mant = 1;
elseif (mantisse >= 1.5) && (mantisse < 3.5)
    poll_size_mant = 2;
else
    poll_size_mant = 5;
end
z = [poll_size_mant, exponent];
end
