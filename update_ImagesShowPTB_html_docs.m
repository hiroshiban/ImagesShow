function update_ImagesShowPTB_html_docs(style)

% Updates all the HTML-based documents of ImagesShowPTB.
% function update_ImagesShowPTB_html_docs(style)
%
% This function updates html-based documents of ImagesShowPTB
%
% [input]
% style : (optional) if 0, a default CSS/TPL templates will be applied in
%         generating HTML-based help documents, while Hiroshi's customized
%         templates will be applied if this value is non-zero. 0 by default.
%
% [output]
% new html-baesd documents will be generated in
% ~/ImagesShowPTB/doc
%
%
% Created    : "2013-11-13 13:08:05 ban"
% Last Update: "2016-09-04 16:35:21 ban"

% check the input variable
if nargin<1 || isempty(style), style=0; end

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

% selecting the style of the HTML-based help documents of BVQX_hbtools.
if style
  m2html('mfiles',tgt_path,'htmldir',docpath,'recursive','on','globalHypertextLinks','on','template','BVQX_hbtools','index','menu');
else
  m2html('mfiles',tgt_path,'htmldir',docpath,'recursive','on','globalHypertextLinks','on','template','blue');
end

cd('ImagesShowPTB');

disp(' ');
disp('completed.');

% remove path to m2html
rmpath(m2htmlpath);

return
