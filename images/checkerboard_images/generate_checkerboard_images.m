function checkerboard=generate_checkerboard_images()

% constant parameters
rmin=0.5;
rmax=8.0;
width=360;
startangle=0;
pix_per_deg=47;
nwedges=24;
nrings=8;
colors=[127,127,127;
        255,  0,  0;   0,255,  0;
        255,255,  0;   0,  0,255;
        255,255,255;   0,  0,  0;
          0,255,255; 255,  0,255;
        128,255,128; 255,128,255;];
phase=0;

% generate chckerboard images
[checkerboard,mask,checkerID]=CreateCheckerBoard(rmin,rmax,width,startangle,pix_per_deg,nwedges,nrings,colors,phase);

% save the generated images
save_dir=fullfile(pwd,'checkerboard_images');
if ~exist(save_dir,'dir'), mkdir(save_dir); end
for ii=1:1:size(checkerboard,1)
  for jj=1:1:size(checkerboard,2)
    imwrite(uint8(checkerboard{ii,jj}),fullfile(save_dir,sprintf('checkerboard_%02d_%02d.png',ii,jj)),'png');
  end
end

imwrite(uint8(colors(1,1)*ones(size(checkerboard{1,1}))),fullfile(save_dir,'background.png'),'png');
