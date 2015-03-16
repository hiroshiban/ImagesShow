function [imgL,imgR]=generate_depth_plane_images()

% some constants
outer_fieldSize=12;
inner_fieldSize=8;
fine_coefficient=1;
% dotSize=5;      % pixels
dotRadius=0.05; % cm
dotDens=3;
bgcolor=127;

pix_per_deg=45;
ipd=6.4;
vdist=50;

cm_per_pix=15.4*2.54/sqrt(1920^2+1200^2); % 15.4 inch 1920 x 1200 display
pix_per_cm=1/cm_per_pix;

save_dir=fullfile(pwd,'depth_plane_images');
if ~exist(save_dir,'dir'), mkdir(save_dir); end

inner_height=-6:0.5:6;

% % generate the base white/black dots
% basedot=double(MakeFineOval(dotSize,[255,0,0],bgcolor,1.2,2,1,0,0));
% wdot=basedot(:,:,1);     % get only gray scale image (white)
% bdot=basedot(:,:,2);     % get only gray scale image (black)
% dotalpha=basedot(:,:,4)./max(max(basedot(:,:,4))); % get alpha channel value 0-1.0;
%
% % generating RDS images
% for ii=1:1:numel(inner_height)
%   field=CreateRectField(outer_fieldSize,inner_fieldSize,inner_height(ii),pix_per_deg,fine_coefficient);
%
%   [posL,posR]=RayTrace_ScreenPos_X_MEX(field,ipd,vdist,pix_per_cm,0);
%   [imgL,imgR]=RDSbyOvalFastest(posL,posR,wdot,bdot,dotalpha,dotDens,bgcolor);
%
%   imwrite(uint8(imgL{1}),fullfile(save_dir,sprintf('plane_%02d_L.png',ii)),'png');
%   imwrite(uint8(imgR{1}),fullfile(save_dir,sprintf('plane_%02d_R.png',ii)),'png');
% end

% generating RDS images
for ii=1:1:numel(inner_height)
  field=CreateRectField(outer_fieldSize,inner_fieldSize,inner_height(ii),pix_per_deg,fine_coefficient);

  [imgL,imgR]=RDSbyOval(field,dotRadius,dotDens,1,[255,0,128],ipd,vdist,pix_per_cm,1,0,0);

  imwrite(uint8(imgL{1}),fullfile(save_dir,sprintf('plane_%02d_L.png',ii)),'png');
  imwrite(uint8(imgR{1}),fullfile(save_dir,sprintf('plane_%02d_R.png',ii)),'png');
end

imwrite(uint8(bgcolor*ones(size(imgL{1}))),fullfile(save_dir,'background.png'),'png');
