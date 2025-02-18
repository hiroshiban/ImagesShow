% a sample of image database file
% for details, please see readImageDatabase.m

% an example of image database for monocular display
imgdb.type='image'; % database type, 'image' (image file) or 'matlab'(matlab .mat file).
imgdb.directory=fullfile(fileparts(mfilename('fullpath')),'..','..','..','images','checkerboard_images','checkerboard_images'); % full path to the image files
imgdb.presentation_size=[760,760]; % this is not the actual image size, all the images will be adjusted based on this value.
imgdb.num=9; % the total number of images

imgdb.img{1}={'background.png','Background',0}; % {'file_name','comment','trigger(a scalar, 0(off),1(on),2,3..., a vector [1,2,3](on), or 'string')}

imgdb.img{2}={'checkerboard_01_01.png','checkerboard',0};
imgdb.img{3}={'checkerboard_01_02.png','checkerboard',0};
imgdb.img{4}={'checkerboard_02_01.png','checkerboard',0};
imgdb.img{5}={'checkerboard_02_02.png','checkerboard',0};
imgdb.img{6}={'checkerboard_03_01.png','checkerboard',0};
imgdb.img{7}={'checkerboard_03_02.png','checkerboard',0};
imgdb.img{8}={'checkerboard_04_01.png','checkerboard',0};
imgdb.img{9}={'checkerboard_04_02.png','checkerboard',0};
