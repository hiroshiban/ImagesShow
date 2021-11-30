% a sample of image database file
% for details, please see readImageDatabase.m

% an example of image database for monocular display
imgdb.type='image'; % database type, 'image' (image file) or 'matlab'(matlab .mat file).
imgdb.directory=fullfile(fileparts(mfilename('fullpath')),'..','..','..','images','png_images'); % full path to the image files
% or imgdb.directory='C:/home/Working/ImagesShowPTB/Presentation/subjects/HB/PNGs';
imgdb.presentation_size=[256,256]; % this is not the actual image size, all the images will be adjusted based on this value.
imgdb.num=6; % the total number of images

imgdb.img{1}={'background.png','background',0}; % {'file_name','comment','trigger(off=0, on=1, or on=string)'}
imgdb.img{2}={'gray.png','gray circle',0};
imgdb.img{3}={'red.png','red circle',1};
imgdb.img{4}={'green.png','green circle',0};
imgdb.img{5}={'blue.png','blue circle',0};
imgdb.img{6}={'picture.png','picture',0};
