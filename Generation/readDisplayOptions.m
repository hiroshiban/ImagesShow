function options=readDisplayOptions(optionfile)

% reads and set options of your experimental procedures for ImagesShowPTB function.
% function options=readDisplayOptions(optionfile)
%
% This function reads option parameters from an input file
% and set ImagesShow display options.
%
% Created    : "2013-11-08 15:36:14 ban"
% Last Update: "2025-02-18 22:20:44 ban"
%
%
% [input]
% optionfile : Option file (a matlab script file). Should be set with a relative path format.
%              The origin is the directory where this function is called.
%              The option file can have various parameters listed below. If some of them are not set,
%              the default parameters are used. So you do not need to set all in your optionfile.
%
%              % display mode, one of "mono", "dual", "dualparallel","dualcross", "cross", "parallel", "redgreen", "greenred", "redblue",
%              % "bluered", "shutter", "topbottom", "bottomtop", "interleavedline", "interleavedcolumn", "propixxmono", "propixxstereo"
%              options.exp_mode='mono';
%
%              options.scrID=1; % screen ID, generally 0 for a single display setup, 1 for dual display setup
%
%              % how to start the experiment
%              % 0: press ENTER or SPACE, 1: click left-mouse button, 2: wait the first MR trigger (CiNet),
%              % 3: waiting for a MR trigger pulse (BUIC) -- checking onset of pin #11 of the parallel port
%              % 4: custom key trigger (wait for a key input that you specify as options.custom_trigger).
%              options.start_method=0;
%
%              % when you want to use your own trigger key to start the stimulus presentation, set a character here.
%              % but note that the setting here is only valid when you set options.start_method=4;
%              options.custom_trigger='s';
%
%              % response key codes. [1xN] matrix in which all the keycodes to be used are stored.
%              options.keys=[37,39]; % 37=left arrow, 39=right arrow
%
%              % screen length along y and x axes which you want to use [row,col] (pixels)
%              options.window_size=[768,1024];
%
%              % if you need to change RGB video input intensities (e.g. for red-green glasses display mode),
%              % please set these values [2(left/right) x 3(RGB)]. Valid only when ~strcmpi(options.exp_mode,'mono')
%              options.RGBgain=[1.0,1.0,1.0; 1.0,1.0,1.0];
%
%              % fixation parameter, {fixation type(0: non, 1: circle, 2: cross, 3: concentrate),size,color}
%              options.fixation={2,24,[255,255,255]};
%
%              % background parameters,
%              % {type(uniform(0) or with patches(1)),background_RGB,patch1_RGB,patch2_RGB,patch_num(row,col),patch_size(row,col),(optional)aperture_size(row,col)}
%              options.background={1,[127,127,127],[255,255,255],[0,0,0],[30,30],[20,20]};
%
%              % whether masking display images using a circular aperture mask, {on_off(0|1),radius_pix(row,col),gaussian_parameters(mean,sd)}
%              % if you want to put a circular aperture mask on each of the images, please set on_off to 1.
%              % if gaussian_parameters(1)=0, no smoothing on the edges is applied.
%              options.cmask={1,[280,280],[20,20]};
%
%              % whether setting background color automatically by matching it with the upper-left (1,1) pixel color of the first target image
%              options.auto_background=1;
%
%              % whether forcing to use the full-screen display, [0|1]
%              options.use_fullscr=0;
%
%              % whether skipping frame sync (flip) test
%              option.skip_frame_sync_test=0;
%
%              % whether forcing to use specific frame rate, if 0, the frame rate wil bw computed in the ImagesShowPTB function.
%              % if non zero, the value is used as the screen frame rate.
%              option.force_frame_rate=60;
%
%              % whether forcing to use frames (vertical sync signals) as a unit of display duration instead of msec.
%              % 0: none, 1: force to use the number of frames for presentation duration setting
%              options.use_frame=0;
%
%              % whether presenting images with original resolution
%              % 0: display images with sizes set in image_database file. 1: diplay image with their original sizes
%              options.use_original_imgsize=0;
%
%              % whether reading images one by one in creating PTB textures
%              % 1: load images to the memory one by one when creating the target texture.
%              % 2: load all the images at once before the actual presentation, but make texture when requested.
%              % 3: load all the images at once and make all the textures before the actual presentation
%              % By setting this to 1, you can save memory, but it requires additional computation time in presentation (~30ms with Core2Duo CPU) on Windows.
%              % When you set this to 2 or 3, you can save computational time, but requires more memory on your computer.
%              % I recommend to test options.img_loading_mode=2 first.
%              options.img_loading_mode=2;
%
%              % image offset, [row,col]. when set [0,0], images will be presented at the center of the screen
%              options.center=[0,0];
%
%              % whether flipping images, 0: none, 1: x-axis (horizontally), 2: y-axis (vertically), 3: x&y-axis,
%              % 4: x-axis only for the left view (the first) display,
%              % 5: x-axis only for the right view (the second) display. (4 and 5 are for some half-mirror stereo displays such as 3D PluraView)
%              options.img_flip=0;
%
%              % whether adding task during the experiment. [1x3] matrix. [type,frequency,duration]
%              % about type. 0: no task, 1: fixation dim, 2: vernier task, 3: character detection task, when 'C' is presented, press a key
%              % 4: 1-back identification task for odd sequence, 5: 1-back identification task for even sequence
%              % about frequency (integer): how often the tasks occur during the experiment, 1 is the most frequent (every time, not recommend). 3-5 would be practically fine.
%              % about duration: task duration in msec or frame
%              % !!!NOTEICE!!! Even you do not need to interpose task (options.task(1)=0), please set the other 2 variables.
%              % when you use task in your experiment, please fix the unit of the durations in protocolfile as 'msec' or 'frame'. please do not mix.
%              options.task=[0,3,250];
%              %options.task=[1,3,250];
%              %options.task=[2,4,250];
%
%              % whether randomize the order of the 'blocks' in protocol file.
%              % 0:OFF, 1:ALL, 2:Even seq. only, 3:Odd seq. only, 4:first half seq. only, 5:last half seq. only
%              % 6:2-N-1 blocks are randomized whereas the first and the last blocks are fixed.
%              % matrix:randomize specific blocks you set. e.g. options.block_rand=[2,4,6,8];
%              options.block_rand=0;
%
%              % whether displaying stimulus onset marker for images with trigger=ON. (you can set in your image database file).
%              % the marker can be used to get a photodiode trigger etc.
%              % {position,onset_marker_size,trigger_ON_RGB,trigger_OFF_RGB}
%              % position, 0: none, 1: upper-left, 2: upper-right, 3: lower-left, 4: lower-right
%              %           5: middle-left, 6: middle-right, 7: upper-middle, 8: lower-middle
%              %           9: whole-left, 10: whole-right, 11: whole-top, 12: whole-bottom, and
%              %           13: binary settings (special option, multiple triggers specified in the image_database file)
%              % onset_marker_size : pixels of the marker
%              % trigger_ON_RGB : color of the trigger marker when it is ON, [R,G,B]. [255,255,255] by default.
%              % trigger_off_RGB: color of the trigger marker when it is OFF, [R,G,B]. [0,0,0] by default.
%              %
%
%              [Important Note on Stimulus Onset Trigger]
%              By properly setting the 'position' (here, in this option file) and related parameters (in the
%              image_database file), ImagesShow offers two different ways to record stimulus/condition types and
%              presentation protocols.
%              First, if you set 'position' to one of 1-12, while the stimulus onset marker (punch stimulus) is
%              only presented at a fixed location, you can record stimulus types in an eventlogger object
%              (or 'event' in the *.mat result file) by assigning different numbers to different images as
%              imgdb.img{1}{3}=1, imgdb.img{2}{3}=2, imgdb.img{3}{3}3,...etc.
%              Second, if you set 'position' to 13, you can use multiple onset markers, which can record the
%              stimulus type using binary encodings. For instance, if you set 'position' to 13 and set
%              imgdb.img{1}{3}=[1], imgdb.img{2}{3}=[1,2], and imgdb.img{3}{3}=[2,3], then an onset marker will
%              be presented on top-left for the image 1, two markers on top-left and top-right for the image 2,
%              and two markers on top-right and bottom-left for the image 3. Then, when you record the photo-trigger
%              responses on an EEG/MEG system, etc, you can judge which stimuli are presented in which order by
%              checking the recorded binary codes, e.g. '11000000'. For such multiple recordings, the combinations
%              of numbers 1-8 are recommended, since the bar-type triggers (position 9-12) are not suitable for
%              binary coding.
%              options.onset_punch={0,50,[255,255,255],[0,0,0]};
%
%              % how to display the progress of image presentations on the MATLAB terminal window.
%              % 0: displaying block and image sequences only
%              % 1: displaying event details including presentation time, responses, triggers etc.
%              options.event_display_mode=0;
%
% [output]
% options    : display options to be used in ImagesShow presentation protocol, a structure
%              with members listed below. Values in () are the default ones.
%              .start_method (0)
%              .custom_trigger ('s')
%              .exp_mode ('mono')
%              .keys ([37,39])
%              .window_size (768,1024)
%              .RGBgain ([1,1,1;1,1,1])
%              .fixation ({2,24,[255,255,255]})
%              .background ({[127,127,127],[255,255,255],[0,0,0],[30,30],[20,20]})
%              .cmask ({0,[280,280],[20,20]})
%              .auto_background (0)
%              .use_fullscr (0)
%              .use_frame (0)
%              .use_original_imgsize (0)
%              .img_loading_mode (2)
%              .center ([0,0])
%              .img_flip (0)
%              .task ([0,1,250])
%              .block_rand (0)
%              .onset_punch ({0,50,[255,255,255],[0,0,0]})
%              .event_display_mode (0)

%clear global; clear mex;
global subj acq session vparam dparam prt imgs;

% check input variable
if nargin<1 || isempty(optionfile), help(mfilename()); options=[]; return; end

% check option file
run_optionfile=optionfile;
if ~strcmpi(run_optionfile(end-1:end),'.m'), run_optionfile=strcat(run_optionfile,'.m'); end

if ~exist(fullfile(pwd,run_optionfile),'file')
  warning('can not find optionfile: %s. setting default parameters...',run_optionfile);
  options=setdefaultoptions();
  return
end
clear optionfile;

% load options and set the default values if required
options=struct(); % initialize
run(fullfile(pwd,run_optionfile));
options=ValidateStructureFields(options,... % validate fields and set the default values to missing field(s)
  'scrID',1,...
  'exp_mode','mono',...
  'start_method',0,...
  'custom_trigger','s',...
  'keys',[37,39],...
  'window_size',[768,1024],...
  'RGBgain',[1,1,1;1,1,1],...
  'fixation',{2,24,[255,255,255]},...
  'background',{0,[127,127,127],[255,255,255],[0,0,0],[30,30],[20,20]},...
  'skip_frame_sync_test',0,...
  'force_frame_rate',0,...
  'cmask',{0,[280,280],[20,20]},...
  'auto_background',0,...
  'use_fullscr',0,...
  'use_frame',0,...
  'use_original_imgsize',0,...
  'img_loading_mode',2,...
  'center',[0,0],...
  'img_flip',0,...
  'task',[0,1,250],...
  'block_rand',0,...
  'onset_punch',{0,50,[255,255,255],[0,0,0]},...
  'event_display_mode',0);

% detect missing parameter values and put them by default ones
if numel(options.window_size)==1, options.window_size=[options.window_size,options.window_size]; end
if size(options.RGBgain,1)==1, options.RGBgain=repmat(options.RGBgain,[2,1]); end
if length(options.fixation)==1, options.fixation{2}=24; end
if length(options.fixation)==2, options.fixation{3}=[255,255,255]; end
if length(options.background)==1, options.background{2}=[127,127,127]; end
if length(options.background)==2, options.background{3}=[255,255,255]; end
if length(options.background)==3, options.background{4}=[0,0,0]; end
if length(options.background)==4, options.background{5}=[30,30]; end
if length(options.background)==5, options.background{6}=[20,20]; end
if length(options.cmask)==1, options.cmask{2}=[280,280]; end
if length(options.cmask)==2, options.cmask{3}=[20,20]; end
if numel(options.center)==1, options.center=[options.center,options.center]; end
if numel(options.task)==1, options.task(2)=3; end
if numel(options.task)==2, options.task(3)=250; end
if length(options.onset_punch)==1, options.onset_punch{2}=50; end
if length(options.onset_punch)==2, options.onset_punch{3}=[255,255,255]; end
if length(options.onset_punch)==3, options.onset_punch{4}=[0,0,0]; end

return
