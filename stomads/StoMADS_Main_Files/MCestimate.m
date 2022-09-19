% This function computes function estimates using the average of the noisy
% observations. It also indicates to the main StoMADS algorithm whether the
% maximum function evaluation is reached or not.
% When the maximum evaluations is reached, the function returns the complex
% number '1i' (i.e., the complex imaginary number i) which is not stored in
% the history files but simply indicates to the algorithm to stop.

% This function, together with 'txt_files_generator.m', also handles the
% generation of .txt Solutions, History and Stats files.

%% Below:

% nfEval = Number of function evaluations

% When using stomads_experiments.m
% fEval_History = a matrix with rows [#Funct_eval, noisy_value,
% smooth_funct_value] (for the history file);
% fEval_Stats = [#Funct_eval, x, noisy_value, smooth_funct_value] (for the stats file)

% When using stomads_experiments.m
% fEval_History = a matrix with rows [#Funct_eval, noisy_value]
% fEval_Stats = [#Funct_eval, x, noisy_value]

%%
%  Argonne National Laboratory (USA) / Polytechnique Montreal (Canada)

%  Kwassi Joseph Dzahini, PhD. September 2022.

%%

function z = MCestimate(x, sample_size, my_fun, probspecs, stomads_option)
global nfEval fEval_History fEval_Stats nfEvalExceeded
y = zeros(sample_size, 1);
if stomads_option.experiments == 1i
    smooth_fun = @(x)calfun_sample(x, probspecs, 'smooth');
end
for i = 1:sample_size
    if nfEval <= stomads_option.MaxFuncEval
        obj = my_fun(x);
        if length(obj) > 1
            warning('Error defining the objective function.');
            warning('Outputs of the objective function should be scalars');
            nfEvalExceeded = 1;
            break
        else
            y(i) = obj;
        end
        if stomads_option.HistoryFile == 1
            if stomads_option.experiments == 1i
                fEval_History(nfEval, :) = [nfEval, y(i), smooth_fun(x)];
            else
                fEval_History(nfEval, :) = [nfEval, y(i)];  % Before any update, see
                                                               % txt_files_generator.m
            end
        end
        if stomads_option.StatsFile == 1
            if iscolumn(x)
                x = x';
            end
            if stomads_option.experiments == 1i
                fEval_Stats(nfEval, :) = [nfEval, x, y(i), smooth_fun(x)];
            else
                fEval_Stats(nfEval, :) = [nfEval, x, y(i)];
            end
        end
        nfEval = nfEval + 1;
    else
        nfEvalExceeded = 1;
        break
    end
end
if nfEvalExceeded ~= 1
    z = mean(y);
else
    z = 1i;
end
end
