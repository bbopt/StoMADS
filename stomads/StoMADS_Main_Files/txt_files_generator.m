%% Output files of the StoMADS algorithm

%%
%  Argonne National Laboratory (USA) / Polytechnique Montreal (Canada)

%  Kwassi Joseph Dzahini, PhD. September 2022.

%%

global nprobl fEval_History fEval_Stats
%%
if stomads_option.MeshType == 1
    mesh = 'xmesh';
elseif stomads_option.MeshType == 0
    mesh = 'smesh';
else
    mesh = 'gmesh';
end
%%
if stomads_option.experiments == 1i % When using 'stomads_experiments'
    if stomads_option.FixSeed == 1
        filestr = [mesh, '_', 'prob', num2str(nprobl), '_', 'type', probspecs.probtype, '_', ...
            'sigma', num2str(probspecs.sigma), '_', 'seed', num2str(stomads_option.SeedValue)];
    else
        filestr = [mesh, '_', 'prob', num2str(nprobl), '_', 'type', probspecs.probtype, '_', ...
            'sigma', num2str(probspecs.sigma)];
    end
    if stomads_option.HistoryFile == 1
        stomads_Hfile = fopen([stomads_option.SaveLocation '/history_' filestr '.txt'], 'w');
        fprintf(stomads_Hfile, [' %i '  ' %12.20f '  ' %12.20f '  '\n'], fEval_History');
        fclose(stomads_Hfile);
    else
        if stomads_option.StatsFile ~= 1
            stomads_option.SolutionFile = 1;
        end
    end
    if stomads_option.StatsFile == 1
        stomads_AHfile = fopen([stomads_option.SaveLocation '/stats_' filestr '.txt'], 'w');
        fprintf(stomads_AHfile, [' %i ' repmat(' %12.20f ', 1, probspecs.n) ' %12.20f '  ...
            ' %12.20f '  '\n'], fEval_Stats');
        fclose(stomads_AHfile);
    end
    if stomads_option.SolutionFile == 1
        stomads_Sfile = fopen([stomads_option.SaveLocation '/solution_' filestr '.txt'], 'w');
        fprintf(stomads_Sfile, [' %12.20f '  '\n'], cur_sol);
        fclose(stomads_Sfile);
    end
else  % When using 'stomads_applications'
    if stomads_option.HistoryFile == 1
        filestr = [mesh, '_', 'history', '_', 'file'];
        stomads_Hfile = fopen([stomads_option.SaveLocation '/stomads_' filestr '.txt'], 'w');
        fprintf(stomads_Hfile, [' %i '  ' %12.20f '  '\n'], fEval_History');
        fclose(stomads_Hfile);
    else
        if stomads_option.StatsFile ~= 1
            stomads_option.SolutionFile = 1;
        end
    end
    if stomads_option.StatsFile == 1
        filestr = [mesh, '_', 'stats', '_', 'file'];
        stomads_AHfile = fopen([stomads_option.SaveLocation '/stomads_' filestr '.txt'], 'w');
        fprintf(stomads_AHfile, [' %i ' repmat(' %12.20f ', 1, ...
            probspecs.Dimension)  ' %12.20f '  '\n'], fEval_Stats');
        fclose(stomads_AHfile);
    end
    if stomads_option.SolutionFile == 1
        filestr = ['stomads', '_', mesh, '_', 'solution', '_', 'file'];
        stomads_Sfile = fopen([stomads_option.SaveLocation '/solution_' filestr '.txt'], 'w');
        fprintf(stomads_Sfile, [' %12.20f '  '\n'], cur_sol);
        fclose(stomads_Sfile);
    end
end
