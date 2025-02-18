% image database file
% for details, please see readImageDatabase.m

% an example of image database for monocular display
imgdb.type='image'; % database type, 'image' (image file) or 'matlab'(matlab .mat file).
imgdb.directory=fullfile(fileparts(mfilename('fullpath')),'..','..','..','images','meridian_checkerboard_images','images'); % full path to the image files
imgdb.presentation_size=[760,760];
imgdb.num=20;

imgdb.img{1} ={'checkerboard_01_01.png','checkerboard_01_01',1}; % {'file_name','comment','trigger(a scalar, 0(off),1(on),2,3..., a vector [1,2,3](on), or 'string')}
imgdb.img{2} ={'checkerboard_01_02.png','checkerboard_01_02',1};
imgdb.img{3} ={'checkerboard_02_01.png','checkerboard_02_01',1};
imgdb.img{4} ={'checkerboard_02_02.png','checkerboard_02_02',1};
imgdb.img{5} ={'checkerboard_03_01.png','checkerboard_03_01',1};
imgdb.img{6} ={'checkerboard_03_02.png','checkerboard_03_02',1};
imgdb.img{7} ={'checkerboard_04_01.png','checkerboard_04_01',1};
imgdb.img{8} ={'checkerboard_04_02.png','checkerboard_04_02',1};
imgdb.img{9} ={'checkerboard_05_01.png','checkerboard_05_01',1};
imgdb.img{10}={'checkerboard_05_02.png','checkerboard_05_02',1};
imgdb.img{11}={'checkerboard_06_01.png','checkerboard_06_01',1};
imgdb.img{12}={'checkerboard_06_02.png','checkerboard_06_02',1};
imgdb.img{13}={'checkerboard_07_01.png','checkerboard_07_01',1};
imgdb.img{14}={'checkerboard_07_02.png','checkerboard_07_02',1};
imgdb.img{15}={'checkerboard_08_01.png','checkerboard_08_01',1};
imgdb.img{16}={'checkerboard_08_02.png','checkerboard_08_02',1};
imgdb.img{17}={'checkerboard_09_01.png','checkerboard_09_01',1};
imgdb.img{18}={'checkerboard_09_02.png','checkerboard_09_02',1};
imgdb.img{19}={'checkerboard_10_01.png','checkerboard_10_01',1};
imgdb.img{20}={'checkerboard_10_02.png','checkerboard_10_02',1};
