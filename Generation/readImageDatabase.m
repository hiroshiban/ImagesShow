function imgs=readImageDatabase(imgdbfile,img_loading_mode)

% reads and interprets image database file for ImagesShowPTB.m function.
% function imgs=readImageDatabase(imgdbfile,:img_loading_mode)
% (: is optional)
%
% This function reads image database file and loads all the
% images in the database into a cell output variable.
%
% [input]
% imgdbfile : Image database file (a matlab script file). Should be set with a relative path format.
%             The origin is the directory where this function is called.
%             The contents of the image database file should be as below.
%
%             [example of image file setting]
%
%             imgdb.type='image'; % database type, 'image' (image file) or 'matlab'(matlab .mat file).
%             imgdb.directory='C:/home/ban/images/'; % a full path to the image files or the parent directory
%             imgdb.presentation_size=[512,512]; % [row,col], this is not the actual image size, all the images will be adjusted based on this value.
%             imgdb.num=120; % the total number of images
%             imgdb.img{1}={'image1.bmp','background',0}; % {'file_name','comment','trigger(off=0, on=1, or on=string)'}
%             imgdb.img{2}={'image2.bmp','taget image 1',1};
%             imgdb.img{3}={'image3.bmp','control image 1',0};
%             ...
%             imgdb.img{120}={'imageN.bmp','control image N',0};
%
%             In this case, the image files are successively loaded and stored into an output matlab variable.
%             Or you can set matlab image matrix as below.
%
%             [example of matlab file setting]
%
%             imgdb.type='matlab';
%             imgdb.directory='C:/home/ban/images/';
%             imgdb.presentation_size=[512,512];
%             imgdb.num=7; % the total number of images stored in imgdb.img{1-N}.
%             imgdb.img{1}={'images1.mat'}; % {'matlab_file_name'}
%
%             images1.mat should have data listed below.
%               .img     : cell structure, each cell is image [x,y,RGB] or [x,y] matrix
%               .comment : (optional) cell structure, each comment is a note to each of images.
%               .trigger : (optional) cell structure, each trigger is a trigger (see above) to each of images.
%
%             In this case, the matlab image in a matrix format is loaded and stored into an output variable.
%
% img_loading_mode : how to load images and to make PTB textures.
%                    1: load images to the memory one by one when creating the target texture.
%                    2: load all the images at once before the actual presentation, but make texture when requested.
%                    3: load all the images at once and make all the textures before the actual presentation
%                    By setting this to 1, you can save memory, but it requires additional computation time in
%                    presentation (~30ms with Core2Duo CPU) on Windows. When you set this to 2 or 3, you can save
%                    computational time, but requires more memory on your computer.
%                    2 by default.
%
% [output]
% imgs      : output image database, a structure
%             imgs.directory
%             imgs.presentation_size
%             imgs.img{1-n}
%             imgs.img_size(1-n,2(x_width and y_height))
%             imgs.comment{1-n}
%             imgs.trigger{1-n}
%
%
% Created:   : "2013-11-08 15:32:41 ban"
% Last Update: "2016-10-05 11:15:22 ban"

%clear global; clear mex;
global subj acq session vparam dparam prt imgs;

% check input variable
if nargin<1 || isempty(imgdbfile), help(mfilename()); imgs=[]; return; end
if nargin<2 || isempty(img_loading_mode), img_loading_mode=2; end

if ~ismember(img_loading_mode,[1,2,3]), error('img_loading_mode should be one of 1-3. check input variable.'); end

% check image database file
run_imgdbfile=imgdbfile;
if ~strcmpi(run_imgdbfile(end-1:end),'.m'), run_imgdbfile=strcat(run_imgdbfile,'.m'); end

% check image database file
if ~exist(fullfile(pwd,run_imgdbfile),'file')
  error('can not find img database file: %s. check an input variable',imgdbfile);
end
clear imgdbfile;

% load image database file
run(fullfile(pwd,run_imgdbfile));

if ~ismember(imgdb.type,{'image','matlab'})
  error('imgdb.type should be ''monocular'' or ''matlab''. check database file.');
end

% initialization
imgs.directory=imgdb.directory;
imgs.presentation_size=imgdb.presentation_size;
imgs.img=cell(imgdb.num,1);
imgs.img_size=zeros(imgdb.num,2);
imgs.comment=cell(imgdb.num,1);
imgs.trigger=cell(imgdb.num,1);

% set images
if strcmpi(imgdb.type,'image')

  imgs.img_size=zeros(imgdb.num,2);
  for ii=1:1:imgdb.num
    if ismember(img_loading_mode,[2,3])
      imgs.img{ii}=imread(fullfile(imgs.directory,imgdb.img{ii}{1}));
      sz=size(imgs.img{ii});
      imgs.img_size(ii,:)=fliplr(sz(1:2));
    else
      imgs.img{ii}=fullfile(imgs.directory,imgdb.img{ii}{1});
      imgs.img_size(ii,:)=[256,256]; % dummy values
    end
    imgs.comment{ii}=imgdb.img{ii}{2};
    imgs.trigger{ii}=imgdb.img{ii}{3};
  end

else % if strcmpi(imgdb.type,'matlab')

  if length(imgdb.img)==1

    % loading the target image file
    tmp=load(fullfile(imgs.directory,imgdb.img{1}));
    imgs.img=tmp.img;

    if isstructmember(tmp,'comment')
      imgs.comment=tmp.comment;
    else
      for ii=1:1:imgdb.num, imgs.comment{cmcounter}=''; end
    end
    if isstructmember(tmp,'trigger')
      imgs.trigger=tmp.trigger;
    else
      for ii=1:1:imgdb.num, imgs.trigger{trigcounter}=0; end
    end

  else % if length(imgdb.img)==1

    imgcounter=0;
    for nn=1:1:length(imgdb.img)
      % loading the target image file
      tmp=load(fullfile(imgs.directory,imgdb.img{nn}));

      % setting parameter one-by-one
      for ii=imgcounter+1:1:imgcounter+length(tmp.img)
        % set image
        imgs.img{ii}=tmp.img{ii};
        sz=size(imgs.img{ii});
        imgs.img_size(ii,:)=fliplr(sz(1:2));

        % set comment
        if isstructmember(tmp,'comment')
          imgs.comment{ii}=tmp.comment{ii};
        else
          imgs.comment{ii}='';
        end

        % set trigger
        if isstructmember(tmp,'trigger')
          imgs.trigger{ii}=tmp.trigger{ii};
        else
          imgs.trigger{ii}=0;
        end

        % update the counter
        imgcounter=imgcounter+length(tmp.img);
      end % for ii=imgcounter+1:1:imgcounter+length(tmp.img)
    end % for nn=1:1:length(imgdb.img)

  end % if length(imgdb.img)==1

end % if strcmpi(imgdb.type,'image')

return
