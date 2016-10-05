function protocols=readExpProtocols(protocolfile,blockrand,fps,ifi,init_rand_flg)

% reads and interprets experiment protocol file for ImagesShowPTB function.
% function protocols=readExpProtocols(protocolfile,:blockrand,:fps,:ifi,:init_rand_flg)
% (: is optional)
%
% This function reads an input protocol file and set experimental conditions.
%
% !!!IMPORTANT!!!
% The seed of random sequence is not initialized in this function by default setting.
% If you shuffle the seed and initialize random array, please set init_rand_flg=1.
% Or please run InitializeRandomSeed() in advance of running this function. Please be careful.
%
% [input]
% protocolfile : experiment protocol file (a matlab script file). Should be set with a relative path format.
%                The origin is the directory where this function is called.
%                The contents of the option file should be as below.
% blockrand    : (optional) whther randomize block order.
%                0:OFF, 1:ALL, 2:Even seq. only, 3:Odd seq. only, 4:first half seq. only, 5:last half seq. only
%                6:2-N-1 blocks are randomized whereas the first and the last blocks are fixed.
%                matrix:randomize specific blocks you set. e.g. blockrand=[2,4,6,8];
%                0 by default.
% fps          : the number of flips per second, e.g. 60
% ifi          : inter-flip-interval in sec. e.g. 16.6667 (60Hz display) or ifi=1/fps;
% init_rand_flg: whether initializing a random seed by time in this function, [0|1]. 0 by default.
%
% [about protocolfile]
% blocks{1}.randomization=0; % 0:OFF, 1:ALL, 2:Even seq. only, 3:Odd seq. only, 4:first half seq. only, 5:last half seq. only.
%                            % 6:2-N-1 blocks are randomized whereas the first and the last sequences are fixed.
%                            % or "matrix":randomize specific sequences you set. e.g. blocks{n}.randomization=1:3:ceil(N/2);
%                            % a scalar (for monocular) or 2x1 cell structure (for binocular display with left/right separate settings).
% blocks{1}.sequence=[2 1 3 1 4 1 5 1 6 1 7 1 8 1 9 1 10 1]; % image numbers to be used, 1xN (monocular) or 2xN (binocular) vector
% blocks{1}.msec=[500 200 500 200 500 200 500 200 500 200 500 200 500 200 500 200 500 200]; % display duration in msec of each image
% (or blocks{1}.frame=[5 2 5 2 5 2 5 2 5 2 5 2 5 2 5 2 5 2 5 2]; % you can alternatively set display durations in frames of each image)
% blocks{1}.slicing=100 (or blocks{2}.slicing=2); % (optional) minimum time slice in presentation (required to display task correctly),
%                                                 % if not specified, 6(frames) or 100(msec) are used by default
%                                                 % by using this variable as an unit, blocks{n}.sequence will be divided to subsequence
%                                                 % for example, if blocks{1}.msec=[500,500,500]; and blocks{1}.slicing=100;,
%                                                 % then blocks{1}.subduration=[100*ones(1,500/100),100*ones(1,500/100),100*ones(1,500/100)];
%                                                 % will be generated. Each residual of the duration is added to the final element or
%                                                 % separately added as the last+1 element.
% blocks{1}.repetitions=1; % the number of repetitions of this block
% blocks{1}.name='condition 1'; % (optional) name of the conditions, empty if not specified
%
% blocks{2}.randomization=0;
% blocks{2}.sequence=[11 1 12 1 13 1 14 1 15 1 16 1 17 1 18 1];
% blocks{2}.msec=[500 200 500 200 500 200 500 200 500 200 500 200 500 200 500 200 500 200];
% (or blocks{2}.frame=[5 2 5 2 5 2 5 2 5 2 5 2 5 2 5 2 5 2 5 2]; % display duration in frames of each image)
% blocks{2}.slicing=100 (or blocks{2}.slicing=2;);
% blocks{2}.repetitions=1;
% blocks{2}.name='control 1';
%
% :
% :
% :
%
% blocks{n}.randomization=0;
% blocks{n}.sequence=[2 1 3 1 4 1 5 1 6 1 7 1 8 1 9 1];
% blocks{n}.msec=[500 200 500 200 500 200 500 200 500 200 500 200 500 200 500 200 500 200];
% (or blocks{n}.frame=[5 2 5 2 5 2 5 2 5 2 5 2 5 2 5 2 5 2 5 2]; % display duration in frames of each image)
% blocks{n}.slicing=100; (or blocks{n}.slicing=2;)
% blocks{n}.repetitions=1;
% blocks{n}.name='final control';
%
% [NOTE: about .msec and .frame]
% Only setting one of the .msec or .frame is enough. When two variables are set, .frame will have a priority.
%
% [NOTE: about blocks{n}.randomization and blocks{n}.sequence]
% When you present stimuli with a monocular display, please just set one randomization parameter and one sequence [1xN].
% For binocualr displays (option.exp_mode='dual', 'cross', etc.), you can chose two options below.
% 1. if you set one randomization paramater (a scalar, e.g. 0) and one sequence (e.g. [1xN] matrix), these parameters will
%    be applied to both left/right image sequences.
% 2. when you additionally give the second variables, you can set randomization modes and sequences of left/right-eye
%    protocols separately. For example, if you set blocks{n}.randomization as a 2x1 "cell" structure (e.g. {0,1}), the
%    first one will be applied to the "left" eye image sequence while the second one will be applied to the "right" eye
%    image sequence. Two sequences will thus be randomized and initialized separately.
% Along with these choices, if you set blocks{n}.sequence as a 1xN vector, the same sequence will be applied to both
% left/right image presentations when you select one of the binocular display modes (e.g. cross-view) in optionfile.
% In contrast, if you set blocks{n}.sequence as a 2xN matrix, the first (blocks{n}.sequence(1,:)) will be used to present
% "left" eye images, while the second (blocks{n}.sequence(2,:)) will be used to present "right" eye images.
% Also note that you can set these parameters independently. Specifically, you can set like
% blocks{n}.randomization=0;
% blocks{n}.sequence=(2xN matrix);
% Then, the same randomization parameter (0) will be applied to both sequences. Please be careful.
%
% [output]
% protocols    : experiment protocol, cell structure
%                the protocols is almost same with blocks variable, but each protocol is expanded
%                based on the setting of the repetition variable.
%                protocols have the members listed below.
%                protocols{n}.sequence    : image presentation sequence, 1xN (monocular) or 2xN (binocular) matrix
%                protocols{n}.duration    : image presentation duration in msec or frame (the number of vertical sync signals)
%                protocols{n}.slicing     : (optional) minimum time slice in presentation (used to display task), 6(frames) or 100(msec) by default
%                protocols{n}.mode        : 'msec' or 'frame'
%                protocols{n}.name        : (optional) name of the block, empty if not specified in blocks.
%                protocols{n}.cumduration : cummurative duration in msec or frame
%
%
% Created    : "2013-11-08 15:30:07 ban"
% Last Update: "2016-10-05 11:15:15 ban"

%clear global; clear mex;
global subj acq session vparam dparam prt imgs;

% check input variable
if nargin<1 || isempty(protocolfile), help(mfilename()); protocols=[]; return; end
if nargin<2 || isempty(blockrand), blockrand=0; end
if nargin<3 || isempty(fps)
  if exist('Screen','file')
    fps=Screen('FrameRate',0);
  else
    fps=60;
  end
end
if nargin<4 || isempty(ifi)
  if exist('Screen','file')
    try
      ifi=Screen('GetFlipInterval',0);
    catch %#ok
      ifi=1/fps;
    end
  else
    ifi=16.666667;
  end
end
if nargin<5 || isempty(init_rand_flg), init_rand_flg=0; end

% initialize the seed of random array
if init_rand_flg, InitializeRandomSeed(); end

% check protocol file
run_protocolfile=protocolfile;
if ~strcmpi(run_protocolfile(end-1:end),'.m'), run_protocolfile=strcat(run_protocolfile,'.m'); end

if ~exist(fullfile(pwd,run_protocolfile),'file'), error('can not find protocolfile: %s. check an input variable',run_protocolfile); end
clear protocolfile;

% load protocols
run(fullfile(pwd,run_protocolfile));
nblocks=length(blocks); %#ok % blocks is loaded on memory after running protocolfile

% covert scalar/vector(s) to a cell structure and checking the validity
for ii=1:1:nblocks
  if ~iscell(blocks{ii}.randomization), blocks{ii}.randomization={blocks{ii}.randomization}; end %#ok
  if length(blocks{ii}.randomization)>2
    error('blocks{%d}.randomization should be cell(2,1) or a scalar. check input variable.',ii);
  end
end

% check whether the condition settings are correct (the number of sequences etc)
for ii=1:1:nblocks
  if ~ismember(cell2mat(blocks{ii}.randomization),0:1:6) && numel(cell2mat(blocks{ii}.randomization))==1
    error('blocks{%d}.randomization is not one of 1-6. check input variable.',ii);
  end
  if ~isempty(find(ismember(cell2mat(blocks{ii}.randomization),1:size(blocks{ii}.sequence,2))==0,1)) && numel(cell2mat(blocks{ii}.randomization))~=1
    error('blocks{%d}.randomization has index that exceeds the number of sequence. check input variable.',ii);
  end
  if isstructmember(blocks{ii},'frame')
    if size(blocks{ii}.sequence,2)~=numel(blocks{ii}.frame)
      error('#block %02d: the number of members in .sequence and .frame are different. check input variable.',ii);
    end
  elseif isstructmember(blocks{ii},'msec')
    if size(blocks{ii}.sequence,2)~=numel(blocks{ii}.msec)
      error('#block %02d: the number of members in .sequence and .msec are different. check input variable.',ii);
    end
  else
    error('blocks{%d}.frame/msec can not be found. check input variable.',ii);
  end
end

% expanding condition sequences
protocols=cell(nblocks,1);
for ii=1:1:nblocks
  ncycles=blocks{ii}.repetitions;
  tmpsequence=[];
  tmpduration=[];
  for rr=1:1:ncycles
    % shuffling the sequence according to the blocks{n}.randomization option
    if length(blocks{ii}.randomization)==1 && size(blocks{ii}.sequence,1)==1
      ridx=shuffle_sequences(blocks{ii}.randomization{1},size(blocks{ii}.sequence,2));
    elseif length(blocks{ii}.randomization)==1 && size(blocks{ii}.sequence,1)==2
      ridx=shuffle_sequences(blocks{ii}.randomization{1},size(blocks{ii}.sequence,2));
      ridx=repmat(ridx,[2,1]); % use the same ridx
    elseif length(blocks{ii}.randomization)==2 && size(blocks{ii}.sequence,1)==1
      warning('blocks{%d}: randomization has 2 elements but sequence is only 1..useing randomization{1} alone',ii); %#ok
      ridx=shuffle_sequences(blocks{ii}.randomization{1},size(blocks{ii}.sequence,2));
    elseif length(blocks{ii}.randomization)==2 && size(blocks{ii}.sequence,1)==2 % use the different ridx
      ridx=zeros(size(blocks{ii}.sequence));
      ridx(1,:)=shuffle_sequences(blocks{ii}.randomization{1},size(blocks{ii}.sequence,2));
      ridx(2,:)=shuffle_sequences(blocks{ii}.randomization{2},size(blocks{ii}.sequence,2));
    else
      error('blocks{%d}: the number of randomization parameter and sequence mismatched. check input variable.',ii);
    end

    % add the randomized sequence to tmpsequence array.
    if size(ridx,1)==1
      tmpsequence=[tmpsequence,blocks{ii}.sequence(ridx)]; %#ok
    else
      tmpsequence=[tmpsequence,[blocks{ii}.sequence(1,ridx(1,:));blocks{ii}.sequence(2,ridx(2,:))]]; %#ok
    end

    if isstructmember(blocks{ii},'frame')
      tmpduration=[tmpduration,blocks{ii}.frame(ridx(1,:))]; %#ok
    elseif isstructmember(blocks{ii},'msec')
      tmpduration=[tmpduration,blocks{ii}.msec(ridx(1,:))]; %#ok
    end
  end % for rr=1:1:ncycles

  % set the generated sequences, durations, and the other parameters
  protocols{ii}.sequence=tmpsequence;
  protocols{ii}.duration=tmpduration;
  if isstructmember(blocks{ii},'slicing')
    protocols{ii}.slicing=blocks{ii}.slicing;
  else
    if isstructmember(blocks{ii},'frame')
      protocols{ii}.slicing=6;
    else
      protocols{ii}.slicing=100;
    end
  end
  if isstructmember(blocks{ii},'frame')
    protocols{ii}.mode='frame';
  elseif isstructmember(blocks{ii},'msec')
    protocols{ii}.mode='msec';
  end
  if isstructmember(blocks{ii},'name')
    protocols{ii}.name=blocks{ii}.name;
  else
    protocols{ii}.name=sprintf('block %02d',ii);
  end
end

% randomize block order
ridx=shuffle_sequences(blockrand,length(protocols));
protocols=protocols(ridx);

% get cummurative durations, taking the differences of msec and frame modes into account
for ii=1:1:length(protocols)
  protocols{ii}.cumduration=cumsum(protocols{ii}.duration);
  if ii>=2
    if strcmp(protocols{ii-1}.mode,'msec') && strcmp(protocols{ii}.mode,'msec')
      protocols{ii}.cumduration=protocols{ii}.cumduration+protocols{ii-1}.cumduration(end);
    elseif strcmp(protocols{ii-1}.mode,'msec') && strcmp(protocols{ii}.mode,'frame')
      protocols{ii}.cumduration=protocols{ii}.cumduration+ceil(protocols{ii-1}.cumduration(end)/1000*fps);
    elseif strcmp(protocols{ii-1}.mode,'frame') && strcmp(protocols{ii}.mode,'msec')
      protocols{ii}.cumduration=protocols{ii}.cumduration+protocols{ii-1}.cumduration(end)*ifi;
    elseif strcmp(protocols{ii-1}.mode,'frame') && strcmp(protocols{ii}.mode,'frame')
      protocols{ii}.cumduration=protocols{ii}.cumduration+protocols{ii-1}.cumduration(end);
    end
  end
end

return


%% subfunctions
function [Y,index] = shuffle(X)
% [Y,index] = shuffle(X)
%
% Randomly sorts X.
% If X is a vector, sorts all of X, so Y = X(index).
% If X is an m-by-n matrix, sorts each column of X, so
%   for j=1:n, Y(:,j)=X(index(:,j),j).
%
% Also see SORT, Sample, Randi, and RandSample.

% xx/xx/92  dhb  Wrote it.
% 10/25/93  dhb  Return index.
% 5/25/96   dgp  Made consistent with sort and "for i=Shuffle(1:10)"
% 6/29/96   dgp  Edited comments above.

[null,index]=sort(rand(size(X)));
Y=X(index);

return


function ridx=shuffle_sequences(s_type,s_length)

% function ridx=shuffle_sequences(s_type,s_length)
%
% This function generates randomized index to 1:s_length,
% following the randomization rule specified by s_type.
%
% [input]
% s_type   : type of the randomization, please see explains in readExpProtocols.m
% s_length : length of the array you want to generate
%
% [output]
% ridx     : randomized index to the 1:s_length array.

ridx=zeros(1,s_length);
if numel(s_type)==1
  if s_type==0 % asis
    ridx=1:s_length;
  elseif s_type==1 % all sequence
    ridx=shuffle(1:s_length);
  elseif s_type==2 % even sequence
    tmp=shuffle(2:2:s_length);
    if ~mod(s_length,2)
      ridx=reshape([(1:2:s_length);tmp],1,s_length);
    else
      tmp=reshape([(1:2:s_length);[tmp,0]],1,s_length+1);
      ridx=tmp(1:end-1);
    end
  elseif s_type==3 % odd sequence
    tmp=shuffle(1:2:s_length);
    if ~mod(s_length,2)
      ridx=reshape([tmp;(2:2:s_length)],1,s_length);
    else
      tmp=reshape([tmp;[(2:2:s_length),0]],1,s_length+1);
      ridx=tmp(1:end-1);
    end
  elseif s_type==4 % the first half
    bidx=ceil(s_length/2);
    tmp=shuffle(1:1:bidx);
    ridx=[tmp,bidx+1:1:s_length];
  elseif s_type==5 % the last half
    bidx=ceil(s_length/2);
    tmp=shuffle(bidx+1:1:s_length);
    ridx=[1:1:bidx,tmp];
  elseif s_type==6 % 2-N-1 blocks
    ridx=shuffle(2:s_length-1);
    ridx=[1,ridx,s_length];
  end
else % matrix:randomize specific sequences you set. e.g. s_type=[2,4,6,8];
  ridx=1:s_length;
  bidx=shuffle(s_type);
  ridx(sort(blcokrand,[],'ascend'))=bidx;
end

return
