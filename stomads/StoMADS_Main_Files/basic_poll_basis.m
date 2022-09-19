% This function generates a basis used to construct positive spanning sets
% in the simple mesh (smesh) case, i.e., when stomads_option.MeshType = 0;
% The construction strategy can be found in the 'Derivative-free and Blackbox optimization'
% book by C. Audet and W. Hare (see Chapter 8).

%%
%  Argonne National Laboratory (USA) / Polytechnique Montreal (Canada)

%  Kwassi Joseph Dzahini, PhD. September 2022.

%%

function z = basic_poll_basis(mesh_size, poll_size, probspecs)
format long g;
dim = probspecs.Dimension;
lw_bnd = -100;
up_bnd = 100;
v = lw_bnd + (up_bnd - lw_bnd) .* rand(dim, 1);   % Could be replaced by Halton sequence-based
                                                  % vectors. Here v is random
Householder_matrix = eye(dim, dim) - 2 * (v / norm(v)) * (v' / norm(v)); % Householder matrix
Basis = zeros(dim, dim);
for i = 1:dim
    Basis(:, i) = round((poll_size / mesh_size) * (Householder_matrix(:, i) / ...
        max(abs(Householder_matrix(:, i)))));
end
z = Basis;
end
