function run_exp(subj,acq,session)

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
% Last Update: "2015-07-14 13:11:03 ban"

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

for ii=1:1:numel(session)
  %for jj=1:1:numel(acq), ImagesShowPTB(subj,acq(jj),session(ii),protocolfile,imgdbfile,viewfile,optionfile,gamma_table); end
  for jj=1:1:numel(acq), ImagesShowPTB(subj,acq(jj),session(ii),protocolfile,imgdbfile,viewfile,optionfile); end
end

return
