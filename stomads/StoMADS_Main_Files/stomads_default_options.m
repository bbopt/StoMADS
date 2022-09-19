%% Default options for the StoMADS algorithm (do not change/delete/modify)

%%
%  Argonne National Laboratory (USA) / Polytechnique Montreal (Canada)

%  Kwassi Joseph Dzahini, PhD. September 2022.

%%

% See 'Remarks and recommendations' below

stomads_option.Anisotropy = 0;        % 1 to enable anisotropy for gmesh. For xmesh, see 'incr_poll_size_vec.m'. Not defined for smesh
stomads_option.AnisoParam = 0.1;      % Anisotropy parameter; See https://doi.org/10.1137/18M1175872
stomads_option.DisplayOutputs = 1;    % 1 to display function values and (maximum) mesh size during optimization process, 0 otherwise
stomads_option.DisplaySolution = 1;   % 1 to display the best solution at the end of a run. 0 otherwise
stomads_option.FixSeed = 0;           % 1 to fix random seeds, 0 otherwise
stomads_option.GammaEpsilon = 1;      % See StoMADS paper for details regarding gamma and epsilon
stomads_option.HistoryFile = 1;       % 1 to generate a .txt history file, 0 otherwise (see MCestimate.m)
stomads_option.InitPollSize = 1;      % Initial poll size for smesh. For gmesh and xmesh, see init_poll_size_coeffs.m
stomads_option.LowerBounds = [];      % Lower bounds on the problem variables; set to -Inf in the algorithm if no bound is provided
stomads_option.MaxFuncEval = Inf;     % Maximum number of function evaluations (handled by MCestimate.m)
stomads_option.MaxNumberIters = 1000; % Maximum number of iterations (considered only when stomads_option.MaxFuncEval = Inf)
stomads_option.MeshType = 0;          % -1 for gmesh, 0 for smesh (in the StoMADS paper) and 1 for xmesh (see other files for details)
stomads_option.OrthoN_PlusOne = 1;    % 1 for polling using n + 1 directions from a (minimal) positive basis. 0 for 2n directions
stomads_option.SampleSize = 5;        % Sample size for estimate computation (see MCestimate.m)
stomads_option.SeedValue = [];        % Seed value when stomads_option.FixSeed = 1; equals floor(1+ pi) in the algorithm if no value is provided
stomads_option.SolutionFile = 0;      % 1 to generate a .txt file containing the solution of the problem; 0 otherwise (see [4] below)
stomads_option.StatsFile = 0;         % 1 to generate a .txt stats file, 0 otherwise (see MCestimate.m)
stomads_option.Tau = 0.5;             % Parameter used to increase/decrease the mesh/poll parameters (for smesh and xmesh)
stomads_option.UpperBounds = [];      % Upper bounds on the problem variables; set to +Inf in the algorithm if no bound is provided
stomads_option.UsePreviousSamples = 1;% 1 to use available samples in cache for estimates computation; 0 otherwise
stomads_option.warning = 0;           % Do not modify
probspecs.Dimension = [];             % Intitialization! Problem dimension set to that of the starting point in the algorithm if no value is provided

%% Remarks and recommendations 

% Please, do not uncomment the following:

%% [1]

% The following are recommended since agreeing with variants of the
% algorithm whose convergence has been proved.

% stomads_option.Anisotropy = 0;
% stomads_option.InitPollSize = 1;
% stomads_option.MeshType = 0;
% stomads_option.OrthoN_PlusOne = 1;
% stomads_option.Tau = 0.5;

%% [2]

% The convergence of StoMADS was neither proved for granular mesh (stomads_option.MeshType = -1, for 'gmesh')
% nor for xmesh, which also uses mesh and poll size vectors (stomads_option.MeshType = 1).
% Consequently, the option stomads_option.MeshType = 0 should be preferred as above, and which corresponds
% to the 'simple mesh' (smesh) used in the original StoMADS paper.

%% [3]

% The algorithm uses random orthogonal polling directions and as a
% consequence, the optimization of deterministic objectives may produce 
% different solutions from one run to another, depending on the problem,
% unless stomads_option.FixSeed = 1.

%% [4]

% When 'stomads_option.HistoryFile', 'stomads_option.SolutionFile' and 'stomads_option.StatsFile'
% are all set to 0, the algorithm automatically sets stomads_option.SolutionFile = 1 to at least
% generate the solution of the run.
