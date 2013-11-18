function user_answer=WaitToProceed(my_message)

% function user_answer=WaitToProceed(my_message)
%
% wait until the user responds to the question by 'y' (yes) or 'n' (no)
%
% [input]
% my_message : message you want to display on MATLAB window for user.
%              'Are you ready to proceed? (y/n) : ' by default.
%
%
% Created    : "2013-11-07 16:14:38 ban"
% Last Update: "2013-11-07 16:17:00 ban"

if nargin<1 || isempty(my_message), my_message='Are you ready to proceed? (y/n) : '; end

while 1
  user_answer=input(my_message,'s');
  if user_answer=='y'
    user_answer=true;
    break
  elseif user_answer=='n'
    user_answer=false;
    break
  else
    disp('Please press y or n!'); continue;
  end
end
pause(0.5);

return
