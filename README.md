# **README on ImagesShow**

<div align="right">
Created    : "2003-12-24 10:25:05 ban"<br>
Last Update: "2021-12-13 05:07:00 ban"
</div>

<br>
<div align="center">
<img src="https://img.shields.io/badge/LANGUAGE-MATLAB-brightgreen" />
<img src="https://img.shields.io/badge/DEPENDENCY-Psychtoolbox3-green" />
<img src="https://img.shields.io/badge/EDITED%20BY-EmEditor%20&%20VS%20Code-blue" />
<img src="https://img.shields.io/badge/LICENSE-BSD-red" /><br>
<img src="https://img.shields.io/badge/KEYWORDS-Vision%20Science,%203D,%20Stereo,%20Binocular,%20Perception,%20Receognition,%20fMRI,%20MEG,%20EEG,%20&%20Psychphysics-blue?style=social&logo=webauthn" /><br>
<img src="https://img.shields.io/badge/CONTACT-lightgrey" /> <img src="doc/images/ban_hiroshi_address.png" />
</div>
<br>

***

# <a name = "Menu"> **Menu** </a>

- [Introduction – what is ImagesShow ?](#Introduction)
- [System requirements](#System)
- [How to run ImagesShow](#Launch)
  - [Detailed descriptions of ImagesShowPTB.m](#Details)
  - [About protocolfile](#Protocolfile)
  - [About imgdbfile](#Imgdbfile)
  - [About viewfile](#Viewfile)
  - [About optionfile](#Optionfile)
  - [About log files](#Logfiles)
- [Acknowledgments](#Acknowledgments)
- [License](#License)
- [Citation](#Citation)
- [History](#History)
- [TODOs](#TODOs)


Japanese version of README.md is available from [here.](README_ja.md)  
日本語版 README.mdは[こちら](README_ja.md)  

***

# <a name = "Introduction"> **Introduction – what is ImagesShow ?** </a>

![ImagesShow](doc/images/00_ImagesShow.gif)  

**ImagesShow** is a ***MATLAB***-based **"Digital Kamishibai"** (Kamishibai, 紙芝居 in Japanese, means "picture-story show") package for visual stimulus presentations in psychophysics and neuroimaging studies. The ImagesShow package enables researchers to present/control visual stimuli flexibly with precise timing, by loading user-pre-defined parameters. Specifically, as a basic feature, the package loads multiple images onto memory and presents them in a pre-defined or random order with various options. The package is compatible with a variety of standard visual stimulus presentation protocols. To set these designs, researchers only have to prepare and adjust simple configuration files, such as image databases, presentation protocols, and presentation options carefully implemented to meat the conventional requirements and criteria of psychophysics and neuroimaging experiments. The package is also compatible with dual-display (stereo, binocular rivalry, and so on) as well as single-display setups.  

***The package is made publicly available in the hope of keeping our research group being transparent and open. Furthermore, the package is made open also for people who want to know our group's research activities, who want to join our group in the near future, and who want to learn how to create visual stimuli for vision science. Please feel free to contact us if you are interested in our research projects.***  

(Matlab is a registered trademark of [***The Mathworks Inc.*** ](https://www.mathworks.com/) )  

**[Key functions]**  

- **Pros**  
1. It especially suits psychophysics and neuroimaging experiments in which multiple images are sequentially and randomly presented with simultaneously recording participant responses, preferences, or cortical activity with fMRI/MEG techniques (e.g. object image perception experiments).  
2. It can be used for both block-paradigm and event-related-paradigm fMRI experiments. By properly customizing the configuration files, it can even replicate any stimulus presentation sequences of almost all the current vision-related fMRI experiments.  
3. It can handle images in all formats that can be loaded into MATLAB. The image data stored in MATLAB *.mat files can be also used as stimulus images seamlessly. With some small modifications, it is also possible to add your own image loading process.  
4. It is based on MATLAB Psychtoolbox, one of the de facto standard libraries in building vision science experiments. The customization will be thus easy for researchers. It is also easy to add some external functions to the ImagesShow pacakge and to export some functions to the other software packages.  
5. It provides a flexible option on selecting how to load images online. By properly selecting this option, it can handle experiments with tons of images on a PC with a limited amount of memory. Or you can put more weights on precise timing/duration of image presentations, without worrying about memory size, by selecting some other option. For details, please see the descriptions of "optionfile" below.  
6. It implements an important presentation option to compensate delays of the presentation periods strictly online by accumulating pieces of presentation periods from the beginning to the end (timing can be set by "msec" or "the number of frames of sync signals").  
7. It can provide flexible options of online modifications of image presentation sizes, positions, and masks etc on memory without overwriting the original images during the actual presentation. Therefore, even without sorting image formats out (e.g. converting image type from bmp/png to jpg or adjusting sizes/resolutions across images), all the input images of different formats can be handled without any errors once the image database and the image option files are properly configured.  
8. It can record almost all the events during the experiment into log files per run (MATLAB warnings/errors, Psychtoolbox warning/errors displayed on the MATLAB console, stimulus presentation timings, image types, and participant responses etc).  
9. It can get external triggers and synchronize the start of the presentation with external recording devices such as EEG, MEG, and eye trackers. Currently, simulated key/mouse inputs and monitoring parallel port's pin are available for this purpose. It also provide a function to present a punch rectangular stimulus on the corner of the display to get the actual stimulus onset via a photo-diode sensor.  

- **Cons**  
1. It can not change the stimulus orders and generate new stimulus images online based on participant responses (selections, preferences, etc), while some image randomization can be implemented. Therefore, the ImagesShow package does not suits for staircase-types of threshold measurements (a constant method is still applicable though). Future update is required.  
2. It has not been able to handle movie files such as *.mpeg and *.avi. We have to prepare multiple images and present them briefly and successively one by one, like flick books, to mimic some movie or motion stimuli.  

For more details, please read the descriptions below.  
Please also check the header comments in ~/ImagesShow/Presentation/ImagesShow.m.  

Thank you for using our software package.
We are happy if ImagesShow can help your research projects.

[back to the menu](#Menu)


# <a name = "System"> **System requirements** </a>

- **OS: Windows 7/8/10, Mac OSX, or Linux**  
  - note 1: Some of the codes (e.g. sound(beep)-related part) may be required to be modified if you are going to run the stimuli on a Linux box.  
  - note 2: To run ImagesShow on MacOS and Linux, some MEX (C/C++ codes) functions in ~/ImagesShow/Common are required to be re-compiled on your own system (please use ~/ImagesShow/Common/CompileMEXs.m).  

- **MATLAB R2009a** or later (We have tested the latest version with **R2020b**), **Psychtoolbox 3 (PTB3)** (for details, please see the [Acknowledgments](#Acknowledgments) section), and **Image Processing** toolbox.  
  - note: Psychtoolbox 3.0.15 or above is required. We have not tested the compatibility of ImagesShow with the former versions of PTB3 and PTB2.  

- **Graphics board**  
  - OpenGL-compatible graphics board is preferred rather than using built-in CPU graphics function.  

[back to the menu](#Menu)


# <a name = "Launch"> **How to run ImagesShowPTB** </a>

To run ImagesShow on MATLAB, you have two options below.  
1. Please call ***ImagesShowPTB*** function directly with specifying the input configuration files.  
   For more details, please see [Detailed descriptions of ImagesShow](#Details).  
2. Please make and call a wrapper function.  

The second option is recommended. For instance, please follow the commands below.  

```Matlab
>> cd ~/ImagesShow/Presentation
>> run_exp('name',acquisition_number,session_number);
```

Here, the function, ***run_exp*** (found as ~/ImagesShow/Presentation/run_exp.m), is a sample wrapper script to control the main ***ImagesShowPTB()*** function with semi-automatically setting participant-specific stimulus configuration parameters stored in ~/ImagesShow/Presentation/subjects/'name' directory. The input variable, 'name' should be a string that specifies the name (or ID) of the participant, acquisition_number and session_number should be integers, such as 1, 2, 3,... Here, two different IDs, acquisition_number and session_number, are prepared to flexibly differentiate, for instance, run 1-3 obtained in two difference days. In such a situation, we can set acquisition_number = 1,2,3 with session_number = 1 for the first day while session_number = 2 for the second day.

[back to the menu](#Menu)


# <a name = "Details"> **Detailed descriptions of ImagesShowPTB.m** </a>

````Matlab
ImagesShowPTB(subj,acq,session,protocolfile,imgdbfile,:viewfile,:optionfile,:gamma_table,:overwrite_flg)
(: is optional)
````

***About***  
**ImagesShow** --- A MATLAB-based "Digital Kamishibai" (Kamishibai, 紙芝居 in Japanese, means "picture-story show") package for flexible visual stimulus presentations in psychophysics and neuroimaging studies.  

***Input/output variables of ImagesShow.m***  

[Input variables]  
<pre>
subj         : name of subject, string, such as 's01', 'HB', 'hiroshi'
               you also need to create a directory ./subjects/(subj) and put 4 condition files there.

acq          : acquisition number. 1,2,3,...

session      : session (day) number. 1,2,3,...

protocolfile : protocol file in which experiment design is described.
               the file should be located in ./subjects/(subj)/
               You can define block- or event-related-design experiment using this file.
               For details, please see ../Generation/readExpProtocols.m

imgdbfile    : image data base file in which all the details of the images to be presented
               in the experiment are described with some options.
               the file should be located in ./subjects/(subj)/
               For details, please see ../Generation/readImageDatabase.m

viewfile     : (optional) viewing parameter file in which viewing distance etc are described.
               currently the contents of this file are preserved for future modifications,
               and have not used yet. However we should set this file to record experiment
               parameters in a file at one location for the later analyses.
               the file should be located in ./subjects/(subj)/
               For details, please see ../Generation/readViewingParameters.m

optionfile   : (optional) experiment/display option file with which you can customize display
               procedures of your experiment (e.g. putting phototrigger image, set ).
               the file should be located in ./subjects/(subj)/
               For details, please see ../Generation/readDisplayOptions.m

gamma_table  : (optional) table(s) of gamma-corrected video input values (Color LookupTable).
               256(8-bits) x 3(RGB) x 1(or 2,3,... when using multiple displays) matrix
               or a *.mat file specified with a relative path format. e.g. '/gamma_table/gamma1.mat'
               The *.mat should include a variable named "gamma_table" consists of a 256x3xN matrix.
               if you use multiple (more than 1) displays and set a 256x3x1 gamma-table, the same
               table will be applied to all displays. if the number of displays and gamma tables
               are different (e.g. you have 3 displays and 256x3x!2! gamma-tables), the last
               gamma_table will be applied to the second and third displays.
               if empty, normalized gamma table (repmat(linspace(0.0,1.0,256),3,1)) will be applied.

overwrite_flg: (optional) whether overwriting pre-existing result file. if 1, the previous results
               file with the same acquisition number will be overwritten by the previous one.
               if 0, the existing file will be backed-up by adding a prefix '_old' at the tail
               of the file. 0 by default.
</pre>

<pre>
NOTE 1: examples of configuration files.

The configuration files, protocolfiles, imgdbdile, viewfile, and optionfile should be located at
    ~/ImagesShow/Presentation/subjects/(subj_name)/
You can find some samples of these configuration files in
    ~/ImagesShow/Presentation/subjects/subj{01|02|03|04|05|06}
</pre>

<pre>
NOTE 2: global access to some of the variables defined in the configuration files.

A global variable extractor, ~/ImagesShowPTB/Generation/getGlobalParameters.m (function),
is prepared for accessing the contents of the parameters over configuration scripts.
With calling this function in your configuration script etc, you can access eight
global variables below,

    subj, acq, session, vparam, dparam, imgs, prt, imgs.

and you can control your configuration files more flexibly.
Please note that these global variables are read-only once set in the
configuration files, not allowed to be overwritten later from the script.
</pre>


[Output variable]  
no output variable.  

[Result files]  
All the results, including participant responses, performance, stimulus parameters etc will be stored as  
*~/ImagesShowPTB/Presentation/(subj)/results/(yymmdd(date))/(subj)_ImagesShowPTB_results_session_%02d_run_%02d.m* and  
*~/ImagesShowPTB/Presentation/(subj)/results/(yymmdd(date))/(subj)_ImagesShowPTB_results_session_%02d_run_%02d.log.*  
Please refer to these log files in confirming the validity of the presentationn protocols and in analyzing participant responses and reaction times.  

***Examples***  
To test ImagesShowPTB.m, please go to *~/ImagesShowPTB/Presentation*. Then, on the MATLAB shell, please run  

````MATLAB
>> run_exp('subj01',1); % LOC localzier example (presenting object images vs their mosaics).
>>                      % NOTE: I am sorry but the object images specified in this example
>>                      % are not stored in the GitHub repository due to license issue.
>>                      % So you can not test this sample. Instead, please check the
>>                      % configuration files in
>>                      % *~/ImagesShowPTB/Presentation/subjects/subj01*.
>>                      % The contents of these files will be useful to understand
>>                      % how the configuration files should be written and how the
>>                      % options work.
>> run_exp('subj02',1); % the simplest example to show images successively.
>> run_exp('subj03',1); % simple visual features (e.g. grating) are presented successively
>> run_exp('subj04',1); % color/luminance flickering checkerboard vs rest
>> run_exp('subj05',1); % stereo image (binocular depth) presentation example
>> run_exp('subj06',1); % meridional retinotopy stimuli example,
>>                      % checkerboards patterns along horizontal vs vertical meridians
>> % NOTE: If you prepare more images of some movements frame by frame, you can present
>> % motion stimuli, following an analogy of flick books.
````

Please also check the contents of ~/ImagesShowPTB/Presentation/subject/subj01/*.m to see how to set the parameters in details.  

[back to the menu](#Menu)


# <a name = "Protocolfile"> **About protocolfile** </a>

An example of the protocolfile: [protocolfile.m](doc/markdowns/protocolfile.md)  

[Detailed descriptions]

For setting the **protocolfile** paramters,  
1. Please make a fucntion that returns a cell structure called **"blocks{N}"** with members described below.  
2. Alternatively, you can directly set the **"blocks{N}"** cell structure in a MATLAB script (not function) file (**RECOMMENDED**).  
   Here, 1,2,3,...,N corresponds to each of the blocks in the current presentation protocol.  

The blocks{n} cell structure should have six members:  
<pre>
1. blocks{n}.randomization : whether randomizing the image presentation sequence
      (set in blocks{n}.sequence) of this block.
      0 = OFF (no randomization, images will be presented as they are set)
      1 = randomizing the image presentation order over the whole sequence.
      2 = randomizing the order of the even-numbered images.
      3 = randomizing the order of the odd-numbered images.
      4 = randomizing the order of the images in the first half of the sequence.
      5 = randomizing the order of the images in the second half of the sequence.
      6 = randomizing the order of the images from the second to the end-1.
      S1. if multiple numbers are set as a matrix (e.g. [2,4,6,8]), only the images
      corresponding to these specific numbers are randomized.
      S2. when a dual-display setup is used and a separate randomization between
      left- and right-eye images is required (e.g. binocular rivalry), please set
      two randomization values as a cell format for left- and right-eye images.
      if only one value is specified, the images will be randomized, with
      preserving the pair relationship between the two-eye images.

2. blocks{n}.sequence      : the order of the image presentation (sequence).
      for instance, if blocks{n}.sequence=[10 1 11 1 12 1 13 1 14 1 15 1 16 1],
      the images nubered 10-16 in the "imagedbfile" will be presented sequentially
      with alternating the image numbered 1. you can randomize the image presentation
      order per session by setting blocks{n}.randomization described above.
      if you specify a matrix of size 1xN for this matrix, one image is presented
      on one screen (single-display mode) or the same image is presented on each
      of the two screens / two eyes (dual-display mode). if a 2xN matrix is set
      together with a dual-display presentation mode (e.g. binocular stereo),
      individual images are separately presented for the left and right displays.
      if this sequence is set to 0, no image will be presented during that period,
      which can be used as a rest period in which only the uniform background is
      presented.

3. blocks{n}.msec (frame)  : presentation duration for each of images. a [1xN] matrix.
      if blocks{n}.msec is used, durations should be set in millisecond (msec).
      if blocks{n}.frame is used, the number of vertical sync signals should be used as
      a presentation duration unit. Just specifying either .msec or .frame is enough.
      when both are set in the script, the .frame contents take precedence.
      please carefully set the variable so that size(blocks{n}.sequence,2) is
      equal to size(blocks{n}.msec(frame),2). if the numbers of these two variable are
      different, ImagesShow returns an error message.
      in randomizing the image presentation order (please see blocks{n}.randomization
      and blocks{n}.sequence), the pair relationship between .sequence and .msec (.frame)
      will be kept as they are.

4. blocks{n}.slicing       : (optional, you can skip this value) minimum updating period.
      ImagesShowPTB will update the screen every blocks{n}.slicing period specified here.
      For example, if "blocks{n}.msec" is set to 500, the corresponding image will be
      shown for 500 ms, but the 500 ms presentation period will be divided into several
      sub-presentation periods according to the slicing value specified here, and the
      screen will be updated every sub-presentation period. specifically, when
      blocks{n}.slicing=100, 500 is divided into [100,100,100,100,100], and the screen is
      updated 5 times during the target blocks{n}.msec period. This is a necessary feature
      to assign tasks asynchronously with the screen updating time. here, please note
      that if the task duration is set as 250 ms in the optionfile, and the slicing is
      set to 100 ms, since the 250 ms cannot be divided by 100 ms, the task duration
      will be rounded off to 200 ms. similarly, fractions of .msec (frame) are either
      included in the previous sub-presentation time or incorporated as additional
      sub-presentation time, depending on their size (smaller or larger than half of the
      sub-presentation time). For example, if 550 ms is specified for .msec and .slicing
      is 100 ms, 550 ms is divided into [100,100,100,100,150]. When .msec is 590 ms and
      .slicing is 100 ms, 590ms will be divided as [100,100,100,100,100,90]. Please be
      careful in designing your protocols. if this value is omitted, a default value of
      100 is used when .msec is specified, and 6 is used when .frame is specified.

5. blocks{n}.repetitions   : (optional, you can skip this value) the number of
      repetitions of this block. please note that if the number of repetitions is set
      to two or more, and the block is randomized, each individually randomized block
      will be repeated multiple times. Namely, randomizing across repetitions is not
      performed. If you want to randomize image presentation order over repeated sequences,
      please describe sequence and msec(frame) multiple times without setting this
      repetition value, and then use the randomization option. the default value, 1
      (no repetition), is set if this option is skipped to be specified.

6. blocks{n}.name          : (optional, you can skip this value) a name of this block.
      if not specified, blocks{n}.name=sprintf('block %02d',n) is set by default.
</pre>

For accessing some global parameters from the configuration files, please see NOTE 2 in [Detailed descriptions of ImagesShow](#Details).  

[back to the menu](#Menu)


# <a name = "Imgdbfile"> **About imgdbfile** </a>

An example of the imgdbfile: [imgdbfile.m](doc/markdowns/imgdbfile.md)  

[Detailed descriptions]  

For setting the **imgdbfile** paramters,  
1. Please make a fucntion that returns a structure called **"imgdb"** with members described below.  
2. Alternatively, you can directly set the **"imgdb"** structure in a MATLAB script (not function) file (**RECOMMENDED**).  

The imgdb structure should have five members:  
<pre>
1. imgdb.type               : type of the images to be presented. 'image' or 'matlab'

2. imgdb.directory          : path to the directory that contains the image files. a full-path format.

3. imgdb.presentation_size  : image presentation size, [row,col].
      all the images will be resized to this parameter in presenting.
      if you don't want to resize, please set the raw image resolution.
      or if you want to present images of different resolutions as what they are,
      please set option.use_original_imgsize=1 in the optionfile.

4. imgdb.num                : the number of total images to be used in this experiment session.

5. imgdb.img                : a cell structure. each cell should have three members below,
      imgdb.img{n}={'filename of a target image', 'image description', 'trigger on/off'};
      here, 'filename of a target image' (string) should be set as a relative-path format
      whose origin is imgdb.directory. if the target images are stored just under the imgdb.directory,
      only setting file names is enough.
      for 'image description' (string), please set a simple description of the image, like 'face.'
      for 'trigger on/off' (an integer, like 0,1,2,3,...), please set 0 if you don't set any trigger
      for the image. if you set an integer other than 0 or set some character(s), it is assumed that
      a trigger is required to be sent in this image presentation period and some special processing
      is applied. The time stamp for the triggered stimulus is also recorded in the log file.
</pre>

For accessing some global parameters from the configuration files, please see NOTE 2 in [Detailed descriptions of ImagesShow](#Details).  

[back to the menu](#Menu)


# <a name = "Viewfile"> **About viewfile** </a>

An example of the viewfile: [viewfile.m](doc/markdowns/viewfile.md)  

[Detailed descriptions]  

For setting the **viewfile** paramters,  
1. Please make a fucntion that returns a structure called **"vparams"** with members described below.  
2. Alternatively, you can directly set the **"vparams"** structure in a MATLAB script (not function) file (**RECOMMENDED**).  

The vparams structure should have three members:  
<pre>
1. ipd        : inter pupil distance in centimeter. e.g. 6.4
2. pix_per_cm : pixels per centimeter.
3. vdist      : viewing distance in centimeter
</pre>

For accessing some global parameters from the configuration files, please see NOTE 2 in [Detailed descriptions of ImagesShow](#Details).  

[back to the menu](#Menu)


# <a name = "Optionfile"> **About optionfile** </a>

An example of the optionfile: [optionfile.m](doc/markdowns/optionfile.md)  

[Detailed descriptions]  

For setting the **optionfile** paramters,  
1. Please make a fucntion that returns a structure called **"options"** with members described below.  
2. Alternatively, you can directly set the **"options"** structure in a MATLAB script (not function) file (**RECOMMENDED**).  

The options structure should have 22 members (you don't need to set all the options; please only set what you need. the default values will be automatically applied if some (or all) of members are not specified.):  

<pre>
1. options.exp_mode             : presentation mode. 'mono' by default.
      mono = single display mode
      dual = dual display mode, can be used for binocular stereo or binocular rivalry studies.
      dualcross = another dual display mode,
                  for cross-viewing stereo display
      cross = cross-viewing stereo display mode,
              by subdividing a single display into left and right halves.
      parallel = parallel-viewing stereo display mode,
                 by subdividing a single display into left and right halves.
      dualparallel = dual display mode, parallel-viewing stereo using two (left/right-eye) displays.
      redgreen = red/green anaglyph mode. stereo viewing on a single display through red/green glasses.
      greenred = green/red anaglyph mode. stereo viewing on a single display through green/red glasses.
      redblue = red/cyan anaglyph mode. stereo viewing on a single display through red/cyan glasses.
      bluered = cyan/red anaglyph mode. stereo viewing on a single display through cyan/red glasses.
      shutter = time resolved stereo mode on a single display (~120 Hz refresh rate),
                by using shutter glasses (e.g. nVidia 3D Vision 2 Kit).
      topbottom = space resolved stereo mode. a single display is subdivided into upper and lower
                  parts for binocular presentation (upper is for left-eye).
      bottomtop = space resolved stereo mode. a single display is subdivided into upper and lower
                  parts for binocular presentation (lower is for left-eye).
      interleavedline = interrace binocular display mode, subdivision is applied along horizontal
                        lines of a single display. Specially adjusted glasses are required for
                        stereo viewing.
      interleavedcolumn = interrace binocular display mode, subdivision is applied along vertical
                          lines of a single display. Specially adjusted glasses are required for
                          stereo viewing.
      propixxmono = single display mode with the PROPixx DLP projector developed by VPIXX, Canada.
      propixxstereo = dual display mode with the PROPixx DLP projector developed by VPIXX, Canada,
                      and DepthQ circular polarized system. this mode will be especially useful for
                      for stereo or binocular rivalry stimulus presentations.

2. options.start_method         : stimulus presentation start method. 0 by default.
      0 = start by pressing ENTER or SPACE key.
      1 = start by left-mouse-click.
      2 = waiting for a trigger from an external device such as MRI.
          in this mode, keyboard input (a character) 't' is set as a default trigger signal.
      3 = waiting for a trigger from an external device such as MRI.
          in this mode, a rising signal at 11th pin of a parallel port is set as a default
          trigger signal and the status of that pin is monitored in starting the presentation.
      4 = a custom key trigger
          they key input set in options.custom_trigger is monitored and used for a trigger to
          start the stimulus presentation.

3. options.custom_trigger       : only effective when options.start_method=4.
      please set a trigger key for starting stimulus presentation.
      options.custom_trigger='s' by default.

4. options.keys                 : keys used for getting participant responses. the parameter
      should be set following the Psychtoolbox KeyCode() manner. For instance, if you want to
      use "A", you should set options.keys=KbName('A') (=65); you can set multiple key codes by
      providing a vector. options.keys=[37,39] by default.

5. options.window_size          : stimulus presentation window size, [row,col]. [768,1024] by default.

6. options.RGBgain              : Gains of RGB phosphors of the display(s). empty by default.
      the parameter may be useful in some binocular display mode such as red/cyan anaglyph.
      option.RGBgain should be set as a [2(left/right) x 3(RGB)] matrix. if this parameter is 0,
      RGBgain=[1.0,1.0,1.0;1.0,1.0,1.0]; (all gains are set to max) is applied for a single display
      mode. For binocular display modes, RGBgain will be adjusted differently depending on the
      display mode automatically (e.g. RG phosphors will be adjusted for redgreen mode).

7. options.fixation             : type of the fixation point. a cell structure with three members.
      options.fixation={fixation_type (an integer), size_in_pizels, colors(RGB,0-255)};
      here, fixation_type is one of
        0 = no fixation
        1 = cross-shaped fixation. recommended for applying the vernier task described in
            the task session.
        2 = circular fication.
        3 = concentrate fixation, that is reported to be able to get more stable and sustained.
            ref: Thaler et al., 2013. Vision Research, 76, 31-42.
                 https://www.sciencedirect.com/science/article/pii/S0042698912003380
      option.fixation={2,24,[255,255,255]}; by default.

8. options.background           : background image parameter, a cell structure with six members below.
      options.background={type(0:uniform、1:with rectangular patches for stereo-viewing stability),
                          background-color(RGB), the first color of the background patch (RGB),
                          the second color of the background patch (RGB),
                          the number of background patches along the display [row,col],
                          size of the background patch in pixels [row,col],
                          size of the stimulus window (aperture) on the center of the screen [row,col]};
      options.background={[127,127,127],[255,255,255],[0,0,0],[30,30],[20,20]}; by default.
      here, the sixth parameter (aperture size) is not generally required to explicitly set since it is
      automatically calculated by ImagesShowPTB internally.

9. options.cmask           : an option to apply a circular or rectangular mask on the presenting images.
      a cell structure with three members below.
      options.cmask={whether applying image mask (0: no mask, 1: circular, 2: rectangular),
                     size of the circular / rectangular mask in pixels [row,col],
                     parameters for applying gaussian smoothing along mask edge position [mean,sd]};
      if no smoothing is required, please set the mean = 0.
      options.cmask={0,[280,280],[20,20]}; by default.

10. options.auto_background      : this mode, if set, automatically obtains the color of the upper
      left [1,1] pixel of imgdb.img{1} described in the image database file (imgdbfile), and gives that
      color to options.background{1}. this is useful when you want to remove the border between the
      background and the presenting images. if you want to use this mode, specify 1.
      The default value is 0 (no auto-background).

11. options.use_fullscr          : if this parameter is set to non-zero value, ImagesShow ignores
      the image window size specified in the imgdbfile and always presents the image in full screen,
      regardless of the display resolution. The default value is 0.

12. option.skip_frame_sync_test  : if 1 is set, ImagesShow will skip display sync test.
      it is equivalent to Screen('Preference','SkipSyncTests',1); 0 by default.

13. option.force_frame_rate      : this parameter is for NOT letting Psychtoolbox3 get the frame rate
      of vertical synchronization, but fix the specific frame rate provided by this parameter.
      the default value is 0, which lets Psychtoolbox3 try to measure the frame rate. if a non-zero
      value is set (e.g. 60), the value is forced to be used in Psychtoolbox as the fixed frame rate.

14. options.use_frame            : this mode, if set, ignores the description of blocks{n}.msec
      specified in the "protocolfile" and rewrites it to blocks{n}.frame processing, forcing the
      presentation time to be controlled by the number of vertical synchronization signals.
      please set 1 if you want to use this mode. 0 by default.

15. options.use_original_imgsize : this mode, if set, ignores the presentation_size parameter set
      in the "imgdbfile" and presents the images in their original pixel sizes.
      please set 1 if you want to use this mode. 0 by default.

16. options.img_loading_mode     : this option specifies how to load imgdb.img defined in imgdbfile.
      1 = in this mode, only the paths of the images are kept, and when necessary, the images are
          loaded into memory one by one, and then the Psychtoolbox texture is generated and presented
          onto the screen also one by one. the texture memory is released each time after the stimulus
          presentation. this mode requires the least amount of memory among the three modes and
          enables to perform experiments with thousands of images. on the other hand, it takes
          additional time to load images one by one in the middle of the experiment, which may
          cause severe delays of presentation timing if your computer only has lower power CPU/GPU
          or slower speed hard disks. please be careful.
      2 = this mode loads all images at once into memory and creates Psychtoolbox textures one by one
          for presentation when necessary. after presentation, the images are deleted from memory.
          since the images are already loaded, this mode is faster than the first mode, but it
          requires more memory during the presentation.
      3 = in this mode, all images are loaded into memory at once, and all Psychtoolbox textures
          are also created at once. during presentation, only the textures that are already in memory
          are switched and presented, making this the fastest mode for image presentation.
          however, this mode requires the most memory of the three modes.
      options.img_loading_mode=2 by default. please try this default option first. if it
      does not work, trying the option 3 is recommended. or if you have tons of images to be presented,
      please try to use the option 1.

17. options.center : (shifted-)center of the image presentation display, [row,col] in pixels.
      options.center = [0,0]; (= no shift, the exact center of the display) by default.
      you can shift the image window by this option.

18. options.img_flip : flipping the images to be presented. this option is necessary to prevent image
      inversion when participant is required to observe the stimuli through a reflector, etc.
        0 = no flipping
        1 = left/right flipping
        2 = upside-down
        3 = left/right flipping and upside-down
      options.img_flip = 0 by default.

19. options.task  : whether adding a task during stimulus presentation. a cell structure.
      options.task={task mode, frequency, task duration};
      here, the first parameter, "task mode" can be selected from these five choices.
        0 = no task.
        1 = luminance change detection task on the central fixation point.
            if the fixation luminance changes darker, pressing a button.
        2 = vernier task, from Ban et al., 2012 Nature Neuroscience.
            in this task, a participant is required to judge whether the vertical bar presented
            in the vicinity of the gazing point (the central fixation) is to the left or right
            from the gazing center. the participant is asked to press options.keys(1) if judged
            as left; if right, the participant is asked to press options.keys(2).
            this task works properly in binocular-viewing mode (e.g. options.exp_mode='dual')
            when the gazing point is set to the cross-type option.fixation{1}=2.
        3 = character detection task. if "C" is presented on the central fixation, pressing a button.
        4 = 1-back memory task, pressing a button if the same images are presented twice successively.
            here, this option internally set the task only for odd-numbered images.
        5 = 1-back memory task, pressing a button if the same images are presented twice successively.
            here, this option internally set the task only for even-numbered images.
      the second parameter, task "frequency" should be an integer; if 1 is set, a task will be
      inserted every sub-presentation time set in options.task{3}, also taking into account the
      value set in blocks{n}.slicing in "protocolfile". while it depends on the purpose of the
      task, it would be generally sufficient to set a value around 3-5.
      the third parameter, "task duration" should be an integer multiple of blocks{n}.slicing
      and should be specified in msec or frame units. here, please note that if it is not divisible,
      the value will be rounded off. for example, when you set 250 ms as the task duration in
      the optionfile, and the slicing is set to 100 ms in the protocolfile, then, 250 ms can not
      be divided by 100 ms. In that case, the task duration will be rounded to 200 ms. Please be
      careful. The default value is options.task=[0,1,250];

20. options.block_rand           : whether randomizing the block order described in protocolfile.
      0 = OFF (no randomization, blocks will be presented as they are set)
      1 = randomizing the blocks over the whole sequence.
      2 = randomizing the order of the even-numbered blocks.
      3 = randomizing the order of the odd-numbered blocks.
      4 = randomizing the order of the blocks in the first half of the sequence.
      5 = randomizing the order of the blocks in the second half of the sequence.
      6 = randomizing the order of the blocks from the second to the end-1.
      here, if multiple numbers are set as a matrix (e.g. [2,4,6,8]), only the blocks
      corresponding to these specific numbers are randomized. 0 by default.

21. options.onset_punch  : this option presents a punch stimulus at the edge of the screen when 
      the trigger-ON image specified by imgdb.img{n}{3} parameter in imgdbfile is presented. this mode
      is useful for recording stimulus onsets accurately with using a photo-diode sensor in EEG/MEG
      experiments. The option is also useful for synchronizing some external devices with the stimulus
      onset. options.onset_punch is a [mode, pixel size of punch stimulus] matrix.
      options.onset_punch=[0,50]; by default.
      here, "mode" is one of
        0 = no punch stimulus
        1 = upper-left corner of the screen
        2 = upper-right corner
        3 = lower-left corner
        4 = lower-right corner

22. options.event_display_mode : this option determines what information will be displayed on the
      MATLAB console window during stimulus presentation.
        0 = simple mode. only the current block and stimulus image ID will be displayed.
        1 = full mode. events such as button pressing and stimulus types and triggers as well as
            the current block and stimulus image ID will be presented.
</pre>

For accessing some global parameters from the configuration files, please see NOTE 2 in [Detailed descriptions of ImagesShow](#Details).  

[back to the menu](#Menu)


# <a name = "Logfiles"> **About log files** </a>

Two types of logs described below will be recorded during the presentation.  

**1. Logs of the MATLAB console window**  

An example of the MATLAB console window log: [logfile.log](doc/markdowns/logfile.md)  

During the stimulus presentation, the outputs on the MATLAB console window are saved in  
*~/ImagesShowPTB/Presentation/(subj)/results/(yymmdd(date))/*,  
as a log (text) file, like  
*(subj)\_ImagesShowPTB_results_session_%02d_run_%02d.log*  

In this log file, MATLAB warnings/errors, Psychtoolbox diagnosis information, and stimulus presentation protocol etc will be recorded. Internally, the recordings are done very simply by using the MATLAB function, diary(). The logs will be appended to one file per acquisition ID and session ID ("acq" and "session" input variables of ImagesShow). By tracking the contents of this file, you can confirm whether the stimulus presentation is properly done without any delays, whether Psychtoolbox works without any errors, and so on.  

**2. Event logs -- presentation timing, stimulus type, stimulus trigger, and participant responses etc.**  

An example of the contents in the "event" cell: [eventlog.log](doc/markdowns/eventlog.md)  

During the stimulus presentation, the image presentation protocol, timing, presentation options, and participant responses will be stored in  
*~/ImagesShowPTB/Presentation/(subj)/results/(yymmdd(date))/*  
as a MAT file, like  
*(subj)\_ImagesShowPTB_results_session_%02d_run_%02d.mat*  

Here, if the "overwrite_flg" option of the ImagesShow function is set to 0, and if the target MAT file is already existing the participant directory (this may often the cases, if you run for instance the second run (acq=2) twice when the first run with acq=2 fails due to some MATLAB errors), the existing file will be renamed with a "\_old" suffix, like  
*(subj)\_ImagesShowPTB_results_session_%02d_run_%02d_old.mat*  
Then, You may be able to analyze data up to the stopped period by looking at the contents of the backup file. If you don't need such backups, please set overwrite_flg=1.  

In this MAT log file, nine variables below will be stored. The "event" variable is especially important for validating stimulus presentation timings and the latter analyses of participant responses.  

<pre>
1. subj        : subject name
2. acq         : acquisition number, 1,2,3.,,,
3. prt         : processed (e.g. order may be randomized if the option requests so) protocols,
                 defined as the "blocks{n}" stucture in protocolfile.m
4. vparam      : viewing parameters such as viewing distance, defined in viewfile.m
5. dparam      : option parameters, defined as the "options" structure in optionfile.m
6. task        : task type, task timing, task performance (correct/incorrect), reaction time
7. gamma_table : display gamma table used in the presentation. If the gamma_table input of
                 ImagesShow is empty, gamma_table=repmat(linspace(0.0,1.0,256),3,1); is used.
8. event       : event log in which start time, stimulus onset, participant responses and triggers
                 are stored. event{n}={event time (sec), event name, paramter/trigger};
9. imgs        : the "images" structure, defined in imgdbfile.m
</pre>

[back to the menu](#Menu)


# <a name = "Acknowledgments"> **Acknowledgments** </a>

The ImagesShow package uses **Psychtoolboox** library for generating/presenting/controlling stimuli described below. I would like to express our sincere gratitude to the authors for sharing the great toolbox.  

**Psychtoolbox** : The individual Psychtoolbox core developers,  
            (c) 1996-2011, David Brainard  
            (c) 1996-2007, Denis Pelli, Allen Ingling  
            (c) 2005-2011, Mario Kleiner  
            Individual major contributors:  
            (c) 2006       Richard F. Murray  
            (c) 2008-2011  Diederick C. Niehorster  
            (c) 2008-2011  Tobias Wolf  
            [ref] [http://psychtoolbox.org/HomePage](http://psychtoolbox.org/HomePage)  

**About the origin of the ImagesShow stimulus codes**  
The ***ImagesShow*** package consists of a series of modified versions of the stimulus presentation codes (termed "***PresentImage***" at that time) originally developed by Dr Hiroki Yamamoto @ Kyoto University with Tcl/Tk programming language and Visualization Toolkit (VTK. Kitware, Inc.) on Sun Microsystems Solaris and SGI Irix boxes. I leant a lot on how to make visual stimuli and how to run vision experiments especially from him. Then, the package was fully revised by me with C/C++ so as to be compatible with MS Windows on the recent standard PCs. Furthermore, the package had been fully re-written by me with MATLAB and Psychtoolbox for simplicity, also adding many new functions including stereo displaying modes, when I had been working at University of Birmingham, UK, under supervisions of Dr Andrew Welchman and Dr Zoe Kourtzi. Because of these backgrounds, I can not help but express my big grtitude to them here. The package would never be publicly avaialbe in the current form without their kind and selfless supports.  

[back to the menu](#Menu)


# <a name = "License"> **License** </a>

<img src="https://img.shields.io/badge/LICENSE-BSD-red" /><br>

ImagesShow --- A MATLAB-based "Digital Kamishibai" (Kamishibai, 紙芝居 in Japanese, means "picture-story show") package for flexible visual stimulus presentations in psychophysics and neuroimaging studies. Copyright (c) 2021, Hiroshi Ban. All rights reserved.  

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in
      the documentation and/or other materials provided with the distribution

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.  

The views and conclusions contained in the software and documentation are those of the authors and should not be interpreted as representing official policies, either expressed or implied, of the FreeBSD Project.  
[back to the menu](#Menu)


# <a name = "Citation"> **Citation of ImagesShow** </a>

If you have some space in your reference section, please cite this GitHub repository like,  

**ImagesShow toolbox: https://github.com/hiroshiban/ImagesShow**  
**by Hiroshi Ban**  

If you have no space, please cite it somewhere someday next time. Thank you so much.  

[back to the menu](#Menu)


# <a name = "History"> **History** </a>

<pre>
The original ImagesShow (written by Tcl/Tk, PresentImage.tcl)
                                           1999 H.Yamamoto
The original PresentImage.cpp  Cxx version on UNX (Solari and IRIX)
                                           2002 H.Yamamoto
Cxx Class Version (compatible with WinOS)  Dec. 24 2003 H.Ban
Interaction with CONTEC digital IO         Dec. 24 2003 H.Ban
Cxx Class Version with a fixation point    Dec. 25 2003 H.Ban
time.h --> multimedia timer                Jan. 20 2004 H.Ban
High Performance Animation                 Jan. 24 2004 H.Ban
Dynamic Storage Allocation                 Jan. 24 2004 H.Ban
timer initialize using Win32API            Jan. 25 2004 H.Ban
PresentImages -> ImagesShow                Mar. 06 2005 H.Ban
Images' Sequences Randomization            Mar. 06 2005 H.Ban
Full Screen Mode                           Mar. 10 2005 H.Ban
Interaction with Keyence KV Controller     Mar. 11 2005 H.Ban
vtk3.2 -> vtk4.2 -> vtk4.2 static library  Mar. 12 2005 H.Ban
Render Window Border Off                   Mar. 12 2005 H.Ban
reading *.jpg, *.png, *.tiff format images Mar. 14 2005 H.Ban
Start Mouse R button on Render Window Mode Mar. 14 2005 H.Ban
reading *.pnm format images                Mar. 15 2005 H.Ban
input file format changes                  Mar. 16 2005 H.Ban
ViewPort (xmin, ymin, xmax, ymax) -> IMAGE-CENTER (x,y)
                                           Mar. 16 2005 H.Ban
Interact with Interface General Pulse Counter (GPC)
                                           Mar. 16 2007 H.Ban
Log file (PresentedLog*.txt)               Mar. 16 2005 H.Ban
Log file (KVSwitchLog*.txt)                Mar. 16 2005 H.Ban
Implicit Rendering                         July 05 2007 H.Ban
rotate images along x&y axes               July 05 2007 H.Ban
compiler VC++6.0 -> VC.NET2003             July 07 2007 H.Ban
vtk4.2 -> vtk5.0.3 static library          July 07 2007 H.Ban
hide cursor within the render window       July 07 2007 H.Ban
R mouse button start -> L mouse button     July 07 2007 H.Ban
ImagesShow.exe icon renewal                July 08 2007 H.Ban
Image Resize (smaller/larger) by bilinear interpolation
                                           July 09 2007 H.Ban
condition files & stimuli for identifying FFA, PPA, & EBA
                                           July 09 2007 H.Ban
real-time presentation delay correction during the rest period(s)
                                           July 14 2007 H.Ban
NEW version: Interact with Interface General Pulse Counter
                                           July 16 2007 H.Ban
New version: Log file (GPCSwitchTriggerLog*.txt)
                                           July 16 2007 H.Ban
New version: ImageDatabase structure       July 17 2007 H.Ban
diplaying "punch" rectangle to notice stimulus presentation onset
                                           July 17 2007 H.Ban
Presentation synchronizing with Display Vertical Sync Signal(s) using GPC
                                           July 19 2007 H.Ban
vtk5.0.3 -> vtk5.0.4                       June 05 2009 H.Ban
compiler VC++.NET 2003 -> VC++.NET 2005    June 05 2009 H.Ban
add Matlab_imageprocessing 22 scripts      June 05 2009 H.Ban
vtk5.0.4 -> vtk5.4.2                       June 05 2009 H.Ban
vtk5.4.2 compiled with boost C++ 1.38 library
                                           July 26 2009 H.Ban
RunTEST with CONTEC, KV, GPC I/O           July 26 2009 H.Ban
Change Press RETURN(ENTER) Start Method
start on the console ---> on the render window
                                           July 26 2009 H.Ban
send stimulus trigger to CONTEC digital I/O
                                           July 26 2009 H.Ban
The final version of ImagesShow C++ was released
                                           July 27 2009 H.Ban
The first version of ImageShow Psychtoolbox was released
The internal procedures have been fully revised from the scratch
Lots of new fancy functions such as binocular displays are available
                                           Nov  15 2013 H.Ban
Add character detection task               Nov  18 2013 H.Ban
separate parameter settings for left/right-eye images
                                           Nov  21 2013 H.Ban
some bug fixes, save more memory in storing PTB textures
                                           Nov  23 2013 H.Ban
Bug fixes, the final version 1.0 was released
                                           Nov  25 2013 H.Ban
Made the source code clean and shorter by changing variable structures
                                           Nov  28 2013 H.Ban
Add a circular aperture mask option        Nov  29 2013 H.Ban
Modified so that the script can handle prt{ii}.sequence = 0 as no input/Display
                                           July 13 2015 H.Ban
Add a parameter, session, to discriminate experiments in different runs etc.
                                           July 14 2015 H.Ban
Change the attribute of the parameters -- subj, acq, session,
vparam, dparam, imgs, prt, and imgs -- as the global variables.
The modification is danger and will never be recommended for the
function independence and safety. But I decided to take this
modification because I thought the users will have more benefits
by this change as we can generate more powerful and flexible
configuration files if the users can access to some global
parameters. Please be careful in use. To get global variable
value(s), please use getGlobalParameters function in
~/ImagesShowPTB/Generation.
                                           July 14 2015 H.Ban
Add a rectangular aperture mask option     July 14 2015 H.Ban
Add an option to skip frame sync test      Aug  29 2016 H.Ban
Add an option to use a specific frame rate Aug  29 2016 H.Ban
Add an option to use an uniform background Aug  29 2016 H.Ban
MATLAB function, as well as script, forms of protocolfile,
imgdbfile,viewfile, and optionfile can be accepted.
You can use more flexible parameter settings.
                                           Aug  29 2016 H.Ban
Add an option to select the way of displaying stimulus
presentation details from "simple" or "details" mode.
                                           Oct  23 2016 H.Ban
Updated so that ImagesShowPTB can work with VPIXX PROPixx Projector
                                           June 03 2021 H.Ban
Add an option to select display ID         June 03 2021 H.Ban
Add a new type of fixation point           Dec  01 2021 H.Ban
</pre>

[back to the menu](#Menu)

# <a name = "TODOs"> **TODOs** </a>

0. Re-writing with Python etc...  
1. Compiling the codes with MATLAB compiler so that ImagesShow can be run without MATLAB.  
2. Adding an opiton to handle movie files (e.g. *.avi and *.mp4) as well as static images.  
3. *DONE* Adding some image mask options.  
4. *DONE* Start by TTL trigger etc.  
5. *DONE* Binocular stereo display modes with stereo shutter goggles or polarized glasses.  
6. *DONE* Compatible with dual display modes.  
7. *DONE* Online (real-time) corections of delays of stimulus presentation timing.  
8. *DONE* Adding an option to present rectangle(s) on the corner(s) of the display for a photo-trigger input in EEG/MEG studies.  

[back to the menu](#Menu)
