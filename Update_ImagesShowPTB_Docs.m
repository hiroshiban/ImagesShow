function Update_ImagesShowPTB_Docs()

% Updates all the HTML-based documents of ImagesShowPTB.
% function Update_ImagesShowPTB_Docs()
%
% This function updates html-based documents of ImagesShowPTB
%
% [input]
% no input variable
%
% [output]
% new html-baesd documents will be generated in
% ~/ImagesShowPTB/doc
%
%
% Created    : "2013-11-13 13:08:05 ban"
% Last Update: "2013-11-22 18:14:34 ban (ban.hiroshi@gmail.com)"

% add path to m2html
m2htmlpath=fullfile(fileparts(mfilename('fullpath')),'m2html');
addpath(m2htmlpath);

docpath=fullfile(fileparts(mfilename('fullpath')),'doc','html');
if exist(docpath,'dir'), rmdir(docpath,'s'); end

% generate html-based documents
disp('Updating ImagesShowPTB documents....');
disp(' ');

cd('..');
%tgt_path={'ImagesShowPTB/Common','ImagesShowPTB/Generation','ImagesShowPTB/Presentation','ImagesShowPTB/gamma_table'};
tgt_path={'ImagesShowPTB/Common','ImagesShowPTB/Generation','ImagesShowPTB/Presentation'};
m2html('mfiles',tgt_path,'htmldir',docpath,'recursive','on','globalHypertextLinks','on');
cd('ImagesShowPTB');

disp(' ');
disp('completed.');

% remove path to m2html
addpath(m2htmlpath);

return
