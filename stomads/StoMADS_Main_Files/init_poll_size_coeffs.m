function z = init_poll_size_coeffs(init_point, stomads_option)

% The strategies implemented here to define the initial poll size vector
% can be found in https://doi.org/10.1137/18M1175872 , page 1173, in the
% gmesh case (see Section 3.1: Initial scaling of variables).
% In the gmesh case, each line of the resulting matrix z is the row vector
% vec described below.
% In the xmesh case, see Section 3.1 of https://doi.org/10.1007/s11081-015-9283-0
% in which case, z is the vector of initial poll size parameters.

%%
%  Argonne National Laboratory (USA) / Polytechnique Montreal (Canada)

%  Kwassi Joseph Dzahini, PhD. September 2022.

%%

lower_bounds = stomads_option.LowerBounds;
upper_bounds = stomads_option.UpperBounds;
alpha_zero = zeros(length(init_point), 1);
z = zeros(length(init_point), 2);

for i = 1:length(init_point)
    if  max(abs(lower_bounds(i)), abs(upper_bounds(i))) < Inf
        alpha_zero(i) = (upper_bounds(i) - lower_bounds(i)) / 10;
    elseif (min(abs(lower_bounds(i)), abs(upper_bounds(i))) < Inf) && ...
            (max(abs(lower_bounds(i)), abs(upper_bounds(i))) == Inf)
        val = min(abs(init_point(i) - lower_bounds(i)) / 10, abs(init_point(i) - ...
            upper_bounds(i)) / 10);
        if val ~= 0
            alpha_zero(i) = val;
        elseif init_point(i) ~= 0
            alpha_zero(i) = abs(init_point(i)) / 10;
        else   % See Eq. (3.3) of https://doi.org/10.1137/18M1175872
            alpha_zero(i) = 1;  % For the definition of alpha_zero (gmesh case)
        end
    elseif (min(abs(lower_bounds(i)), abs(upper_bounds(i))) == Inf) && (init_point(i) ~= 0)
        alpha_zero(i) = abs(init_point(i)) / 10;
    else
        alpha_zero(i) = 1;
    end
    if stomads_option.MeshType == -1 % gmesh
        vec = round_init_poll_size(alpha_zero(i)); % rounding to the nearest elements a, b such that
                                                   % poll size = a * 10^b, a in {1, 2, 5}, b integer.
                                      % See the set P defined in Section 2.2. of the above reference.
        if iscolumn(vec)
            vec = vec';
        end
        z(i, :) = vec;
    end
    if stomads_option.MeshType == 1 % xmesh
        z = ceil(alpha_zero);
        if isrow(z)
            z = z';
        end
    end
end
end
