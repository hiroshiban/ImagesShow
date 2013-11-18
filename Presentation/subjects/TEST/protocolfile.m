% a sample of protocolfile
% for details, please see readExpProtocols.m

% if you want to set display duration in msec
blocks{1}.randomization=5;   % 0:OFF, 1:ALL, 2:Even seq. only, 3:Odd seq. only, 4:first half seq. only, 5:last half seq. only, 6:2-N-1 blocks are randomized whereas the first and the last blocks are fixed, matrix:randomize specific blocks you set. e.g. blockrand=[2,4,6,8];
blocks{1}.sequence=1;        % image number to be used
blocks{1}.msec=500;          % display duration in msec of each image
blocks{1}.slicing=100;       % (optional) minimum time slice in presentation (used to display task), if not specified, 6(frames) or 100(msec) are used by default
blocks{1}.repetitions=1;     % the number of repetitions of this block
blocks{1}.name='cond 1';     % (optional) name of the conditions, empty if not specified

blocks{2}.randomization=0;
blocks{2}.sequence=[7 5 1 2 3 4 6 5 1 2 3 4 6 5 1 2 3 4 6 7];
blocks{2}.msec=[500 200 100 200 100 200 100 200 100 200 100 200 100 200 100 200 100 200 100 500];
blocks{2}.slicing=100;
blocks{2}.repetitions=1;
blocks{2}.name='images 1';

blocks{3}.randomization=3;
blocks{3}.sequence=[7 5 1 2 3 4 6 5 1 2 3 4 6 5 1 2 3 4 6 7];
blocks{3}.msec=[500 200 100 200 100 200 100 200 100 200 100 200 100 200 100 200 100 200 100 500];
blocks{3}.slicing=100;
blocks{3}.repetitions=2;
blocks{3}.name='images 2';

% alternatively, if you want to set display duration in frames (vertical sync signals), please set protocols as below.

%blocks{1}.randomization=5;
%blocks{1}.sequence=1;
%blocks{1}.frame=30;
%blocks{1}.slicing=10;
%blocks{1}.repetitions=1;
%blocks{1}.name='cond 1';
%
%blocks{2}.randomization=0;
%blocks{2}.sequence=[7 5 1 2 3 4 6 5 1 2 3 4 6 5 1 2 3 4 6 7];
%blocks{2}.frame=[30 12 6 12 6 12 6 12 6 12 6 12 6 12 6 12 6 12 6 30]; % you can alternatively set display durations in frames of each image
%blocks{2}.slicing=10;
%blocks{2}.repetitions=1;
%blocks{2}.name='images 1';
%
%blocks{3}.randomization=3;
%blocks{3}.sequence=[7 5 1 2 3 4 6 5 1 2 3 4 6 5 1 2 3 4 6 7];
%blocks{3}.frame=[30 12 6 12 6 12 6 12 6 12 6 12 6 12 6 12 6 12 6 30];
%blocks{3}.slicing=10;
%blocks{3}.repetitions=2;
%blocks{3}.name='images 2';
