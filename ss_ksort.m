function ss_ksort(respath,nchans,ntrodes)
% matlab -r -nodisplay -nojvm "ss_ksort('~/res/test2try4/',16,2)"
%respath='~/res/';%put data.dat in htis directory
% nchans=16;
% ntrodes=2;
%% This part adds paths
%disp(respath)
%  disp(nchans)
%  disp(ntrodes)
%ntrodes=2;
%nchans=32;
try
ntrodes=str2num(ntrodes);
nchans=str2num(nchans);
%f=fopen('~/tempoutput.txt','w');fprintf(f,'%s,%f,%f',respath,nchans,ntrodes);fclose(f) %this was just for test
end
addpath(genpath('~/git/ss/mmyksort')) % path to kilosort folder
addpath(genpath('~/git/npy-matlab')) % path to npy-matlab scripts
createChannelMapFile(respath,nchans,ntrodes) 
ops=ksort_config(respath); 
%% This part runs the normal Kilosort processing on the simulated data
[rez, DATA, uproj] = preprocessData(ops); % preprocess data and extract spikes for initialization
rez                = fitTemplates(rez, DATA, uproj);  % fit templates iteratively
rez                = fullMPMU(rez, DATA);% extract final spike times (overlapping extraction)

% save python results file for Phy

rezToPhy(rez, respath);
