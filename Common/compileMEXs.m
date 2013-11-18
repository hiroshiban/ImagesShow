function compileMEXs()

% function compileMEXs()
%
% Compiles all mex files in Common directory
%
% [dependency]
% wildcardsearch
%
% Created    : "2012-09-19 12:21:12 ban"
% Last Update: "2012-09-19 12:25:01 ban"

cfiles=wildcardsearch(pwd,'*.cpp');
for ii=1:1:length(cfiles)
  [path,fname,ext]=fileparts(cfiles{ii});
  fprintf('compiling: %s%s...',fname,ext);
  eval(sprintf('mex %s;',cfiles{ii}));
  disp('done.');
end

return;
