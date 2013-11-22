% a sample of protocolfile
% for details, please see readExpProtocols.m

% blocks{1}.randomization=0; % 0:OFF, 1:ALL, 2:Even seq. only, 3:Odd seq. only, 4:first half seq. only, 5:last half seq. only.
%                            % 6:2-N-1 blocks are randomized whereas the first and the last sequences are fixed.
%                            % or "matrix":randomize specific sequences you set. e.g. blocks{n}.randomization=1:3:ceil(N/2);
%                            % a scalar (for monocular) or 2x1 cell structure (for binocular display with left/right separate settings).
% blocks{1}.sequence=[7 5 1 2 3 4 6 5 1 2 3 4 6 5 1 2 3 4 6 7]; % image numbers to be used, 1xN (monocular) or 2xN (binocular) vector
% blocks{1}.msec=[500 200 100 200 100 200 100 200 100 200 100 200 100 200 100 200 100 200 100 500]; % display duration in msec of each image
% blocks{1}.slicing=100 (or blocks{2}.slicing=2); % (optional) minimum time slice in presentation (required to display task correctly),
%                                                 % if not specified, 6(frames) or 100(msec) are used by default
%                                                 % by using this variable as an unit, blocks{n}.sequence will be divided to subsequence
%                                                 % for example, if blocks{1}.msec=[500,500,500]; and blocks{1}.slicing=100;,
%                                                 % then blocks{1}.subduration=[100*ones(1,500/100),100*ones(1,500/100),100*ones(1,500/100)];
%                                                 % will be generated. Each residual of the duration is added to the final element or
%                                                 % separately added as the last+1 element.
% blocks{1}.repetitions=1; % the number of repetitions of this block
% blocks{1}.name='images 1'; % (optional) name of the conditions, empty if not specified
% ...
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

blocks{1}.randomization=0;
blocks{1}.sequence=201;
blocks{1}.msec=16000;
blocks{1}.slicing=100;
blocks{1}.repetitions=1;
blocks{1}.name='The First Fixation';

block_counter=1; n_each=20;
for ii=1:1:100/n_each
  block_counter=block_counter+1;
  stim_array=n_each*(ii-1)+1:n_each*ii;
  stim_array=[stim_array;stim_array+100;stim_array;stim_array+100];
  stim_array=stim_array(:)';

  blocks{block_counter}.randomization=0;
  blocks{block_counter}.sequence=Pad2Array(stim_array,201,0);
  blocks{block_counter}.msec=repmat([200,100],1,numel(stim_array));
  blocks{block_counter}.slicing=100;
  blocks{block_counter}.repetitions=3;
  blocks{block_counter}.name=sprintf('Voronoi Textures %02d',ii);

  block_counter=block_counter+1;
  blocks{block_counter}.randomization=0;
  blocks{block_counter}.sequence=201;
  blocks{block_counter}.msec=6000;
  blocks{block_counter}.slicing=100;
  blocks{block_counter}.repetitions=1;
  blocks{block_counter}.name='Fixation Rest';
end

% replace the final fixation rest as below.
blocks{block_counter}.randomization=0;
blocks{block_counter}.sequence=201;
blocks{block_counter}.msec=16000;
blocks{block_counter}.slicing=100;
blocks{block_counter}.repetitions=1;
blocks{block_counter}.name='The Final Fixation';
