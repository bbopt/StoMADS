% This function generates a basis used to construct positive spanning sets
% in the gmesh case, i.e., when stomads_option.MeshType = -1;
% The construction strategies can be found in the 'Derivative-free and Blackbox optimization'
% book by C. Audet and W. Hare (see Chapter 8) and the paper https://doi.org/10.1137/18M1175872

%%
%  Argonne National Laboratory (USA) / Polytechnique Montreal (Canada)

%  Kwassi Joseph Dzahini, PhD. September 2022.

%%

function z = gmesh_poll_basis(poll_size_coeffs, mesh_size_vector)
format long g;
dim = length(mesh_size_vector);
poll_size_vector = poll_size_coeffs(:, 1) .* 10.^(poll_size_coeffs(:, 2));
if isrow(poll_size_vector)
    poll_size_vector = poll_size_vector';
end
rho_k = diag(1 ./ mesh_size_vector) * poll_size_vector;
lw_bnd = -100;
up_bnd = 100;
v = lw_bnd + (up_bnd - lw_bnd) .* rand(dim, 1);
if isrow(v)
    v = v';
end
Householder_matrix = eye(dim, dim) - 2 * (v / norm(v)) * (v' / norm(v));
Basis_vectors = zeros(dim, dim);
for i = 1:dim
    h_i = Householder_matrix(:, i);
    Basis_vectors(:, i) = round(diag(rho_k) * (h_i / max(abs(h_i))));
end
z =  Basis_vectors;
end
