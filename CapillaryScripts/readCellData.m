% Basic script that can read a set of text files from a series of
% directories for multiple output trajectories, and write that data
% to a .mat file which is stored in binary so can be read in fast and
% takes up less space.



tic;
%populationDirectory = '/home/msneddon/Desktop/swim_output/pop16_cap/';
populationDirectory = cell(0,0);

%list of all directories we want to visit
%populationDirectory{1,1} = '/home/msneddon/Desktop/testLinear/';
populationDirectory{1,1} = '/home/msneddon/Desktop/bullDog_Results/swimLinear1/pop1_wt/';
populationDirectory{2,1} = '/home/msneddon/Desktop/bullDog_Results/swimLinear1/pop2_wt/';
populationDirectory{3,1} = '/home/msneddon/Desktop/bullDog_Results/swimLinear1/pop3_wt/';
populationDirectory{4,1} = '/home/msneddon/Desktop/bullDog_Results/swimLinear1/pop4_wt/';
populationDirectory{5,1} = '/home/msneddon/Desktop/bullDog_Results/swimLinear1/pop5_wt/';
%populationDirectory{6,1} = '/home/msneddon/Desktop/bullDog_Results/swimLinear1/pop1_wt/';

cellCount = 20;            % Number of cells per directory
startCountOutput = 1;     % Number to start the new counter for output



%Remember the current directory we were in
currentDirectory = pwd;

for d=1:length(populationDirectory)
    
    %First, go the the right directory
    fprintf(['Reading directory: ',populationDirectory{d}, '\n']);
    cd(populationDirectory{d});
    unix('mkdir matlabData');

    %For each cell
    for i=1:cellCount;
        
        %Read the data (takes a while!)
        fprintf([' -Processing Cell #',num2str(i), ' ...  ']);
        [data,dataColNames] = tblread(['c',num2str(i),'/cellTrajectory.txt'],'\t');

        %Make a new directory to save our results, and save the results
        unix(['mkdir matlabData/c',num2str(startCountOutput)]);
        save(['matlabData/c',num2str(startCountOutput),'/cellTrajectory.mat'],'dataColNames','data');
        startCountOutput = startCountOutput+1;
        fprintf(['Done.\n']);
    end

    toc;
end;

%Go back to where we started, and tell us how long it all took
cd(currentDirectory);
toc;