% a sample of optionfile
%
% !!NOTE!! you do not need to set all the options (you can delete or comment some of them).
%          the script automatically set the missing parameters using default ones.
%
% for details, please see readDisplayOptions.m


% how to start the experiment
% 0: press ENTER or SPACE, 1: click left-mouse button, 2: wait the first MR trigger (CiNet),
% 3: waiting for a MR trigger pulse (BUIC) -- checking onset of pin #11 of the parallel port
% 4: custom key trigger (wait for a key input that you specify as options.custom_trigger).
options.start_method=0;

% when you want to use your own trigger key to start the stimulus presentation, set a character here.
% but note that the setting here is valid only when you set options.start_method=4;
options.custom_trigger='s';

% display mode, one of "mono", "dual", "dualcross", "dualparallel", "cross", "parallel", "redgreen", "greenred",
% "redblue", "bluered", "shutter", "topbottom", "bottomtop", "interleavedline", "interleavedcolumn".
options.exp_mode='mono';

% response key codes. [1xN] matrix in which all the keycodes to be used are stored.
options.keys=[37,39]; % 37=left arrow, 39=right arrow

% screen length along y and x axes which you want to use [row,col] (pixels)
options.window_size=[1200,1920];

% if you need to change RGB video input intensities (e.g. for red-green glasses display mode),
% please set these values [2(left/right) x 3(RGB)]. Valid only when options.exp_mode is 'redgreen', 'greenred', 'redblue', or 'bluered'.
options.RGBgain=[1.0,1.0,1.0; 1.0,1.0,1.0];

% fixation parameter, {fixation type(0: non, 1: circle, 2: cross),size,color}
%options.fixation={2,24,[255,255,255]};
options.fixation={1,6,[255,0,0]};

% background parameters,
% {type(uniform(0) or with patches(1)),background_RGB,patch1_RGB,patch2_RGB,patch_num(row,col),patch_size(row,col),(optional)aperture_size(row,col)}
options.background={1,[127,127,127],[255,255,255],[0,0,0],[30,30],[20,20]};

% whether masking display images using a circular aperture mask, {on_off(0|1(circular)|2(rectangular)),radius_pix(row,col),gaussian_parameters(mean,sd)}
% if you want to put a circular aperture mask on each of the images, please set on_off to 1.
% if gaussian_parameters(1)=0, no smoothing on the edges is applied.
options.cmask={0,[280,280],[20,20]};

% whether setting background color automatically by matching it with the upper-left (1,1) pixel color of the first target image
options.auto_background=0;

% whether forcing to use the full-screen display, [0|1]
options.use_fullscr=0;

% whether skipping frame sync (flip) test
option.skip_frame_sync_test=0;

% whether forcing to use specific frame rate, if 0, the frame rate wil bw computed in the ImagesShowPTB function.
% if non zero, the value is used as the screen frame rate.
option.force_frame_rate=60;

% whether forcing to use frames (vertical sync signals) as a unit of display duration instead of msec.
% 0: none, 1: force to use the number of frames for presentation duration setting
options.use_frame=0;

% whether presenting images with original resolution
% 0: display images with sizes set in image_database file. 1: diplay image with their original sizes
options.use_original_imgsize=0;

% whether reading images one by one in creating PTB textures
% 1: load images to the memory one by one when creating the target texture.
% 2: load all the images at once before the actual presentation, but make texture when requested.
% 3: load all the images at once and make all the textures before the actual presentation
% By setting this to 1, you can save memory, but it requires additional computation time in presentation (~30ms with Core2Duo CPU) on Windows.
% When you set this to 2 or 3, you can save computational time, but requires more memory on your computer.
% I recommend to test options.img_loading_mode=2 first.
options.img_loading_mode=3;

% image offset, [row,col]. when set [0,0], images will be presented at the center of the screen
options.center=[0,0];

% whether flipping images, 0: none, 1: x-axis, 2: y-axis, 3: x&y-axis
options.img_flip=0;

% whether adding task during the experiment. [1x3] matrix. [type,frequency,duration]
% about type. 0: no task, 1: fixation dim, 2: vernier task, 3: character detection task, when 'C' is presented, press a key
% 4: 1-back identification task for odd sequence, 5: 1-back identification task for even sequence
% about frequency (integer): how often the tasks occur during the experiment, 1 is the most frequent (every time, not recommend). 3-5 would be practically fine.
% about duration: task duration in msec or frame
% !!!NOTEICE!!! Even you do not need to interpose task (options.task(1)=0), please set the other 2 variables.
% when you use task in your experiment, please fix the unit of the durations in protocolfile as 'msec' or 'frame'. please do not mix.
%options.task=[0,4,250];
options.task=[1,4,250];
%options.task=[2,4,250];
%options.task=[3,4,250];
%options.task=[4,3,250];

% whether randomize the order of the 'blocks' in protocol file.
% 0:OFF, 1:ALL, 2:Even seq. only, 3:Odd seq. only, 4:first half seq. only, 5:last half seq. only
% 6:2-N-1 blocks are randomized whereas the first and the last blocks are fixed.
% matrix:randomize specific blocks you set. e.g. options.block_rand=[2,4,6,8];
options.block_rand=0;

% whether displaying stimulus onset marker for images with trigger=ON. (you can set in your image database file).
% the marker can be used to get a photodiode trigger etc.
% [type,onset_marker_size]
% type, 0: none, 1: upper-left, 2: upper-right, 3: lower-left, 4: lower-right
% onset_marker_size : pixels of the marker
options.onset_punch=[2,50];

% how to display the progress of image presentations on the MATLAB terminal window.
% 0: displaying block and image sequences only
% 1: displaying event details including presentation time, responses, triggers etc.
options.event_display_mode=0;
