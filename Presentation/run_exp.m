function OK=run_exp(subj,acq,session)

% a simple wrapper to ImageShowPTB.m.
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
% Last Update: "2016-08-29 10:10:48 ban"

% check input variables
if nargin<1 || isempty(subj), help(mfilename()); return; end
if nargin<2 || isempty(acq), acq=1; end
if nargin<3 || isempty(session), session=1; end

if acq<1, error('acq should be an interger and greater than 0. check input variable.'); end
if session<1, error('session should be an interger and greater than 0. check input variable.'); end

% set default input file names
protocolfile='protocolfile';
imgdbfile='image_database';
viewfile='size_params';
optionfile='display_options';
%gamma_table='../gamma_table/gamma_table_131115.mat';

%% check directory with subject name

% [NOTE]
% if the subj directory is not found, create subj directory, copy all condition
% files from DEFAULT and then run the script using DEFAULT parameters

subj_dir=fullfile(pwd,'subjects',subj);
if ~exist(subj_dir,'dir')

  disp('The subject directory was not found.');
  user_response=0;
  while ~user_response
    user_entry = input('Do you want to proceed using DEFAULT parameters? (y/n) : ', 's');
    if(user_entry == 'y')
      fprintf('Generating subj directory using DEFAULT parameters...');
      user_response=1; %#ok
      break;
    elseif (user_entry == 'n')
      disp('quiting the script...');
      if nargout, OK=false; end
      return;
    else
      disp('Please answer y or n!'); continue;
    end
  end

  %mkdir(subj_dir);
  copyfile(fullfile(pwd,'subjects','_DEFAULT_'),subj_dir);
end

%% run ImagesShowPTB
for ii=1:1:numel(session)
  %for jj=1:1:numel(acq), ImagesShowPTB(subj,acq(jj),session(ii),protocolfile,imgdbfile,viewfile,optionfile,gamma_table); end
  for jj=1:1:numel(acq), ImagesShowPTB(subj,acq(jj),session(ii),protocolfile,imgdbfile,viewfile,optionfile); end
end

return
