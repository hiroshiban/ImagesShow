function protocols=readExpProtocols(protocolfile,blockrand,fps,ifi,init_rand_flg)

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
%
% [about protocolfile]
% blocks{1}.randomization=0; % 0:OFF, 1:ALL, 2:Even seq. only, 3:Odd seq. only, 4:first half seq. only, 5:last half seq. only
% blocks{1}.sequence=[2 1 3 1 4 1 5 1 6 1 7 1 8 1 9 1 10 1]; % image number to be used
% blocks{1}.msec=[500 200 500 200 500 200 500 200 500 200 500 200 500 200 500 200 500 200]; % display duration in msec of each image
% (or blocks{1}.frame=[5 2 5 2 5 2 5 2 5 2 5 2 5 2 5 2 5 2 5 2]; % you can alternatively set display durations in frames of each image)
% blocks{1}.slicing=100 (or blocks{2}.slicing=2); % (optional) minimum time slice in presentation (used to display task), if not specified, 6(frames) or 100(msec) are used by default
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
% !NOTE about .msec and .frame!
% Only setting one of the .msec or .frame is enough. When two variables are set, .frame will have a priority.
%
% [output]
% protocols    : experiment protocol, cell structure
%                the protocols is almost same with blocks variable, but each protocol is expanded
%                based on the setting of the repetition variable.
%                protocols have the members listed below.
%                protocols{n}.sequence    : image presentation sequence
%                protocols{n}.duration    : image presentation duration in msec or frame (the number of vertical sync signals)
%                protocols{n}.slicing : (optional) minimum time slice in presentation (used to display task), 6(frames) or 100(msec) by default
%                protocols{n}.mode        : 'msec' or 'frame'
%                protocols{n}.name        : (optional) name of the block, empty if not specified in blocks.
%                protocols{n}.cumduration : cummurative duration in msec or frame
%
%
% Created    : "2013-11-08 15:30:07 ban"
% Last Update: "2013-11-15 14:50:29 ban"

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
    catch
      ifi=1/fps;
    end
  else
    ifi=16.666667;
  end
end
if nargin<4 || isempty(init_rand_flg), init_rand_flg=0; end

% initialize the seed of random array
if init_rand_flg, InitializeRandomSeed(); end

% check protocol file
run_protocolfile=protocolfile;
if ~strcmpi(run_protocolfile(end-1:end),'.m'), run_protocolfile=strcat(run_protocolfile,'.m'); end

if ~exist(fullfile(pwd,run_protocolfile),'file')
  error('can not find protocolfile: %s. check an input variable',run_protocolfile);
end
clear protocolfile;

% load protocols
run(fullfile(pwd,run_protocolfile));
nblocks=length(blocks); %#ok % blocks is loaded on memory after running protocolfile

% check whether the condition settings are correct (the number of sequences etc)
for ii=1:1:nblocks
  if isempty(intersect(blocks{ii}.randomization,0:1:5))
    error('blocks{%d}.randomization is not one of 1-5. check input variable.',ii);
  end
  if isstructmember(blocks{ii},'frame')
    if numel(blocks{ii}.sequence)~=numel(blocks{ii}.frame)
      error('#block %02d: the number of members in .sequence and .frame are different. check input variable.',ii);
    end
  elseif isstructmember(blocks{ii},'msec')
    if numel(blocks{ii}.sequence)~=numel(blocks{ii}.msec)
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
    if blocks{ii}.randomization==0 % asis
      ridx=1:numel(blocks{ii}.sequence);

    elseif blocks{ii}.randomization==1 % all sequences
      ridx=shuffle(1:numel(blocks{ii}.sequence));

    elseif blocks{ii}.randomization==2 % even sequence
      tmp=shuffle(2:2:numel(blocks{ii}.sequence));
      if ~mod(numel(blocks{ii}.sequence),2)
        ridx=reshape([(1:2:numel(blocks{ii}.sequence));tmp],1,numel(blocks{ii}.sequence));
      else
        tmp=reshape([(1:2:numel(blocks{ii}.sequence));[tmp,0]],1,numel(blocks{ii}.sequence)+1);
        ridx=tmp(1:end-1);
      end

    elseif blocks{ii}.randomization==3 % odd sequence
      tmp=shuffle(1:2:numel(blocks{ii}.sequence));
      if ~mod(numel(blocks{ii}.sequence),2)
        ridx=reshape([tmp;(2:2:numel(blocks{ii}.sequence))],1,numel(blocks{ii}.sequence));
      else
        tmp=reshape([tmp;[(2:2:numel(blocks{ii}.sequence)),0]],1,numel(blocks{ii}.sequence)+1);
        ridx=tmp(1:end-1);
      end

    elseif blocks{ii}.randomization==4 % the first half
      bidx=ceil(numel(blocks{ii}.sequence)/2);
      tmp=shuffle(1:1:bidx);
      ridx=[tmp,bidx+1:1:numel(blocks{ii}.sequence)];

    elseif blocks{ii}.randomization==5 % the last half
      bidx=ceil(numel(blocks{ii}.sequence)/2);
      tmp=shuffle(bidx+1:1:numel(blocks{ii}.sequence));
      ridx=[1:1:bidx,tmp];
    end

    tmpsequence=[tmpsequence,blocks{ii}.sequence(ridx)]; %#ok
    if isstructmember(blocks{ii},'frame')
      tmpduration=[tmpduration,blocks{ii}.frame(ridx)]; %#ok
    elseif isstructmember(blocks{ii},'msec')
      tmpduration=[tmpduration,blocks{ii}.msec(ridx)]; %#ok
    end
  end % for rr=1:1:ncycles
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
if numel(blockrand)==1
  if blockrand==0 % asis
    ridx=1:length(protocols);
  elseif blockrand==1 % all sequence
    ridx=shuffle(1:length(protocols));
  elseif blockrand==2 % even sequence
    tmp=shuffle(2:2:length(protocols));
    if ~mod(length(protocols),2)
      ridx=reshape([(1:2:length(protocols));tmp],1,length(protocols));
    else
      tmp=reshape([(1:2:length(protocols));[tmp,0]],1,length(protocols)+1);
      ridx=tmp(1:end-1);
    end
  elseif blockrand==3 % odd sequence
    tmp=shuffle(1:2:length(protocols));
    if ~mod(length(protocols),2)
      ridx=reshape([tmp;(2:2:length(protocols))],1,length(protocols));
    else
      tmp=reshape([tmp;[(2:2:length(protocols)),0]],1,length(protocols)+1);
      ridx=tmp(1:end-1);
    end
  elseif blockrand==4 % the first half
    bidx=ceil(length(protocols)/2);
    tmp=shuffle(1:1:bidx);
    ridx=[tmp,bidx+1:1:length(protocols)];
  elseif blockrand==5 % the last half
    bidx=ceil(length(protocols)/2);
    tmp=shuffle(bidx+1:1:length(protocols));
    ridx=[1:1:bidx,tmp];
  elseif blockrand==6 % 2-N-1 blocks
    ridx=shuffle(2:length(protocols)-1);
    ridx=[1,ridx,length(protocols)];
  end
else % matrix:randomize specific block you set. e.g. blockrand=[2,4,6,8];
  ridx=1:length(protocols);
  [bidx,index]=shuffle(blockrand);
  ridx(blcokrand)=bidx;
end
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


%% subfunction
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

[null,index] = sort(rand(size(X)));
Y = X(index);

return
