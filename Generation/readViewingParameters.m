function vparams=readViewingParameters(viewfile)

% reads viewing parameters (viewing distance etc) for ImagesShowPTB function.
% function vparams=readViewingParameters(viewfile)
%
% This function reads viewing parameters from an input file.
%
% [input]
% viewfile : viewing parameter file (a matlab script file). Should be set with a relative path format.
%            The origin is the directory where this function is called.
%            The viewing parameter file can have at most three variables listed below.
%            If some of them are not set, the default parameters are used.
%
%            vparams.ipd=6.4;            % inter pupil distance in cm
%            vparams.pix_per_cm=57.1429; % pixels per degree in visual angle
%            vparams.vdist=65;           % viewing distance in cm
%
% [output]
% vparams  : viewing parameters to be used in ImagesShow presentation, a structure
%            with members listed below.
%            .ipd
%            .pix_per_cm
%            .vdist
%
%
% Created    : "2013-11-08 15:33:56 ban"
% Last Update: "2015-07-14 13:08:32 ban"

% check input variable
if nargin<1 || isempty(viewfile), help(mfilename()); vparams=[]; return; end

% check option file
run_viewfile=viewfile;
if ~strcmpi(run_viewfile(end-1:end),'.m'), run_viewfile=strcat(run_viewfile,'.m'); end

if ~exist(fullfile(pwd,run_viewfile),'file')
  warning('can not find viewfile: %s. setting default parameters...',run_viewfile); %#ok
  vparams=struct('ipd',6.4,'pix_per_cm',57.1429,'vdist',65);
  return
end
clear viewfile;

% load options and set the default values if required
run(fullfile(pwd,run_viewfile));
if ~exist('vparams','var')
  vparams=struct('ipd',6.4,'pix_per_cm',57.1429,'vdist',65);
end
if ~isstructmember(vparams,'ipd'), vparams.ipd=6.4; end
if ~isstructmember(vparams,'pix_per_cm'), vparams.pix_per_cm=57.1429; end
if ~isstructmember(vparams,'vdist'), vparams.vdist=65; end

return
