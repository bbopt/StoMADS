% This function provides strategies for updating poll size vectors on
% successful steps, in the xmesh case, i.e., when stomads_option.MeshType = 1
% See https://doi.org/10.1007/s11081-015-9283-0 for further details.

%%
%  Argonne National Laboratory (USA) / Polytechnique Montreal (Canada)

%  Kwassi Joseph Dzahini, PhD. September 2022.

%%

function z = incr_poll_size_vec(poll_size_vector, mesh_size_vector, ...
    last_success_direction, stomads_option)

% Used only for XMesh   stomads_option.AnisoParam
dim = length(poll_size_vector);
if stomads_option.Anisotropy == 1
    rho_k = diag(1 ./ mesh_size_vector) * poll_size_vector;
    init_mesh_size_vec = stomads_option.InitMeshSizeVector;
    for i = 1:dim          % Here, (1 / dim) is considered for anistropy parameter
        if (abs(last_success_direction(i)) > (1 / dim) * max(abs(last_success_direction))) || ...
                ((mesh_size_vector(i) < init_mesh_size_vec(i)) && (sum(rho_k > rho_k.^2) > 0))
            poll_size_vector(i) = (stomads_option.Tau)^(-2) * poll_size_vector(i);
        end
    end
else
    poll_size_vector = (stomads_option.Tau)^(-2) * poll_size_vector;
end
z = poll_size_vector;
end
