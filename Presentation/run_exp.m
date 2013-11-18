function run_exp(subj,acq)

% function run_exp(subj,:acq)
% (: is optional)
%
% This function is a simple wrapper to run fMRI/TMS experiment with ImageShowPTB.m
%
% [input]
% subj : subject name, e.g. subj='HB';
% acq  : acquisition number(s), integer above 0. e.g. acq=1; or acq=1:3;
%
% [output]
% no output variable
%
%
% Created:   : "2013-11-15 14:49:29 ban"
% Last Update: "2013-11-15 14:49:39 ban"

% check input variables
if nargin<1 || isempty(subj), help(mfilename()); return; end
if nargin<2 || isempty(acq), acq=1; end

if acq<1, error('acq should be interger above 0. check input variable.'); end

% set default input file names
protocolfile='protocolfile';
imgdbfile='image_database';
viewfile='size_params';
optionfile='display_options';
%gamma_table='../gamma_table/gamma_table_131115.mat';

%for ii=1:1:numel(acq), ImagesShowPTB(subj,acq(ii),protocolfile,imgdbfile,viewfile,optionfile,gamma_table); end
for ii=1:1:numel(acq), ImagesShowPTB(subj,acq(ii),protocolfile,imgdbfile,viewfile,optionfile); end

return
