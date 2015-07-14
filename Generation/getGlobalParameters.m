function output=getGlobalParameters(var_name_str,field_name_str)

% gets global parameters for more flexible config file setups.
% function output=getGlobalParameters(var_name_str,:field_name_str)
% (: is optional)
%
% This function returns the global parameter or its field value(s).
% The returned value(s) can be used to set the parameters in the
% config files with more flexibility.
%
% [input]
% var_name_str   : the name of the global variable you want to get, string.
%                  currently, the acceptable variable name is one of
%                  'subj', 'acq', 'session', 'vparam', 'dparam', 'prt', and 'imgs'.
% field_name_str : (optional) the field name of the var_name_str, string.
%
% [output]
% output         : output variable or field value you want to extract.
%
% [note]
% Please use this function is your protocolfile, imgdbfile, viewfile, or optionfile.
% Then you can use the global parameters as references, which enables users to create
% config files with more flexiblity.
%
%
% Created    : "2015-07-14 13:42:40 ban"
% Last Update: "2015-07-14 13:55:13 ban"

global subj acq session vparam dparam prt imgs; %#ok

% check input variable
if nargin<1 || isempty(var_name_str), help(mfilename()); return; end
if nargin<2 || isempty(field_name_str), field_name_str=''; end

if ~ismember(var_name_str,{'subj', 'acq', 'session', 'vparam', 'dparam', 'prt','imgs'})
  error('var_name_str should be one of ''subj'', ''acq'', ''session'', ''vparam'', ''dparam'', ''prt'', and ''imgs''. check input variable.');
end

if ~isempty(field_name_str)
  output=eval(sprintf('%s.%s;',var_name_str,field_name_str));
else
  output=eval(sprintf('%s;',var_name_str));
end

return
