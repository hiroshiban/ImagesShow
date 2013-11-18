% a sample of image database file
% for details, please see readImageDatabase.m

% an example of image database for monocular display
imgdb.type='monocular'; % database type, one of 'monocular', 'binocular', or 'matlab'(matlab .mat file).
imgdb.directory=fullfile(fileparts(mfilename('fullpath')),'PNGs'); % full path to the image files
% or imgdb.directory='C:/home/Working/ImagesShowPTB/Presentation/subjects/HB/PNGs';
imgdb.presentation_size=[256,256]; % this is not the actual image size, all the images will be adjusted based on this value.
imgdb.num=7; % the total number of images

imgdb.img{1}={'gray.png','background',0}; % {'file_name','comment','trigger(off=0, on=1, or on=string)'}
imgdb.img{2}={'red.png','red rectangle',1};
imgdb.img{3}={'green.png','green circle',0};
imgdb.img{4}={'blue.png','blue circle',0};
imgdb.img{5}={'rainbow1.png','rainbow 1',1};
imgdb.img{6}={'rainbow2.png','rainbow 2',0};
imgdb.img{7}={'picture.png','picture',0};

% % an example of image database for binocular display
% imgdb.type='binocular';
% imgdb.directory='C:/home/Working/ImagesShowPTB/Presentation/subjects/HB/PNGs';
% imgdb.presentation_size=[256,256];
% imgdb.num=7;
% 
% imgdb.img{1}={'gray.png','gray.png','background',0}; % {'file_name left-eye','file_name right-eye','comment','trigger(off=0, on=1, or on=string)'}
% imgdb.img{2}={'red.png','green.png','red rectangle',1};
% imgdb.img{3}={'green.png','blue.png','green circle',0};
% imgdb.img{4}={'blue.png','red.png','blue circle',0};
% imgdb.img{5}={'rainbow1.png','rainbow2.png','rainbow 1',1};
% imgdb.img{6}={'rainbow2.png','rainbow1.png','rainbow 2',0};
% imgdb.img{7}={'picture.png','gray.png','picture',0};
