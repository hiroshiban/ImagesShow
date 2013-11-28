function ImagesShowPTB(subj,acq,protocolfile,imgdbfile,viewfile,optionfile,gamma_table,overwrite_flg)

% a fully-customizable image presentation script for your fMRI(event- and block-design)/TMS/EEG/behavior experiments.
% function ImagesShowPTB(subj,acq,protocolfile,imgdbfile,:viewfile,:optionfile,:gamma_table,:overwrite_flg)
% (: is optional)
%
% This MATLAB function is a fully updated version of ImagesShow that was originally written in C++
% with VTK (Visualization Toolkit, Kitware,Inc.) in 2009 by Hiroshi Ban, Kyoto University, Japan.
% (Note: the original ImagesShow (termed "PresentImage" at that time) was based on a script written
% in Tcl/Tk with VTK by Hiroki Yamamoto in 2002). The Psychtoolbox with MATLAB/Octave is required
% to use this function for your fMRI, TMS, or EEG experiments.
%
% This function presents sequences of monocular/binocular images with accurate timing controls for
% your block & event-related paradigm fMRI/TMS/EEG/behavior experiments. The way of image presentation,
% experiment protocols, display options, and more can be fully customizable; you can run any type of
% experiment by editing your protocolfile, imgdbfile, viewfile, optionfile for your purposes. You can
% also record participant's key responses, get trigger from the external devices and more.
% For details, please read ../doc/readme.txt
%
%
% Created    : "2013-11-08 16:43:35 ban"
% Last Update: "2013-11-28 15:46:44 ban (ban.hiroshi@gmail.com)"
%
%
% [input]
% subj         : name of subject, string, such as 's01', 'HB', 'hiroshi'
% acq          : acquisition number. 1,2,3,...
% protocolfile : protocol file in which experiment design is described.
%                the file should be located in ./subjects/(subj)/
%                You can define block- or event-related-design experiment using this file.
%                For details, please see ../Generation/readExpProtocols.m
% imgdbfile    : image data base file in which all the details of the images to be presented
%                in the experiment are described with some options.
%                the file should be located in ./subjects/(subj)/
%                For details, please see ../Generation/readImageDatabase.m
% viewfile     : (optional) viewing parameter file in which viewing distance etc are described.
%                currently the contents of this file are preserved for future modifications,
%                and have not used yet. However we should set this file to record experiment
%                parameters in a file at one location for the later analyses.
%                the file should be located in ./subjects/(subj)/
%                For details, please see ../Generation/readViewingParameters.m
% optionfile   : (optional) experiment/display option file with which you can customize display
%                procedures of your experiment (e.g. putting phototrigger image, set ).
%                the file should be located in ./subjects/(subj)/
%                For details, please see ../Generation/readDisplayOptions.m
% gamma_table  : (optional) table(s) of gamma-corrected video input values (Color LookupTable).
%                256(8-bits) x 3(RGB) x 1(or 2,3,... when using multiple displays) matrix
%                or a *.mat file specified with a relative path format. e.g. '/gamma_table/gamma1.mat'
%                The *.mat should include a variable named "gamma_table" consists of a 256x3xN matrix.
%                if you use multiple (more than 1) displays and set a 256x3x1 gamma-table, the same
%                table will be applied to all displays. if the number of displays and gamma tables
%                are different (e.g. you have 3 displays and 256x3x!2! gamma-tables), the last
%                gamma_table will be applied to the second and third displays.
%                if empty, normalized gamma table (repmat(linspace(0.0,1.0,256),3,1)) will be applied.
% overwrite_flg: (optional) whether overwriting pre-existing result file. if 1, the previous results
%                file with the same acquisition number will be overwritten by the previous one.
%                if 0, the existing file will be backed-up by adding a prefix '_old' at the tail
%                of the file. 0 by default.
%
% [output]
% No output variable.
% The resutls are saved in
% ~/ImagesShowPTB/Presentation/(subj)/results/(yymmdd(date))/(subj)_ImagesShowPTB_results_run_%02d.m
%
% [dependencies]
% 1. Psychtoolbox by Denis Pelli et al. version 3.x or above. Should be installed independently.
% 2. Subrountines located in ../Generation
% 2. Hiroshi Ban's MATLAB PTB Common functions. All of these are already included in ../Common
%
% [history]
% Cxx Class Version                          Dec. 24 2003 H.Ban (T_T)/~~
% Interaction with CONTEC digital IO         Dec. 24 2003 H.Ban
% Cxx Class Version with a fixation point    Dec. 25 2003 H.Ban (o^-')b
% time.h --> multimedia timer                Jan. 20 2004 H.Ban
% High Performance Animation                 Jan. 24 2004 H.Ban
% Dynamic Storage Allocation                 Jan. 24 2004 H.Ban
% timer initialize using Win32API            Jan. 25 2004 H.Ban
% PresentImages -> ImagesShow                Mar. 06 2005 H.Ban
% Images' Sequences Randomization            Mar. 06 2005 H.Ban
% Full Screen Mode                           Mar. 10 2005 H.Ban
% Interaction with Keyence KV Controller     Mar. 11 2005 H.Ban
% vtk3.2 -> vtk4.2 -> vtk4.2 static library  Mar. 12 2005 H.Ban
% Render Window Border Off                   Mar. 12 2005 H.Ban
% reading *.jpg, *.png, *.tiff format images Mar. 14 2005 H.Ban
% Start Mouse R button on Render Window Mode Mar. 14 2005 H.Ban
% reading *.pnm format images                Mar. 15 2005 H.Ban
% input file format changes                  Mar. 16 2005 H.Ban
% ViewPort (xmin, ymin, xmax, ymax) -> IMAGE-CENTER (x,y)
%                                            Mar. 16 2005 H.Ban
% Interact with Interface General Pulse Counter (GPC)
%                                            Mar. 16 2007 H.Ban
% Log file (PresentedLog*.txt)               Mar. 16 2005 H.Ban
% Log file (KVSwitchLog*.txt)                Mar. 16 2005 H.Ban
% Implicit Rendering                         July 05 2007 H.Ban
% rotate images along x&y axes               July 05 2007 H.Ban
% compiler VC++6.0 -> VC.NET2003             July 07 2007 H.Ban
% vtk4.2 -> vtk5.0.3 static library          July 07 2007 H.Ban
% hide cursor within the render window       July 07 2007 H.Ban
% R mouse button start -> L mouse button     July 07 2007 H.Ban
% ImagesShow.exe icon renewal                July 08 2007 H.Ban
% Image Resize (smaller/larger) by bilinear interpolation
%                                            July 09 2007 H.Ban
% condition files & stimuli for identifying FFA, PPA, & EBA
%                                            July 09 2007 H.Ban
% real-time presentation delay correction during the rest period(s)
%                                            July 14 2007 H.Ban
% NEW version: Interact with Interface General Pulse Counter
%                                            July 16 2007 H.Ban
% New version: Log file (GPCSwitchTriggerLog*.txt)
%                                            July 16 2007 H.Ban
% New version: ImageDatabase structure       July 17 2007 H.Ban
% diplaying "punch" rectangle to notice stimulus presentation onset
%                                            July 17 2007 H.Ban
% Presentation synchronizing with Display Vertical Sync Signal(s) using GPC
%                                            July 19 2007 H.Ban
% vtk5.0.3 -> vtk5.0.4                       June 05 2009 H.Ban
% compiler VC++.NET 2003 -> VC++.NET 2005    June 05 2009 H.Ban
% add Matlab_imageprocessing 22 scripts      June 05 2009 H.Ban
% vtk5.0.4 -> vtk5.4.2                       June 05 2009 H.Ban
% vtk5.4.2 compiled with boost C++ 1.38 library
%                                            July 26 2009 H.Ban
% RunTEST with CONTEC, KV, GPC I/O           July 26 2009 H.Ban
% Change Press RETURN(ENTER) Start Method
% start on the console ---> on the render window
%                                            July 26 2009 H.Ban
% send stimulus trigger to CONTEC digital I/O
%                                            July 26 2009 H.Ban
% The final version of ImagesShow C++ was released
%                                            July 27 2009 H.Ban
% The first version of ImageShow Psychtoolbox was released
% The internal procedures have been fully revised from the scratch
% Lots of new fancy functions such as binocular displays are available
%                                            Nov  15 2013 H.Ban
% Add character detection task               Nov  18 2013 H.Ban
% separate parameter settings for left/right-eye images
%                                            Nov  21 2013 H.Ban
% some bug fixes, save more memory in storing PTB textures
%                                            Nov  23 2013 H.Ban
% Bug fixes, the final version 1.0 was released
%                                            Nov  25 2013 H.Ban
% Made the source code clean and shorter by changing variable structures
%                                            Nov  28 2013 H.Ban


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% adding path to the subfunctions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% add paths to the subfunctions
rootDir=fileparts(mfilename('fullpath'));
addpath(genpath(fullfile(rootDir,'..','Common')));
addpath(fullfile(rootDir,'..','Generation'));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% for log file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% get date
today=strrep(datestr(now,'yy/mm/dd'),'/','');

% result directry & file
resultDir=fullfile(rootDir,'subjects',num2str(subj),'results',today);
if ~exist(resultDir,'dir'), mkdir(resultDir); end
logfname=fullfile(resultDir,[num2str(subj),'_ImagesShowPTB_results_run_',num2str(acq,'%02d'),'.log']);
diary(logfname);
warning off; %#ok warning('off','MATLAB:dispatcher:InexactCaseMatch');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% check input variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear global; clear mex;

if nargin<4, help(mfilename()); return; end
if nargin<8 || isempty(overwrite_flg), overwrite_flg=0; end
if nargin>8, error(['takes at most 8 arguments: ',...
                    'ImagesShowPTB(subj,acq,protocolfile,imgdbfile,(:viewfile),(:optionfile),(:gamma_table)),(:overwrite_flg)']); end

% check the aqcuisition number. up to 10 design files can be used
if acq<1, error('Acquistion number must be integer and greater than zero'); end
if ~exist(fullfile(pwd,'subjects',subj),'dir'), error('can not find subj directory. check input variable.'); end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Start processing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% try & catch %%%%%
try


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% check the PTB version
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PTB_OK=CheckPTBversion(3); % check wether the PTB version is 3
if ~PTB_OK, error('Wrong version of Psychtoolbox is running. ImagesShowPTB requires PTB ver.3'); end

% debug level, black screen during calibration
Screen('Preference','VisualDebuglevel', 3);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Setup random seed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

InitializeRandomSeed();


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Reset/load display Gamma-function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin<7 || isempty(gamma_table)
  gamma_table=repmat(linspace(0.0,1.0,256),3,1); %#ok
  GammaResetPTB(1.0);
else
  GammaLoadPTB(gamma_table);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% read and set size and option parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load size parameters
fprintf('step 1: loading viewing size parameters...');
if nargin<5 || isempty(viewfile)
  vparam=readViewingParameters('default'); %#ok
else
  fviewfile=fullfile('subjects',subj,viewfile);
  vparam=readViewingParameters(fviewfile); %#ok
  clear fviewfile;
end
disp('done.');

% load display options
fprintf('step 2: loading display options...');
if nargin<6 || isempty(optionfile)
  dparam=readDisplayOptions('default');
else
  foptionfile=fullfile('subjects',subj,optionfile);
  dparam=readDisplayOptions(foptionfile);
  clear foptionfile;
end
disp('done.');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Getting temporal display refresh rate and inter-flip-interval
%%%% (required just for protocol file setting in frame precision)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

winPtr=0; % temporal setting, will be changed later in InitializePTBDisplays
dparam.fps=Screen('FrameRate',winPtr); dparam.ifi=1/dparam.fps;
if dparam.fps==0, dparam.fps=1/dparam.ifi; end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% read and set protocol and image-database parameters (presentation protocol, images)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load experiment protocols
fprintf('step 3: loading protocols...');
fprotocolfile=fullfile('subjects',subj,protocolfile);
prt=readExpProtocols(fprotocolfile,dparam.block_rand,dparam.fps,dparam.ifi);
clear fprotocolfile;
disp('done.');

% load image database
fprintf('step 4: loading image database...');
fimgdbfile=fullfile('subjects',subj,imgdbfile);
imgs=readImageDatabase(fimgdbfile,dparam.img_loading_mode);
clear fimgdbfile;
disp('done.');
disp(' ');

% set RGB gain
if isstructmember(imgs,'RGBgain')
  RGBgain=imgs.RGBgain;
else
  RGBgain=[];
end

% change duration from msec to frame
if dparam.use_frame
  for ii=1:1:length(prt)
    prt{ii}.mode='frame';
    if ~isstructmember(prt{ii},'frame')
      prt{ii}.duration=ceil(prt{ii}.duration./1000.*dparam.fps);
      prt{ii}.cumduration=ceil(prt{ii}.cumduration./1000.*dparam.fps);
    end
  end
end

% set image display offset
centeroffset=[fliplr(dparam.center),fliplr(dparam.center)];

% set background color automatically by matching it with the upper-left (1,1) pixel of the first image
if dparam.auto_background
  if dparam.img_loading_mode==1 % read image one-by-one
    tmp=imread(imgs.img{1});
  else
    tmp=imgs.img{1};
  end
  bgcolor=double(tmp(1,1,:));
  if numel(bgcolor)==1, bgcolor=repmat(bgcolor,[1,3]); end
  dparam.background{1}=bgcolor;
  clear tmp bgcolor;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% displaying the presentation parameters you set
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('The Presentation Parameters are as below.');
fprintf('\n');
disp('************************************************');
disp('****** Script, Subject, Acquistion Number ******');
eval(sprintf('disp(''Date & Time            : %s'');',strcat([strrep(datestr(now,'yy/mm/dd'),'/',''),' ',datestr(now,'HH:mm:ss')])));
eval(sprintf('disp(''Running Script Name    : %s'');',mfilename()));
eval(sprintf('disp(''Subject Name           : %s'');',subj));
eval(sprintf('disp(''Acquisition Number     : %d'');',acq));
disp('********* Run Type, Display Image Type *********');
eval(sprintf('disp(''Stimulus Display Mode  : %s'');',dparam.exp_mode));
eval(sprintf('disp(''Full Screen Mode       : %d'');',dparam.use_fullscr));
disp('*********** Screen/Display Settings ************');
eval(sprintf('disp(''Screen Height          : %d'');',dparam.window_size(1)));
eval(sprintf('disp(''Screen Width           : %d'');',dparam.window_size(2)));
eval(sprintf('disp(''Window Center [row,col]: [%d,%d]'');',dparam.center(1),dparam.center(2)));
eval(sprintf('disp(''Image Flipping         : %d'');',dparam.img_flip));
eval(sprintf('disp(''Onset Punch [type,size]: [%d,%d]'');',dparam.onset_punch(1),dparam.onset_punch(2)));
eval(sprintf('disp(''Fixation Type          : %d'');',dparam.fixation{1}));
eval(sprintf('disp(''Background Color       : [%d,%d,%d]'');',dparam.background{1}(1),dparam.background{1}(2),dparam.background{1}(3)));
disp('************ The number of blocks **************');
eval(sprintf('disp(''#conditions            : %d'');',length(prt)));
if numel(dparam.block_rand)==1
  eval(sprintf('disp(''Block Randomization    : %d'');',dparam.block_rand));
else
  tmpstr=['disp(''Block Randomization    : ',repmat('%d ',[1,numel(dparam.block_rand)]),''');'];
  eval(sprintf(tmpstr,dparam.block_rand));
  clear tmpstr;
end
disp('******************* Task ***********************');
eval(sprintf('disp(''Task Type              : %d'');',dparam.task(1)));
eval(sprintf('disp(''Task Frequency         : %d'');',dparam.task(2)));
eval(sprintf('disp(''Task Duration          : %d'');',dparam.task(3)));
disp('************** Experiment Time *****************');
if strcmpi(prt{end}.mode,'frame')
  eval(sprintf('disp(''Estimated Exp Time     : %.2f frames'');',prt{end}.cumduration(end)));
else
  eval(sprintf('disp(''Estimated Exp Time     : %.2f secs'');',prt{end}.cumduration(end)/1000));
end
disp('************** The Other Settings **************');
eval(sprintf('disp(''Start Method           : %d'');',dparam.start_method));
eval(sprintf('disp(''Force to use frame     : %d'');',dparam.use_frame));
disp('************ Response key settings *************');
for ii=1:1:numel(dparam.keys)
  eval(sprintf('disp(''Reponse Key #%d        : %d=%s'');',ii,dparam.keys(ii),KbName(dparam.keys(ii))));
end
disp('************************************************');
fprintf('\n');
disp('Please check all the parameters above carefully before proceeding.');
fprintf('\n');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% initialize response & event logger objects
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initialize MATLAB objects for event and response logs
event=eventlogger();
resps=responselogger(dparam.keys);
resps.initialize(event); % initialize responselogger


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Wait for user reponse to start
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[user_answer,resps]=resps.wait_to_proceed();
if ~user_answer, clear all; close all; return; end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Initialization of Left & Right screens for binocular presenting/viewing mode
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[winPtr,winRect,nScr,dparam.fps,dparam.ifi,initDisplay_OK]=InitializePTBDisplays(dparam.exp_mode,dparam.background{1},dparam.img_flip,RGBgain);
if ~initDisplay_OK, error('Display initialization error. Please check your exp_run parameter.'); end
HideCursor();


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Setting the PTB runnning priority to MAX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set the priority of this script to MAX
priorityLevel=MaxPriority(winPtr,'WaitBlanking');
Priority(priorityLevel);

% conserve VRAM memory: Workaround for flawed hardware and drivers.
% 32 == kPsychDontShareContextRessources: Do not share ressources between different onscreen windows.
% Usually you want PTB to share all ressources like offscreen windows, textures and GLSL shaders among all open
% onscreen windows. If that causes trouble for some weird reason, you can prevent automatic sharing with this flag.
%Screen('Preference','ConserveVRAM',32);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Setting the PTB OpenGL functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Enable OpenGL mode of Psychtoolbox: This is crucially needed for clut animation
InitializeMatlabOpenGL();

% This script calls Psychtoolbox commands available only in OpenGL-based versions of the Psychtoolbox.
% (So far, the OS X Psychtoolbox is the only OpenGL-base Psychtoolbox.) The Psychtoolbox command AssertPsychOpenGL
% will issue an error message if someone tries to execute this script on a computer without an OpenGL Psychtoolbox
AssertOpenGL();

% set OpenGL blend functions
Screen('BlendFunction',winPtr,GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Displaying 'Initializing...'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% displaying texts on the center of the screen
DisplayMessage2('Initializing...',dparam.background{1},winPtr,nScr,'Arial',36);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Expanding protocols following prt{n}.slicing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% get subdurations
for ii=1:1:length(prt)
  prt{ii}.subduration=cell(numel(prt{ii}.duration),1);
  for jj=1:1:numel(prt{ii}.duration)
    prt{ii}.subduration{jj}=repmat(prt{ii}.slicing,[1,numel(prt{ii}.slicing:prt{ii}.slicing:prt{ii}.duration(jj))]);
    if sum(prt{ii}.subduration{jj})<prt{ii}.duration(jj)
      % some manipulations to avoid missing frames in a very short flipping interval
      if prt{ii}.duration(jj)-sum(prt{ii}.subduration{jj})<prt{ii}.slicing/2 % the rest duration is less than the half of prt{ii}.slicing
        prt{ii}.subduration{jj}(end)=prt{ii}.subduration{jj}(end)+(prt{ii}.duration(jj)-sum(prt{ii}.subduration{jj})); % add the rest of durations to the last element
      else
        prt{ii}.subduration{jj}(end+1)=prt{ii}.duration(jj)-sum(prt{ii}.subduration{jj});  % add the rest of durations to the last+1 element
      end
    end
  end
end

% get cummurative subdurations
for ii=1:1:length(prt)
  prt{ii}.subcumduration=cell(length(prt{ii}.subduration),1);
  for jj=1:1:length(prt{ii}.subduration)
    prt{ii}.subcumduration{jj}=cumsum(prt{ii}.subduration{jj});
    if jj>=2, prt{ii}.subcumduration{jj}=prt{ii}.subcumduration{jj}+prt{ii}.subcumduration{jj-1}(end); end
  end
  if ii>=2
    for jj=1:1:length(prt{ii}.subduration)
      if strcmp(prt{ii-1}.mode,'msec') && strcmp(prt{ii}.mode,'msec')
        prt{ii}.subcumduration{jj}=prt{ii}.subcumduration{jj}+prt{ii-1}.subcumduration{end}(end);
      elseif strcmp(prt{ii-1}.mode,'msec') && strcmp(prt{ii}.mode,'frame')
        prt{ii}.subcumduration{jj}=prt{ii}.subcumduration{jj}+ceil(prt{ii-1}.subcumduration{end}(end)/1000*dparam.fps);
      elseif strcmp(prt{ii-1}.mode,'frame') && strcmp(prt{ii}.mode,'msec')
        prt{ii}.subcumduration{jj}=prt{ii}.subcumduration{jj}+prt{ii-1}.subcumduration{end}(end)*dparam.ifi;
      elseif strcmp(prt{ii-1}.mode,'frame') && strcmp(prt{ii}.mode,'frame')
        prt{ii}.subcumduration{jj}=prt{ii}.subcumduration{jj}+prt{ii-1}.subcumduration{end}(end);
      end
    end
  end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Set RECT (rectangle) regions for stimulus displays.
%%%% also, adjusting size to match the current display resolutions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if dparam.use_fullscr
  ratio_wid=( winRect(3)-winRect(1) )/dparam.window_size(2); ratio_hei=( winRect(4)-winRect(2) )/dparam.window_size(1);
else
  ratio_wid=1; ratio_hei=1;
end

if dparam.use_original_imgsize && dparam.img_loading_mode~=1
  imgSize=imgs.img_size.*repmat([ratio_wid,ratio_hei],[size(imgs.img_size,1),1]);
else
  imgSize=repmat(fliplr(imgs.presentation_size),[size(imgs.img_size,1),1]);
end
fixSize=[2*dparam.fixation{2}*ratio_wid 2*dparam.fixation{2}*ratio_hei];
bgSize=[dparam.window_size(2)*ratio_wid dparam.window_size(1)*ratio_hei];

% adjust display size for split display settings
if strcmpi(dparam.exp_mode,'cross') || strcmpi(dparam.exp_mode,'parallel') || ...
  strcmpi(dparam.exp_mode,'topbottom') || strcmpi(dparam.exp_mode,'bottomtop')
  imgSize=imgSize./2;
  bgSize=bgSize./2;
  fixSize=fixSize./2;
  %if dparam.task(1)==2, task.vernierrect=task.vernierrect./2; end
  imgReduceRatio=0.5;
else
  imgReduceRatio=1.0;
end

imgRect=zeros(size(imgSize,1),4);
imgRect(:,3:4)=imgSize;
bgRect=[0 0 bgSize]; % used to display background images
fixRect=[0 0 fixSize]; % used to display the central fixation point


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Creating background images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

patch_size=dparam.background{4};
patch_num=dparam.background{5};
%aperture_size=[500,500];

% calculate the central aperture size of the background image
edgeY=mod(dparam.window_size(1),patch_num(1)); % delete exceeded region
p_height=round((dparam.window_size(1)-edgeY)/patch_num(1)); % height in pix of patch_height + interval-Y

edgeX=mod(dparam.window_size(2),patch_num(2)); % delete exceeded region
p_width=round((dparam.window_size(2)-edgeX)/patch_num(2)); % width in pix of patch_width + interval-X

if length(dparam.background)==6
  aperture_size=dparam.background{6};
else
  if ~dparam.use_original_imgsize || dparam.img_loading_mode~=1
    aperture_size(1)=2*( p_height*ceil(imgs.presentation_size(1)/2/p_height) );
    aperture_size(2)=2*( p_width*ceil(imgs.presentation_size(2)/2/p_width) );
  else
    if dparam.use_original_imgsize
      tmph=imgRect(:,4); tmph=max(tmph(:));
      tmpw=imgRect(:,3); tmpw=max(tmpw(:));
    else
      tmph=512; tmpw=512; % arbitral values, just temporally
    end
    aperture_size(1)=2*( p_height*ceil(tmph/2/p_height) );
    aperture_size(2)=2*( p_width*ceil(tmpw/2/p_width) );
  end
end

bgimg=CreateBackgroundImage([dparam.window_size(1),dparam.window_size(2)],aperture_size,patch_size,...
                            dparam.background{1},dparam.background{2},dparam.background{3},dparam.fixation{3},patch_num,0,0,0);
background(1)=Screen('MakeTexture',winPtr,bgimg{1});
background(2)=background(1); %Screen('MakeTexture',winPtr,bgimg{2});


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Creating the central fixation, circular or cross images (left/right)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fixlinew=2; % line width of the central fixation
fixlineh=12; % line height of the central fixation

if dparam.fixation{1}==1 % circular fixational dot

  fix=MakeFineOval(dparam.fixation{2},dparam.fixation{3},dparam.background{1},1,8,0,0,0);
  wait_fix=MakeFineOval(dparam.fixation{2},[0,0,0],dparam.background{1},1,8,0,0,0);

  wait_fcross(1)=Screen('MakeTexture',winPtr,wait_fix);
  wait_fcross(2)=Screen('MakeTexture',winPtr,wait_fix);
  fcross(1)=Screen('MakeTexture',winPtr,fix);
  fcross(2)=Screen('MakeTexture',winPtr,fix);
  clear wait_fix fix;

elseif dparam.fixation{1}==2 % fixation cross

  if strcmpi(dparam.exp_mode,'mono')
    fix_L=CreateFixationImgMono(dparam.fixation{2},dparam.fixation{3},dparam.background{1},fixlinew,fixlineh,0,0);
    wait_fix_L=CreateFixationImgMono(dparam.fixation{2},[64,64,64],dparam.background{1},fixlinew,fixlineh,0,0);
    fix_R=fix_L; wait_fix_R=wait_fix_L;
  else % if strcmpi(dparam.exp_mode,'mono') % binocular stimuli
    [fix_L,fix_R]=CreateFixationImg(dparam.fixation{2},dparam.fixation{3},dparam.background{1},fixlinew,fixlineh,0,0);
    [wait_fix_L,wait_fix_R]=CreateFixationImg(dparam.fixation{2},[0,0,0],dparam.background{1},fixlinew,fixlineh,0,0);
  end

  wait_fcross(1)=Screen('MakeTexture',winPtr,wait_fix_L);
  wait_fcross(2)=Screen('MakeTexture',winPtr,wait_fix_R);
  fcross(1)=Screen('MakeTexture',winPtr,fix_L);
  fcross(2)=Screen('MakeTexture',winPtr,fix_R);
  clear wait_fix_L wait_fix_R fix_L fix_R;

end % if dparam.fixation{1}==1 % circular dot


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Creating task event arrays and task images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% generate task event arrays
if ~isempty(intersect(dparam.task(1),1:3))

  % get all the potential task periods into an arary
  task.arrays=[];
  for ii=1:1:length(prt)
    for jj=1:1:size(prt{ii}.sequence,2), task.arrays=[task.arrays,zeros(1,numel(prt{ii}.subduration{jj}))]; end
  end

  % select task periods randomlly
  taskidx=shuffle(1:numel(task.arrays));
  taskidx=taskidx(1:dparam.task(2):end); % so that tasks are put into 1/dparam.task(2) of the presentation trials (subdurations)
  task.arrays(taskidx)=1;
  task.arrays(1)=0; % omit the task from the first trial

  % update task.array structure so that each task period lasts for task.duration
  tmpcounter=0; done_flg=zeros(1,numel(task.arrays));
  for ii=1:1:length(prt)
    for jj=1:1:size(prt{ii}.sequence,2)
      for mm=1:1:numel(prt{ii}.subduration{jj})
        tmpcounter=tmpcounter+1;
        if ~done_flg(tmpcounter) && task.arrays(tmpcounter)
          % set task for task.duration
          durcounter=0;
          tmpduration=0;
          while tmpduration<dparam.task(3) && durcounter<numel(task.arrays)
            durcounter=durcounter+1;
            task.arrays(tmpcounter+durcounter)=1;
            tmpduration=tmpduration+prt{ii}.subduration{jj}(mm);
            done_flg(tmpcounter+durcounter)=1;
          end
          % unset task (rest) for the next task.duration period
          durcounter=durcounter-1; % -1 is required to put back the current task array to 0 as tmpduration already exceeds the preset task duration
          tmpduration=0;
          while tmpduration<dparam.task(3) && durcounter<numel(task.arrays)
            durcounter=durcounter+1;
            task.arrays(tmpcounter+durcounter)=0;
            tmpduration=tmpduration+prt{ii}.subduration{jj}(mm);
            done_flg(tmpcounter+durcounter)=1;
          end
        else
          done_flg(tmpcounter)=1;
        end
      end
    end
  end
  clear tmpcounter durcounter tmpduration done_flg;

  % set ratio of luminance dim
  if dparam.task(1)==1, task.fixdimratio=0.6; end

  % set vernier positions
  if dparam.task(1)==2
    task.vernierpos=randsample(-3:3,numel(task.arrays),true);
    task.vernierrect=[0,0,2,8]; % PTB rect for DrawTexture
  end

  % set character types
  if dparam.task(1)==3
    task.chars={'C','O','X','Y'}; % the first character ('C' in this case) is the target
    task.texttype=randsample(1:length(task.chars),numel(task.arrays),true);
  end

elseif ~isempty(intersect(dparam.task(1),4:5))

  % set 1-back task
  task.arrays=[];
  for ii=1:1:length(prt)
    if dparam.task(1)==4, taskidx=shuffle(3:2:size(prt{ii}.sequence,2)); end % odd order, but omit the first period
    if dparam.task(1)==5, taskidx=shuffle(4:2:size(prt{ii}.sequence,2)); end % even order, but omit the first period
    taskidx=sort(taskidx(1:dparam.task(2):end)); % so that tasks are put into 1/dparam.task(2) of the presentation trials (subdurations)
    taskidx(find(diff(taskidx)==2)+1)=[]; % omit showing tasks in seccessive (adjacent) periods
    tasks=zeros(1,size(prt{ii}.sequence,2));
    tasks(taskidx)=1;
    for jj=1:1:size(prt{ii}.sequence,2)
      tmp=zeros(1,numel(prt{ii}.subduration{jj}));
      if tasks(jj)
        tmp(end)=1;
        % set 1-back stimulus. here, taskidx starts from 3(or 4). so we do not need to think overflow of jj here.
        prt{ii}.sequence(:,jj)=prt{ii}.sequence(:,jj-2);
      end
      task.arrays=[task.arrays,tmp];
    end
  end

end % if dparam.task(1)

% generate task images
if dparam.task(1)==1 % luminance detection task

  % generate additional fixation for luminance detection tasks
  if dparam.fixation{1}==1 % circular fixational dot
    fix=MakeFineOval(dparam.fixation{2},task.fixdimratio.*dparam.fixation{3},dparam.background{1},1,8,0,0,0);
    tasktex(1)=Screen('MakeTexture',winPtr,fix);
    tasktex(2)=Screen('MakeTexture',winPtr,fix);
    clear fix;
  elseif dparam.fixation{1}==2 % fixation cross
    if strcmpi(dparam.exp_mode,'mono')
      fix_L=CreateFixationImgMono(dparam.fixation{2},task.fixdimratio.*dparam.fixation{3},dparam.background{1},fixlinew,fixlineh,0,0);
      fix_R=fix_L;
    else % if strcmpi(dparam.exp_mode,'mono') % binocular stimuli
      [fix_L,fix_R]=CreateFixationImg(dparam.fixation{2},task.fixdimratio.*dparam.fixation{3},dparam.background{1},fixlinew,fixlineh,0,0);
    end
    tasktex(1)=Screen('MakeTexture',winPtr,fix_L);
    tasktex(2)=Screen('MakeTexture',winPtr,fix_R);
    clear fix_L fix_R;
  end % if dparam.fixation{1}==1 % circular dot

elseif dparam.task(1)==2 % vernier task

  % generate vertical bar for vernier task
  vernier_bar_L=repmat(reshape(dparam.background{1},[1,1,3]),[task.vernierrect(3:4),1]);
  vernier_bar_R=repmat(reshape(dparam.fixation{3},[1,1,3]),[task.vernierrect(3:4),1]);
  tasktex(1)=Screen('MakeTexture',winPtr,vernier_bar_L);
  tasktex(2)=Screen('MakeTexture',winPtr,vernier_bar_R);
  clear vernier_bar_L vernier_bar_R;

elseif dparam.task(1)==3 % text 'C' detection task

  % generate character textures, each character position is defined by DrawFormattedText function
  Screen('Preference','TextAlphaBlending',1); Screen('Preference','TextRenderer',1);
  textPtr=zeros(1,length(task.chars));
  for ii=1:1:length(task.chars)
    [textPtr(ii),task.textrect]=Screen('OpenOffscreenWindow',winPtr,[dparam.background{1},0],[0,0,4*dparam.fixation{2},4*dparam.fixation{2}]);
    Screen(textPtr(ii),'BlendFunction',GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
    Screen('TextFont',textPtr(ii),'Arial'); Screen('TextSize',textPtr(ii),dparam.fixation{2}*2); Screen('TextStyle',textPtr(ii),1);
    DrawFormattedText(textPtr(ii),task.chars{ii},'center','center',dparam.fixation{3});
  end

  if strcmpi(dparam.exp_mode,'cross') || strcmpi(dparam.exp_mode,'parallel') || ...
     strcmpi(dparam.exp_mode,'topbottom') || strcmpi(dparam.exp_mode,'bottomtop')
    task.textrect=task.textrect./2;
  end

elseif dparam.task(1)==4 || dparam.task(1)==5 % 1-back task

  % for 1-back task, do nothing

  %% there is no fixation/vernier task in 1-back task sequence. Thus, just create the standard fixation as dummy PTB textures.
  %if dparam.fixation{1}==1 % circular fixational dot
  %  fix=MakeFineOval(dparam.fixation{2},dparam.fixation{3},dparam.background{1},1,8,0,0,0);
  %  tasktex(1)=Screen('MakeTexture',winPtr,fix);
  %  tasktex(2)=Screen('MakeTexture',winPtr,fix);
  %elseif dparam.fixation{1}==2 % fixation cross
  %  if strcmpi(dparam.exp_mode,'mono')
  %    fix_L=CreateFixationImgMono(dparam.fixation{2},dparam.fixation{3},dparam.background{1},fixlinew,fixlineh,0,0);
  %    fix_R=fix_L;
  %  else % if strcmpi(dparam.exp_mode,'mono') % binocular stimuli
  %    [fix_L,fix_R]=CreateFixationImg(dparam.fixation{2},dparam.fixation{3},dparam.background{1},fixlinew,fixlineh,0,0);
  %  end
  %  tasktex(1)=Screen('MakeTexture',winPtr,fix_L);
  %  tasktex(2)=Screen('MakeTexture',winPtr,fix_R);
  %  clear fix_L fix_R;
  %end % if dparam.fixation{1}==1 % circular dot

end % if dparam.task(1)==1


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Prepare a rectangle for onset punch stimulus
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if dparam.onset_punch(1)
  psize=dparam.onset_punch(2); offset=bgSize./2;
  if dparam.onset_punch(1)==1 % upper-left
    punchoffset=[psize/2,psize/2,psize/2,psize/2]-[offset,offset];
  elseif dparam.onset_punch(1)==2 % upper-right
    punchoffset=[-psize/2,psize/2,-psize/2,psize/2]+[offset(1),-offset(2),offset(1),-offset(2)];
  elseif dparam.onset_punch(1)==3 %lower-left
    punchoffset=[psize/2,-psize/2,psize/2,-psize/2]+[-offset(1),offset(2),-offset(1),offset(2)];
  elseif dparam.onset_punch(1)==4 % lower-right
    punchoffset=-[psize/2,psize/2,psize/2,psize/2]+[offset,offset];
  end
  clear offset;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Saving the current parameters temporally
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% saving the current parameters
% (this is required to analyze part of the data obtained even when the experiment is interrupted unexpectedly)
fprintf('saving the stimulus generation and presentation parameters...');
savefname=fullfile(resultDir,[num2str(subj),'_ImagesShowPTB_results_run_',num2str(acq,'%02d'),'.mat']);

% backup the old file(s)
if overwrite_flg
  BackUpObsoleteFiles(fullfile('subjects',num2str(subj),'results',today),...
                      [num2str(subj),'_ImagesShowPTB_results_run_',num2str(acq,'%02d'),'.mat'],'_old');
end

% save the current parameters
eval(sprintf('save %s subj acq prt vparam dparam task gamma_table;',savefname));
disp('done.');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Preparing the first (or all) texture image(s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if dparam.img_loading_mode==1 % read image one-by-one
  cimg=imread(imgs.img{prt{1}.sequence(1,1)});
  if dparam.use_original_imgsize, sz=size(cimg); imgRect(prt{1}.sequence(1,1),3:4)=fliplr(sz(1:2)).*imgReduceRatio; end % need to update imgRect
  timg(1)=Screen('MakeTexture',winPtr,cimg);
  if size(prt{1}.sequence,1)==2 && prt{1}.sequence(2,1)~=prt{1}.sequence(1,1)
    cimg=imread(imgs.img{prt{1}.sequence(2,1)});
    if dparam.use_original_imgsize, sz=size(cimg); imgRect(prt{1}.sequence(2,1),3:4)=fliplr(sz(1:2)).*imgReduceRatio; end
    timg(2)=Screen('MakeTexture',winPtr,cimg);
  else
    timg(2)=timg(1);
  end
  clear cimg;
elseif dparam.img_loading_mode==2 % images are already loaded as MATLAB matrix, imgs.img
  timg(1)=Screen('MakeTexture',winPtr,imgs.img{prt{1}.sequence(1,1)});
  if size(prt{1}.sequence,1)==2 && prt{1}.sequence(2,1)~=prt{1}.sequence(1,1)
    timg(2)=Screen('MakeTexture',winPtr,imgs.img{prt{1}.sequence(2,1)});
  else
    timg(2)=timg(1);
  end
elseif dparam.img_loading_mode==3 % generate all the textures at once
  timg=zeros(length(imgs.img),1);
  for ii=1:1:length(imgs.img), timg(ii)=Screen('MakeTexture',winPtr,imgs.img{ii}); imgs.img{ii}=[]; end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Displaying 'Ready to Start'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% displaying texts on the center of the screen
DisplayMessage2('Ready to Start',dparam.background{1},winPtr,nScr,'Arial',36);
ttime=GetSecs(); while (GetSecs()-ttime < 0.5), end  % run up the clock.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Flip the display(s) to the background image(s)
%%%% and inform the ready of stimulus presentation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% change the screen to the background with the fixation
for nn=1:1:nScr
  Screen('SelectStereoDrawBuffer',winPtr,nn-1);
  Screen('DrawTexture',winPtr,background(nn),[],CenterRect(bgRect,winRect)+centeroffset);
  if dparam.fixation{1}, Screen('DrawTexture',winPtr,wait_fcross(nn),[],CenterRect(fixRect,winRect)+centeroffset); end
  if dparam.onset_punch(1), Screen('FillRect',winPtr,[0,0,0],CenterRect([0,0,psize,psize],winRect)+punchoffset+centeroffset); end
end
Screen('DrawingFinished',winPtr); % Mark end of all graphics operation (until flip). This allows GPU to optimize its operations.
Screen('Flip',winPtr,[],[],[],1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Prepare the first display
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set the current sequence numbers
cseq=[prt{1}.sequence(1,1),prt{1}.sequence(min([size(prt{1}.sequence,1),2]),1)];
% drawing left/right-eye images
for nn=1:1:nScr
  Screen('SelectStereoDrawBuffer',winPtr,nn-1);
  Screen('DrawTexture',winPtr,background(nn),[],CenterRect(bgRect,winRect)+centeroffset);
  if dparam.img_loading_mode~=3
    Screen('DrawTexture',winPtr,timg(nn),[],CenterRect(imgRect(cseq(nn),:),winRect)+centeroffset);
  else
    Screen('DrawTexture',winPtr,timg(cseq(nn)),[],CenterRect(imgRect(cseq(nn),:),winRect)+centeroffset);
  end
  if dparam.fixation{1}, Screen('DrawTexture',winPtr,fcross(nn),[],CenterRect(fixRect,winRect)+centeroffset); end
  if dparam.onset_punch(1) % draw a punch rectangle for photo-trigger etc.
    if imgs.trigger{cseq(nn)}~=0, trigcolor=[255,0,0]; else trigcolor=[0,0,0]; end
    Screen('FillRect',winPtr,trigcolor,CenterRect([0,0,psize,psize],winRect)+punchoffset+centeroffset);
  end
end
Screen('DrawingFinished',winPtr);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% wait for the first trigger pulse from the MR scanner or for button pressing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initialize task counter
taskcounter=1;

% add time stamp (this also works to load add_event method in memory in advance of the actual displays)
event=event.add_event('Experiment Start',strcat([strrep(datestr(now,'yy/mm/dd'),'/',''),' ',datestr(now,'HH:mm:ss')]),[]);

% waiting for stimulus presentation
resps.wait_stimulus_presentation(dparam.start_method,dparam.custom_trigger);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% The Trial Loop, Stimulus Displays
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('\nExperiment Start.\n');
[event,the_experiment_start]=event.set_reference_time(GetSecs());
for ii=1:1:length(prt) % blocks

  %event=event.add_event('Start block',sprintf('Cond_%03d',ii));
  event=event.add_event(sprintf('Start block %03d',ii),prt{ii}.name);
  fprintf('Block #%03d(% 8s): ',ii,prt{ii}.name(1:min(8,length(prt{ii}.name))));

  if sum(strcmpi(prt{ii}.mode,{'frame','msec'})) % frame or msec precision

    for jj=1:1:size(prt{ii}.sequence,2) % trials

      % set the current sequence numbers
      cseq=[prt{ii}.sequence(1,jj),prt{ii}.sequence(min([size(prt{ii}.sequence,1),2]),jj)];

      for mm=1:1:numel(prt{ii}.subduration{jj}) % sub-durations

        % present the current displays
        if strcmpi(prt{ii}.mode,'frame')
          if ii==1 && jj==1 && mm==1, Screen('Flip',winPtr,[],[],[],1); end % flip here is required only for the first time for "frame" mode.
        else
          Screen('Flip',winPtr,[],[],[],1);
        end

        % record the stimulus onset and send the stimulus trigger
        if mm==1
          if cseq(1)~=cseq(2)
            event=event.add_event('Stim on',sprintf('%d/%d',cseq(1),cseq(2)));
            if imgs.trigger{cseq(1)}~=0, event=event.add_event('Stim Trigger L',imgs.trigger{cseq(1)}); end
            if imgs.trigger{cseq(2)}~=0, event=event.add_event('Stim Trigger R',imgs.trigger{cseq(2)}); end
            fprintf('%03d/%03d ',cseq(1),cseq(2));
          else
            event=event.add_event('Stim on',sprintf('%d',cseq(1)));
            if imgs.trigger{cseq(1)}~=0, event=event.add_event('Stim Trigger',imgs.trigger{cseq(1)}); end
            fprintf('%03d ',cseq(1));
          end
          if jj==size(prt{ii}.sequence,2), fprintf('\n'); end
        end

        % add task event
        if dparam.task(1)==1 && task.arrays(taskcounter) && ~task.arrays(max(taskcounter-1,1)) % luminance detection
          event=event.add_event('Lum Task',1);
        elseif dparam.task(1)==2 && task.arrays(taskcounter) && ~task.arrays(max(taskcounter-1,1)) % vernier left/right
          event=event.add_event('Vernier Task',task.vernierpos(taskcounter));
        elseif dparam.task(1)==3 && task.texttype(taskcounter)==1 && task.arrays(taskcounter) && ~task.arrays(max(taskcounter-1,1)) % vernier left/right
          event=event.add_event('Character Task',task.chars{1});
        elseif (dparam.task(1)==4 || dparam.task(1)==5) && task.arrays(taskcounter) % 1-back
          event=event.add_event('OneBack Task',1);
        end

        [resps,event]=resps.check_responses(event);

        % generate the next image after cleaning up the current texture (to save memory)
        if mm==numel(prt{ii}.subduration{jj})
          if dparam.img_loading_mode~=3, Screen('Close',timg(1)); Screen('Close',timg(2)); end
          nextblockidx=ii; nextstimidx=jj+1;
          if nextstimidx>size(prt{ii}.sequence,2), nextblockidx=ii+1; nextstimidx=1; end
          if nextblockidx<=length(prt)
            if dparam.img_loading_mode==1 % load image one-by-one
              cimg=imread(imgs.img{prt{nextblockidx}.sequence(1,nextstimidx)});
              if dparam.use_original_imgsize
                sz=size(cimg); imgRect(prt{nextblockidx}.sequence(1,nextstimidx),3:4)=fliplr(sz(1:2)).*imgReduceRatio;
              end
              timg(1)=Screen('MakeTexture',winPtr,cimg);
              if size(prt{nextblockidx}.sequence,1)==2 && prt{nextblockidx}.sequence(2,nextstimidx)~=prt{nextblockidx}.sequence(1,nextstimidx)
                cimg=imread(imgs.img{prt{nextblockidx}.sequence(2,nextstimidx)});
                if dparam.use_original_imgsize
                  sz=size(cimg); imgRect(prt{nextblockidx}.sequence(2,nextstimidx),3:4)=fliplr(sz(1:2)).*imgReduceRatio;
                end
                timg(2)=Screen('MakeTexture',winPtr,cimg);
              else
                timg(2)=timg(1);
              end
              clear cimg;
            elseif dparam.img_loading_mode==2 % make PTB texture one-by-one
              timg(1)=Screen('MakeTexture',winPtr,imgs.img{prt{nextblockidx}.sequence(1,nextstimidx)});
              if size(prt{nextblockidx}.sequence,1)==2 && prt{nextblockidx}.sequence(2,nextstimidx)~=prt{nextblockidx}.sequence(1,nextstimidx)
                timg(2)=Screen('MakeTexture',winPtr,imgs.img{prt{nextblockidx}.sequence(2,nextstimidx)});
              else
                timg(2)=timg(1);
              end
            end
          end % if nextblockidx<=length(prt)
        else
          nextblockidx=ii; nextstimidx=jj;
        end % if mm==numel(prt{ii}.subduration{jj})

        [resps,event]=resps.check_responses(event);

        % preparing the next displays
        if nextblockidx<=length(prt)
          taskcounter=taskcounter+1;

          % set the next sequence numbers
          nseq=[prt{nextblockidx}.sequence(1,nextstimidx),prt{nextblockidx}.sequence(min([size(prt{nextblockidx}.sequence,1),2]),nextstimidx)];

          % drawing the next left/right-eye images
          for nn=1:1:nScr
            Screen('SelectStereoDrawBuffer',winPtr,nn-1);

            % background
            Screen('DrawTexture',winPtr,background(nn),[],CenterRect(bgRect,winRect)+centeroffset);

            % target image
            if dparam.img_loading_mode~=3
              Screen('DrawTexture',winPtr,timg(nn),[],CenterRect(imgRect(nseq(nn),:),winRect)+centeroffset);
            else
              Screen('DrawTexture',winPtr,timg(nseq(nn)),[],CenterRect(imgRect(nseq(nn),:),winRect)+centeroffset);
            end

            % fixation
            if dparam.fixation{1} && ~(ismember(dparam.task(1),[1,3]) && task.arrays(taskcounter))
              Screen('DrawTexture',winPtr,fcross(nn),[],CenterRect(fixRect,winRect)+centeroffset);
            end

            % onset marker
            if dparam.onset_punch(1) % draw a punch rectangle for photo-trigger etc.
              if imgs.trigger{nseq(nn)}~=0, trigcolor=[255,0,0]; else trigcolor=[0,0,0]; end
              Screen('FillRect',winPtr,trigcolor,CenterRect([0,0,psize,psize],winRect)+punchoffset+centeroffset);
            end

            % task
            if dparam.task(1)==1 && task.arrays(taskcounter) % luminance detection
              Screen('DrawTexture',winPtr,tasktex(nn),[],CenterRect(fixRect,winRect)+centeroffset);
            elseif dparam.task(1)==2 && task.arrays(taskcounter) % vernier left/right
              Screen('DrawTexture',winPtr,tasktex(nn),[],CenterRect(task.vernierrect,winRect)+centeroffset+[task.vernierpos(taskcounter),0,task.vernierpos(taskcounter),0]);
            elseif dparam.task(1)==3 && task.arrays(taskcounter) % character detection task
              Screen('DrawTexture',winPtr,textPtr(task.texttype(taskcounter)),[],CenterRect(task.textrect,winRect)+centeroffset);
            elseif (dparam.task(1)==4 || dparam.task(1)==5) && task.arrays(taskcounter) % 1-back
              % for 1-back task, do nothing
              %Screen('DrawTexture',winPtr,tasktex(nn),[],CenterRect(fixRect,winRect)+centeroffset);
            end

            [resps,event]=resps.check_responses(event);
          end % for nn=1:1:nScr

          Screen('DrawingFinished',winPtr);
        end % if nextblockidx<=length(prt)

        if strcmpi(prt{ii}.mode,'frame')
          % wait for the current sub-duration and then flip to the next screen
          Screen('Flip',winPtr,the_experiment_start+(prt{ii}.subcumduration{jj}(mm)-0.5)*dparam.ifi,[],[],1);
        else
          % wait for the current sub-duration
          while (GetSecs()-the_experiment_start < prt{ii}.subcumduration{jj}(mm)/1000), [resps,event]=resps.check_responses(event); end
        end

      end % for mm=1:1:numel(prt{ii}.subduration{jj})
    end % for jj=1:1:numel(prt{ii}) % trials

  else
    error('prt{%d}.mode should be ''msec'' or ''frame''. check input variable',ii);
  end % if sum(strcmpi(prt{ii}.mode,{'frame','msec'})) % frame or msec precision

end % for ii=1:1:length(prt) % blocks


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Experiment & scanner end here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

experimentDuration=GetSecs()-the_experiment_start;
event=event.add_event('End',[]);
if strcmpi(prt{ii}.mode,'frame')
  fprintf('Experiemnt Completed: %.3f/%.3f sec.\n',experimentDuration,prt{end}.cumduration(end)*dparam.ifi);
else
  fprintf('Experiemnt Completed: %.3f/%.3f sec.\n',experimentDuration,prt{end}.cumduration(end)/1000); 
end

% clean up
for ii=1:1:length(prt), prt{ii}=rmfield(prt{ii},{'subcumduration','subduration'}); end
if dparam.img_loading_mode~=1, imgs=rmfield(imgs,'img'); end %#ok % clean up raw image data if they are stored


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Write data into file for post analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% saving the results
fprintf('saving the results...');
eval(sprintf('save -append %s prt event imgs;',savefname));
disp('done.');

% calculate & display task performance
disp(' ');
if ~isempty(intersect(dparam.task(1),[1,3:5])) % detection/identification task
  correct_event=cell(numel(dparam.keys),1); for ii=1:1:numel(dparam.keys), correct_event{ii}=sprintf('key%d',ii); end
  [task.numTasks,task.numHits,task.numErrors,task.numResponses,task.RT]=event.calc_accuracy(correct_event);
elseif dparam.task(1)==2 % vernier line detection task
  correct_event{1}={-3,'key1'}; correct_event{2}={-2,'key1'}; correct_event{3}={-1,'key1'}; correct_event{4}={ 0,'key2'};
  correct_event{5}={ 1,'key2'}; correct_event{6}={ 2,'key2'}; correct_event{7}={ 3,'key2'};
  [task.numTasks,task.numHits,task.numErrors,task.numResponses,task.RT]=event.calc_accuracies(correct_event);
end
event=event.get_event(); % convert an event logger object to a cell data structure
eval(sprintf('save -append %s task event;',savefname)); % save the updated task & event structures


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Cleaning up the PTB screen, removing path to the subfunctions, and finalizing the script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Screen('CloseAll');
ShowCursor();
Priority(0);
GammaResetPTB(1.0);
rmpath(genpath(fullfile(rootDir,'..','Common')));
rmpath(fullfile(rootDir,'..','Generation'));
clear all; clear mex; clear global;
diary off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Catch the errors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

catch lasterror
  % this "catch" section executes in case of an error in the "try" section
  % above.  Importantly, it closes the onscreen window if its open.
  Screen('CloseAll');
  ShowCursor();
  Priority(0);
  GammaResetPTB(1.0);
  tmp=lasterror; %#ok
  if exist('event','var'), event=event.get_event(); end %#ok % just for debugging
  diary off;
  fprintf(['\nErrror detected and the program was terminated.\n',...
           'To check error(s), please type ''tmp''.\n',...
           'Please save the current variables now if you need.\n',...
           'Then, quit by ''dbquit''\n']);
  keyboard;
  rmpath(genpath(fullfile(rootDir,'..','Common')));
  rmpath(fullfile(rootDir,'..','Generation'));
  %psychrethrow(psychlasterror);
  clear global; clear mex; clear all; close all;
  return
end % try..catch


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% that's it - we're done
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
return
% end % function ImagesShowPTB
