% This function provides strategies described in https://doi.org/10.1137/18M1175872
% to update the coefficients ak and bk defining the mesh and poll size
% vectors during successful steps, in the gmesh case, i.e., when
% stomads_option.MeshType = -1.

%%
%  Argonne National Laboratory (USA) / Polytechnique Montreal (Canada)

%  Kwassi Joseph Dzahini, PhD. September 2022.

%%

function z = increase_poll_size_coeffs(poll_size_coeffs, last_success_direction, ...
    mesh_size_vector, poll_size_vector, stomads_option)

% poll_size_coeffs is a matrix with rows [a, b] such that the poll size
% equals Delta = a * 10^b.
% See page 1168 of https://doi.org/10.1137/18M1175872:
% 'The Mesh Adaptive Direct Search Algorithm for Granular and Discrete Variables'

if stomads_option.Anisotropy == 1
    rho_k = diag(1 ./ mesh_size_vector) * poll_size_vector;
    init_mesh_size_vec = stomads_option.InitMeshSizeVector;
    for i = 1:size(poll_size_coeffs, 1)
        if (abs(last_success_direction(i)) / rho_k(i) > stomads_option.AnisoParam) || ...
                ((mesh_size_vector(i) < init_mesh_size_vec(i)) && (sum(rho_k > rho_k.^2) > 0))
            if poll_size_coeffs(i, 1) == 1
                poll_size_coeffs(i, 1) = 2;
            elseif poll_size_coeffs(i, 1) == 2
                poll_size_coeffs(i, 1) = 5;
            else
                poll_size_coeffs(i, 1) = 1;
                poll_size_coeffs(i, 2) = poll_size_coeffs(i, 2) + 1;
            end
        end
    end
end
if stomads_option.Anisotropy == 0
    for i = 1:size(poll_size_coeffs, 1)
        if poll_size_coeffs(i, 1) == 1
            poll_size_coeffs(i, 1) = 2;
        elseif poll_size_coeffs(i, 1) == 2
            poll_size_coeffs(i, 1) = 5;
        else
            poll_size_coeffs(i, 1) = 1;
            poll_size_coeffs(i, 2) = poll_size_coeffs(i, 2) + 1;
        end
    end
end
z = poll_size_coeffs;
end
