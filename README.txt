# ImagesShow
A general 2D/3D image presentation software package for fMRI/MEG/psychophysics experiments

FULL VERSION OF README IN ENGLISH IS COMING SOON.


心理実験およびfMRI/TMS/EEG実験用画像呈示ソフトウェア  ImagesShowPTB Ver. 1.0

作成日時： 2003年12月24日  番浩志(BAN, Hiroshi)
最終更新： 2021年06月13日  番浩志(BAN, Hiroshi)

1. ImagesShowPTBとは

・複数の画像ファイルを読み込み、それらを視覚刺激としてあらかじめ指定したとおり(あるいはランダム)に正確なタイミングで連続呈示する
  ソフトウェアです。

主な特徴は以下のとおりです。
・画像を連続呈示して観察者の反応時間や脳活動を取得するようなパラダイムの心理行動実験、TMS/EEG/fMRI実験をサポートします。
・ブロックパラダイム、イベントリレイテッドパラダイム、どちらのfMRI実験にも使用可能です。
  コンディションファイルを適切に記述することで、現行のオブジェクト知覚・認知関連のfMRI実験のほぼ全ての呈示シーケンスを再現できます。
・MATLABで扱える全てのフォーマットの画像を利用できます。スクリプトを変更して、独自の画像読み込み処理を追加することも可能です。
  また、画像を予めMATLABの*.mat形式で保存し、その*.matファイルを読み込ませることも可能です。
・画像の読み込み、メモリへのOpenGLテクスチャの書き込みタイミングをオプションで変更できます。この機能により、
  1. 画像呈示前に一度に全てのテクスチャを作成し、後の処理で呈示以外の割り込みが入らないようにすることで、呈示時間の正確な制御が可能です。
  2. 画像を呈示時に1枚ずつ読み込むよう設定することで(ローパワーなコンピュータでは、呈示時間の精度が少し犠牲になるかもしれません)、メモリ
     が少ないコンピュータ上でも多くの画像を呈示することが可能です。実験に数千枚の画像が必要な場合も、必要な画像を1枚ずつ読み込んで呈示す
     れば、メモリ・エラーが起きません。
  といった柔軟な処理が可能です。ただし、各画像のパス付きファイル名をcell構造体としてMATLABにロードする必要があるので、そのcell構造のサイ
  ズがMATLABメモリを超える(通常数千～数万件は保持できます)ような場合は、本ソフトウェアは使用できません。
・画像ファイルを自由に拡大・縮小して呈示できます。また、画像ファイルのサイズを予め揃えておく必要はありません。
・時間制御や呈示ルーチンは、PsychtoolboxのScreen関数を利用しています。Psychtoolboxは多くの研究者に使われ、アップデートされており、呈示
  時間の制御などは十分に信頼できます。よほどの環境でない限り、レンダリングが大きく遅れることはありません。
  また、ImagesShowPTBは、1つの画像の呈示時間にズレが生じた際に次の画像の呈示時間を調整することで、総呈示時間を正確に保つ機能が備わっています。
・呈示時間の指定には、垂直同期信号のカウントとmsec単位の2つが選べます(混在も可能です)。
・刺激呈示シーケンス、Psychtoolboxの警告・エラーは毎回ログファイルに出力・保存されます。
・Parallel Portを通じたImagesShowPTBと外部装置との連携も可能です (現在、トリガー取得のみ対応。他の連携にはスクリプトの変更が必要です)。
・ImagesShowPTBの全ての処理はMATLABのスクリプトにより記述されているので、一部の機能のみを変更したり、ある処理を抜き出して他のプログラムに
  その機能を移植することも容易です。

2. 動作環境

・Windows XP,7,8 (Windows9x系では未確認), Mac OSX, Linux
・それらのOS上で動作するMATLAB (http://www.mathworks.com)、およびPsychtoolbox ver.3以上 (http://psychtoolbox.org/HomePage)
・OpenGL Accelerator対応のグラフィックカード(Nvidia GEForce, ATI Radeon, ATI FireGLなど)を積んだコンピュータが望ましい。

3. 作者の動作確認環境

・Lenovo Thinkpad T61p (Intel Core 2 Duo 2.6GHz, 4GB(3GB) RAM, nVidia Quadro FX540 512MB VRAM, Windows XP SP3)

(旧バージョンの動作は確認)
・COMPAQ mobile workstation N800w (Pentium4 2.2GHz, 1GB RAM, ATI Mobility FireGL 9000 64MB VRAM, Windows2000)
・IBM Thinkpad mobile workstation A31p (Pentium4 2.0GHz, 768MB RAM, ATI Mobility Radeon 7800 64MB VRAM, Windows2000)
・FUJITSU CELSIUS 600 (Pentium3 1GHz, ATI FireGL 2, Windows2000)
・TOSHIBA G5 (Pentium*, WindowsXP home)

4. 作者の開発環境

・Windows XP SP3上で、Emacs (24.2.91)、EmEditor (ver.13.0.6)を用いてスクリプトを書き、MATLAB 7.8.0.347 (R2009a)上で動作確認しています。
・ほとんど全てのファイルは、MATLABスクリプト形式ですので、変更は自由にできます。
・一部、Commonディレクトリ内にC++ソースとMEXファイルが含まれています。これらをお使いの環境に合うようにコンパイルするには、お使いのOSに
  対応したC/C++のコンパイラ(gccなど)が必要です。コンパイルには、MATLABコマンドウィンドウ上で、
  >> mex -setup [RETURN]
  をしてコンパイラを指定した後、Commonディレクトリに移動し、
  >> CompileMEXs [RETURN]
  としてください。

5. ImagesShowPTBディレクトリの構成

ImagesShowPTBディレクトリ直下には、以下の8つのサブディレクトリと2つのファイルがあります。それぞれの詳細は以下の通りです。
.git ------------ Gitによるバージョン管理に必要なファイル群です。
Common ---------- ImagesShowPTBの動作に必要なサブ関数および画像処理、他のプログラムにも共通して利用できる関数が入っています
doc ------------- ImagesShowPTBのドキュメントが入っています。このREADMEファイルの他に、~/ImagesShowPTB/doc/html/index.html
                  をブラウザで開いていただくことで、ImagesShowPTBの全てのソース・コードの中身と関係性を閲覧できます。
gamma_table ----- ImagesShowPTBで使用できるディスプレイ・ガンマ・テーブルのサンプルが入っています。ガンマ・テーブルは自由に
                  作成していただけます。詳細は下記の使用方法をご覧ください。
Generation ------ ImagesShowPTBでの画像呈示に必要な4つのコンディション・ファイルを読み込むためのサブ関数が入っています。
images ---------- デモスクリプトで利用する画像ファイルが入っています。imgdbfileの記述を変更すれば、画像ファイルはどこにでも
                  置くことができます。
                  (!注意!) このディレクトリにある顔刺激は、特許取得済みの刺激を許可をいただいて使用しています。
                  この研究室でのデモ用途以外には決して使用しないでください。
m2html ---------- ImagesShowPTBのHTML形式ヘルプ・ドキュメントを作成するために必要なツールです。
Presentation ---- ImagesShowPTB本体、被験者毎のコンディション・ファイルが入っています。実験に必要なコンディション・ファイルは
                  ~/ImagesShowPTB/Presentation/subjects/(被験者名)以下へ保存してください。
                  デフォルトでは、デモ用コンディション・ファイルと画像ファイルが入っています。
                  また、実験結果は~/ImagesShowPTB/subjects/(被験者名)ディレクトリ以下に保存されます。
Update_ImagesShowPTB_Docs.m --- ImagesShowPTBのHTML形式ヘルプ・ドキュメントをアップデートするためのスクリプトです。
readme_for_testing.txt -------- Presentation/subjects/以下にあるデモ用スクリプトの使い方を示したファイルです。

6. 使用方法および注意点

・MATLABコマンドウィンドウ上でコンディション・ファイルを直接指定してImagesShowPTBを走らせるするか、ラッパー・ファイルを作成してください。
・~/ImagesShowPTB/Presentation/run_exp.mがラッパー・ファイルのサンプルです。

・詳細な使用方法

 * ヘルプを表示するには、
 >> ImagesShow.exe [RETURN]

 * 実際に画像呈示を行うには、
 >> ImagesShowPTB(subj,acq,protocolfile,imgdbfile,:viewfile,:optionfile,:gamma_table,:overwrite_flg)
    (: はオプション、省略可)

[引数の詳細]
  subj         : 被験者の名前、'HB'や'test01'. ~/ImagesShowPTB/Presentation/subjects/以下に同じ名前のディレクトリを作成し、
                 書きの4つのコンディション・ファイルをそこに置いてください。それ以外の場所のコンディション・ファイルは読み込
                 めません。
  acq          : ラン(セッション)・ナンバー、1,2,3,...と1つ数字を指定してください。
  protocolfile : 実験プロトコルファイル。
                 画像呈示ブロック、シーケンスを指定し、ランドマイズ・オプションも合わせて指定します。
                 また、ファイルは、./subjects/(subj)/以下に設置してください。
                 このファイルの記述を変えることで、ブロック・デザインやイベント・リレイテッド・デザインの実験を作成できます。
                 詳細は、../Generation/readExpProtocols.mをご覧ください。
                 ../Generation/readExpProtocols.mの戻り値と同じ構造体を返すMATLAB関数を作成し、その関数を指定することもできます。
                 より柔軟な制御が可能です。
  imgdbfile    : 画像データベースファイル。
                 実験で使用する画像のデータベースをMATLAB cell構造体で作成し、オプションを指定します。
                 また、ファイルは、./subjects/(subj)/以下に設置してください。
                 詳細は、../Generation/readImageDatabase.mをご覧ください。
                 ../Generation/readImageDatabase.mの戻り値と同じ構造体を返すMATLAB関数を作成し、その関数を指定することもできます。
                 より柔軟な制御が可能です。
  viewfile     : (省略可) 視距離などの観察条件ファイル。
                 現在、このファイルの中身は使用しておりませんが、実験環境を他のデータと共に保存しておくために、指定してください。
                 将来画像サイズを視角で表現するために使用するかもしれません。
                 また、ファイルは、./subjects/(subj)/以下に設置してください。
                 詳細は、../Generation/readViewingParameters.mをご覧ください。
                 ../Generation/readViewingParameters.mの戻り値と同じ構造体を返すMATLAB関数を作成し、その関数を指定することもできます。
                 より柔軟な制御が可能です。
  optionfile   : (省略可) 呈示オプション指定ファイル。
                 刺激を呈示する際のオプションを指定できます。
                 省略可能ですが、ウィンドウサイズの変更など、重要なオプションも多く含まれているので、できる限り実験毎にしっかり
                 と指定してください。
                 また、ファイルは、./subjects/(subj)/以下に設置してください。
                 詳細は、../Generation/readDisplayOptions.mをご覧ください。
                 ../Generation/readDisplayOptions.mの戻り値と同じ構造体を返すMATLAB関数を作成し、その関数を指定することもできます。
                 より柔軟な制御が可能です。
  gamma_table  : (省略可) ディスプレイ・ガンマ・テーブル
                 256(8-bits) x 3(RGB) x 1(or 2,3,... when using multiple displays) のMATLAB matrixデータか、このmatrixをgamma_table
                 という名前の変数で含んでいる*.matファイルを指定してください。
                 *.matファイルを指定する場合は、相対パスでファイルを記述してください。起点は、~/Presentaionです。
                 もし複数のディスプレイで呈示を行う際に、256x3x1のgamma_tableが読み込まれた場合、同じテーブルが全てのディスプレイ
                 に適用されます。また、ディスプレイの数とgamma_tableの数と合わない場合は、最後のテーブルが残りのディスプレイ全てに
                 適用されます。この入力引数を省略した場合、単純な線形テーブル(repmat(linspace(0.0,1.0,256),3,1))が全てのディスプレイ
                 に適用されます。
  overwrite_flg: (省略可) すでに~/Presentaion/subjects/(subj)以下に存在する結果のファイルを上書きするかどうかを決めるフラグです。
                 0を指定すると、同名の結果ファイルがすでに存在する場合、そのファイルが'_old'というプレフィックスがつけられてバックアッ
                 プされます。1を指定すると、同名のファイルは上書きされます。デフォルトは0です。

[入力引数で指定する各コンディション・ファイルの記述方法]
・~/Presentation/subjects/{subj01|subj02|subj03}ディレクトリの中に記述例がありますので、記述の際にはご参照ください。
・各ファイルの記述にはテキストエディタをご利用ください。

 1) protocolfile (*.m) について

    blocks{N}というセル構造体を返す関数を作成してください。あるいは、下記の通りmatlabスクリプトを使うこともできます。スクリプト内に
    blocks{N}というセル構造体を作成してください。各セルが各ブロックに対応します。各セルは下記の6つのメンバを持ちます。
    1. blocks{n}.randomization : このブロックの中の画像呈示順(.sequenceで指定したもの)をランダムにするかのオプションです。
                                 0 = OFF (ランドマイズせずにそのまま呈示)
                                 1 = 全ての画像順番をランドマイズ
                                 2 = 偶数番目の画像の順番をランドマイズ
                                 3 = 奇数番目の画像の順番をランドマイズ
                                 4 = 前半1/2の画像の順番をランドマイズ
                                 5 = 後半1/2の画像の順番をランドマイズ
                                 6 = 2番目から(最後-1)番目までの画像の順番をランドマイズ
                                 matrixで複数(2つ以上)指定 = sequenceの中でmatrix番目に当たる画像の順番をランドマイズします。e.g. [2,4,6,8]
                                 両眼呈示モードを使用して左右眼の画像を個別にランドマイズしたい時(視野闘争実験など)は、セル構造で2つ
                                 の値(それぞれ左眼、右眼画像用)を指定してください。1つのみ指定した場合は、両眼の画像のペア関係を保っ
                                 たままた、ランドマイズされます。
    2. blocks{n}.sequence      : 画像の呈示順を指定します。例えば、blocks{n}.sequence=[10 1 11 1 12 1 13 1 14 1 15 1 16 1]のとき、
                                 imagedbfileの中で10~16に指定された画像が、1番目の画像と交互に呈示されます。上のrandomization
                                 オプションで呈示順を実験毎に異なるようにランドマイズ可能です。
                                 また、このmatrixを1xNのサイズで指定すると、1画面に1つの画像あるいは両眼それぞれの画面に同じ画像が
                                 呈示されます。2xNのサイズで指定すると、両眼呈示モードとなり、左右眼用のディスプレイに別々の画像を
                                 呈示することが可能です。両眼立体視や視野闘争実験に便利な機能です。
                                 sequenceに0番を指定すると、その当該シーケンスでは画像呈示を行いません。レスト期間として、背景画像
                                 のみを呈示したい場合などは、0をご指定ください。
    3. blocks{n}.msec (frame)  : 各画像の呈示時間を指定します。.msecの際にはmsec単位で、.frameの際には垂直同期信号の数を単位として
                                 記述してください。.msecと.frameのどちらか一方を指定すれば問題ありません。両者が同時に指定された場
                                 合には、.frameの記述が優先して使用されます。
                                 size(blocks{n}.sequence,2)はsize(blocks{n}.msec(frame),2)と同じになるよう、記述の際にはご注意くだ
                                 さい。異なる場合、ImagesShowPTBはエラーを返します。
                                 また、ランドマイズの際には、sequenceとmsecのペア関係が保持されます。
    4. blocks{n}.slicing       : (省略可) 呈示画面を更新する際の最小単位。ImagesShowPTBは、ここで指定された時間を基準に画面更新を行い
                                 ます。例えば、blocks{n}.msecに500が記述されていた際には、対応する画像が500ms呈示されますが、その際、
                                 500msの呈示時間はslicingの値に応じて複数のサブ呈示時間に分割され、各サブ呈示時間ごとに画面の更新が行
                                 われます。すなわち、blocks{n}.slicing=100の際には、500が[100,100,100,100,100]に分割され、5回の画面更
                                 新が行われます。これは、画面の呈示時間とは非同期にタスクを付与するために必要な機能です。
                                 また、optionfileで各タスクの呈示時間を250msと指定し、slicingが100の場合、250msは100msで分割できないた
                                 め、値が丸められてタスクの呈示時間は200msとなります。また、.msec(frame)の端数はその大きさ(サブ呈示時
                                 間の半分との大小)によって前のサブ呈示時間に含まれるか、追加のサブ呈示時間として組み込まれます。
                                 例えば、.msecに550msが指定され、.slicingが100の際、550msは[100,100,100,100,150]と分割されます。
                                 .msecが590ms、.slicingが100の際には、590msは[100,100,100,100,100,90]と分割されます。ご注意ください。
                                 この値を省略した場合、デフォルト値として.msec指定の際は100、.frame指定の際は6が使われます。
    5. blocks{n}.repetitions   : (省略可) このブロックの繰り返し回数。デフォルトは１です。繰り返し数を2以上に指定し、ランドマイズし
                                 た場合、それぞれ個別にランドマイズされたブロックが複数回繰り返して呈示されます。繰り返しを跨いでの
                                 ランドマイズは行われません。繰り返しを跨いでランドマイズしたい際には、繰り返し数と対応する分だけ
                                 sequenceおよびmsec(frame)を複数回記述した後、randomizationオプションをお使いください。
                                 省略した場合は1となります。
    6. blocks{n}.name          : (省略可) このブロックの名前を記述します。省略した場合、blocks{n}.name=sprintf('block %02d',n)となり
                                 ます。

    また、~/ImagesShowPTB/Generation/getGlobalParameters.mを使用すると、条件ファイル内から、subj, acq, session, vparam, dparam, imgs,
    prt, imgsの8つのグローバル変数の中身を参照できます。より柔軟な条件ファイルの作成が可能です。グローバル変数は今のところ読み取りのみ
    可能で、書き込みはできません。

    記述例：

    blocks{1}.randomization=0;
    blocks{1}.sequence=[7 5 1 2 3 4 6 5 1 2 3 4 6 5 1 2 3 4 6 7];
    blocks{1}.msec=[500 200 100 200 100 200 100 200 100 200 100 200 100 200 100 200 100 200 100 500];
    blocks{1}.slicing=100
    blocks{1}.repetitions=1
    blocks{1}.name='images 1';
    .
    .
    .
    blocks{n}.randomization=0;
    blocks{n}.sequence=[7 5 1 2 3 4 6 5 1 2 3 4 6 5 1 2 3 4 6 7];
    blocks{n}.msec=[500 200 100 200 100 200 100 200 100 200 100 200 100 200 100 200 100 200 100 500];
    blocks{n}.slicing=100;
    blocks{n}.repetitions=1;
    blocks{n}.name='images N';

    また、このファイルはMATLABスクリプトなので、数式や関数を含ませてブロックをより柔軟に記述することも可能です。例えば、

    もう1つの記述例：

    blocks{1}.randomization=0;
    blocks{1}.sequence=201;
    blocks{1}.msec=16000;
    blocks{1}.slicing=100;
    blocks{1}.repetitions=1;
    blocks{1}.name='The First Fixation';

    block_counter=1; n_each=20;
    for ii=1:1:100/n_each
      block_counter=block_counter+1;
      stim_array=n_each*(ii-1)+1:n_each*ii;
      stim_array=[stim_array;stim_array+100;stim_array;stim_array+100];
      stim_array=stim_array(:)';

      blocks{block_counter}.randomization=0;
      blocks{block_counter}.sequence=Pad2Array(stim_array,201,0);
      blocks{block_counter}.msec=repmat([200,100],1,numel(stim_array));
      blocks{block_counter}.slicing=100;
      blocks{block_counter}.repetitions=3;
      blocks{block_counter}.name=sprintf('Voronoi Textures %02d',ii);

      block_counter=block_counter+1;
      blocks{block_counter}.randomization=0;
      blocks{block_counter}.sequence=201;
      blocks{block_counter}.msec=6000;
      blocks{block_counter}.slicing=100;
      blocks{block_counter}.repetitions=1;
      blocks{block_counter}.name='Fixation Rest';
    end

    % replace the final fixation rest as below.
    blocks{block_counter}.randomization=0;
    blocks{block_counter}.sequence=201;
    blocks{block_counter}.msec=16000;
    blocks{block_counter}.slicing=100;
    blocks{block_counter}.repetitions=1;
    blocks{block_counter}.name='The Final Fixation';

 2) imgdbfile (image database file) (*.m) について

    imgdbという構造体を返す関数を作成してください。あるいは、下記の通りmatlabスクリプトを使うこともできます。スクリプト内に
    imgdbという構造体を作成してください。この構造体は下記の5つのメンバを持ちます。
    1. imgdb.type               : 画像ファイルのタイプ、'image'か'matlab'の2つからお選びください。
    2. imgdb.directory          : 画像ファイルが含まれるディレクトリ(フルパス形式)を指定してください。
    3. imgdb.presentation_size  : 画像の呈示サイズ [row,col]。全画像は、ここで指定した大きさにリサイズされます。
                                  リサイズしたくない場合は、実際の画像サイズをご指定ください。
                                  また、オリジナルの画像サイズで呈示したい場合には、optionfileのuse_original_imgsizeを1にしてください。
    4. imgdb.num                : 実験で使用する画像の枚数を記述してください。
    5. imgdb.img                : セル構造体。それぞれのセルは、下記3つを変数として持ちます。
                                  imgdb.img{n}={'画像ファイル本体へのパスおよびファイル名', '画像ファイルの説明', 'トリガーの有無'}
                                  画像ファイル本体へのパスおよびファイル名(string) = imgdb.directoryからの相対パスでご指定ください。
                                                                                     directory直下に画像がある場合は、ファイル名のみ
                                                                                     の記述となります。
                                  画像ファイルの説明(string) = この画像ファイルが何であるかの簡単な説明を記述してください。
                                  トリガーの有無(integer or string) = 0を指定するとトリガー無し、0以外の数字あるいは文字を指定すると、
                                                                      トリガー有りと判断され、その画像の呈示時に個別の処理が可能です。
                                                                      また、その画像の呈示時間がログに記録されます。

    また、~/ImagesShowPTB/Generation/getGlobalParameters.mを使用すると、条件ファイル内から、subj, acq, session, vparam, dparam, imgs,
    prt, imgsの8つのグローバル変数の中身を参照できます。より柔軟な条件ファイルの作成が可能です。グローバル変数は今のところ読み取りのみ
    可能で、書き込みはできません。

    記述例：

    imgdb.type='image';
    imgdb.directory=fullfile(fileparts(mfilename('fullpath')),'images');
    imgdb.presentation_size=[320,320];
    imgdb.num=321;

    imgdb.img{1}={'background.jpg','Background',0};

    imgdb.img{2}={'/Building/Buildings_0001.jpg','Buildings',0};
    imgdb.img{3}={'/Building/Buildings_0002.jpg','Buildings',0};
    imgdb.img{4}={'/Building/Buildings_0003.jpg','Buildings',0};
    imgdb.img{5}={'/Building/Buildings_0004.jpg','Buildings',0};
    .
    .
    .
    imgdb.img{317}={'/HandMosaic/Hands_0036.jpg','Hands',0};
    imgdb.img{318}={'/HandMosaic/Hands_0037.jpg','Hands',0};
    imgdb.img{319}={'/HandMosaic/Hands_0038.jpg','Hands',0};
    imgdb.img{320}={'/HandMosaic/Hands_0039.jpg','Hands',0};
    imgdb.img{321}={'/HandMosaic/Hands_0040.jpg','Hands',0};

    protocolfileと同じく、このファイルはMATLABスクリプトなので、数式や関数を含ませてより柔軟に画像を指定することも可能です。例えば、

    もう1つの記述例：

    % an example of image database for monocular display
    imgdb.type='image'; % database type, 'image' (image file) or 'matlab'(matlab .mat file).
    imgdb.directory=fullfile(fileparts(mfilename('fullpath')),'images'); % full path to the image files
    imgdb.presentation_size=[400,400]; % this is not the actual image size, all the images will be adjusted based on this value.
    imgdb.num=201; % the total number of images

    % set image file names
    % img{1}-img{100}   : inphase images
    % img{101}-img{200} : outphase images
    imgcounter=1;
    for jj=1:1:2
      for ii=1:1:100
        imgdb.img{imgcounter}={sprintf('img_01_03_%02d_%02d.png',ii,jj),sprintf('voronoi_%02d',ii),jj-1};
        imgcounter=imgcounter+1;
      end
    end

    % background image
    imgdb.img{201}={'background.png','background',0}; % {'file_name','comment','trigger(off=0, on=1, or on=string)'}

 3) viewfile (*.m) について

    vparamという構造体を返す関数を作成してください。あるいは、下記の通りmatlabスクリプトを使うこともできます。スクリプト内に
    vparamという構造体を作成してください。この構造体は、下記の3つのメンバを持ちます。
    1. ipd        : 眼間距離 (inter pupil distance) をcm単位で記述してください。
    2. pix_per_cm : 呈示画面の画素サイズをpixels/cm単位で記述してください。
    3. vdist      : 視距離 (viewing distance) をcm単位で記述してください。

    また、~/ImagesShowPTB/Generation/getGlobalParameters.mを使用すると、条件ファイル内から、subj, acq, session, vparam, dparam, imgs,
    prt, imgsの8つのグローバル変数の中身を参照できます。より柔軟な条件ファイルの作成が可能です。グローバル変数は今のところ読み取りのみ
    可能で、書き込みはできません。

    記述例：

    vparams.ipd=6.4;
    vparams.pix_per_cm=57.1429;
    vparams.vdist=65;

 4) optionfile (*.m) について

    optionsという構造体を返す関数を作成してください。あるいは、下記の通りmatlabスクリプトを使うこともできます。スクリプト内に
    optionsという構造体を作成してください。この構造体は下記の19のメンバを持ちます。必要なオプションのみ記述すればよく、省略されたメンバ
    にはデフォルト値が使われます。
     1. options.exp_mode             : 刺激呈示モードを指定します。
                                       mono = 単一ディスプレイ呈示
                                       dual = デュアルディスプレイ呈示。両眼立体視や視野闘争の研究に有効です。
                                       dualcross = デュアルディスプレイ呈示。交差法で立体視ができる呈示モードです。
                                       cross = 1つの画面を左右に2分割し、交差法で立体視ができる呈示モードです。
                                       parallel = 1つの画面を左右に2分割し、平行法で立体視ができる呈示モードです。
                                       dualparallel = デュアルディスプレイ呈示。平行法で立体視ができる呈示モードです。
                                       redgreen = 1つの画面に赤緑メガネを使用して両眼呈示を行うモードです。
                                       greenred = 1つの画面に緑赤メガネを使用して両眼呈示を行うモードです。
                                       redblue = 1つの画面に赤青メガネを使用して両眼呈示を行うモードです。
                                       bluered = 1つの画面に青赤メガネを使用して両眼呈示を行うモードです。
                                       shutter = 1つの画面に垂直同期毎に異なる画像を呈示します。
                                                 シャッターゴーグルを使用した際に両眼呈示ができるモードです。
                                       topbottom = 1つの画面を上下に分割して、両眼呈示を行うモードです。上に左眼画像がきます。
                                       bottomtop = 1つの画面を上下に分割して、両眼呈示を行うモードです。下に左眼画像がきます。
                                       interleavedline = 水平ピクセルに沿って2つの異なる画像をインターレース呈示して両眼視を行うモードです。
                                                         両眼視には特殊なゴーグルや装置が必要です。
                                       interleavedcolumn = 垂直ピクセルに沿って2つの異なる画像をインターレース呈示して両眼視を行うモードです。
                                                           両眼視には特殊なゴーグルや装置が必要です。
                                       propixxmono = カナダVPIXX社のPROPixx Projectorに2D刺激を呈示するモードです。
                                       propixxstereo = カナダVPIXX社のPROPixx ProjectorとDepthQの円偏光シャッターを使用して3D刺激を呈示するモードです。
                                       デフォルト値は'mono'です。
     2. options.start_method         : 刺激画像呈示のスタート方法を指定します。
                                       0 = ENTER、SPACEキーを押下
                                       1 = マウス左クリック
                                       2 = 外部装置(MRなど)からのトリガー待ち(CiNET版、キーボードの"t"キーに相当)
                                       3 = 外部装置(MRなど)からのトリガー待ち(Birmingham BUIC版、パラレルポートの11番目のピンのONを監視)
                                       4 = カスタム・キー(MRからのトリガーをキー入力として受ける場合に有効、下のcustom_triggerで設定したキー)
                                       デフォルトは0です。
     3. options.custom_trigger       : start_methodで4を指定した場合にのみ有効となります。トリガー入力に相当する仮想キーを指定します。
                                       デフォルトは"s"です。
     4. options.keys                 : 被験者の応答取得に用いるキーを、キーコードで記述します。例えば、"A"キーを応答ボタンとして使用する
                                       場合、options.keys=KbName('A')=65となります。複数のキーをベクトルで指定できます。
                                       例：options.keys=[37,39]; デフォルト値は[37,39]です。
     5. options.window_size          : 呈示範囲(ウィンドウ・サイズ)を[row,col]で記述します。デフォルト値は[768,1024]です。
     6. options.RGBgain              : ディスプレイのRGBフォスファーのゲインを指定します。両眼視モード(赤緑メガネ用呈示など)の際に有効です。
                                       2(left/right)x3(RGB)のmatrixを指定してください。デフォルトは空行列で、その際、単一ディスプレイを初期化
                                       する際には、RGBgain=[1.0,1.0,1.0;1.0,1.0,1.0];(RGBフォスファーゲインを全て最大に設定)となります。両眼
                                       立体視モードではRGBのゲインがモードに応じて適切に(赤緑メガネ用呈示なら、RGフォスファーのゲインを)調整
                                       されます。
     7. options.fixation             : 注視点の有無、タイプ、サイズ、色を指定します。セル構造体で、下記の3つのメンバを持ちます。
                                       options.fixation={タイプ, ピクセル・サイズ, 色(RGB,0-255)};です。指定できるタイプは、
                                       0 = 注視点なし
                                       1 = クロス型の注視点。後のタスク・オプションでバーニエ・タスクを指定する際にはこの形がおすすめです。
                                       2 = 円形の注視点
                                       デフォルト値は、fixation={2,24,[255,255,255]};です。
     8. options.background           : 背景に関する設定値を持つセル構造体です。下記の6つのメンバを持ちます。6番目のメンバ(窓サイズ)は、
                                       通常ImagesShowPTBが処理の中で自動で計算するので、指定する必要はなく、省略します。
                                       options.background={タイプ(0:単一色、1:パッチ付きの背景), 背景色(RGB), パッチの1つめの色(RGB),
                                                           パッチの2つめの色(RGB), パッチの数[row,col], パッチのピクセル・サイズ[row,col],...
                                                           窓サイズ(中心の画像呈示窓)[row,col]};
                                       デフォルト値は、options.background={[127,127,127],[255,255,255],[0,0,0],[30,30],[20,20]};です。
                                       背景にパッチ状の両眼融合ガイドを表示したくない場合は、パッチ1，2の色を背景色と同じにしてください。
     9. options.cmask                : 呈示画像に円・四角形窓マスクをかけるオプションです。3つのメンバを持つセル構造体を下記の通り指定してください。
                                       options.cmask={マスクあり・なし(0|1(円形)|2(四角)), 円・四角形マスクのピクセル・サイズ[row,col],...
                                                      マスクのエッジ部分をガウシアン・フィルタでスムージングする際のパラメータ[mean,sd]};
                                       マスクのエッジをスムージングしたくない場合は、meanを0に設定してください。デフォルト値は、
                                       options.cmask={0,[280,280],[20,20]};です。
    10. options.auto_background      : イメージ・データベース・ファイル(imgdbfile)に記載したimgdb.img{1}の左上[1,1]ピクセルの色を自動で
                                       取得し、その色をoptions.background{1}に付与するモードです。背景と画像との境界を消したい場合など
                                       有効です。使用したい場合は1を指定してください。デフォルトは0です。
    11. options.use_fullscr          : ウィンドウ・サイズの指定を無視して、ディスプレイ解像度にかかわらず常にフル・スクリーンで画像を
                                       呈示します。使用したい場合は1を指定してください。デフォルトは0です。
    12. option.skip_frame_sync_test  : 1を指定すると、Psychtoolbox3のスクリーン同期テストをスキップします。デフォルトは0です。
    13. option.force_frame_rate      : Psychtoolbox3に垂直同期のフレームレートを取得させず、指定したフレームレートに固定して呈示を行います。
                                       デフォルトは0で、垂直同期の計測をPsychtoolbox3に任せます。0以外を指定するとそのフレームレートが使用されます。
    14. options.use_frame            : プロトコル・ファイル(protocolfile)で指定したblocks{n}.msecの記述を無視し、blocks{n}.frame処理に
                                       書き換え、強制的に呈示時間を垂直同期信号の数で制御するモードです。使用したい場合は1を指定してく
                                       ださい。デフォルト値は0です。
    15. options.use_original_imgsize : イメージ・データベース・ファイル(imgdbfile)に記載したpresentation_size指定を無視して、画像をオリ
                                       ジナルのピクセル・サイズで呈示するモードです。使用したい場合は1を指定してください。デフォルトは0です。
    16. options.img_loading_mode     : イメージ・データベース・ファイル(imgdbfile)に記載したimgdb.imgを読み込む方法を指定します。
                                       1 = 画像のパス名のみを保持しておき、必要な際に1枚1枚画像をメモリへ読み込んだ後、さらにPsychtoolbox
                                           のテクスチャを作成して呈示するモードです。呈示後はメモリから画像を削除します。3つのモードのうち
                                           最も少ないメモリ量で呈示を行えます。数千枚の画像を使用した実験も可能です。一方で、読み込みなど
                                           に時間がかかるため、CPUパワーの少ない、あるいはハードディスク読み込みの遅いコンピュータでは呈
                                           示が遅れるかもしれません。
                                       2 = 画像をメモリ上に一度に全て読み込んでおき、必要な際に1枚1枚Psychtoolboxのテクスチャを作成して
                                           呈示を行うモードです。呈示後はメモリから画像を削除します。画像の読み込みを済ませてあるので、
                                           1のモードよりは速いですが、その分呈示中は多くのメモリ必要とします。
                                       3 = 画像をメモリ上に一度に全て読み込み、さらにPsychtoolboxのテクスチャを全て一度に作成しておく
                                           モードです。呈示中は既にメモリ上にあるテクスチャの切り替えのみを行うため、最も高速に画像呈示
                                           が可能です。一方、呈示中は3つのモードのうちで最もメモリを必要とします。
                                       デフォルト値は2です。最初は2で試してみて、画像が少ない場合には3を指定することをおすすめします。
    17. options.center               : 呈示画面の中心を[row,col]でピクセル単位で指定します。[0,0](デフォルト値)が中心を示します。
                                       ウィンドウをずらして画像呈示することが可能です。
    18. options.img_flip             : 呈示画面を反転します。反射鏡などを介して刺激を観察する際、画像の反転を防ぐために必要なオプション
                                       です。0が反転無し、1が左右反転、2が上下反転、3が左右上下反転です。デフォルト値は0です。
    19. options.task                 : 刺激呈示中に被験者が行うタスクを追加します。セル構造体で、下記のメンバを持ちます。
                                       options.task={タスク・モード, タスクの頻度, タスクの呈示時間};
                                       タスク・モードは下記5つから選べます。
                                       0 = タスクなし
                                       1 = 注視点の輝度変化タスク(低輝度の注視点が呈示されたらボタン押し)
                                       2 = バーニエ・バーの左右判別タスク(Ban et al., 2012 Nat Neurosci.のタスクです)
                                           このタスクでは、注視点近辺に呈示された垂直のバーが中心から見て左と右のどちらに出たかを
                                           判断します。左ならoptions.keys(1)を、右ならoptions.keys(2)を押します。両眼視モード
                                           (options.exp_mode='dual')で、注視点をクロス型options.fixation{1}=2にした際に正しく動作します。
                                       3 = 文字変化検出タスク(注視点位置に"C"が呈示されたらボタン押し)
                                       4 = 1-back画像記憶タスク(奇数番目の画像に対して)、同じ画像が連続で呈示されたらボタン押し
                                       5 = 1-back画像記憶タスク(偶数番眼の画像に対して)、同じ画像が連続で呈示されたらボタン押し
                                       タスクの頻度は、整数で指定してください。1を指定すると、protocolfileのblocks{n}.slicingの値を
                                       考慮してoptions.task{3}で設定されるサブ呈示時間毎に毎回タスクが挿入されます。目的にもよります
                                       が、通常3-5辺りを指定しておけば問題ありません。タスクの呈示時間は、blocks{n}.slicingの整数倍で
                                       msecかframe単位でご指定ください。割り切れない場合、例えば、optionfileで各タスクの呈示時間を250ms
                                       と指定し、slicingが100の場合、250msは100msで分割できないため、値が丸められてタスクの呈示時間は
                                       200msとなります。ご注意ください。デフォルト値は、options.task=[0,1,250];です。
    20. options.block_rand           : protocolfileに記述されたblocks{n}をランドマイズするオプションです。
                                       0 = OFF (ランドマイズせずにそのまま呈示)
                                       1 = 全てのブロックの順番をランドマイズ
                                       2 = 偶数番目のブロックの順番をランドマイズ
                                       3 = 奇数番目のブロックの順番をランドマイズ
                                       4 = 前半1/2のブロックの順番をランドマイズ
                                       5 = 後半1/2のブロックの順番をランドマイズ
                                       6 = 2番目から(最後-1)番目までのブロックの順番をランドマイズ
                                       matrixで複数(2つ以上)指定 = matrix番目に当たるブロックの順番をランドマイズします。e.g. [2,4,6,8]
                                       デフォルト値は0です。
    21. options.onset_punch          : イメージ・データベース・ファイル(imgdbfile)の中でimgdb.img{n}{3}に指定したトリガーONの画像が呈示
                                       された際に、画面端にパンチ刺激を呈示するモードです。EEG実験で刺激呈示のトリガーを記録する際や計測
                                       と刺激呈示を同期させる際に便利なオプションです。
                                       options.onset_punch=[モード, パンチ刺激のピクセル・サイズ];
                                       と指定してください。モードは、
                                       0 = パンチ刺激なし
                                       1 = 左上端にパンチ刺激
                                       2 = 右上端にパンチ刺激
                                       3 = 右下端にパンチ刺激
                                       4 = 右下端にパンチ刺激
                                       デフォルト値はoptions.onset_punch=[0,50];です。
    22. options.event_display_mode   : 刺激呈示中、MATLABコンソールウィンドウにどのような情報を表示するかを決めるオプションです。
                                       0 = MATLABウィンドウに現在のブロック、呈示イメージIDのみを表示します。
                                       1 = MATLABウィンドウに呈示イベント(ブロック、ボタン押しなどの時間、種類、トリガーなど)の全ての情報を表示します。

    また、~/ImagesShowPTB/Generation/getGlobalParameters.mを使用すると、条件ファイル内から、subj, acq, session, vparam, dparam, imgs,
    prt, imgsの8つのグローバル変数の中身を参照できます。より柔軟な条件ファイルの作成が可能です。グローバル変数は今のところ読み取りのみ
    可能で、書き込みはできません。

    記述例：

    % display mode, one of "mono", "dual", "dualparallel","dualcross", "cross", "parallel", "redgreen", "greenred", "redblue",
    % "bluered", "shutter", "topbottom", "bottomtop", "interleavedline", "interleavedcolumn", "propixxmono", "propixxstereo"
    options.exp_mode='mono';

    options.scrID=1; % screen ID, generally 0 for a single display setup, 1 for dual display setup

    % how to start the experiment
    % 0: press ENTER or SPACE, 1: click left-mouse button, 2: wait the first MR trigger (CiNet),
    % 3: waiting for a MR trigger pulse (BUIC) -- checking onset of pin #11 of the parallel port
    % 4: custom key trigger (wait for a key input that you specify as options.custom_trigger).
    options.start_method=0;

    % when you want to use your own trigger key to start the stimulus presentation, set a character here.
    % but note that the setting here is valid only when you set options.start_method=4;
    options.custom_trigger='s';

    % response key codes. [1xN] matrix in which all the keycodes to be used are stored.
    options.keys=[37,39]; % 37=left arrow, 39=right arrow

    % screen length along y and x axes which you want to use [row,col] (pixels)
    options.window_size=[1200,1920];

    % if you need to change RGB video input intensities (e.g. for red-green glasses display mode),
    % please set these values [2(left/right) x 3(RGB)]. Valid only when ~strcmpi(options.exp_mode,'mono')
    options.RGBgain=[1.0,1.0,1.0; 1.0,1.0,1.0];

    % fixation parameter, {fixation type(0: non, 1: circle, 2: cross),size,color}
    %options.fixation={2,24,[255,255,255]};
    options.fixation={1,6,[255,0,0]};

    % background parameters,
    % {type(uniform(0) or with patches(1)),background_RGB,patch1_RGB,patch2_RGB,patch_num(row,col),patch_size(row,col),(optional)aperture_size(row,col)}
    options.background={1,[127,127,127],[255,255,255],[0,0,0],[30,30],[20,20]};

    % whether masking display images using a circular aperture mask, {on_off(0|1),radius_pix(row,col),gaussian_parameters(mean,sd)}
    % if you want to put a circular aperture mask on each of the images, please set on_off to 1.
    % if gaussian_parameters(1)=0, no smoothing on the edges is applied.
    options.cmask={1,[280,280],[20,20]};

    % whether setting background color automatically by matching it with the upper-left (1,1) pixel color of the first target image
    options.auto_background=1;

    % whether forcing to use the full-screen display, [0|1]
    options.use_fullscr=0;

    % whether skipping frame sync (flip) test
    option.skip_frame_sync_test=0;

    % whether forcing to use specific frame rate, if 0, the frame rate wil bw computed in the ImagesShowPTB function.
    % if non zero, the value is used as the screen frame rate.
    option.force_frame_rate=60;

    % whether forcing to use frames (vertical sync signals) as a unit of display duration instead of msec.
    % 0: none, 1: force to use the number of frames for presentation duration setting
    options.use_frame=0;

    % whether presenting images with original resolution
    % 0: display images with sizes set in image_database file. 1: diplay image with their original sizes
    options.use_original_imgsize=0;

    % whether reading images one by one in creating PTB textures
    % 1: load images to the memory one by one when creating the target texture.
    % 2: load all the images at once before the actual presentation, but make texture when requested.
    % 3: load all the images at once and make all the textures before the actual presentation
    % By setting this to 1, you can save memory, but it requires additional computation time in presentation
    % When you set this to 2 or 3, you can save computational time, but requires more memory on your computer.
    % I recommend to test options.img_loading_mode=2 first.
    options.img_loading_mode=3;

    % image offset, [row,col]. when set [0,0], images will be presented at the center of the screen
    options.center=[0,0];

    % whether flipping images, 0: none, 1: x-axis, 2: y-axis, 3: x&y-axis
    options.img_flip=0;

    % whether adding task during the experiment. [1x3] matrix. [type,frequency,duration]
    % about type. 0: no task, 1: fixation dim, 2: vernier task, 3: character detection task, when 'C' is presented, press a key
    % 4: 1-back identification task for odd sequence, 5: 1-back identification task for even sequence
    % about frequency (integer): how often the tasks occur during the experiment, 1 is the most frequent (every time, not recommend).
    % 3-5 would be practically fine.
    % about duration: task duration in msec or frame
    % !!!NOTEICE!!! Even you do not need to interpose task (options.task(1)=0), please set the other 2 variables.
    % when you use task in your experiment, please fix the unit of the durations in protocolfile as 'msec' or 'frame'. please do not mix.
    %options.task=[0,4,250];
    options.task=[1,4,250];
    %options.task=[2,4,250];
    %options.task=[3,3,250];

    % whether randomize the order of the 'blocks' in protocol file.
    % 0:OFF, 1:ALL, 2:Even seq. only, 3:Odd seq. only, 4:first half seq. only, 5:last half seq. only
    % 6:2-N-1 blocks are randomized whereas the first and the last blocks are fixed.
    % matrix:randomize specific blocks you set. e.g. options.block_rand=[2,4,6,8];
    options.block_rand=0;

    % whether displaying stimulus onset marker for images with trigger=ON. (you can set in your image database file).
    % the marker can be used to get a photodiode trigger etc.
    % [type,onset_marker_size]
    % type, 0: none, 1: upper-left, 2: upper-right, 3: lower-left, 4: lower-right
    % onset_marker_size : pixels of the marker
    options.onset_punch=[2,50];

    % how to display the progress of image presentations on the MATLAB terminal window.
    % 0: displaying block and image sequences only
    % 1: displaying event details including presentation time, responses, triggers etc.
    options.event_display_mode=0;


 [出力ファイル(実験結果の記録ファイル)について]
 * 実験結果は~/ImagesShowPTB/subjects/(被験者名)ディレクトリ以下に保存されます。

 1) MATLABコマンドウィンドウのログ
    刺激呈示中、MATLABコマンドウィンドウには呈示刺激やPsychtoolboxの警告、エラーが表示されます。これらの情報は、diary()関数により
    ~/ImagesShowPTB/subjects/(被験者名)/results/(YYMMDD)/(被験者名)_ImagesShowPTB_results_run_%02d.log
    というテキストファイルに保存されていきます。ログファイルはappendモードで実験ラン毎(ImagesShowPTBのacq引数で指定します)に1つの
    ファイルに追加保存されていきます。このログファイルを確認することで、Psychtoolboxの画像呈示に関する警告やエラー、呈示時間の遅れ
    を追跡できます。

    ログファイルの出力例：

    Using Psychtoolbox 3.0.9 - make sure this is correct before you continue
    step 1: loading viewing size parameters...done.
    step 2: loading display options...done.
    step 3: loading protocols...done.
    step 4: loading image database...done.

    The Presentation Parameters are as below.

    ************************************************
    ****** Script, Subject, Acquistion Number ******
    Date & Time            : 131129 13:11:17
    Running Script Name    : ImagesShowPTB
    Subject Name           : LOC
    Acquisition Number     : 1
    ********* Run Type, Display Image Type *********
    Stimulus Display Mode  : mono
    Full Screen Mode       : 0
    *********** Screen/Display Settings ************
    Screen Height          : 1200
    Screen Width           : 1920
    Window Center [row,col]: [0,0]
    Image Loading Mode     : 3
    Image Flipping         : 0
    Onset Punch [type,size]: [2,50]
    Fixation Type          : 1
    Background Color       : [64,64,64]
    Ciruclar Aperture Mask : 1
    ************ The number of blocks **************
    #conditions            : 21
    Block Randomization    : 0
    ******************* Task ***********************
    Task Type              : 1
    Task Frequency         : 4
    Task Duration          : 250
    ************** Experiment Time *****************
    Estimated Exp Time     : 336.00 secs
    ************** The Other Settings **************
    Start Method           : 0
    Force to use frame     : 0
    ************ Response key settings *************
    Reponse Key #1        : 37=left
    Reponse Key #2        : 39=right
    ************************************************

    Please check all the parameters above carefully before proceeding.

    Are you ready to proceed? (y/n) : y


    PTB-INFO: This is Psychtoolbox-3 for Microsoft Windows, under Matlab (Version 3.0.9 - Build date: Aug 23 2011).
    PTB-INFO: Type 'PsychtoolboxVersion' for more detailed version information.
    PTB-INFO: Most parts of the Psychtoolbox distribution are licensed to you under terms of the MIT License, with
    PTB-INFO: some restrictions. See file 'License.txt' in the Psychtoolbox root folder for the exact licensing conditions.



    OpenGL-Extensions are: GL_ARB_color_buffer_float GL_ARB_depth_texture GL_ARB_draw_buffers GL_ARB_fragment_program GL_ARB_fragment_program_shadow GL_ARB_fragment_shader GL_ARB_half_float_pixel GL_ARB_imaging GL_ARB_multisample GL_ARB_multitexture GL_ARB_occlusion_query GL_ARB_pixel_buffer_object GL_ARB_point_parameters GL_ARB_point_sprite GL_ARB_shadow GL_ARB_shader_objects GL_ARB_shading_language_100 GL_ARB_texture_border_clamp GL_ARB_texture_compression GL_ARB_texture_cube_map GL_ARB_texture_env_add GL_ARB_texture_env_combine GL_ARB_texture_env_dot3 GL_ARB_texture_float GL_ARB_texture_mirrored_repeat GL_ARB_texture_non_power_of_two GL_ARB_texture_rectangle GL_ARB_transpose_matrix GL_ARB_vertex_buffer_object GL_ARB_vertex_program GL_ARB_vertex_shader GL_ARB_window_pos GL_ATI_draw_buffers GL_ATI_texture_float GL_ATI_texture_mirror_once GL_S3_s3tc GL_EXT_texture_env_add GL_EXT_abgr GL_EXT_bgra GL_EXT_blend_color GL_EXT_blend_equation_separate GL_EXT_blend_func_separate GL_EXT_blend_minmax GL_EXT_blend_subtract GL_EXT_compiled_vertex_array GL_EXT_Cg_shader GL_EXT_bindable_uniform GL_EXT_depth_bounds_test GL_EXT_draw_buffers2 GL_EXT_draw_instanced GL_EXT_draw_range_elements GL_EXT_fog_coord GL_EXT_framebuffer_blit GL_EXT_framebuffer_multisample GL_EXT_framebuffer_object GL_EXTX_framebuffer_mixed_formats GL_EXT_framebuffer_sRGB GL_EXT_geometry_shader4 GL_EXT_gpu_program_parameters GL_EXT_gpu_shader4 GL_EXT_multi_draw_arrays GL_EXT_packed_depth_stencil GL_EXT_packed_float GL_EXT_packed_pixels GL_EXT_pixel_buffer_object GL_EXT_point_parameters GL_EXT_rescale_normal GL_EXT_secondary_color GL_EXT_separate_specular_color GL_EXT_shadow_funcs GL_EXT_stencil_two_side GL_EXT_stencil_wrap GL_EXT_texture3D GL_EXT_texture_array GL_EXT_texture_buffer_object GL_EXT_texture_compression_latc GL_EXT_texture_compression_rgtc GL_EXT_texture_compression_s3tc GL_EXT_texture_cube_map GL_EXT_texture_edge_clamp GL_EXT_texture_env_combine GL_EXT_texture_env_dot3 GL_EXT_texture_filter_anisotropic GL_EXT_texture_integer GL_EXT_texture_lod GL_EXT_texture_lod_bias GL_EXT_texture_mirror_clamp GL_EXT_texture_object GL_EXT_texture_sRGB GL_EXT_texture_shared_exponent GL_EXT_timer_query GL_EXT_vertex_array GL_IBM_rasterpos_clip GL_IBM_texture_mirrored_repeat GL_KTX_buffer_region GL_NV_blend_square GL_NV_copy_depth_to_color GL_NV_depth_buffer_float GL_NV_conditional_render GL_NV_depth_clamp GL_NV_fence GL_NV_float_buffer GL_NV_fog_distance GL_NV_fragment_program GL_NV_fragment_program_option GL_NV_fragment_program2 GL_NV_framebuffer_multisample_coverage GL_NV_geometry_shader4 GL_NV_gpu_program4 GL_NV_half_float GL_NV_light_max_exponent GL_NV_multisample_coverage GL_NV_multisample_filter_hint GL_NV_occlusion_query GL_NV_packed_depth_stencil GL_NV_parameter_buffer_object GL_NV_pixel_data_range GL_NV_point_sprite GL_NV_primitive_restart GL_NV_register_combiners GL_NV_register_combiners2 GL_NV_texgen_reflection GL_NV_texture_compression_vtc GL_NV_texture_env_combine4 GL_NV_texture_expand_normal GL_NV_texture_rectangle GL_NV_texture_shader GL_NV_texture_shader2 GL_NV_texture_shader3 GL_NV_transform_feedback GL_NV_vertex_array_range GL_NV_vertex_array_range2 GL_NV_vertex_program GL_NV_vertex_program1_1 GL_NV_vertex_program2 GL_NV_vertex_program2_option GL_NV_vertex_program3 GL_NVX_conditional_render GL_SGIS_generate_mipmap GL_SGIS_texture_lod GL_SGIX_depth_texture GL_SGIX_shadow GL_SUN_slice_accum GL_WIN_swap_hint WGL_EXT_swap_control GL_Autodesk_valid_back_buffer_hint

    PTB-INFO: The detected endline of the vertical blank interval is equal or lower than the startline. This indicates
    PTB-INFO: that i couldn't detect the duration of the vertical blank interval and won't be able to correct timestamps
    PTB-INFO: for it. This will introduce a very small and constant offset (typically < < 1 msec). Read 'help BeampositionQueries'
    PTB-INFO: for how to correct this, should you really require that last few microseconds of precision.
    PTB-INFO: Btw. this can also mean that your systems beamposition queries are slightly broken. It may help timing precision to
    PTB-INFO: enable the beamposition workaround, as explained in 'help ConserveVRAM', section 'kPsychUseBeampositionQueryWorkaround'.


    PTB-INFO: OpenGL-Renderer is NVIDIA Corporation :: Quadro FX 570M/PCI/SSE2 :: 2.1.2
    PTB-INFO: VBL startline = 1440 , VBL Endline = 1440
    PTB-INFO: Measured monitor refresh interval from beamposition = 16.693246 ms [59.904468 Hz].
    PTB-INFO: Will use beamposition query for accurate Flip time stamping.
    PTB-INFO: Measured monitor refresh interval from VBLsync = 16.692842 ms [59.905916 Hz]. (50 valid samples taken, stddev=0.014713 ms.)
    PTB-INFO: Reported monitor refresh interval from operating system = 16.666667 ms [60.000000 Hz].
    PTB-INFO: Small deviations between reported values are normal and no reason to worry.
    PTB-INFO: Using OpenGL GL_TEXTURE_RECTANGLE_EXT extension for efficient high-performance texture mapping...
    saving the stimulus generation and presentation parameters...done.

    Experiment Start.
    Block #001(Fixation): 001
    Block #002(Building): 016 001 010 001 003 001 011 001 002 001 013 001 020 001 021 001 005 001 004 001 017 001 009 001 006 001 014 001 012 001 019 001 015 001 007 001 008 001 018 001
    Block #003(HandMosa): 166 001 170 001 173 001 169 001 181 001 178 001 167 001 177 001 172 001 174 001 164 001 180 001 165 001 162 001 176 001 171 001 163 001 175 001 179 001 168 001
    Block #004(   Faces): 035 001 028 001 041 001 032 001 040 001 030 001 036 001 031 001 025 001 039 001 034 001 022 001 038 001 024 001 037 001 033 001 029 001 027 001 023 001 026 001
    Block #005(ObjectMo): 183 001 201 001 198 001 200 001 196 001 191 001 188 001 194 001 182 001 187 001 195 001 192 001 184 001 186 001 199 001 197 001 189 001 185 001 193 001 190 001
    Block #006(Fixation): 001
    Block #007(FaceMosa): 206 001 219 001 204 001 208 001 205 001 220 001 207 001 211 001 218 001 221 001 210 001 203 001 213 001 217 001 215 001 202 001 216 001 214 001 209 001 212 001
    Block #008(   Hands): 060 001 051 001 049 001 052 001 044 001 050 001 061 001 046 001 056 001 045 001 042 001 058 001 059 001 043 001 048 001 054 001 053 001 057 001 047 001 055 001
    Block #009(Building): 234 001 238 001 230 001 225 001 223 001 232 001 224 001 222 001 236 001 227 001 228 001 239 001 226 001 237 001 235 001 241 001 240 001 231 001 229 001 233 001
    Block #010(Objects ): 071 001 074 001 077 001 062 001 070 001 079 001 067 001 066 001 076 001 069 001 065 001 064 001 063 001 080 001 078 001 081 001 075 001 073 001 068 001 072 001
    Block #011(Fixation): 001
    Block #012(Objects ): 084 001 085 001 098 001 089 001 092 001 083 001 082 001 100 001 090 001 086 001 096 001 087 001 094 001 099 001 091 001 101 001 088 001 097 001 093 001 095 001
    Block #013(Building): 257 001 260 001 243 001 255 001 251 001 250 001 248 001 256 001 247 001 253 001 249 001 242 001 245 001 259 001 246 001 254 001 261 001 258 001 252 001 244 001
    Block #014(   Hands): 102 001 114 001 106 001 119 001 110 001 113 001 103 001 111 001 117 001 112 001 104 001 108 001 109 001 105 001 120 001 116 001 115 001 121 001 107 001 118 001
    Block #015(FaceMosa): 276 001 263 001 273 001 265 001 270 001 271 001 272 001 278 001 267 001 268 001 262 001 280 001 266 001 274 001 269 001 275 001 281 001 264 001 279 001 277 001
    Block #016(Fixation): 001
    Block #017(ObjectMo): 295 001 288 001 300 001 298 001 296 001 297 001 284 001 290 001 289 001 291 001 294 001 282 001 287 001 292 001 285 001 286 001 301 001 293 001 299 001 283 001
    Block #018(   Faces): 127 001 137 001 140 001 138 001 136 001 122 001 139 001 124 001 128 001 134 001 131 001 141 001 125 001 126 001 130 001 129 001 123 001 133 001 132 001 135 001
    Block #019(HandMosa): 309 001 313 001 310 001 308 001 319 001 302 001 312 001 305 001 316 001 306 001 321 001 315 001 304 001 318 001 314 001 317 001 307 001 320 001 311 001 303 001
    Block #020(Building): 153 001 159 001 155 001 148 001 145 001 146 001 144 001 149 001 156 001 157 001 161 001 158 001 150 001 143 001 142 001 160 001 154 001 151 001 152 001 147 001
    Block #021(Fixation): 001
    Experiemnt Completed: 336.000/336.000 sec.
    saving the results...done.

    ******************************
    Total Tasks     : 264
    Total Responses : 98
    Hit Rate        : 35.9848%
    False alarms    : 3
    Median RT (Hit) : 427.8751 ms
    ******************************


    PTB-INFO: There are still 329 textures, offscreen windows or proxy windows open. Screen('CloseAll') will auto-close them.
    PTB-INFO: This may be fine for studies where you only use a few textures or windows, but a large number of open
    PTB-INFO: textures or offscreen windows can be an indication that you forgot to dispose no longer needed items
    PTB-INFO: via a proper call to Screen('Close', [windowOrTextureIndex]); , e.g., at the end of each trial. These
    PTB-INFO: stale objects linger around and can consume significant memory ressources, causing degraded performance,
    PTB-INFO: timing trouble (if the system has to resort to disk paging) and ultimately out of memory conditions or
    PTB-INFO: crashes. Please check your code. (Screen('Close') is a quick way to release all textures and offscreen windows)



    INFO: PTB's Screen('Flip', 10) command seems to have missed the requested stimulus presentation deadline
    INFO: a total of 54 times out of a total of 1285 flips during this session.

    INFO: This number is fairly accurate (and indicative of real timing problems in your own code or your system)
    INFO: if you provided requested stimulus onset times with the 'when' argument of Screen('Flip', window [, when]);
    INFO: If you called Screen('Flip', window); without the 'when' argument, this count is more of a ''mild'' indicator
    INFO: of timing behaviour than a hard reliable measurement. Large numbers may indicate problems and should at least
    INFO: deserve your closer attention. Cfe. 'help SyncTrouble', the FAQ section at www.psychtoolbox.org and the
    INFO: examples in the PDF presentation in PsychDocumentation/Psychtoolbox3-Slides.pdf for more info and timing tips.

 2) 画像呈示時間、トリガー、被験者の応答のログ
    使用した画像、呈示オプション、実験プロトコル、被験者の応答は
    ~/ImagesShowPTB/subjects/(被験者名)/results/(YYMMDD)/(被験者名)_ImagesShowPTB_results_run_%02d.mat
    というMATLAB形式のファイルに保存されていきます。この際、ImagesShowPTBのoverwrite_flgを1に設定しておくと、対象ディレクトリ以下に
    すでに同名のファイルが存在する場合(例えば、実験中に何かの問題が生じ、2番目の実験(acq=2)を2度行った際など)に、古いファイルを
    ~/ImagesShowPTB/subjects/(被験者名)/results/(YYMMDD)/(被験者名)_ImagesShowPTB_results_run_%02d_old.mat
    と'_old'というプレフィックスをつけてバックアップします(途中で中断したデータも解析できるように)。バックアップが必要ない場合は、
    overwrite_flgを0に設定してください。
    このファイルには、下記の変数が記録されています。特に、event変数が後の解析に重要です。
    subj        : 被験者名
    acq         : ラン番号
    prt         : 実験プロトコル (protocolfileで指定したblocks{n}を処理したもの)
    vparam      : 視距離などの情報 (viewfileで指定したvparam)
    dparam      : ディスプレイ・パラメータ (optionfileで指定したoptions構造体を処理したもの)
    task        : タスクの種類、呈示タイミング、成績(正答、エラー、false alarm)、反応時間など
    gamma_table : 使用したガンマ・テーブル (ImagesShowPTBのgamma_tableに空行列を指定した場合は、repmat(linspace(0.0,1.0,256),3,1))
    event       : イベントログ。実験スタート時間、刺激のオンセット、被験者の応答、トリガーなどが記録されたセル構造体
                  event{n}={イベントの時間(sec単位、実験開始が0), イベントの名前(Stim ONなど), パラメータ};
                  が記録されています。
    imgs        : imgdbfileで記述したimgsセル構造体

    eventセル構造体の中身の例：

            []    'Experiment Start'    '131129 13:11:25'
    [  0.0033]    'Start block 001'     'Fixation 1'
    [  0.0255]    'Stim on'             '1'
    [  1.2605]    'Lum Task'            [                1]
    [  1.7118]    'Response'            'key1'
    [  2.2600]    'Lum Task'            [                1]
    [  2.6394]    'Response'            'key1'
    [  3.0112]    'Lum Task'            [                1]
    [  3.3839]    'Response'            'key1'
    [  5.2648]    'Lum Task'            [                1]
    [  5.5759]    'Response'            'key1'
    [  5.7656]    'Lum Task'            [                1]
    [  6.0877]    'Response'            'key1'
    [  7.0176]    'Lum Task'            [                1]
    [  7.3119]    'Response'            'key1'
    [  7.7689]    'Lum Task'            [                1]
    [  8.0476]    'Response'            'key1'
    [  8.2529]    'Lum Task'            [                1]
    [  8.5562]    'Response'            'key1'
    [  9.0041]    'Lum Task'            [                1]
    [  9.3758]    'Response'            'key1'
    [ 10.0057]    'Lum Task'            [                1]
    [ 10.3115]    'Response'            'key1'
    [ 10.7568]    'Lum Task'            [                1]
    [ 11.0721]    'Response'            'key1'
    [ 12.0089]    'Lum Task'            [                1]
    [ 12.3113]    'Response'            'key1'
    [ 13.5113]    'Lum Task'            [                1]
    [ 13.9041]    'Response'            'key1'
    [ 14.0121]    'Lum Task'            [                1]
    [ 14.3593]    'Response'            'key1'
    [ 14.5128]    'Lum Task'            [                1]
    [ 14.8553]    'Response'            'key1'
    [ 15.0136]    'Lum Task'            [                1]
    [ 15.3114]    'Response'            'key1'
    [ 15.7674]    'Response'            'key1'
    [ 16.0003]    'Start block 002'     'Building'
    [ 16.0153]    'Stim on'             '16'
    [ 16.0156]    'Lum Task'            [                1]
    [ 16.5161]    'Stim on'             '1'
    [ 16.6795]    'Response'            'key1'
    [ 16.8166]    'Stim on'             '10'
    .
    .
    .
    .
    .
    [330.5179]    'Lum Task'            [                1]
    [330.6487]    'Response'            'key1'
    [331.2692]    'Lum Task'            [                1]
    [331.3119]    'Response'            'key1'
    [331.7699]    'Lum Task'            [                1]
    [332.0794]    'Response'            'key1'
    [332.5211]    'Lum Task'            [                1]
    [332.8480]    'Response'            'key1'
    [333.2556]    'Lum Task'            [                1]
    [333.5677]    'Response'            'key1'
    [335.0084]    'Lum Task'            [                1]
    [335.4320]    'Response'            'key1'
    [336.0025]    'End'                                  []

7. その他の注意点

 *このImagesShowPTBプログラムは画像を順に呈示するだけで負荷が軽いので、最近の高速なCPUを積んだコンピュータをお使いの際には、処理時間、
  呈示時間がずれることはないと思います。きわどい場合には、画面の表示モード（解像度、色数など）、電源管理、仮想記憶などに起因するエラー
  や割り込み処理が関わっている可能性があります。イベント・ログなどで呈示の妨げとなっている処理がないか、確認してください。また、他の
  プログラムは全て終了してから、実行して下さい。

 *プロジェクターとの相性
  歪みのチェック＆補正を行って下さい。正方形を画面中心に描いて、画面のプロパティの詳細メニューなどで調整して下さい。調整の方法は、
  コンピュータのグラフィックス・ドライバーに依存します。詳細は各メーカのホームページを調べて下さい。また、できる限り実験時と同様の
  ケーブル構成(形式、長さ、延長)にして下さい。信号の減衰のせいで表示できなくなる場合もあります。

 *ImagesShowPTBの改良
  MATLAB(MathWorks, http://www.mathworks.com)とPsychtoolboxが必要です。Psychtoolboxの詳細は、http://psychtoolbox.org/HomePageをご覧ください。
  ImagesShowPTBのメイン・スクリプトは、
  ~/ImagesShowPTB/Presentation/ImagesShowPTB.m
  です。同じディレクトリにあるrun_exp.mは、ImagesShowPTB.mを呼び出すための簡単なラッパー・スクリプトの例です。呈示手続きその他に変更
  が必要な場合は、これらのスクリプトを修正してください。また、ImagesShowPTB.mは処理の中で、
  ~/ImagesShowPTB/Generation
  ~/ImagesShowPTB/Common
  にあるサブ関数を呼んでいます。必要に応じてこれらの関数も修正してください。

  もしご質問がございましたら、番浩志(ばんひろし)までご連絡ください。
  ban.hiroshi@gmail.com

8. これからすべきこと

 1) Movie版ImagesShow.exe(*.mpegファイルへの対応)
 2) イメージにマスクフィルタをかけて呈示

 以下、過去のバージョンで対応済
 1) fMRI実験においてMR装置からのトリガー入力を受けて刺激を同期スタート(CONTEC版は対応済。KV版は未対応) COMPLETED! July 16 2007 H.Ban
 2) デュアルディスプレイモード(両眼闘争や両眼立体視向け) COMPLETED! Nov 15 2013 H.Ban
 3) 呈示時間のリアルタイム補正(*.condファイル内のrestブロックで補正をかける仕組みを作成) COMPLETED! July 14 2007 H.Ban
 4) 画面端に刺激呈示オンセットを知らせるパンチ刺激を呈示するモードを追加 COMPLETED! July 17 2007 H.Ban

9. プログラム更新履歴

・初代PresentImage.tcl  tcl version         1999 H.Yamamoto
・初代PresentImage.cpp  Cxx version         2002 H.Yamamoto

・C++クラスによる記述                       Dec. 24 2003 H.Ban (T_T)/~~
・CONTEC digital I/Oとの同期                Dec. 24 2003 H.Ban
・自動で注視点追加モード                    Dec. 25 2003 H.Ban (o^-')b
・time.h --> Win32API multimedia timer      Jan. 20 2004 H.Ban
・アニメーションパフォーマンス改善          Jan. 24 2004 H.Ban
・Dynamic Storage Allocation
  (読み込めるブロック、イメージ数がメモリの許す限り無限に)
                                            Jan. 24 2004 H.Ban
・実行時にmultimedia timerを自動で初期化    Jan. 25 2004 H.Ban
・PresentImages 改め ImagesShowへ           Mar. 06 2005 H.Ban
・イメージシーケンスのランドマイズ機能      Mar. 06 2005 H.Ban
・フルスクリーンレンダリング                Mar. 10 2005 H.Ban
・Keyence KV Controllerとの同期             Mar. 11 2005 H.Ban
・vtk3.2 -> vtk4.2 static library           Mar. 12 2005 H.Ban
・レンダーウィンドウの境界なくす            Mar. 12 2005 H.Ban
・*.jpg, *.png, *.tiff形式に対応            Mar. 14 2005 H.Ban
・レンダーウィドウ上でマウスクリックスタート    Mar. 14 2005 H.Ban
・*.pnm形式に対応                           Mar. 15 2005 H.Ban
・読み込みファイルの記述内容変更            Mar. 16 2005 H.Ban
・ViewPort (xmin, ymin, xmax, ymax) -> IMAGE-CENTER (x,y)
                                            Mar. 16 2005 H.Ban
・Interface GPC (General Pulse Counter)との連携
                                            Mar. 16 2007 H.Ban
・ログファイルの出力 (PresentedLog*.txt)    Mar. 16 2005 H.Ban
・ログファイルの出力 (KVSwitchLog*.txt)     Mar. 16 2005 H.Ban
・最初に画像を呈示せず、メモリ上にのみレンダリング
                                            July 05 2007 H.Ban
・x&y軸に沿って画像を反転                   July 05 2007 H.Ban
・VC++6.0からVC++.NET 2003へコンパイラを変更  July 07 2007 H.Ban
・vtk4.2 static library -> vtk5.0.3 static library
                                            July 07 2007 H.Ban
・レンダーウィンドウ上からマウスカーソルを消去  July 07 2007 H.Ban
・右マウスクリックで呈示スタート -> 左マウスクリック
                                            July 07 2007 H.Ban
・ImagesShow.exeのアイコン変更              July 08 2007 H.Ban
・呈示画像のbilinear補間による拡大/縮小が可能   July 09 2007 H.Ban
・FFA(Fusiform Face Area) & PPA(Parahipocampal Place Area) &
  EBA(Extrastriate Body Area)を同定するためのコンディションを
  あらかじめ用意
                                            July 09 2007 H.Ban
・呈示時間の誤差をリアルタイムで補正する機能を追加
                                            July 14 2007 H.Ban
・Newバージョン：Interface GPC (General Pulse Counter)との連携
                                            July 16 2007 H.Ban
・Newバージョン：Log file (GPCSwitchTriggerLog*.txt)の出力
                                            July 16 2007 H.Ban
・Newバージョン: ImageDatabaseファイル        July 17 2007 H.Ban
・画面端に刺激呈示のオンセットを知らせるパンチ刺激を呈示するモード
                                            July 17 2007 H.Ban
・Interface GPCと連携して、ディスプレイの垂直同期信号を取得、
  指定したフレーム数だけ呈示するモードの追加
                                            July 17 2007 H.Ban
・VTK5.4.2ライブラリへアップデート
                                            June 05 2009 H.Ban
・VC++.NET 2003からVC++.NET 2005へコンパイラを変更、実行速度アップ
                                            June 05 2009 H.Ban
・Matlab_imageprocessingを追加、様々な画像処理が可能
                                            June 05 2009 H.Ban
・vtk5.4.2をboost C++ 1.38を組み込んでコンパイル
                                            July 26 2009 H.Ban
・RunTEST()をCONTEC digital I/O, KV digital I/O, GPC digital I/Oと連携可能に
                                            July 26 2009 H.Ban
・*.displayファイルのSTART-METHODで0(RETURN Key start)を選んだ際、
  コンソール上でなく、レンダーウィンドウ上でリターンキーを押すことで刺激呈示スタート
                                            July 26 2009 H.Ban
・CONTEC digital I/Oと連携中にdigital I/Oへ刺激の種類のトリガーを送出可能に
                                            July 26 2009 H.Ban
・C++ソースをもとに、MATLAB & Psychtoolboxバージョンを作成
  内部の画像処理および呈示手続き新しいものに変更
  両眼呈示に対応、タスクの自動追加モード
                                            Nov  15 2013 H.Ban
・文字検出タスクの追加                      Nov  18 2013 H.Ban
・左右眼画像に異なるパラメータを設定可能に
                                           Nov  21 2013 H.Ban
・バグ修正、メモリを使いすぎないように内部処理を変更
                                           Nov  23 2013 H.Ban
・バグ修正、バージョン1.0 最終版を作成
                                           Nov  25 2013 H.Ban
・左右眼画像の処理を効率的にするため、変数の構造を変更
                                           Nov  28 2013 H.Ban
・円形窓マスクを追加するオプション         Nov  29 2013 H.Ban
・シーケンスに0番を指定することで、画像呈示を行わない(背景のみ呈示)
  オプションを追加                         July 13 2015 H.Ban
・入力パラメータに"session"を追加(日付の違いなどでファイルを区別する際に利用可能)
                                            July 14 1014 H.Ban
・subj, acq, session, vparam, dparam, imgs, prt, imgsの8変数を
  グローバル変数とした。変数へ外部からのアクセスを許可するのは
  危険かもしれないが、より柔軟な条件ファイル作成のために変更を
  決めた。グローバル変数の中身は、今のところ読み取りのみ可能で、
  書き込みは不可。変数の中身を取得するためには、
  ~/ImagesShowPTB/Generation/getGlobalParameters.m
  を使用する
                                            July 14 2014 H.Ban
・四角形窓マスクを追加するオプション        July 14 2014 H.Ban
・フレームの同期テストをスキップするオプションの追加
                                            Aug  29 2016 H.Ban
・特定のフレームレートを指定して呈示を行うオプションの追加
                                            Aug  29 2016 H.Ban
・単一背景、パッチ付き背景の選択が可能に    Aug  29 2016 H.Ban
・protocolfile、imgdbfile、viewfile、optionfileの4つのファイル
  を記述する際にスクリプト形式のみではなく、MATLAB関数形式にも
  対応させた。より柔軟な制御が可能となった。Aug  29 2016 H.Ban
・MATLABコンソールウィンドウに表示する刺激呈示情報の種類を
  オプションで選択可能に(簡易あるいは詳細モード)
                                            Oct  23 2016 H.Ban
・カナダVPIXX社PROPixxプロジェクタ上への刺激呈示に対応(2D/3D呈示ともに可)
                                            June 03 2021 H.Ban
・刺激を呈示するスクリーンのIDを選択するオプションの追加
                                            June 03 2021 H.Ban
