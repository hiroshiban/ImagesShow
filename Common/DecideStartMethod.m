function [fMRItriggerStartON, StartWithButtonPressOn] = DecideStartMethod()

% function [fMRItriggerStartON, StartWithButtonPressOn] = DecideStartMethod()
%
% Wait for User input to decide how to start the stimulus Presentation
% Answer [y/n] to decide the start method.
% Currently, fMRI trigger will be input from Parallel port #17
%
% [input]
% no input variable
%
% [output]
% fMRItriggerStartON     : if 1, the current fMRI experiment will start
%                          after getting a trigger signal from MRI. [0/1]
% StartWithButtonPressOn : if 1, the current fMRI experiment will start
%                          by pressing ENTER or SPACE key. [0/1]
%
% Created : Feb 04 2010 Hiroshi Ban
% Last Update: "2010-02-04 10:56:15 ban"

%Check to see if we will send parallel port trigger
fMRItriggerStartON = 0; StartWithButtonPressOn = 0;
while ~fMRItriggerStartON && ~StartWithButtonPressOn
  user_entry = input('Does stimulus presentaiton start by fMRI trigger (at BUIC) ? (y/n) : ', 's');
  if(user_entry == 'y')
    disp('Waiting a trigger from fMRI scanner...');
    fMRItriggerStartON = 1;
    break;
  elseif (user_entry == 'n')
    disp('Start with SPACE or RETURN key...');
    StartWithButtonPressOn = 1;
    break;
  else 
    disp('Please press y or n!'); continue;
  end
end
pause(1.0); % wait for 1 sec.

return
