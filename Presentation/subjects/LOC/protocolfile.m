% a sample of protocolfile
% for details, please see readExpProtocols.m

% blocks{1}.randomization=0; % 0:OFF, 1:ALL, 2:Even seq. only, 3:Odd seq. only, 4:first half seq. only, 5:last half seq. only.
%                            % 6:2-N-1 blocks are randomized whereas the first and the last sequences are fixed.
%                            % or "matrix":randomize specific sequences you set. e.g. blocks{n}.randomization=1:3:ceil(N/2);
%                            % a scalar (for monocular) or 2x1 cell structure (for binocular display with left/right separate settings).
% blocks{1}.sequence=[7 5 1 2 3 4 6 5 1 2 3 4 6 5 1 2 3 4 6 7]; % image numbers to be used, 1xN (monocular) or 2xN (binocular) vector
% blocks{1}.msec=[500 200 100 200 100 200 100 200 100 200 100 200 100 200 100 200 100 200 100 500]; % display duration in msec of each image
% blocks{1}.slicing=100 (or blocks{2}.slicing=2); % (optional) minimum time slice in presentation (required to display task correctly),
%                                                 % if not specified, 6(frames) or 100(msec) are used by default
%                                                 % by using this variable as an unit, blocks{n}.sequence will be divided to subsequence
%                                                 % for example, if blocks{1}.msec=[500,500,500]; and blocks{1}.slicing=100;,
%                                                 % then blocks{1}.subduration=[100*ones(1,500/100),100*ones(1,500/100),100*ones(1,500/100)];
%                                                 % will be generated. Each residual of the duration is added to the final element or
%                                                 % separately added as the last+1 element.
% blocks{1}.repetitions=1; % the number of repetitions of this block
% blocks{1}.name='images 1'; % (optional) name of the conditions, empty if not specified
% ...
%
% [NOTE: about blocks{n}.randomization and blocks{n}.sequence]
% When you present stimuli with a monocular display, please just set one randomization parameter and one sequence [1xN].
% For binocualr displays (option.exp_mode='dual', 'cross', etc.), you can chose two options below.
% 1. if you set one randomization paramater (a scalar, e.g. 0) and one sequence (e.g. [1xN] matrix), these parameters will
%    be applied to both left/right image sequences.
% 2. when you additionally give the second variables, you can set randomization modes and sequences of left/right-eye
%    protocols separately. For example, if you set blocks{n}.randomization as a 2x1 "cell" structure (e.g. {0,1}), the
%    first one will be applied to the "left" eye image sequence while the second one will be applied to the "right" eye
%    image sequence. Two sequences will thus be randomized and initialized separately.
% Along with these choices, if you set blocks{n}.sequence as a 1xN vector, the same sequence will be applied to both
% left/right image presentations when you select one of the binocular display modes (e.g. cross-view) in optionfile.
% In contrast, if you set blocks{n}.sequence as a 2xN matrix, the first (blocks{n}.sequence(1,:)) will be used to present
% "left" eye images, while the second (blocks{n}.sequence(2,:)) will be used to present "right" eye images.
% Also note that you can set these parameters independently. Specifically, you can set like
% blocks{n}.randomization=0;
% blocks{n}.sequence=(2xN matrix);
% Then, the same randomization parameter (0) will be applied to both sequences. Please be careful.

blocks{1}.randomization=0;
blocks{1}.sequence=1;
blocks{1}.msec=16000;
blocks{1}.slicing=250;
blocks{1}.repetitions=1;
blocks{1}.name='Fixation 1';

blocks{2}.randomization=3;
blocks{2}.sequence=[1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0]+1;
blocks{2}.msec=[500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300];
blocks{2}.slicing=250;
blocks{2}.repetitions=1;
blocks{2}.name='Building';

blocks{3}.randomization=3;
blocks{3}.sequence=[161 0 162 0 163 0 164 0 165 0 166 0 167 0 168 0 169 0 170 0 171 0 172 0 173 0 174 0 175 0 176 0 177 0 178 0 179 0 180 0]+1;
blocks{3}.msec=[500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300];
blocks{3}.slicing=250;
blocks{3}.repetitions=1;
blocks{3}.name='HandMosaics';

blocks{4}.randomization=3;
blocks{4}.sequence=[21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 35 0 36 0 37 0 38 0 39 0 40 0]+1;
blocks{4}.msec=[500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300];
blocks{4}.slicing=250;
blocks{4}.repetitions=1;
blocks{4}.name='Faces';

blocks{5}.randomization=3;
blocks{5}.sequence=[181 0 182 0 183 0 184 0 185 0 186 0 187 0 188 0 189 0 190 0 191 0 192 0 193 0 194 0 195 0 196 0 197 0 198 0 199 0 200 0]+1;
blocks{5}.msec=[500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300];
blocks{5}.slicing=250;
blocks{5}.repetitions=1;
blocks{5}.name='ObjectMosaics';

blocks{6}.randomization=0;
blocks{6}.sequence=1;
blocks{6}.msec=16000;
blocks{6}.slicing=250;
blocks{6}.repetitions=1;
blocks{6}.name='Fixation 2';

blocks{7}.randomization=3;
blocks{7}.sequence=[201 0 202 0 203 0 204 0 205 0 206 0 207 0 208 0 209 0 210 0 211 0 212 0 213 0 214 0 215 0 216 0 217 0 218 0 219 0 220 0]+1;
blocks{7}.msec=[500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300];
blocks{7}.slicing=250;
blocks{7}.repetitions=1;
blocks{7}.name='FaceMosaics';

blocks{8}.randomization=3;
blocks{8}.sequence=[41 0 42 0 43 0 44 0 45 0 46 0 47 0 48 0 49 0 50 0 51 0 52 0 53 0 54 0 55 0 56 0 57 0 58 0 59 0 60 0]+1;
blocks{8}.msec=[500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300];
blocks{8}.slicing=250;
blocks{8}.repetitions=1;
blocks{8}.name='Hands';

blocks{9}.randomization=3;
blocks{9}.sequence=[221 0 222 0 223 0 224 0 225 0 226 0 227 0 228 0 229 0 230 0 231 0 232 0 233 0 234 0 235 0 236 0 237 0 238 0 239 0 240 0]+1;
blocks{9}.msec=[500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300];
blocks{9}.slicing=250;
blocks{9}.repetitions=1;
blocks{9}.name='BuildingMosaics 1';

blocks{10}.randomization=3;
blocks{10}.sequence=[61 0 62 0 63 0 64 0 65 0 66 0 67 0 68 0 69 0 70 0 71 0 72 0 73 0 74 0 75 0 76 0 77 0 78 0 79 0 80 0]+1;
blocks{10}.msec=[500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300];
blocks{10}.slicing=250;
blocks{10}.repetitions=1;
blocks{10}.name='Objects 1';

blocks{11}.randomization=0;
blocks{11}.sequence=1;
blocks{11}.msec=16000;
blocks{11}.slicing=250;
blocks{11}.repetitions=1;
blocks{11}.name='Fixation 3';

blocks{12}.randomization=3;
blocks{12}.sequence=[81 0 82 0 83 0 84 0 85 0 86 0 87 0 88 0 89 0 90 0 91 0 92 0 93 0 94 0 95 0 96 0 97 0 98 0 99 0 100 0]+1;
blocks{12}.msec=[500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300];
blocks{12}.slicing=250;
blocks{12}.repetitions=1;
blocks{12}.name='Objects 2';

blocks{13}.randomization=3;
blocks{13}.sequence=[241 0 242 0 243 0 244 0 245 0 246 0 247 0 248 0 249 0 250 0 251 0 252 0 253 0 254 0 255 0 256 0 257 0 258 0 259 0 260 0]+1;
blocks{13}.msec=[500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300];
blocks{13}.slicing=250;
blocks{13}.repetitions=1;
blocks{13}.name='BuildingMosaics 2';

blocks{14}.randomization=3;
blocks{14}.sequence=[101 0 102 0 103 0 104 0 105 0 106 0 107 0 108 0 109 0 110 0 111 0 112 0 113 0 114 0 115 0 116 0 117 0 118 0 119 0 120 0]+1;
blocks{14}.msec=[500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300];
blocks{14}.slicing=250;
blocks{14}.repetitions=1;
blocks{14}.name='Hands';

blocks{15}.randomization=3;
blocks{15}.sequence=[261 0 262 0 263 0 264 0 265 0 266 0 267 0 268 0 269 0 270 0 271 0 272 0 273 0 274 0 275 0 276 0 277 0 278 0 279 0 280 0]+1;
blocks{15}.msec=[500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300];
blocks{15}.slicing=250;
blocks{15}.repetitions=1;
blocks{15}.name='FaceMosaics';

blocks{16}.randomization=0;
blocks{16}.sequence=1;
blocks{16}.msec=16000;
blocks{16}.slicing=250;
blocks{16}.repetitions=1;
blocks{16}.name='Fixation 4';

blocks{17}.randomization=3;
blocks{17}.sequence=[281 0 282 0 283 0 284 0 285 0 286 0 287 0 288 0 289 0 290 0 291 0 292 0 293 0 294 0 295 0 296 0 297 0 298 0 299 0 300 0]+1;
blocks{17}.msec=[500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300];
blocks{17}.slicing=250;
blocks{17}.repetitions=1;
blocks{17}.name='ObjectMosaics';

blocks{18}.randomization=3;
blocks{18}.sequence=[121 0 122 0 123 0 124 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 134 0 135 0 136 0 137 0 138 0 139 0 140 0]+1;
blocks{18}.msec=[500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300];
blocks{18}.slicing=250;
blocks{18}.repetitions=1;
blocks{18}.name='Faces';

blocks{19}.randomization=3;
blocks{19}.sequence=[301 0 302 0 303 0 304 0 305 0 306 0 307 0 308 0 309 0 310 0 311 0 312 0 313 0 314 0 315 0 316 0 317 0 318 0 319 0 320 0]+1;
blocks{19}.msec=[500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300];
blocks{19}.slicing=250;
blocks{19}.repetitions=1;
blocks{19}.name='HandMosaics';

blocks{20}.randomization=3;
blocks{20}.sequence=[141 0 142 0 143 0 144 0 145 0 146 0 147 0 148 0 149 0 150 0 151 0 152 0 153 0 154 0 155 0 156 0 157 0 158 0 159 0 160 0]+1;
blocks{20}.msec=[500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300 500 300];
blocks{20}.slicing=250;
blocks{20}.repetitions=1;
blocks{20}.name='Buildings';

blocks{21}.randomization=0;
blocks{21}.sequence=1;
blocks{21}.msec=16000;
blocks{21}.slicing=250;
blocks{21}.repetitions=1;
blocks{21}.name='Fixation 5';
