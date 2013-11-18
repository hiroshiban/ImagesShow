function imgs=readImageDatabase(imgdbfile,load_img_flg)

% function imgs=readImageDatabase(imgdbfile,:load_img_flg)
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
%             [example of monocular display setting]
%
%             imgdb.type='monocular'; % database type, one of 'monocular', 'binocular', or 'matlab'(matlab .mat file).
%             imgdb.directory='C:/home/ban/images/'; % % full path to the image files
%             imgdb.presentation_size=[512,512]; % [row,col], this is not the actual image size, all the images will be adjusted based on this value.
%             (imgdb.RGBgain=[1.0,1.0,1.0;1.0,1.0,1.0];) % (optional) if you need to change RGB video intensity (e.g. for red-green glasses display), please set these values
%             imgdb.num=120; % the total number of images
%             imgdb.img{1}={'image1.bmp','background',0}; % {'file_name','comment','trigger(off=0, on=1, or on=string)'}
%             imgdb.img{2}={'image2.bmp','taget image 1',1};
%             imgdb.img{3}={'image3.bmp','control image 1',0};
%             ...
%             imgdb.img{120}={'imageN.bmp','control image N',0};
%
%             [example of binocular display setting]
%
%             imgdb.type='binocular';
%             imgdb.directory='C:/home/ban/images/';
%             imgdb.presentation_size=[512,512];
%             (imgdb.RGBgain=[1.0,1.0,1.0;1.0,1.0,1.0];)
%             imgdb.num=120;
%             imgdb.img{1}={'image1_L.bmp','image1_R.bmp','background',0}; % {'file_name left-eye','file_name right-eye','comment','trigger(off=0, on=1, or string)'}
%             imgdb.img{2}={'image2_L.bmp','image2_R.bmp','taget image 1',1};
%             imgdb.img{3}={'image3_L.bmp','image3_R.bmp','control image 1',0};
%             ...
%             imgdb.img{120}={'image120.bmp','control image 120',0};
%
%             In these cases, the image files are successively loaded and stored into an output matlab variable.
%             Or you can set matlab image matrix as below.
%
%             imgdb.type='matlab';
%             imgdb.directory='C:/home/ban/images/';
%             imgdb.presentation_size=[512,512];
%             (imgdb.RGBgain=[1.0,1.0,1.0];)
%             imgdb.num=7;
%             imgdb.img{1}={'images1.mat'}; % {'matlab_file_name'}
%
%             In this case, the matlab image in a matrix format is loaded and stored into an output variable.
% load_img_flg : if 1, loading images on memory as MATLAB matrix. if 0, only the paths to image files are stored.
%                1 by default. This variable will have no effect when you set imgdb.type='matlab'.
%
% [output]
% imgs      : output image database, a structure
%             imgs.directory
%             imgs.presentation_size
%             imgs.img{1-n}
%             imgs.img_size(1-n,2(x/y))
%             imgs.comment{1-n}
%             imgs.trigger{1-n}
%             (imgs.RGBgain)
%
%
% Created:   : "2013-11-08 15:32:41 ban"
% Last Update: "2013-11-15 14:50:33 ban"

% check input variable
if nargin<1 || isempty(imgdbfile), help(mfilename()); imgs=[]; return; end
if nargin<2 || isempty(load_img_flg), load_img_flg=1; end

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

if ~strcmpi(imgdb.type,'monocular') && ~strcmpi(imgdb.type,'binocular') && ~strcmpi(imgdb.type,'matlab')
  error('imgdb.type should be one of ''monocular'', ''binocular'', or ''matlab''. check database file.');
end

% initialization
imgs.directory=imgdb.directory;
imgs.presentation_size=imgdb.presentation_size;
imgs.img=cell(imgdb.num,1);
imgs.img_size=0;
imgs.comment=cell(imgdb.num,1);
imgs.trigger=cell(imgdb.num,1);
if isstructmember(imgdb,'RGBgain'), imgs.RGBgain=imgdb.RGBgain; end

% set images
if strcmpi(imgdb.type,'monocular')

  imgs.img_size=zeros(imgdb.num,2);
  for ii=1:1:imgdb.num
    if load_img_flg
      imgs.img{ii}=imread(fullfile(imgs.directory,imgdb.img{ii}{1}));
      sz=size(imgs.img{ii}); if numel(sz)==3, sz=sz(1:2); end
      imgs.img_size(ii,:)=fliplr(sz);
    else
      imgs.img{ii}=fullfile(imgs.directory,imgdb.img{ii}{1});
      imgs.img_size(ii,:)=[256,256]; % dummy values
    end
    imgs.comment{ii}=imgdb.img{ii}{2};
    imgs.trigger{ii}=imgdb.img{ii}{3};
  end

elseif strcmpi(imgdb.type,'binocular')

  imgs.img=cell(imgdb.num,2); % update initialized variable
  imgs.img_size=zeros(2,imgdb.num,2);
  for ii=1:1:imgdb.num
    if load_img_flg
      imgs.img{ii,1}=imread(fullfile(imgs.directory,imgdb.img{ii}{1}));
      imgs.img{ii,2}=imread(fullfile(imgs.directory,imgdb.img{ii}{2}));
      sz=size(imgs.img{ii,1}); if numel(sz)==3, sz=sz(1:2); end
      imgs.img_size(1,ii,:)=fliplr(sz);
      sz=size(imgs.img{ii,2}); if numel(sz)==3, sz=sz(1:2); end
      imgs.img_size(2,ii,:)=fliplr(sz);
    else
      imgs.img{ii,1}=fullfile(imgs.directory,imgdb.img{ii}{1});
      imgs.img{ii,2}=fullfile(imgs.directory,imgdb.img{ii}{2});
      imgs.img_size(1,ii,:)=[256,256]; % dummy values
      imgs.img_size(2,ii,:)=[256,256]; % dummy values
    end
    imgs.comment{ii}=imgdb.img{ii}{3};
    imgs.trigger{ii}=imgdb.img{ii}{4};
  end

else % if strcmpi(imgdb.type,'matlab')

  cmcounter=0; trigcounter=0;
  for nn=1:1:length(imgdb.img)
    tmp=load(fullfile(imgs.directory,imgdb.img{nn}));
    imgs.img=tmp.img;

    if numel(size(imgs.img))==1 % monocular
      imgs.img_size=zeros(imgdb.num,2);
      for ii=1:1:imgdb.num
        sz=size(imgs.img{ii}); if numel(sz)==3, sz=sz(1:2); end
        imgs.img_size(ii,:)=fliplr(sz);
      end
    else % if numel(size(imgs.img))==2 % binocular
      imgs.img_size=zeros(2,imgdb.num,2);
      for ii=1:1:imgdb.num
        sz=size(imgs.img{ii,1}); if numel(sz)==3, sz=sz(1:2); end
        imgs.img_size(1,ii,:)=fliplr(sz);
        sz=size(imgs.img{ii,2}); if numel(sz)==3, sz=sz(1:2); end
        imgs.img_size(2,ii,:)=fliplr(sz);
      end
    end

    if isstructmember(tmp,'comment')
      imgs.comment=tmp.comment;
    else
      for ii=1:1:imgdb.num, cmcounter=cmcounter+1; imgs.comment{cmcounter}=''; end
    end
    if isstructmember(tmp,'trigger')
      imgs.trigger=tmp.trigger;
    else
      for ii=1:1:imgdb.num, trigcounter=trigcounter+1; imgs.trigger{trigcounter}=0; end
    end
  end

end % if strcmpi(imgdb.type,'monocular')

return
