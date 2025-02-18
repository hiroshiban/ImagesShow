% a sample of image database file
% for details, please see readImageDatabase.m

% an example of image database for monocular display
imgdb.type='image'; % database type, 'image' (image file) or 'matlab'(matlab .mat file).
imgdb.directory=fullfile(fileparts(mfilename('fullpath')),'..','..','..','images','object_images'); % full path to the image files
imgdb.presentation_size=[320,320]; % this is not the actual image size, all the images will be adjusted based on this value.
imgdb.num=321; % the total number of images

imgdb.img{1}={'background.jpg','Background',0}; % {'file_name','comment','trigger(a scalar, 0(off),1(on),2,3..., a vector [1,2,3](on), or 'string')}

imgdb.img{2}={'/Building/Buildings_0001.jpg','Buildings',0};
imgdb.img{3}={'/Building/Buildings_0002.jpg','Buildings',0};
imgdb.img{4}={'/Building/Buildings_0003.jpg','Buildings',0};
imgdb.img{5}={'/Building/Buildings_0004.jpg','Buildings',0};
imgdb.img{6}={'/Building/Buildings_0005.jpg','Buildings',0};
imgdb.img{7}={'/Building/Buildings_0006.jpg','Buildings',0};
imgdb.img{8}={'/Building/Buildings_0007.jpg','Buildings',0};
imgdb.img{9}={'/Building/Buildings_0008.jpg','Buildings',0};
imgdb.img{10}={'/Building/Buildings_0009.jpg','Buildings',0};
imgdb.img{11}={'/Building/Buildings_0010.jpg','Buildings',0};
imgdb.img{12}={'/Building/Buildings_0011.jpg','Buildings',0};
imgdb.img{13}={'/Building/Buildings_0012.jpg','Buildings',0};
imgdb.img{14}={'/Building/Buildings_0013.jpg','Buildings',0};
imgdb.img{15}={'/Building/Buildings_0014.jpg','Buildings',0};
imgdb.img{16}={'/Building/Buildings_0015.jpg','Buildings',0};
imgdb.img{17}={'/Building/Buildings_0016.jpg','Buildings',0};
imgdb.img{18}={'/Building/Buildings_0017.jpg','Buildings',0};
imgdb.img{19}={'/Building/Buildings_0018.jpg','Buildings',0};
imgdb.img{20}={'/Building/Buildings_0019.jpg','Buildings',0};
imgdb.img{21}={'/Building/Buildings_0020.jpg','Buildings',0};

imgdb.img{22}={'/Face/Faces_0001.jpg','Faces',1};
imgdb.img{23}={'/Face/Faces_0002.jpg','Faces',1};
imgdb.img{24}={'/Face/Faces_0003.jpg','Faces',1};
imgdb.img{25}={'/Face/Faces_0004.jpg','Faces',1};
imgdb.img{26}={'/Face/Faces_0005.jpg','Faces',1};
imgdb.img{27}={'/Face/Faces_0006.jpg','Faces',1};
imgdb.img{28}={'/Face/Faces_0007.jpg','Faces',1};
imgdb.img{29}={'/Face/Faces_0008.jpg','Faces',1};
imgdb.img{30}={'/Face/Faces_0009.jpg','Faces',1};
imgdb.img{31}={'/Face/Faces_0010.jpg','Faces',1};
imgdb.img{32}={'/Face/Faces_0011.jpg','Faces',1};
imgdb.img{33}={'/Face/Faces_0012.jpg','Faces',1};
imgdb.img{34}={'/Face/Faces_0013.jpg','Faces',1};
imgdb.img{35}={'/Face/Faces_0014.jpg','Faces',1};
imgdb.img{36}={'/Face/Faces_0015.jpg','Faces',1};
imgdb.img{37}={'/Face/Faces_0016.jpg','Faces',1};
imgdb.img{38}={'/Face/Faces_0017.jpg','Faces',1};
imgdb.img{39}={'/Face/Faces_0018.jpg','Faces',1};
imgdb.img{40}={'/Face/Faces_0019.jpg','Faces',1};
imgdb.img{41}={'/Face/Faces_0020.jpg','Faces',1};

imgdb.img{42}={'/Hand/Hands_0001.jpg','Hands',0};
imgdb.img{43}={'/Hand/Hands_0002.jpg','Hands',0};
imgdb.img{44}={'/Hand/Hands_0003.jpg','Hands',0};
imgdb.img{45}={'/Hand/Hands_0004.jpg','Hands',0};
imgdb.img{46}={'/Hand/Hands_0005.jpg','Hands',0};
imgdb.img{47}={'/Hand/Hands_0006.jpg','Hands',0};
imgdb.img{48}={'/Hand/Hands_0007.jpg','Hands',0};
imgdb.img{49}={'/Hand/Hands_0008.jpg','Hands',0};
imgdb.img{50}={'/Hand/Hands_0009.jpg','Hands',0};
imgdb.img{51}={'/Hand/Hands_0010.jpg','Hands',0};
imgdb.img{52}={'/Hand/Hands_0011.jpg','Hands',0};
imgdb.img{53}={'/Hand/Hands_0012.jpg','Hands',0};
imgdb.img{54}={'/Hand/Hands_0013.jpg','Hands',0};
imgdb.img{55}={'/Hand/Hands_0014.jpg','Hands',0};
imgdb.img{56}={'/Hand/Hands_0015.jpg','Hands',0};
imgdb.img{57}={'/Hand/Hands_0016.jpg','Hands',0};
imgdb.img{58}={'/Hand/Hands_0017.jpg','Hands',0};
imgdb.img{59}={'/Hand/Hands_0018.jpg','Hands',0};
imgdb.img{60}={'/Hand/Hands_0019.jpg','Hands',0};
imgdb.img{61}={'/Hand/Hands_0020.jpg','Hands',0};

imgdb.img{62}={'/Object/Objects_0001.jpg','Objects',0};
imgdb.img{63}={'/Object/Objects_0002.jpg','Objects',0};
imgdb.img{64}={'/Object/Objects_0003.jpg','Objects',0};
imgdb.img{65}={'/Object/Objects_0004.jpg','Objects',0};
imgdb.img{66}={'/Object/Objects_0005.jpg','Objects',0};
imgdb.img{67}={'/Object/Objects_0006.jpg','Objects',0};
imgdb.img{68}={'/Object/Objects_0007.jpg','Objects',0};
imgdb.img{69}={'/Object/Objects_0008.jpg','Objects',0};
imgdb.img{70}={'/Object/Objects_0009.jpg','Objects',0};
imgdb.img{71}={'/Object/Objects_0010.jpg','Objects',0};
imgdb.img{72}={'/Object/Objects_0011.jpg','Objects',0};
imgdb.img{73}={'/Object/Objects_0012.jpg','Objects',0};
imgdb.img{74}={'/Object/Objects_0013.jpg','Objects',0};
imgdb.img{75}={'/Object/Objects_0014.jpg','Objects',0};
imgdb.img{76}={'/Object/Objects_0015.jpg','Objects',0};
imgdb.img{77}={'/Object/Objects_0016.jpg','Objects',0};
imgdb.img{78}={'/Object/Objects_0017.jpg','Objects',0};
imgdb.img{79}={'/Object/Objects_0018.jpg','Objects',0};
imgdb.img{80}={'/Object/Objects_0019.jpg','Objects',0};
imgdb.img{81}={'/Object/Objects_0020.jpg','Objects',0};

imgdb.img{82}={'/Object/Objects_0021.jpg','Objects',0};
imgdb.img{83}={'/Object/Objects_0022.jpg','Objects',0};
imgdb.img{84}={'/Object/Objects_0023.jpg','Objects',0};
imgdb.img{85}={'/Object/Objects_0024.jpg','Objects',0};
imgdb.img{86}={'/Object/Objects_0025.jpg','Objects',0};
imgdb.img{87}={'/Object/Objects_0026.jpg','Objects',0};
imgdb.img{88}={'/Object/Objects_0027.jpg','Objects',0};
imgdb.img{89}={'/Object/Objects_0028.jpg','Objects',0};
imgdb.img{90}={'/Object/Objects_0029.jpg','Objects',0};
imgdb.img{91}={'/Object/Objects_0030.jpg','Objects',0};
imgdb.img{92}={'/Object/Objects_0031.jpg','Objects',0};
imgdb.img{93}={'/Object/Objects_0032.jpg','Objects',0};
imgdb.img{94}={'/Object/Objects_0033.jpg','Objects',0};
imgdb.img{95}={'/Object/Objects_0034.jpg','Objects',0};
imgdb.img{96}={'/Object/Objects_0035.jpg','Objects',0};
imgdb.img{97}={'/Object/Objects_0036.jpg','Objects',0};
imgdb.img{98}={'/Object/Objects_0037.jpg','Objects',0};
imgdb.img{99}={'/Object/Objects_0038.jpg','Objects',0};
imgdb.img{100}={'/Object/Objects_0039.jpg','Objects',0};
imgdb.img{101}={'/Object/Objects_0040.jpg','Objects',0};

imgdb.img{102}={'/Hand/Hands_0021.jpg','Hands',0};
imgdb.img{103}={'/Hand/Hands_0022.jpg','Hands',0};
imgdb.img{104}={'/Hand/Hands_0023.jpg','Hands',0};
imgdb.img{105}={'/Hand/Hands_0024.jpg','Hands',0};
imgdb.img{106}={'/Hand/Hands_0025.jpg','Hands',0};
imgdb.img{107}={'/Hand/Hands_0026.jpg','Hands',0};
imgdb.img{108}={'/Hand/Hands_0027.jpg','Hands',0};
imgdb.img{109}={'/Hand/Hands_0028.jpg','Hands',0};
imgdb.img{110}={'/Hand/Hands_0029.jpg','Hands',0};
imgdb.img{111}={'/Hand/Hands_0030.jpg','Hands',0};
imgdb.img{112}={'/Hand/Hands_0031.jpg','Hands',0};
imgdb.img{113}={'/Hand/Hands_0032.jpg','Hands',0};
imgdb.img{114}={'/Hand/Hands_0033.jpg','Hands',0};
imgdb.img{115}={'/Hand/Hands_0034.jpg','Hands',0};
imgdb.img{116}={'/Hand/Hands_0035.jpg','Hands',0};
imgdb.img{117}={'/Hand/Hands_0036.jpg','Hands',0};
imgdb.img{118}={'/Hand/Hands_0037.jpg','Hands',0};
imgdb.img{119}={'/Hand/Hands_0038.jpg','Hands',0};
imgdb.img{120}={'/Hand/Hands_0039.jpg','Hands',0};
imgdb.img{121}={'/Hand/Hands_0040.jpg','Hands',0};

imgdb.img{122}={'/Face/Faces_0021.jpg','Faces',1};
imgdb.img{123}={'/Face/Faces_0022.jpg','Faces',1};
imgdb.img{124}={'/Face/Faces_0023.jpg','Faces',1};
imgdb.img{125}={'/Face/Faces_0024.jpg','Faces',1};
imgdb.img{126}={'/Face/Faces_0025.jpg','Faces',1};
imgdb.img{127}={'/Face/Faces_0026.jpg','Faces',1};
imgdb.img{128}={'/Face/Faces_0027.jpg','Faces',1};
imgdb.img{129}={'/Face/Faces_0028.jpg','Faces',1};
imgdb.img{130}={'/Face/Faces_0029.jpg','Faces',1};
imgdb.img{131}={'/Face/Faces_0030.jpg','Faces',1};
imgdb.img{132}={'/Face/Faces_0031.jpg','Faces',1};
imgdb.img{133}={'/Face/Faces_0032.jpg','Faces',1};
imgdb.img{134}={'/Face/Faces_0033.jpg','Faces',1};
imgdb.img{135}={'/Face/Faces_0034.jpg','Faces',1};
imgdb.img{136}={'/Face/Faces_0035.jpg','Faces',1};
imgdb.img{137}={'/Face/Faces_0036.jpg','Faces',1};
imgdb.img{138}={'/Face/Faces_0037.jpg','Faces',1};
imgdb.img{139}={'/Face/Faces_0038.jpg','Faces',1};
imgdb.img{140}={'/Face/Faces_0039.jpg','Faces',1};
imgdb.img{141}={'/Face/Faces_0040.jpg','Faces',1};

imgdb.img{142}={'/Building/Buildings_0021.jpg','Buildings',0};
imgdb.img{143}={'/Building/Buildings_0022.jpg','Buildings',0};
imgdb.img{144}={'/Building/Buildings_0023.jpg','Buildings',0};
imgdb.img{145}={'/Building/Buildings_0024.jpg','Buildings',0};
imgdb.img{146}={'/Building/Buildings_0025.jpg','Buildings',0};
imgdb.img{147}={'/Building/Buildings_0026.jpg','Buildings',0};
imgdb.img{148}={'/Building/Buildings_0027.jpg','Buildings',0};
imgdb.img{149}={'/Building/Buildings_0028.jpg','Buildings',0};
imgdb.img{150}={'/Building/Buildings_0029.jpg','Buildings',0};
imgdb.img{151}={'/Building/Buildings_0030.jpg','Buildings',0};
imgdb.img{152}={'/Building/Buildings_0031.jpg','Buildings',0};
imgdb.img{153}={'/Building/Buildings_0032.jpg','Buildings',0};
imgdb.img{154}={'/Building/Buildings_0033.jpg','Buildings',0};
imgdb.img{155}={'/Building/Buildings_0034.jpg','Buildings',0};
imgdb.img{156}={'/Building/Buildings_0035.jpg','Buildings',0};
imgdb.img{157}={'/Building/Buildings_0036.jpg','Buildings',0};
imgdb.img{158}={'/Building/Buildings_0037.jpg','Buildings',0};
imgdb.img{159}={'/Building/Buildings_0038.jpg','Buildings',0};
imgdb.img{160}={'/Building/Buildings_0039.jpg','Buildings',0};
imgdb.img{161}={'/Building/Buildings_0040.jpg','Buildings',0};

imgdb.img{162}={'/HandMosaic/Hands_0001.jpg','Hands',0};
imgdb.img{163}={'/HandMosaic/Hands_0002.jpg','Hands',0};
imgdb.img{164}={'/HandMosaic/Hands_0003.jpg','Hands',0};
imgdb.img{165}={'/HandMosaic/Hands_0004.jpg','Hands',0};
imgdb.img{166}={'/HandMosaic/Hands_0005.jpg','Hands',0};
imgdb.img{167}={'/HandMosaic/Hands_0006.jpg','Hands',0};
imgdb.img{168}={'/HandMosaic/Hands_0007.jpg','Hands',0};
imgdb.img{169}={'/HandMosaic/Hands_0008.jpg','Hands',0};
imgdb.img{170}={'/HandMosaic/Hands_0009.jpg','Hands',0};
imgdb.img{171}={'/HandMosaic/Hands_0010.jpg','Hands',0};
imgdb.img{172}={'/HandMosaic/Hands_0011.jpg','Hands',0};
imgdb.img{173}={'/HandMosaic/Hands_0012.jpg','Hands',0};
imgdb.img{174}={'/HandMosaic/Hands_0013.jpg','Hands',0};
imgdb.img{175}={'/HandMosaic/Hands_0014.jpg','Hands',0};
imgdb.img{176}={'/HandMosaic/Hands_0015.jpg','Hands',0};
imgdb.img{177}={'/HandMosaic/Hands_0016.jpg','Hands',0};
imgdb.img{178}={'/HandMosaic/Hands_0017.jpg','Hands',0};
imgdb.img{179}={'/HandMosaic/Hands_0018.jpg','Hands',0};
imgdb.img{180}={'/HandMosaic/Hands_0019.jpg','Hands',0};
imgdb.img{181}={'/HandMosaic/Hands_0020.jpg','Hands',0};

imgdb.img{182}={'/ObjectMosaic/Objects_0001.jpg','Objects',0};
imgdb.img{183}={'/ObjectMosaic/Objects_0002.jpg','Objects',0};
imgdb.img{184}={'/ObjectMosaic/Objects_0003.jpg','Objects',0};
imgdb.img{185}={'/ObjectMosaic/Objects_0004.jpg','Objects',0};
imgdb.img{186}={'/ObjectMosaic/Objects_0005.jpg','Objects',0};
imgdb.img{187}={'/ObjectMosaic/Objects_0006.jpg','Objects',0};
imgdb.img{188}={'/ObjectMosaic/Objects_0007.jpg','Objects',0};
imgdb.img{189}={'/ObjectMosaic/Objects_0008.jpg','Objects',0};
imgdb.img{190}={'/ObjectMosaic/Objects_0009.jpg','Objects',0};
imgdb.img{191}={'/ObjectMosaic/Objects_0010.jpg','Objects',0};
imgdb.img{192}={'/ObjectMosaic/Objects_0011.jpg','Objects',0};
imgdb.img{193}={'/ObjectMosaic/Objects_0012.jpg','Objects',0};
imgdb.img{194}={'/ObjectMosaic/Objects_0013.jpg','Objects',0};
imgdb.img{195}={'/ObjectMosaic/Objects_0014.jpg','Objects',0};
imgdb.img{196}={'/ObjectMosaic/Objects_0015.jpg','Objects',0};
imgdb.img{197}={'/ObjectMosaic/Objects_0016.jpg','Objects',0};
imgdb.img{198}={'/ObjectMosaic/Objects_0017.jpg','Objects',0};
imgdb.img{199}={'/ObjectMosaic/Objects_0018.jpg','Objects',0};
imgdb.img{200}={'/ObjectMosaic/Objects_0019.jpg','Objects',0};
imgdb.img{201}={'/ObjectMosaic/Objects_0020.jpg','Objects',0};

imgdb.img{202}={'/FaceMosaic/Faces_0001.jpg','Faces',1};
imgdb.img{203}={'/FaceMosaic/Faces_0002.jpg','Faces',1};
imgdb.img{204}={'/FaceMosaic/Faces_0003.jpg','Faces',1};
imgdb.img{205}={'/FaceMosaic/Faces_0004.jpg','Faces',1};
imgdb.img{206}={'/FaceMosaic/Faces_0005.jpg','Faces',1};
imgdb.img{207}={'/FaceMosaic/Faces_0006.jpg','Faces',1};
imgdb.img{208}={'/FaceMosaic/Faces_0007.jpg','Faces',1};
imgdb.img{209}={'/FaceMosaic/Faces_0008.jpg','Faces',1};
imgdb.img{210}={'/FaceMosaic/Faces_0009.jpg','Faces',1};
imgdb.img{211}={'/FaceMosaic/Faces_0010.jpg','Faces',1};
imgdb.img{212}={'/FaceMosaic/Faces_0011.jpg','Faces',1};
imgdb.img{213}={'/FaceMosaic/Faces_0012.jpg','Faces',1};
imgdb.img{214}={'/FaceMosaic/Faces_0013.jpg','Faces',1};
imgdb.img{215}={'/FaceMosaic/Faces_0014.jpg','Faces',1};
imgdb.img{216}={'/FaceMosaic/Faces_0015.jpg','Faces',1};
imgdb.img{217}={'/FaceMosaic/Faces_0016.jpg','Faces',1};
imgdb.img{218}={'/FaceMosaic/Faces_0017.jpg','Faces',1};
imgdb.img{219}={'/FaceMosaic/Faces_0018.jpg','Faces',1};
imgdb.img{220}={'/FaceMosaic/Faces_0019.jpg','Faces',1};
imgdb.img{221}={'/FaceMosaic/Faces_0020.jpg','Faces',1};

imgdb.img{222}={'/BuildingMosaic/Buildings_0001.jpg','Buildings',0};
imgdb.img{223}={'/BuildingMosaic/Buildings_0002.jpg','Buildings',0};
imgdb.img{224}={'/BuildingMosaic/Buildings_0003.jpg','Buildings',0};
imgdb.img{225}={'/BuildingMosaic/Buildings_0004.jpg','Buildings',0};
imgdb.img{226}={'/BuildingMosaic/Buildings_0005.jpg','Buildings',0};
imgdb.img{227}={'/BuildingMosaic/Buildings_0006.jpg','Buildings',0};
imgdb.img{228}={'/BuildingMosaic/Buildings_0007.jpg','Buildings',0};
imgdb.img{229}={'/BuildingMosaic/Buildings_0008.jpg','Buildings',0};
imgdb.img{230}={'/BuildingMosaic/Buildings_0009.jpg','Buildings',0};
imgdb.img{231}={'/BuildingMosaic/Buildings_0010.jpg','Buildings',0};
imgdb.img{232}={'/BuildingMosaic/Buildings_0011.jpg','Buildings',0};
imgdb.img{233}={'/BuildingMosaic/Buildings_0012.jpg','Buildings',0};
imgdb.img{234}={'/BuildingMosaic/Buildings_0013.jpg','Buildings',0};
imgdb.img{235}={'/BuildingMosaic/Buildings_0014.jpg','Buildings',0};
imgdb.img{236}={'/BuildingMosaic/Buildings_0015.jpg','Buildings',0};
imgdb.img{237}={'/BuildingMosaic/Buildings_0016.jpg','Buildings',0};
imgdb.img{238}={'/BuildingMosaic/Buildings_0017.jpg','Buildings',0};
imgdb.img{239}={'/BuildingMosaic/Buildings_0018.jpg','Buildings',0};
imgdb.img{240}={'/BuildingMosaic/Buildings_0019.jpg','Buildings',0};
imgdb.img{241}={'/BuildingMosaic/Buildings_0020.jpg','Buildings',0};

imgdb.img{242}={'/BuildingMosaic/Buildings_0021.jpg','Buildings',0};
imgdb.img{243}={'/BuildingMosaic/Buildings_0022.jpg','Buildings',0};
imgdb.img{244}={'/BuildingMosaic/Buildings_0023.jpg','Buildings',0};
imgdb.img{245}={'/BuildingMosaic/Buildings_0024.jpg','Buildings',0};
imgdb.img{246}={'/BuildingMosaic/Buildings_0025.jpg','Buildings',0};
imgdb.img{247}={'/BuildingMosaic/Buildings_0026.jpg','Buildings',0};
imgdb.img{248}={'/BuildingMosaic/Buildings_0027.jpg','Buildings',0};
imgdb.img{249}={'/BuildingMosaic/Buildings_0028.jpg','Buildings',0};
imgdb.img{250}={'/BuildingMosaic/Buildings_0029.jpg','Buildings',0};
imgdb.img{251}={'/BuildingMosaic/Buildings_0030.jpg','Buildings',0};
imgdb.img{252}={'/BuildingMosaic/Buildings_0031.jpg','Buildings',0};
imgdb.img{253}={'/BuildingMosaic/Buildings_0032.jpg','Buildings',0};
imgdb.img{254}={'/BuildingMosaic/Buildings_0033.jpg','Buildings',0};
imgdb.img{255}={'/BuildingMosaic/Buildings_0034.jpg','Buildings',0};
imgdb.img{256}={'/BuildingMosaic/Buildings_0035.jpg','Buildings',0};
imgdb.img{257}={'/BuildingMosaic/Buildings_0036.jpg','Buildings',0};
imgdb.img{258}={'/BuildingMosaic/Buildings_0037.jpg','Buildings',0};
imgdb.img{259}={'/BuildingMosaic/Buildings_0038.jpg','Buildings',0};
imgdb.img{260}={'/BuildingMosaic/Buildings_0039.jpg','Buildings',0};
imgdb.img{261}={'/BuildingMosaic/Buildings_0040.jpg','Buildings',0};

imgdb.img{262}={'/FaceMosaic/Faces_0021.jpg','Faces',1};
imgdb.img{263}={'/FaceMosaic/Faces_0022.jpg','Faces',1};
imgdb.img{264}={'/FaceMosaic/Faces_0023.jpg','Faces',1};
imgdb.img{265}={'/FaceMosaic/Faces_0024.jpg','Faces',1};
imgdb.img{266}={'/FaceMosaic/Faces_0025.jpg','Faces',1};
imgdb.img{267}={'/FaceMosaic/Faces_0026.jpg','Faces',1};
imgdb.img{268}={'/FaceMosaic/Faces_0027.jpg','Faces',1};
imgdb.img{269}={'/FaceMosaic/Faces_0028.jpg','Faces',1};
imgdb.img{270}={'/FaceMosaic/Faces_0029.jpg','Faces',1};
imgdb.img{271}={'/FaceMosaic/Faces_0030.jpg','Faces',1};
imgdb.img{272}={'/FaceMosaic/Faces_0031.jpg','Faces',1};
imgdb.img{273}={'/FaceMosaic/Faces_0032.jpg','Faces',1};
imgdb.img{274}={'/FaceMosaic/Faces_0033.jpg','Faces',1};
imgdb.img{275}={'/FaceMosaic/Faces_0034.jpg','Faces',1};
imgdb.img{276}={'/FaceMosaic/Faces_0035.jpg','Faces',1};
imgdb.img{277}={'/FaceMosaic/Faces_0036.jpg','Faces',1};
imgdb.img{278}={'/FaceMosaic/Faces_0037.jpg','Faces',1};
imgdb.img{279}={'/FaceMosaic/Faces_0038.jpg','Faces',1};
imgdb.img{280}={'/FaceMosaic/Faces_0039.jpg','Faces',1};
imgdb.img{281}={'/FaceMosaic/Faces_0040.jpg','Faces',1};

imgdb.img{282}={'/ObjectMosaic/Objects_0021.jpg','Objects',0};
imgdb.img{283}={'/ObjectMosaic/Objects_0022.jpg','Objects',0};
imgdb.img{284}={'/ObjectMosaic/Objects_0023.jpg','Objects',0};
imgdb.img{285}={'/ObjectMosaic/Objects_0024.jpg','Objects',0};
imgdb.img{286}={'/ObjectMosaic/Objects_0025.jpg','Objects',0};
imgdb.img{287}={'/ObjectMosaic/Objects_0026.jpg','Objects',0};
imgdb.img{288}={'/ObjectMosaic/Objects_0027.jpg','Objects',0};
imgdb.img{289}={'/ObjectMosaic/Objects_0028.jpg','Objects',0};
imgdb.img{290}={'/ObjectMosaic/Objects_0029.jpg','Objects',0};
imgdb.img{291}={'/ObjectMosaic/Objects_0030.jpg','Objects',0};
imgdb.img{292}={'/ObjectMosaic/Objects_0031.jpg','Objects',0};
imgdb.img{293}={'/ObjectMosaic/Objects_0032.jpg','Objects',0};
imgdb.img{294}={'/ObjectMosaic/Objects_0033.jpg','Objects',0};
imgdb.img{295}={'/ObjectMosaic/Objects_0034.jpg','Objects',0};
imgdb.img{296}={'/ObjectMosaic/Objects_0035.jpg','Objects',0};
imgdb.img{297}={'/ObjectMosaic/Objects_0036.jpg','Objects',0};
imgdb.img{298}={'/ObjectMosaic/Objects_0037.jpg','Objects',0};
imgdb.img{299}={'/ObjectMosaic/Objects_0038.jpg','Objects',0};
imgdb.img{300}={'/ObjectMosaic/Objects_0039.jpg','Objects',0};
imgdb.img{301}={'/ObjectMosaic/Objects_0040.jpg','Objects',0};

imgdb.img{302}={'/HandMosaic/Hands_0021.jpg','Hands',0};
imgdb.img{303}={'/HandMosaic/Hands_0022.jpg','Hands',0};
imgdb.img{304}={'/HandMosaic/Hands_0023.jpg','Hands',0};
imgdb.img{305}={'/HandMosaic/Hands_0024.jpg','Hands',0};
imgdb.img{306}={'/HandMosaic/Hands_0025.jpg','Hands',0};
imgdb.img{307}={'/HandMosaic/Hands_0026.jpg','Hands',0};
imgdb.img{308}={'/HandMosaic/Hands_0027.jpg','Hands',0};
imgdb.img{309}={'/HandMosaic/Hands_0028.jpg','Hands',0};
imgdb.img{310}={'/HandMosaic/Hands_0029.jpg','Hands',0};
imgdb.img{311}={'/HandMosaic/Hands_0030.jpg','Hands',0};
imgdb.img{312}={'/HandMosaic/Hands_0031.jpg','Hands',0};
imgdb.img{313}={'/HandMosaic/Hands_0032.jpg','Hands',0};
imgdb.img{314}={'/HandMosaic/Hands_0033.jpg','Hands',0};
imgdb.img{315}={'/HandMosaic/Hands_0034.jpg','Hands',0};
imgdb.img{316}={'/HandMosaic/Hands_0035.jpg','Hands',0};
imgdb.img{317}={'/HandMosaic/Hands_0036.jpg','Hands',0};
imgdb.img{318}={'/HandMosaic/Hands_0037.jpg','Hands',0};
imgdb.img{319}={'/HandMosaic/Hands_0038.jpg','Hands',0};
imgdb.img{320}={'/HandMosaic/Hands_0039.jpg','Hands',0};
imgdb.img{321}={'/HandMosaic/Hands_0040.jpg','Hands',0};
