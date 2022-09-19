% This script provides to 'stomads_experiments.m' and  'stomads_applications.m'
% the paths for the main algorithm and problems files, which are necessary
% for each run of the StoMADS algorithm.
% It also creates a folder for the outputs txt files.

%%
%  Argonne National Laboratory (USA) / Polytechnique Montreal (Canada)

%  Kwassi Joseph Dzahini, PhD. September 2022.

%%

% Do not modify/delete the following!!

% Main files location
main_files_location = 'StoMADS_Main_Files';

% Adding main files location folder to the MATLAB path.
addpath([main_files_location, '/']);

% Adding YATSop folder (containing experiment main files) to the MATLAB path.
addpath([main_files_location, '/YATSOp/m/']);

stomads_default_options;

%% Location for the outputs (see txt_files_generator.m)
stomads_option.SaveLocation = 'StoMADS_Output';
if ~exist('StoMADS_Output', 'dir')
    mkdir StoMADS_Output;
end
