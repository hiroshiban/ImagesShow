% a sample of image database file
% for details, please see readImageDatabase.m

% an example of image database for monocular display
imgdb.type='image'; % database type, 'image' (image file) or 'matlab'(matlab .mat file).
imgdb.directory=fullfile(fileparts(mfilename('fullpath')),'..','..','..','images','depth_plane_images','depth_plane_images'); % full path to the image files
imgdb.presentation_size=[540,540]; % this is not the actual image size, all the images will be adjusted based on this value.
imgdb.num=51; % the total number of images

imgdb.img{1}={'background.png','Background',0}; % {'file_name','comment','trigger(a scalar, 0(off),1(on),2,3..., a vector [1,2,3](on), or 'string')}

for ii=1:1:25
  imgdb.img{2+2*(ii-1)}={sprintf('plane_%02d_L.png',ii),'left',0};
  imgdb.img{3+2*(ii-1)}={sprintf('plane_%02d_R.png',ii),'right',0};
end
