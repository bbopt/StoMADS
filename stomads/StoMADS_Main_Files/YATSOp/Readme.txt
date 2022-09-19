
Once the YATSOp repository downloaded (see stomads_experiments.m for details), then 
make sure the following files are copied to the 'm' folder:

calfun_sample.m
calldfofuns.m
calldfomidfuns.m
dfoxsnew.m
mghvec.m

Note that the YATSOp folder is already added to the MATLAB path in StoMADS_Paths.m via
the following:

% Adding YATSop folder (containing experiment main files) to the MATLAB path.
addpath([main_files_location, '/YATSOp/m/']);


Note (just in case): if for some reasons, a "concatenation error" occurs while using the
mghvec.m file, then maybe consider adding to it the following in order for the vector x
to (always) be a column vector:

if isrow(x)
    x = x';
end