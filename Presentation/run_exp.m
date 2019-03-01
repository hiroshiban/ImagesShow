function OK=run_exp(subj,acq,session)

% a simple wrapper of ImageShowPTB.m.
% function run_exp(subj,:acq,:session)
% (: is optional)
%
% This function is a simple wrapper to run fMRI/TMS/EEG/behavior experiments with ImageShowPTB.m
%
% [input]
% subj    : subject name, e.g. subj='HB';
% acq     : acquisition number(s), integer above 0. e.g. acq=1; or acq=1:3; 1 by default
% session : acquisition session (day), integer above 0. 1 by default.
%
% [output]
% no output variable
%
%
% Created:   : "2013-11-15 14:49:29 ban"
% Last Update: "2019-03-01 15:15:47 ban"


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% check the input variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin<1 || isempty(subj), help(mfilename()); return; end
if nargin<2 || isempty(acq), acq=1; end
if nargin<3 || isempty(session), session=1; end

if acq<1, error('acq should be an interger and greater than 0. check input variable.'); end
if session<1, error('session should be an interger and greater than 0. check input variable.'); end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% set the display-configuration, presentation-protocol,
%% image-database, and option files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

protocolfile='protocolfile';
imgdbfile='image_database';
viewfile='size_params';
optionfile='display_options';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% check whether the subject directory already exists
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [NOTE]
% if the subj directory is not found, the directory is created with coping
% all condition files from DEFAULT and then this function tries to run the
% stimulus presentation script using the DEFAULT parameters

subj_dir=fullfile(fileparts(mfilename('fullpath')),'subjects',subj);
if ~exist(subj_dir,'dir')

  error('subjects directory not found. check the input variable.');

  % fprintf('The subject directory was not found.\n');
  % user_response=0;
  % while ~user_response
  %   user_entry = input('Do you want to proceed using DEFAULT parameters? (y/n) : ', 's');
  %   if(user_entry == 'y')
  %     fprintf('Generating subj directory using DEFAULT parameters...');
  %     user_response=1; %#ok
  %     break;
  %   elseif (user_entry == 'n')
  %     fprintf('quiting the script...\n');
  %     if nargout, OK=false; end
  %     return;
  %   else
  %     fprintf('Please answer y or n!\n'); continue;
  %   end
  % end
  %
  % %mkdir(subj_dir);
  % copyfile(fullfile(fileparts(mfilename('fullpath')),'subjects','_DEFAULT_'),subj_dir);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% set the gamma table. please change the line below to use your measurements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% loading gamma_table
%load(fullfile('..','gamma_table','ASUS_ROG_Swift_PG278Q','181003','cbs','gammatablePTB.mat'));
%load(fullfile('..','gamma_table','ASUS_VG278HE','181003','cbs','gammatablePTB.mat'));
%load(fullfile('..','gamma_table','MEG_B1','151225','cbs','gammatablePTB.mat'));
gammatable=repmat(linspace(0.0,1.0,256),3,1)'; %#ok % a simple linear gamma


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% run ImagesShoPTB
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for ii=1:1:numel(session)
  for jj=1:1:numel(acq), ImagesShowPTB(subj,acq(jj),session(ii),protocolfile,imgdbfile,viewfile,optionfile,gammatable); end
end


return
