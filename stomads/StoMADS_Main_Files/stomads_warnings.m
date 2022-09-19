%  Argonne National Laboratory (USA) / Polytechnique Montreal (Canada)

%  Kwassi Joseph Dzahini, PhD. September 2022.

%%

if length(cur_sol) ~= length(lw_bounds)
    warning('Error defining stomads_option.LowerBounds and the starting point.');
    warning('Dimensions of the problem and the lower bound vector must be consistent.');
    stomads_option.warning = 1;
end

if length(cur_sol) ~= length(up_bounds)
    warning('Error defining stomads_option.UpperBounds and the starting point.');
    warning('Dimensions of the problem and the upper bound vector must be consistent.');
    stomads_option.warning = 1;
end

if sum(cur_sol < lw_bounds) > 0
    warning('Error defining stomads_option.LowerBounds or the starting point');
    warning('Lower bound violated by the starting point');
    stomads_option.warning = 1;
end

if sum(cur_sol > up_bounds) > 0
    warning('Error defining stomads_option.UpperBounds or the starting point');
    warning('Upper bound violated by the starting point');
    stomads_option.warning = 1;
end

if sum(lw_bounds > up_bounds) > 0
    warning('Error defining stomads_option.UpperBounds and stomads_option.LowerBounds');
    warning('Lower bounds must be at most equal to upper bounds.');
    stomads_option.warning = 1;
end
