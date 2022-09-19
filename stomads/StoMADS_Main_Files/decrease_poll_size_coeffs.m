% This function is used to update the poll size vector when using gmesh

%%
%  Argonne National Laboratory (USA) / Polytechnique Montreal (Canada)

%  Kwassi Joseph Dzahini, PhD. September 2022.

%%

function z = decrease_poll_size_coeffs(poll_size_coeffs)
% poll_size_coeffs is a matrix with rows [a, b] such that the poll size
% equals Delta = a * 10^b.
% See page 1168 of https://doi.org/10.1137/18M1175872 :
% 'The Mesh Adaptive Direct Search Algorithm for Granular and Discrete Variables'

for i = 1:size(poll_size_coeffs, 1)
    if poll_size_coeffs(i, 1) == 1
        poll_size_coeffs(i, 1) = 5;
        poll_size_coeffs(i, 2) = poll_size_coeffs(i, 2) - 1;
    elseif poll_size_coeffs(i, 1) == 2
        poll_size_coeffs(i, 1) = 1;
    else
        poll_size_coeffs(i, 1) = 2;
    end
end
z = poll_size_coeffs;
end
