function checkerboard=generate_checkerboard_images()

% constant parameters
rmin=0;
rmax=8.0;
width=30;
startangle=-90-width/2;
pix_per_deg=47;
nwedges=4;
nrings=8;
colors=[127,127,127;
        255,  0,  0;   0,255,  0;
        255,255,  0;   0,  0,255;
        255,255,255;   0,  0,  0;
          0,255,255; 255,  0,255;
        128,255,128; 255,128,255;];
phase=0;

% generate chckerboard images vertical
[checkerboard,mask,checkerID]=CreateCheckerBoard(rmin,rmax,width,startangle,pix_per_deg,nwedges,nrings,colors,phase);

% save the generated images
save_dir=fullfile(pwd,'images');
if ~exist(save_dir,'dir'), mkdir(save_dir); end
for ii=1:1:size(checkerboard,1)
  for jj=1:1:size(checkerboard,2)
    sz=size(checkerboard{ii,jj});
    checkerboard{ii,jj}(sz(1)/2+1:end,:,:)=flipdim(checkerboard{ii,jj}(1:sz(1)/2,:,:),1);
    imwrite(uint8(checkerboard{ii,jj}),fullfile(save_dir,sprintf('checkerboard_%02d_%02d.png',ii,jj)),'png');
  end
end

startangle=180-width/2;
% generate chckerboard images horizontal
[checkerboard,mask,checkerID]=CreateCheckerBoard(rmin,rmax,width,startangle,pix_per_deg,nwedges,nrings,colors,phase);

% save the generated images
save_dir=fullfile(pwd,'images');
if ~exist(save_dir,'dir'), mkdir(save_dir); end
for ii=1:1:size(checkerboard,1)
  for jj=1:1:size(checkerboard,2)
    sz=size(checkerboard{ii,jj});
    checkerboard{ii,jj}(:,sz(2)/2+1:end,:,:)=flipdim(checkerboard{ii,jj}(:,1:sz(2)/2,:),2);
    imwrite(uint8(checkerboard{ii,jj}),fullfile(save_dir,sprintf('checkerboard_%02d_%02d.png',ii+5,jj)),'png');
  end
end
