README for running demo scripts of ImagesShowPTB

Created    : "2013-11-18 16:28:34 ban (ban.hiroshi@gmail.com)"
Last Update: "2018-11-14 10:32:16 ban"

To test ImagesShowPTB.m, please go to ~/ImagesShowPTB/Presentation
Then, on the MATLAB shell, please run
>> run_exp('subj01',1); % LOC localzier example
>> run_exp('subj02',1); % the simplest example to show images successively
>> run_exp('subj03',1); % simple visual features (e.g. grating) images are presented successively
>> run_exp('subj04',1); % color/luminance flickering checkerboard vs rest
>> run_exp('subj05',1); % stereo image (binocular depth) presentation example
>> run_exp('subj06',1); % retinotopy stimuli example, contrasting checkerboards patterns along horizontal vs vertical meridians

For details (parameter setting etc.), please see ~/ImagesShowPTB/Presentation/subject/subj01/*.m
and a README file (~/ImagesShowPTB/doc/README_ja.txt).
