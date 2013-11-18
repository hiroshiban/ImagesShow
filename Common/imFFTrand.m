function [img,fnames]=imFFTrand(tgt_dir,amp_shuffle_ratio,phase_shuffle_ratio,img_ext,img_inc_prefix,img_exc_prefix,display_flg,save_flg,randseed_flg)

% function [img,fnames]=imFFTrand(tgt_dir,amp_shuffle_ratio,phase_shuffle_ratio,...
%                                 :img_ext,:img_inc_prefix,:img_exc_prefix,:display_flg,:save_flg,:randseed_flg)
% (: is optional)
%
% This function reads grayscale images and randomize their amplitudes and/or phases in Fourier domain.
%
% [input]
% tgt_dir        : target directory that includes images you want to process.
%                  should set with a relative path format, e.g. tgt_dir='../images/image01';
% amp_shuffle    : whether shuffling amplitudes of the images in Fourier domain, [0|1]. 0 by default.
% phase_shuffle  : whether shuffling phases of the images in Fourier domain, [0|1]. 0 by default.
% img_ext        : image file extension(s), cell structure or string. '.jpg' by default
% img_inc_prefix : image file prefix(s) that is to be included in processing,
%                  cell structure or string, '*' by default.
% img_exc_prefix : image file prefix(s) that is to be excluded from processing,
%                  cell structure or string, empty by default.
% display_flg    : whether displaying the converted image [0|1]. 0 by default.
% save_flg       : whether saving the converted image [0|1]. 0 by default.
% randseed_flg   : whether initializing random seed, [0|1]. 1 by default.
%
% [output]
% img            : converted Fourier-phase/power randomized images, cell structure
% fnames         : the corresponding file names that are converted.
%
%
% Created    : "2013-11-13 15:36:11 ban"
% Last Update: "2013-11-14 17:01:45 ban"

% check input variables
if nargin<1 || isempty(tgt_dir), help(mfilename()); return; end
if nargin<2 || isempty(amp_shuffle_ratio), amp_shuffle_ratio=1; end
if nargin<3 || isempty(phase_shuffle_ratio), phase_shuffle_ratio=1; end
if nargin<4 || isempty(img_ext), img_ext='.jpg'; end
if nargin<5 || isempty(img_inc_prefix), img_inc_prefix='*'; end
if nargin<6 || isempty(img_exc_prefix), img_exc_prefix=''; end
if nargin<7 || isempty(display_flg), display_flg=0; end
if nargin<8 || isempty(save_flg), save_flg=0; end
if nargin<9 || isempty(randseed_flg), randseed_flg=1; end

if ~iscell(img_ext), img_ext={img_ext}; end
if ~iscell(img_inc_prefix), img_inc_prefix={img_inc_prefix}; end
if ~iscell(img_exc_prefix), img_exc_prefix={img_exc_prefix}; end

if save_flg, save_prefix='_fftrand'; end

% set prefix correctly
for ii=1:1:length(img_ext)
  if ~strcmp(img_ext{ii}(1),'.'), img_ext{ii}=['.',img_ext{ii}]; end
end

% check target directory
tgt_dir=fullfile(pwd,tgt_dir);
if ~exist(tgt_dir,'dir'), error('can not find taget directory. check input variable.'); end

% initialize random seed
if randseed_flg, InitializeRandomSeed(); end

fprintf('target: %s\n',tgt_dir);

% get image files
fprintf('converting images...');
img=''; fnames=''; img_counter=0;
dcr=1; % for preserving DC component of the image
for ii=1:1:length(img_ext)
  for jj=1:1:length(img_inc_prefix)
    tmpfnames=wildcardsearch(tgt_dir,[img_inc_prefix{jj},img_ext{ii}]);
    for kk=1:1:length(tmpfnames)

      % check whether the target image is excluded from processing
      exc_flg=0;
      for mm=1:1:length(img_exc_prefix)
        if ~isempty(img_exc_prefix{mm}) && strfind(tmpfnames{kk},img_exc_prefix{mm}), exc_flg=1; break; end
      end
      if exc_flg, continue; end

      % FFT and amp/phase randomization
      timg=imread(tmpfnames{kk});
      if numel(size(timg))~=3 % if the target is not a RGB image
        img_counter=img_counter+1;

        %% 2D FFT
        fftimg=fft2(double(timg));
        fftimg=fftshift(fftimg); % set DC component to the center, point symmetric
                                 % preserve DC component to recover image mean intensity later
        sz=ceil(size(fftimg)./2);
        DC=fftimg(sz(1)-dcr:sz(1)+dcr,sz(2)-dcr:sz(2)+dcr);

        %% phase shuffling
        phase=angle(fftimg);
        tidx=randperm(numel(fftimg));
        idx1=tidx(1:round(numel(tidx)*phase_shuffle_ratio));
        idx2=sort(idx1,'ascend');
        phase(idx2)=phase(idx1);

        %% amplitude shuffling
        amp=abs(fftimg);
        tidx=randperm(numel(fftimg));
        idx1=tidx(1:round(numel(tidx)*amp_shuffle_ratio));
        idx2=sort(idx1,'ascend');
        amp(idx2)=amp(idx1);

        %% recreate FFT map
        fftimg=complex(amp.*cos(phase),amp.*sin(phase));
        % recover DC component
        fftimg(sz(1)-dcr:sz(1)+dcr,sz(2)-dcr:sz(2)+dcr)=DC;
        % inverse FFT
        img{img_counter}=uint8(ifft2(ifftshift(fftimg))); % reset FFT map to raw format
        fnames{img_counter}=tmpfnames{kk};
      else
        [dummy,fname,ext]=fileparts(tmpfnames{kk});
        fprintf('\nimage:%s%s is RGB image. skipping.\n',fname,ext);
        clear dummy fname ext;
      end % if numel(size(img{img_counter}))~=3

    end
  end
end
disp('done.');

% displaying
if display_flg
  fprintf('displaying the converted images...');
  for ii=1:1:length(img)
    figure;
    imshow(img{ii});
  end
  disp('done.');
end

% saving the images
if save_flg
  fprintf('saving the converted images...')
  for ii=1:1:length(img)
    [save_path,save_name,save_ext]=fileparts(fnames{ii});
    imwrite(img{ii},fullfile(save_path,[save_name,save_prefix,save_ext]),strrep(save_ext,'.',''));
  end
  disp('done.');
end

return
