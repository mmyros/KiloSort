function createChannelMapFile(fpath,Nchannels,ntrodes)
%  create a channel map file
if ~exist('Nchannels','var'),    Nchannels = 16; end
if ~exist('nshanks','var'),    ntrodes = 2; end
% connected = true(Nchannels, 1);
% chanMap   = 1:Nchannels;
% chanMap0ind = chanMap - 1;
% xcoords   = ones(Nchannels,1);
% ycoords   = [1:Nchannels]';
% kcoords   = ones(Nchannels,1); % grouping of channels (i.e. tetrode groups)

% fs = 30000; % sampling frequency
% save([fpath 'chanMap.mat'], ...
%     'chanMap','connected', 'xcoords', 'ycoords', 'kcoords', 'chanMap0ind', 'fs')

%%

if mod(Nchannels,ntrodes)==0

    connected = true(Nchannels, 1);
    chanMap   = 1:Nchannels;
    chanMap0ind = chanMap - 1;
    xcoords   = repmat([1:ntrodes]', 1, Nchannels/ntrodes);
    ycoords   = repmat(1:Nchannels/ntrodes, ntrodes, 1);
    else%must also include 3 acceleromtere channels
    
	   connected = [true(Nchannels-3, 1)',false(3,1)']';
    chanMap   = 1:Nchannels;
    chanMap0ind = chanMap - 1;
    xcoords   = [repmat([1:ntrodes]', 1, (Nchannels-3)/ntrodes)  repmat(ntrodes+3,2,ntrodes)'];
    ycoords   = [repmat(1:(Nchannels-3)/ntrodes, ntrodes, 1) repmat(Nchannels-2:Nchannels,ntrodes,1)];    
end
% keyboard

xcoords   = xcoords(:);
ycoords   = ycoords(:);
kcoords   = ycoords;% same as ishank %ones(Nchannels,1); % grouping of channels (i.e. tetrode groups)

fs = 30000; % sampling frequency

%%
save([fpath 'chanMap.mat'], ...
    'chanMap','connected', 'xcoords', 'ycoords', 'kcoords', 'chanMap0ind', 'fs')
%%

% kcoords is used to forcefully restrict templates to channels in the same
% channel group. An option can be set in the master_file to allow a fraction 
% of all templates to span more channel groups, so that they can capture shared 
% noise across all channels. This option is

% ops.criterionNoiseChannels = 0.2; 

% if this number is less than 1, it will be treated as a fraction of the total number of clusters

% if this number is larger than 1, it will be treated as the "effective
% number" of channel groups at which to set the threshold. So if a template
% occupies more than this many channel groups, it will not be restricted to
% a single channel group. 
