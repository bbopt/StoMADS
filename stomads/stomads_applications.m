% This script runs StoMADS on unconstrained problems, or problems with
% bound constraints. It aims to show users how to provide problems to the
% algorithm.

%% StoMADS algorithm: (https://doi.org/10.1007/s10589-020-00249-0 or https://rdcu.be/cS8fR)
%% To cite the StoMADS paper, see Readme.md

% Applications examples are therefore provided below.

% See MCestimate.m in the 'StoMADS_Main_Files' folder to understand the output files.
% Before any update related to the creation of the output files, see 'MCestimate.m'
% and then 'txt_files_generator.m'.

% For details about 'stomads_option' or for other options, see 'stomads_default_options.m'
% in the 'StoMADS_Main_Files' folder.

% See the 'Remarks and recommendations' section in 'stomads_default_options.m'
% Note in particular that the algorithm uses random orthogonal polling
% directions and as a consequence, the optimization of deterministic
% objectives may produce different solutions from one run to another,
% depending on the problem, unless stomads_option.FixSeed = 1

%  Argonne National Laboratory (USA) / Polytechnique Montreal (Canada)

%  Kwassi Joseph Dzahini, PhD. September 2022.

%%
clear;                          % Be careful!!

%% Paths for algorithm main files and creation of the folder for the outputs txt files
StoMADS_Paths;                  % Warning: do not comment!!
stomads_option.experiments = 0; % Warning: do not comment!!

%%  Problem specifications and algorithm options
% See comments above on stomads_options

stomads_option.DisplayOutputs = 1;
stomads_option.DisplaySolution = 1;
stomads_option.FixSeed = 0;
stomads_option.HistoryFile = 1;           % See comments above on output files
stomads_option.MaxFuncEval = 3000;
stomads_option.SampleSize = 2;            % (Very small value provided here!!)
stomads_option.SolutionFile = 1;
stomads_option.StatsFile = 1;
stomads_option.UsePreviousSamples = 1;

%%
%                          Test problems

%%                           Problem 1

% % n dimensional problem
% % Lower and upper bounds on the variables are automatically set to
% % [-Inf, ...] and [Inf, ...], respectively, since no bounds are provided
% 
% % Objective function
% % noisy using a normal distribution with mean 0 and standard deviation 0.01
% myfun = @(x)(norm(x)^2 - 2 * sum(x) - 27) + 0.01 * randn(1);
% 
% % Starting point
% X0 = [1000, 10000, 1570, 125];   % Can be replaced by lower or higher dimension vectors

%%                           Problem 2

% % 2 dimensional problem
% 
% % Objective function (deterministic part) from https://doi.org/10.1287/ijoc.1090.0319 (Section 5),
% % noisy using a uniform distribution in [-a, a]: here a = 0.01
% myfun = @(x)(2 * x(1)^6 - 12.2 * x(1)^5 + 21.2 * x(1)^4 + 6.2 * x(1)^1 - 6.4 * x(1)^3 - ...
%     4.7 * x(1)^2 + x(2)^6 - 11 * x(2)^5 + 43.3 * x(2)^4 - 10 * x(2)^1 - 74.8 * ...
%     x(2)^3 + 56.9 * x(2)^2 - 4.1 * x(1) * x(2) - 0.1 * (x(1) * x(2))^2 + 0.4 * ...
%     x(1) * x(2)^2 + 0.4 * x(1)^2 * x(2)) + (0.01 + (0.01 + 0.01) * rand(1));
% 
% % Starting point
% X0 = [-5, 2];                                % Wrong dimensions of X0 will throw warning messages
%                                              % (see 'stomads_warnings.m' in 'StoMADS_Main_Files')
% 
% % Bounds on the variables
% stomads_option.LowerBounds = [-Inf, 2];      % Wrong bounds will throw warning messages
% stomads_option.UpperBounds = [-1, 10];

%%                           Problem 3

% Same as Problem 2, but with the objective provided by an external script (blackbox)
% in the 'problem' folder

% Adding problem location to the MATLAB path
addpath(['problem', '/']);

% Objective function provided by a 'blackbox'
myfun = @(x)bbox(x);

% Starting point
X0 = [-5, 2];                                % Wrong dimensions of X0 will throw warning messages
                                             % (see 'stomads_warnings.m' in 'StoMADS_Main_Files')

% Bounds on the variables
stomads_option.LowerBounds = [-Inf, 2];      % Wrong bounds will throw warning messages
stomads_option.UpperBounds = [-1, 10];

%% For display during the optimization process
if stomads_option.DisplayOutputs == 1
    fprintf('Noisy function value         &  FinalMaxMeshSize   \\\\ \n');
end
%% Run optimization
X = stomads_algorithm(myfun, X0, stomads_option);
