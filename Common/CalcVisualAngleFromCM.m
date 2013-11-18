function vangle=CalcVisualAngleFromCM(vdist,stim_size_in_cm)

% function vangle=CalcVisualAngleFromCM(vdist,stim_size_in_cm)
%
% [INPUT]
% vdist      : viewing distance, [cm]
% stim_size_in_cm : size of the stimulus in deg [deg]
% 
% [OUTPUT]
% vangle     : visual angle in deg
%
% Created    : "2010-06-23 14:56:49 ban" 
% Last Update: "2010-06-23 15:00:55 ban"

vangle= atan( stim_size_in_cm / vdist) * 180 / pi;

return;
