% a sample of image database file
% for details, please see readImageDatabase.m

% an example of image database for monocular display
imgdb.type='image'; % database type, 'image' (image file) or 'matlab'(matlab .mat file).
imgdb.directory=fullfile(fileparts(mfilename('fullpath')),'..','..','..','images','voronoi_images'); % full path to the image files
imgdb.presentation_size=[400,400]; % this is not the actual image size, all the images will be adjusted based on this value.
imgdb.num=51; % the total number of images

% set image file names
% img{1}-img{100}   : inphase images
% img{101}-img{200} : outphase images
imgcounter=1;
for jj=1:1:2
  for ii=1:1:25
    imgdb.img{imgcounter}={sprintf('img_01_03_%02d_%02d.png',ii,jj),sprintf('voronoi_%02d',ii),jj-1};
    imgcounter=imgcounter+1;
  end
end

% background image
imgdb.img{201}={'background.png','background',0}; % {'file_name','comment','trigger(off=0, on=1, or on=string)'}
