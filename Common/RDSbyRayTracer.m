function [imgL,imgR]=RDSbyRayTracer(heightfield,dotDens,imgNum,...
                                    colors,ipd,vdist,pix_per_cm,oversampling_ratio,display_flag,save_flag)

% function [imgL,imgR]=RDSbyRayTracer(heightfield,dotDens,imgNum,...
%                                     ipd,vdist,pix_per_cm,oversampling_ratio,display_flag,save_flag)
%
% Generate left/right Random Dot (2 colors) Stereogram (RDS) Images based on heightfield.
% This function takes 'image distortion problem' and 'Hidden Surface Problem' (HSP) into account.
% Therefore, the generated images are finest, but slower than 'RDSbyOvalFinest'
% The generated images are the same size with heightfield image.
% The procedure to generate RDS images are as below.
%    1. create random dot image
%    2. 3D rotation (affine transformation) of dot image along y-axis so that the left(or right)
%       plane is orthogonal to the viewing sight from left(or right) the the central fixation point.
%    3. add disparity to the dots and generate left/right-eye images
%
% [input]
% heightfield : height field to generate RDS, [row,col]
%               *NOTICE* the unit of the height should be cm
% dotDens     : density of the random dots, [percent(1-100,integer)]
% imgNum      : the number of images to be generated, [num]
% colors      : dot/background colors, [0-255(dot1),0-255(dot2),0-255(background)]
% ipd         : distance between left/right pupils, [cm]
% vdist       : visual distance from screen to eyes, [cm]
% pix_per_cm  : pixels per cm
% oversampling_ratio : if above 1, oversampling of heightfield & disparity position
%                      is conducted. [val](default,1)
% display_flag: if 1, the generated images will be displayed, [0/1]
% save_flag   : if 1, the generated images will be saved as RDS_imgs.mat, [0/1]
%
% [output]
% imgL        : generated image(s) for left eye, cells [row,col]
% imgR        : generated image(s) for right eye, cells [row,col]
% 
% [example]
% field=CreateExpField([480,480],3,1);
% [imgL,imgR]=RDSbyRayTracer(field,0.05,3,1,[255,0,128],6.4,50,57,1,0);
%
% Created: "2010-04-03 14:05:21 ban"
% Last Update: "2010-06-23 18:17:15 ban"

%% --- input variable check
if nargin<1, help RDSbyRayTracer; return; end
if nargin<2 || isempty(dotDens), dotDens=10; end
if nargin<3 || isempty(imgNum), imgNum=1; end
if nargin<4 || isempty(colors), colors=[255,0,128]; end
if nargin<5 || isempty(ipd), ipd=6.4; end
if nargin<6 || isempty(vdist), vdist=65; end
if nargin<7 || isempty(pix_per_cm), 
  % cm per pix
  % 1 inch = 2.54 cm, my PC's display is 1920x1200, 15.4 inch.
  % So, 15.4(inch)*2.54(cm) / sqrt(1920^2+1200^2) (pix) = XXX cm/pixel
  cm_per_pix=15.4*2.54/sqrt(1920^2+1200^2);
  pix_per_cm=1/cm_per_pix;
end
if nargin<8 || isempty(oversampling_ratio), oversampling_ratio=1; end
if nargin<9 || isempty(display_flag), display_flag=0; end
if nargin<10 || isempty(save_flag), save_flag=0; end

if numel(colors)~=3
  error('RDSbyRayTracer requires 3 grayscales(0-255) [dot1,dot2,background]. Check input variable.');
end

% adjust parameters for oversampling
if oversampling_ratio~=1
  heightfield=imresize(heightfield,oversampling_ratio,'bilinear');
  dotDens=dotDens/oversampling_ratio;
  ipd=ipd*oversampling_ratio;
  vdist=vdist*oversampling_ratio;
  pix_per_cm=pix_per_cm*oversampling_ratio;
end

%% --- initalize random seed
%InitializeRandomSeed;

heightfield=-1*heightfield; % since RayTrace_ScreenPos_X assumes the near position is minus value.

%% --- calculate pixel shifts of the input heightfield when it is seen from left or right eye
% [note]
% After this procedure, the position (i,j) in heightfield will
% correspond to ( coordsL(i,j,2), coordsL(i,j,1) ) & ( coordsR(i,j,2), coordsR(i,j,1) )

% rotation matrix (affine transformation) along y-axis as to orthogonal to the left/right view sight
RotMatL=makehgtform('yrotate',atan(ipd/2/vdist));
RotMatR=makehgtform('yrotate',-atan(ipd/2/vdist));

% set xy coordinates as the origin is the center of the heightfield
% note, mod(size(heightfield,{1|2}),2) is always 0 in this function
X=repmat( ( (1:1:size(heightfield,2)) -0.5-size(heightfield,2)/2 )./pix_per_cm, size(heightfield,1), 1 );
Y=repmat( ( (1:1:size(heightfield,1))'-0.5-size(heightfield,1)/2 )./pix_per_cm, 1, size(heightfield,2) );

% matrix rotation calculate position from left or right eye
coordsL=RotMatL*[X(:)';Y(:)';heightfield(:)';ones(1,size(heightfield,1)*size(heightfield,2))];
coordsR=RotMatR*[X(:)';Y(:)';heightfield(:)';ones(1,size(heightfield,1)*size(heightfield,2))];

% reshape the coords matrix as to match heightfield{L|R}
coordsL=reshape(coordsL',[size(heightfield),4]);
coordsR=reshape(coordsR',[size(heightfield),4]);

% put back xy coordinates as the origin is the upper left corner of the heightfield{L|R}
coordsL(:,:,1)=round( coordsL(:,:,1).*pix_per_cm+0.5+size(heightfield,1)/2 ); % x-axis
coordsL(:,:,2)=round( coordsL(:,:,2).*pix_per_cm+0.5+size(heightfield,2)/2 ); % y-axis
coordsR(:,:,1)=round( coordsR(:,:,1).*pix_per_cm+0.5+size(heightfield,1)/2 );
coordsR(:,:,2)=round( coordsR(:,:,2).*pix_per_cm+0.5+size(heightfield,2)/2 );

coordsL(:,:,3)=round(coordsL(:,:,3));
coordsR(:,:,3)=round(coordsR(:,:,3));

% generate new heightfield maps that will be seen from left/rigth eye
heightfieldL=coordsL(:,:,3);
heightfieldR=coordsR(:,:,3);

% sort Lcoords & Rcoords
% this process is important to put dots on the image, starting from distant surface to
% nearby one. It automatically prevents the generated images from 'hidden surface removal problem'
depthL=sort(unique(coordsL(:,:,3)),'ascend')'; depthL=depthL(~isnan(depthL));
depthR=sort(unique(coordsR(:,:,3)),'ascend')'; depthR=depthR(~isnan(depthR));

%% --- initializing of output image cell arrays
imgL=cell(imgNum,1);
imgR=cell(imgNum,1);
for n=1:1:imgNum
  imgL{n}=colors(3)*ones(size(heightfield));
  imgR{n}=colors(3)*ones(size(heightfield));
end

%% --- generate RDS images
for n=1:1:imgNum

  % create initial random dot image
  randXY=randi(round(oversampling_ratio*100/dotDens),size(heightfield));
  randXY(randXY~=round(oversampling_ratio*100/dotDens))=0;
  randXY(logical(randXY))=1;
  randXY(randXY==0)=NaN; % background;
  
  % set 2 colors
  [row,col]=find(randXY==1);
  for ii=1:1:size(row,1)
    if mod(randi(2),2)
      randXY(row(ii),col(ii))=colors(1); % dot1;
    else
      randXY(row(ii),col(ii))=colors(2); % dot2;
    end
  end
  
  %% left image(s)
  tmp=colors(3)*ones(size(randXY));
  for depth=depthL % depthL is already unique & sorted, so processed from near surface to far
    didx=find(heightfieldL==depth); % get indeces of the current depth surface;
    if ~isempty(didx)
      [drow,dcol]=ind2sub(size(heightfieldL),didx); % convert to sub indeces;
      for ii=1:1:size(drow,1)
        
        % if you do not want to fill the 'hole' of the image use the codes below 
        if 1<=coordsL(drow(ii),dcol(ii),1) && coordsL(drow(ii),dcol(ii),1)<=size(tmp,2)
            tmp(coordsL(drow(ii),dcol(ii),2),coordsL(drow(ii),dcol(ii),1))=randXY(drow(ii),dcol(ii));
        end
        
        % if you want to fill the 'hole' of the image use the codes below 
        %if coordsL(drow(ii),dcol(ii),1)<1
        %  tmp(coordsL(drow(ii),dcol(ii),2),coordsL(drow(ii),dcol(ii),1)+size(tmp,2))=idXY(drow(ii),dcol(ii));
        %elseif size(tmp,2)<coordsL(drow(ii),dcol(ii),1)
        %  tmp(coordsL(drow(ii),dcol(ii),2),coordsL(drow(ii),dcol(ii),1)-size(tmp,2))=idXY(drow(ii),dcol(ii));
        %else
        %  tmp(coordsL(drow(ii),dcol(ii),2),coordsL(drow(ii),dcol(ii),1))=idXY(drow(ii),dcol(ii));
        %end
        
      end
    end
  end
  imgL{n}=tmp;
  imgL{n}(isnan(imgL{n}))=colors(3);
      
  %% right image(s)
  tmp=colors(3)*ones(size(randXY));
  for depth=depthR % depthR is already unique & sorted, so processed from near surface to far
    didx=find(heightfieldR==depth); % get indeces of the current depth surface;
    if ~isempty(didx)
      [drow,dcol]=ind2sub(size(heightfieldR),didx); % convert to sub indeces;
      for ii=1:1:size(drow,1)
        
        % if you do not want to fill the 'hole' of the image use the codes below 
        if 1<=coordsR(drow(ii),dcol(ii),1) && coordsR(drow(ii),dcol(ii),1)<=size(tmp,2)
            tmp(coordsR(drow(ii),dcol(ii),2),coordsR(drow(ii),dcol(ii),1))=randXY(drow(ii),dcol(ii));
        end
        
        % if you want to fill the 'hole' of the image use the codes below 
        %if coordsR(drow(ii),dcol(ii),1)<1
        %  tmp(coordsR(drow(ii),dcol(ii),2),coordsR(drow(ii),dcol(ii),1)+size(tmp,2))=idXY(drow(ii),dcol(ii));
        %elseif size(tmp,2)<coordsR(drow(ii),dcol(ii),1)
        %  tmp(coordsR(drow(ii),dcol(ii),2),coordsR(drow(ii),dcol(ii),1)-size(tmp,2))=idXY(drow(ii),dcol(ii));
        %else
        %  tmp(coordsR(drow(ii),dcol(ii),2),coordsR(drow(ii),dcol(ii),1))=idXY(drow(ii),dcol(ii));
        %end
        
      end
    end
  end
  imgR{n}=tmp;
  imgR{n}(isnan(imgR{n}))=colors(3);
  
  % adjust oversampled image to the original size
  if oversampling_ratio~=1
    imgL{n}=imresize(uint8(imgL{n}),1/oversampling_ratio,'bilinear');
    imgR{n}=imresize(uint8(imgR{n}),1/oversampling_ratio,'bilinear');
  else
    imgL{n}=uint8(imgL{n});
    imgR{n}=uint8(imgR{n});
  end
  
end % for n=1:1:imgNum

% --- plot the results
if display_flag
  figure; hold on;
  for n=1:1:imgNum
    M = [imgL{n} 127*ones(size(imgL{n},1),20) imgR{n} 127*ones(size(imgL{n},1),20) imgL{n}];
    im_h = imagesc(M,[0 255]);
    axis off
    % truesize is necessary to avoid automatic scaling
    size_one2one(im_h);
    colormap(gray);
    shg;
  end
end

% --- save the results
if save_flag
  save RDSbyRayTracer.mat imgL imgR heightfield heightfieldL heightfieldR;
end

return;
