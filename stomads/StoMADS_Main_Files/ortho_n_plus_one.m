% This function provides a strategy for constructing minimal positive basis
% by reducing the number of vectors in a maximal positive basis (here the
% OrthoMADS 2n directions, see https://doi.org/10.1137/080716980) from 2n
% to n + 1, with n denoting the dimension.
% See Section 4 of https://doi.org/10.1137/120895056, subsections 4.1-4.3

%%
%  Argonne National Laboratory (USA) / Polytechnique Montreal (Canada)

%  Kwassi Joseph Dzahini, PhD. September 2022.

%%

function z = ortho_n_plus_one(pos_span_set, last_success_direction)
pos_basis = order_last(pos_span_set, last_success_direction);
basis = pos_basis(:, 1:size(pos_basis, 1));
z = [basis, ceil(-sum(basis, 2))];
end
