%% IMPORTANT NOTE:
% The 40 problems considered by this script are available via
% https://github.com/POptUS/YATSOp or by emailing poptus@mcs.anl.gov if
% the latter link is unavailable (In case the repository is not yet made public).
% See 'Readme.txt' in the YATSOp subfolder located in the 'StoMADS_Main_Files'
% folder for other details.

%% StoMADS algorithm: (https://doi.org/10.1007/s10589-020-00249-0 or https://rdcu.be/cS8fR)
%% To cite the StoMADS paper, see Readme.md

%%
% This script runs StoMADS in an automated way on the 40 problems considered
% in the numerical section of https://arxiv.org/abs/2207.06452 (STARS algorithm),
% for various types of noise and various noise levels. It generates
% solutions files, stats files and history files in a 'StoMADS_Output' folder,
% which can be used to generate data profiles, performance profiles,
% trajectory plots, convergence graphs, etc.
% Users can therefore refer to the numerical section of the above manuscript
% for more details on the use of this script.

% See MCestimate.m in the 'StoMADS_Main_Files' folder to understand the output files.
% Before any update related to the creation of the output files, see 'MCestimate.m'
% and then 'txt_files_generator.m'.

% The noisy versions of the problems are referred to (see "probtypes" below)
% by 'absuniform', 'reluniform2', etc. (see 'calfun_sample.m' in the 'YATSOp'
% folder (once downloaded!) for details).

% See the 'Remarks and recommendations' section in 'stomads_default_options.m'.
% Note in particular that the algorithm uses random orthogonal polling
% directions and as a consequence, the optimization of deterministic
% objectives may produce different solutions from one run to another,
% depending on the problem, unless stomads_option.FixSeed = 1.

% For other general experiments, see 'stomads_applications.m'.

% See 'stomads_default_options.m' in the 'StoMADS_Main_Files' folder for details
% about "stomads options".

%%
%  Argonne National Laboratory (USA) / Polytechnique Montreal (Canada)

%  Kwassi Joseph Dzahini, PhD. September 2022.

clear;                          % Be careful!!

%% Paths for algorithm main files and creation of the folder for the outputs txt files
StoMADS_Paths;  % Warning: do not comment!!

%% Sample calling syntax for the dfo and mgh functions
calldfomidfuns; % Warning: do not comment!!
stomads_option.experiments = 1i; % Warning: do not modify!!

%%
global  nprobl

% Defining the types of problems: see calfun_sample.m in 'YATSOp' for details
probtypes = {'smooth', 'absuniform2', 'absnormal2', 'reluniform2', 'relnormal2', ...
    'absnormal', 'absuniform', 'reluniform', 'relnormal', 'abswild', 'nondiff'};

sigmavals = [1, 2, 3, 4, 5, 6, 7, 8];   %  See probspecs.sigma below

%% Loop on the noise level
for ind_sigma = 3% :8     % Indices in sigmavals (above) for the standard deviation
                          % Sigma (see probspecs.sigma below)
    
    % One must define ind.prob, ind.sigma, ind.seed
    ind.seed = 1;
    ind.prob = 8;  % Index corresponding to the type of problem in probtypes (above):
                   % for example, 8 corresponds to 'reluniform'
    seedval = floor(1 + pi^(ind.seed));
    ind.sigma = ind_sigma;        % See probspecs.sigma below
    
    %% define probtype and noiselevel and truncation level
    
    % (these will not change across the 40 problems)
    probtype = probtypes{ind.prob};
    probspecs.sigma = 10^(-sigmavals(ind.sigma));
    probspecs.trunc = 10^16; % Chosen so that starting point unaffected
    
    %% Loop on the 40 problems
    
    for nprobl = 1:40   %  (1 to 40 problems)
        %% Initialize the rest of the problem specifications specific to problem nprobl
        
        % Do not modify/delete any of the probspecs below
        probspecs.nprob = Var(nprobl, 1);  % See calldfomidfuns.m for the Var array
        probspecs.n = Var(nprobl, 2);
        probspecs.m = Var(nprobl, 3);
        probspecs.probtype = probtype; % This is needed for the output files
        
        %% Initializing the algorithm options (see stomads_default_options.m for details)
        
        stomads_option.DisplayOutputs = 0;
        stomads_option.DisplaySolution = 0;
        stomads_option.FixSeed = 0;
        stomads_option.HistoryFile = 1;
        stomads_option.MaxFuncEval = 100000;
        stomads_option.SampleSize = 5;
        stomads_option.SolutionFile = 1;
        stomads_option.StatsFile = 1;
        stomads_option.UsePreviousSamples = 1;
        
        %% Defining bounds on the variables
        
        % No need to uncomment the following since the lower and upper
        % bounds are automatically set to [-Inf, ...] and [Inf, ...], respectively,
        % in the algorithm if no specific bounds are provided
        
        %         stomads_option.LowerBounds = -Inf * ones(probspecs.n, 1);
        %         stomads_option.UpperBounds = Inf * ones(probspecs.n, 1);
        
        %%  Get starting point and problem name
        
        [X0, prob] = dfoxsnew(probspecs.m, probspecs.n, probspecs.nprob); % starting point
        namestr{nprobl} = prob.name;
        
        %% Define a function that takes column vector input
        
        myfun = @(x)calfun_sample(x, probspecs, probtype);
        
        %% (For display during the optimization process)
        
        fprintf('----------------------------------------------------------------------------------   \\\\ \n');
        if stomads_option.DisplayOutputs == 1
            fprintf('Problem  &   n   &   fbest       &   FinalMaxMeshSize   \\\\ \n');
        end
        
        %% Run optimization  (see stomads_algorithm.m in 'StoMADS_Main_Files' folder)
        
        X = stomads_algorithm(myfun, X0, stomads_option, probspecs);
        
        %%
        % The algorithm, although applied to a stochastic objective (e.g.,
        % see 'absnormal', etc., and other 'probtypes' above), displays the
        % corresponding 'smooth' function value at the best solution found.
        % Indeed, note that all the noisy problems are noisy variants of
        % the 'smooth' problem.
        
        fprintf('Problem  &  Dimension   &    Best smooth function value       &   FinalMaxMeshSize   \\\\ \n');
        fprintf('%8s &  %i         &%12.7g                         &%8.0e         \\\\ \n', ...
            namestr{nprobl}, probspecs.n, X(1), X(2));
    end
end
