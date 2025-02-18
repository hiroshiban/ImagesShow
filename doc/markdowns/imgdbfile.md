**Example 1**

````MATLAB
imgdb.type='image';
imgdb.directory=fullfile(fileparts(mfilename('fullpath')),'images');
imgdb.presentation_size=[320,320];
imgdb.num=321;

imgdb.img{1}={'background.jpg','Background',0};

imgdb.img{2}={'/Building/Buildings_0001.jpg','Buildings',0};
imgdb.img{3}={'/Building/Buildings_0002.jpg','Buildings',0};
imgdb.img{4}={'/Building/Buildings_0003.jpg','Buildings',0};
imgdb.img{5}={'/Building/Buildings_0004.jpg','Buildings',0};
.
.
.
imgdb.img{317}={'/HandMosaic/Hands_0036.jpg','Hands',0};
imgdb.img{318}={'/HandMosaic/Hands_0037.jpg','Hands',0};
imgdb.img{319}={'/HandMosaic/Hands_0038.jpg','Hands',0};
imgdb.img{320}={'/HandMosaic/Hands_0039.jpg','Hands',0};
imgdb.img{321}={'/HandMosaic/Hands_0040.jpg','Hands',0};
````


Alternatively, as this imgdbfile.m is also a MATLAB script like protocolfile.m, you can use more flexible descriptions by using some mathematics formulas and MATLAB functions.


**Example 2**

````MATLAB
% an example of image database for monocular display
imgdb.type='image'; % database type, 'image' (image file) or 'matlab'(matlab .mat file).
imgdb.directory=fullfile(fileparts(mfilename('fullpath')),'images'); % full path to the image files
imgdb.presentation_size=[400,400]; % this is not the actual image size, all the images will be adjusted based on this value.
imgdb.num=201; % the total number of images

% set image file names
% img{1}-img{100}   : inphase images
% img{101}-img{200} : outphase images
imgcounter=1;
for jj=1:1:2
  for ii=1:1:100
    imgdb.img{imgcounter}={sprintf('img_01_03_%02d_%02d.png',ii,jj),sprintf('voronoi_%02d',ii),jj-1};
    imgcounter=imgcounter+1;
  end
end

% background image
imgdb.img{201}={'background.png','background',0}; % {'file_name','comment','trigger(a scalar, 0(off),1(on),2,3..., a vector [1,2,3](on), or 'string')}
````
