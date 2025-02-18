# **README on ImagesShow**

<div align="right">
Created    : "2003-12-24 10:25:05 ban"<br>
Last Update: "2025-02-18 22:04:03 ban"
</div>

<br>
<div align="center">
<img src="https://img.shields.io/badge/LANGUAGE-MATLAB-brightgreen" />
<img src="https://img.shields.io/badge/DEPENDENCY-Psychtoolbox3-green" />
<img src="https://img.shields.io/badge/EDITED%20BY-EmEditor%20&%20VS%20Code-blue" />
<img src="https://img.shields.io/badge/LICENSE-BSD-red" /><br>
<img src="https://img.shields.io/badge/KEYWORDS-Vision%20Science,%203D,%20stereo,%20binocular,%20Perception,%20Recognition,%20fMRI,%20MEG,%20EEG,%20&%20Psychophysics-blue?style=social&logo=webauthn" /><br>
<img src="https://img.shields.io/badge/CONTACT-lightgrey" /> <img src="doc/images/ban_hiroshi_address.png" />
</div>
<br>

***

# <a name = "Menu"> **メニュー** </a>

- [はじめに - ImagesShowソフトウェアの概要](#Introduction)
- [動作環境](#System)
- [ImagesShowの実行方法](#Launch)
  - [ImagesShowPTB.mの詳細](#Details)
  - [protocolfileについて](#Protocolfile)
  - [imgdbfileについて](#Imgdbfile)
  - [viewfileについて](#Viewfile)
  - [optionfileについて](#Optionfile)
  - [log filesについて](#Logfiles)
- [謝辞](#Acknowledgments)
- [ライセンス](#License)
- [ImagesShowの引用](#Citation)
- [更新履歴](#History)
- [TODOs](#TODOs)


English version of README.md is available from [here.](README.md)  
英語版 README.mdは[こちら](README.md)  

***

# <a name = "Introduction"> **はじめに - ImagesShowソフトウェアの概要** </a>

![ImagesShow](doc/images/00_ImagesShow.gif)  

**ImagesShow**は、心理行動実験および脳機能イメージング実験(fMRIやMEG)用の視覚刺激の呈示を行う「**デジタル紙芝居**」ソフトウェア・パッケージで、**MATLAB**言語で記述されています。ソフトウェアに用意された様々なオプションを指定することで、柔軟かつ精確に視覚刺激の呈示を制御できます。特に、基本機能として、ImagesShowは複数の画像をメモリに読み込み、視覚実験に必要な様々なオプションとともにそれらの画像を指定した順、あるいはランダムに呈示するための仕組みを備えています。fMRI実験におけるブロックデザインやイベントリレイテッドデザインをはじめとする現行の標準的な視覚刺激呈示デザインはほぼ全てカバーできます。いくつかの設定ファイルの記述といくつかのオプションの指定だけで、それら様々な刺激呈示デザインの設計が可能です。また、ImagesShowは通常のシングル・ディスプレイ表示のみでなく、両眼立体視や両眼視野闘争で用いられるデュアル・ディスプレイ表示設定にも標準で対応しています。

(MATLABは、[***The Mathworks Inc.*** ](https://www.mathworks.com/)の商標です )  

**[主な機能]**  

- **特徴**  
1. ImagesShowは、複数の画像を読み込み、それらを指定された順番あるいはランダムに呈示しながら、それらの画像に対する様々な反応(参加者の応答、選好、fMRI/MEGなどで計測される脳活動)を記録するような心理行動実験、脳機能イメージング実験に特に適しています(e.g. 物体画像の知覚・認知実験など).  
2. ブロックデザインとイベントリレイテッドデザインのどちらのfMRI/MEG/EEG実験にも対応可能です。設定ファイルをうまく記述すれば、現行の視覚実験デザインのほぼ全てを再現可能です。  
3. MATLABで読み込める画像形式ならどのような画像が混在していても、それらを一括で処理・呈示することが可能です。MATLAB *.matファイル形式で保存された画像マトリックスにも対応しています。プログラム本体はスクリプト言語で記述されているので、少しの変更を加えれば、独自の画像読み込みルーチンを組み込むことも可能です。  
4. 視覚刺激プログラム制作ツールのデファクトスタンダードの1つであるMATLAB Psychtoolboxをベースに作られていますので、視覚研究者にとってはカスタマイズが容易です。また、スクリプト言語で記述されているため、他の機能を組み込んだり、あるいはImagesShowの特定の機能を他のプログラムに移植することも容易です。  
5. 画像をどのように読み込み、処理し、呈示するかに関して複数の柔軟なオプションを備えています。それらのオプションを適切に指定することで、少ないメモリしか積んでいないPC上でも数千枚の画像ライブラリを扱うような刺激呈示が可能です。あるいは、メモリ量に心配がなければ、画像を一度に読み込んでおき(画像呈示のメインルーチン実行時にファイルロードによる遅延が生じることを回避し)、刺激呈示タイミングの精確さに重点を置くような設定も可能です。詳細は"optionfileについて"をご覧ください。  
6. 最も重要な機能の1つとして、刺激呈示開始から終了までの動作をリアルタイムで監視し、経過時間を積算して保持する機能を備えています。これにより、刺激呈示中に生じた遅れをオンラインで補正可能です(刺激呈示タイミングは、ミリ秒あるいはフレーム数で指定・補正が可能です)。  
7. 画像の読み込み、呈示に関する多くの柔軟なオプションが提供されています。指定されたオプションに従って、画像の呈示サイズの調整、呈示位置の調整、画像のマスク処理などがプログラム内で実行されるため、元の画像に変更を加えることなく、フォーマットの異なる複数の画像を一括でスムーズに扱うことが可能です。  
8. 実験中の全てのイベント(MATLABの警告/エラー、Psychtoolboxの警告/エラー、刺激呈示タイミング、参加者の応答、反応時間など)はほぼ全てログファイルに記録されます。刺激が適切に呈示されていたかの検証に利用可能です。  
9. 外部装置からのトリガー信号を受けて、刺激呈示の開始と外部装置(fMRI、EEG、MEG、眼球運動計測装置など)の記録開始のタイミングを同期させることが可能です。現在、トリガーとしてキーボード/マウスの仮想入力、パラレルポートのピンの起ち上がりを監視する機能が提供されています。また、視覚刺激のオンセットをフォトダイオードセンサで精確に計測するためのパンチ刺激を画面端に呈示する機能も備えています。  

- **今後、改善が必要な点**  
1. 実験参加者の応答(選択や選好)に応じてリアルタイムで刺激の呈示順を変更したり、新たな刺激を生成することはできません(参加者の応答とは関係なく、刺激呈示順をランダムにするオプションは提供されています)。よって、ImagesShowはステアケース法などの閾値計測には向きません(恒常法には対応可能です)。将来の対応を検討しています。  
2. 動画ファイル(\*.mpegや\*.avi)を扱うことはできません。現行のプログラムでも、パラパラ漫画のように複数の画像ファイルを連続かつ短時間呈示することでモーション刺激を呈示することも可能ですが、将来的に動画ファイルを直接扱うオプションを検討します。  

ImagesShowのより詳細な使用方法は本ドキュメント下部をご覧ください。  
また、~/ImagesShow/Presentation/ImagesShow.m.のコメントもご参照ください。  

**最後に...**  
**本ソフトウェアは、私どもの研究グループの研究内容、研究手法の透明性が保たれますよう、そして私どもの研究グループがオープンな場で有り続けられますよう、一般公開させていただきます。また、本ソフトウェアは、私どものグループの研究内容味を知りたい方々、私どもの研究グループで一緒に研究したい方々、視覚刺激の作り方を知りたい方々のためにも、一般公開と改訂を続けられるよう努力いたします。私どもの研究プロジェクトにご興味をお持ちの方は、お気軽にご連絡ください。**  

私どもの開発したソフトウェアをご利用いただき、ありがとうございます。  
本ソフトウェアがみなさまの研究のお役に立てましたら幸甚に存じます。  

[メニューへ戻る](#Menu)


# <a name = "System"> **動作環境** </a>

- **OS: Windows 7/8/10、Mac OSX、or Linux**  
  - note 1: Linux上でご利用の際には、プログラムの一部(音声(ビープ)処理など)を修正する必要があるかもしれません。  
  - note 2: MacOsやLinux上でご利用の際には、MEXファイル(C/C++ codes)を再コンパイルする必要があります。ご自身の環境で\~/ImagesShow/Common/CompileMEXs.mを走らせていただけば、MEXファイルのコンパイルが可能です。  

- **MATLAB R2009a**以降(私どもはMATLAB **R2020b**上で本プログラムの動作検証をしております)、**Psychtoolbox 3 (PTB3)**(詳細は[Acknowledgments](#Acknowledgments)をご覧ください)、**Image Processing** toolbox.  
  - note: Psychtoolbox(PTB) 3.0.15以上が必要です。それ以前のバージョンのPTB3、PTB2上での動作検証は行っておりません。  

- **Graphics board**  
  - OpenGL互換のグラフィックスボードを積んだPC上でのご利用を推奨します。本ソフトウェアは軽い処理しか実装しておりませんが、CPU付属のグラフィックス機能では一部の動作に遅延が生じる可能性があります。  

[メニューへ戻る](#Menu)


# <a name = "Launch"> **ImagesShowの実行方法** </a>

ImagesShowを実行するためには、2つの方法があります。  
1. ***ImagesShowPTB***を設定ファイルを直接指定して実行します。  
   詳細は[ImagesShow.mプログラムの詳細](#Details)をご参照ください。  
2. ラッパー関数・スクリプトを作成して、その関数・スクリプトからImagesShowPTBを実行してください。  

2つめのオプションがおすすめです。ImagesShowパッケージ内にラッパースクリプトを用意してあります。下記のコマンドで実行できます。  

```Matlab
>> cd ~/ImagesShow/Presentation
>> run_exp('name',acquisition_number,session_number);
```

ここで、***run_exp*** (\~/ImagesShow/Presentation/run_exp.m)が、指定した設定ファイル(\~/ImagesShow/Presentation/subjects/'name'内に保存されています)とともに***ImagesShowPTB()***を呼び出すラッパースクリプトです。'name'は実験参加者の名前あるいはIDを示す文字列(string)です。acquisition_numberは、1以上の自然数で、実験ラン数を示します。session_numberも同じく1以上の自然数で、実験日を区別するためにacquisition_numberに加えてこの変数を用意しています。  

[メニューへ戻る](#Menu)


# <a name = "Details"> **ImagesShowPTB.mの詳細** </a>

````Matlab
ImagesShowPTB(subj,acq,session,protocolfile,imgdbfile,:viewfile,:optionfile,:gamma_table,:overwrite_flg)
(: is optional)
````

***About***  
**ImagesShow** --- 心理行動実験および脳機能イメージング実験(fMRIやMEG)用の視覚刺激の呈示を行う「**デジタル紙芝居**」ソフトウェア・パッケージで、**MATLAB**言語で記述されています。ソフトウェアに用意された様々なオプションを指定することで、柔軟かつ精確に視覚刺激の呈示を制御できます。  

***ImagesShow.mの入力/出力引数***  

[入力引数]  
<pre>
subj         : 実験参加者の名前、'HB'や'test01'. ~/ImagesShowPTB/Presentation/subjects/以下に同じ名前のディレクトリを作成し、
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

</pre>

<pre>
NOTE 1: 設定ファイルの例.

protocolfiles, imgdbdile, viewfile, optionfileの4つの設定ファイルは、
    \~/ImagesShow/Presentation/subjects/(subj_name)/
下に実験参加者のディレクトリ毎に配置する必要があります。記述例は、
    \~/ImagesShow/Presentation/subjects/subj{01|02|03|04|05|06}
にあります。
</pre>

<pre>
NOTE 2: 設定ファイル内で指定したいくつかの変数は、グローバル変数として定義されているため、
        他のスクリプト、関数から参照可能です。

グローバル変数を参照するための関数として、
    \~/ImagesShowPTB/Generation/getGlobalParameters.m
が用意されています。この関数を利用することで、下記の8つの変数の値を参照しながら
設定ファイルをより柔軟に記述できます。

    subj, acq, session, vparam, dparam, imgs, prt, imgs.

なお、上の関数からはこれらの変数の値を参照できますが、その値を変更することはできません。
</pre>


[出力引数]  
出力引数はありません。  

[結果ファイル]  
実験参加者の応答、課題成績、刺激呈示パラメータ、刺激呈示タイミングなどは、下記のログファイル  
*\~/ImagesShowPTB/Presentation/(subj)/results/(yymmdd(date))/(subj)_ImagesShowPTB_results_session_%02d_run_%02d.m*  
*\~/ImagesShowPTB/Presentation/(subj)/results/(yymmdd(date))/(subj)_ImagesShowPTB_results_session_%02d_run_%02d.log*  
に記録されます。刺激呈示プロトコルの確認や応答・反応時間解析をするためには、これらのログファイルをご利用ください。  

***ImagesShow実行例***  
ImagesShowPTB.mの動作を確認するためのサンプルスクリプトが用意されています。  
MATLABコンソール上で*\~/ImagesShowPTB/Presentation*に移動後、下記をお試しください。  

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

パラメータ設定法の詳細については、*\~/ImagesShowPTB/Presentation/subject/subjXX/*.m*の各設定ファイルもご参照ください。  

[メニューへ戻る](#Menu)


# <a name = "Protocolfile"> **protocolfileについて** </a>

protocolfileの記述例: [protocolfile.m](doc/markdowns/protocolfile.md)  

[設定項目の詳細]

**protocolfile**を設定するためには、  
1. **"blocks{N}"**という名前のセル構造体(メンバは下記をご参照ください)を返す関数をお作りください。  
2. あるいは、**"blocks{N}"**セル構造体の中身をMATLABスクリプトに直接ご記述ください。(**こちらを推奨いたします**)。  
   ここで、1,2,3,...,Nは刺激呈示プロトコルのブロックの番号を示しています。  

blocks{n}セル構造体は下記に示す6個のメンバを持ちます。  
<pre>
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
6. blocks{n}.name          : (省略可) このブロックの名前を記述します。省略した場合、blocks{n}.name=sprintf('block %02d',n)
                             となります。
</pre>

このスクリプト中からいくつかのグローバル変数の値を参照することが可能です。詳細は[ImagesShowPTB.mの詳細](#Details)のNOTE 2をご参照ください。  

[メニューへ戻る](#Menu)


# <a name = "Imgdbfile"> **imgdbfileについて** </a>

imgdbfileの記述例: [imgdbfile.m](doc/markdowns/imgdbfile.md)  

[設定項目の詳細]  

**imgdbfile**を設定するためには、  
1. **"imgdb"**という名前の構造体(メンバは下記をご参照ください)を返す関数をお作りください。  
2. あるいは、**"imgdb"**構造体の中身をMATLABスクリプトに直接ご記述ください。(**こちらを推奨いたします**)。  

imgdb構造体は下記に示す5個のメンバを持ちます。  
<pre>
1. imgdb.type               : 画像ファイルのタイプ、'image'か'matlab'の2つからお選びください。
2. imgdb.directory          : 画像ファイルが含まれるディレクトリ(フルパス形式)を指定してください。
3. imgdb.presentation_size  : 画像の呈示サイズ [row,col]。全画像は、ここで指定した大きさにリサイズされます。
                              リサイズしたくない場合は、実際の画像サイズをご指定ください。
                              また、オリジナルの画像サイズで呈示したい場合には、optionfileのuse_original_imgsizeを1にしてください。
4. imgdb.num                : 実験で使用する画像の枚数を記述してください。
5. imgdb.img                : セル構造体。それぞれのセルは、下記3つを変数として持ちます。
                              imgdb.img{n}={'画像ファイル本体へのパスおよびファイル名', '画像ファイルの説明', 'トリガーの有無'}
                              画像ファイル本体へのパスおよびファイル名(string) = imgdb.directoryからの相対パスでご指定ください。
                              directory直下に画像がある場合は、ファイル名のみを記述してください。
                              画像ファイルの説明(string) = この画像ファイルが何であるかの簡単な説明を記述してください。
                              トリガーの有無(integer or string) = 0を指定するとトリガー無し、0以外の数字あるいは文字を指定すると、
                              トリガー有りと判断され、その画像の呈示時に個別の処理が可能です。また、その画像の呈示時間がログに記録されます。
</pre>

このスクリプト中からいくつかのグローバル変数の値を参照することが可能です。詳細は[ImagesShowPTB.mの詳細](#Details)のNOTE 2をご参照ください。  

[メニューへ戻る](#Menu)


# <a name = "Viewfile"> **viewfileについて** </a>

viewfileの記述例: [viewfile.m](doc/markdowns/viewfile.md)  

[設定項目の詳細]  

**viewfile**を設定するためには、  
1. **"vparams"**という名前の構造体(メンバは下記をご参照ください)を返す関数をお作りください。  
2. あるいは、**"vparams"**構造体の中身をMATLABスクリプトに直接ご記述ください。(**こちらを推奨いたします**)。  

vparams構造体は下記に示す3個のメンバを持ちます。  
<pre>
1. ipd        : 眼間距離 (inter pupil distance) をcm単位で記述してください。
2. pix_per_cm : 呈示画面の画素サイズをpixels/cm単位で記述してください。
3. vdist      : 視距離 (viewing distance) をcm単位で記述してください。
</pre>

このスクリプト中からいくつかのグローバル変数の値を参照することが可能です。詳細は[ImagesShowPTB.mの詳細](#Details)のNOTE 2をご参照ください。  

[メニューへ戻る](#Menu)


# <a name = "Optionfile"> **optionfileについて** </a>

optionfileの記述例: [optionfile.m](doc/markdowns/optionfile.md)  

[設定項目の詳細]  

**optionfile**を設定するためには、  
1. **"options"**という名前の構造体(メンバは下記をご参照ください)を返す関数をお作りください。  
2. あるいは、**"options"**構造体の中身をMATLABスクリプトに直接ご記述ください。(**こちらを推奨いたします**)。  

options構造体は下記に示す22個のメンバを持ちます。これらの全てを指定する必要はありません。必要なものだけをご指定ください。指定されていないオプションには、デフォルトの値が自動的に設定されます。  
<pre>
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
                                   3 = 集中注視点。他の形状の注視点よりも中止が持続することが示されています。ただし、サイズが多少大きくなります。
                                       ref: Thaler et al., 2013. Vision Research, 76, 31-42.
                                            https://www.sciencedirect.com/science/article/pii/S0042698912003380
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
                                   と刺激呈示を同期させる際に便利なオプションです。セル構造体です。
                                   options.onset_punch={位置, パンチ刺激のピクセル・サイズ,[R,G,B (トリガーON時のカラー)],[R,G,B (トリガーOFF時のカラー)]};
                                   と指定してください。位置は、
                                    0 = パンチ刺激なし
                                    1 = 左上端にパンチ刺激
                                    2 = 右上端にパンチ刺激
                                    3 = 右下端にパンチ刺激
                                    4 = 右下端にパンチ刺激
                                    5 = 左中央にパンチ刺激
                                    6 = 右中央にパンチ刺激
                                    7 = 上中央にパンチ刺激
                                    8 = 下中央にパンチ刺激
                                    9 = 左端全体にパンチ刺激
                                   10 = 右端全体にパンチ刺激
                                   11 = 上端全体にパンチ刺激
                                   12 = 下端全体にパンチ刺激
                                   13 = バイナリ指定 (特別オプション、image_databaseファイルで指定した複数の位置に同時にパンチ刺激呈示)
                                   デフォルト値はoptions.onset_punch={0,50,[255,255,255],[0,0,0]};です。

                                   重要：onset_punchのposition(位置)指定方法についての補足
                                   「位置」と関連するパラメータを(image_database ファイル内で)適切に設定することで、ImagesShowは
                                   刺激/条件タイプと提示プロトコルを記録する2つの異なる方法を提供します。
                                   まず、'position'を1～12のいずれかに設定した場合、フォトトリガー記録用の刺激オンセット・マーカーは
                                   1つの固定位置にしか提示されませんが、image_databaseファイル内でimgdb.img{1}{3}=1、imgdb.img{2}{3}=2、
                                   imgdb.img{3}{3}=3、...のように異なる画像に異なる番号を割り当てることによって、eventloggerオブジェクト
                                   （結果ファイル(*.mat)の'event'変数）に刺激タイプを記録することができます。これが結果ファイルを用いた
                                   刺激呈示プロトコルの記録方法となります。
                                   もう1つの異なる記録方法として、'position'を13に設定すると、複数のオンセットマーカーを使用し、所謂
                                   'バイナリーエンコーディング'法にて刺激のタイプを記録することができます。例えば、'position'を13に設定し、
                                   imgdb.img{1}{3}=[1],imgdb.img{2}{3}=[1,2],imgdb.img{3}{3}=[2,3]と設定すると、画像1では左上、画像2では
                                   左上と右上、画像3では右上と左下にオンセットマーカーが提示されます。よって、フォトトリガー応答をEEG/MEG
                                   システムなどで記録しておけば、そのバイナリコード、例えば「1,1,0,0,0,0,0」を確認することで、どの刺激が
                                   どの順番で提示されたかを判断することができます。なお、このバイナリーエンコーディング法を用いる場合、
                                   バータイプのトリガー（9～12 番の位置）はバイナリコード化には適さないため、'position'は1～8 番までの
                                   組み合わせを用いることを推奨します。
22. options.event_display_mode   : 刺激呈示中、MATLABコンソールウィンドウにどのような情報を表示するかを決めるオプションです。
                                   0 = MATLABウィンドウに現在のブロック、呈示イメージIDのみを表示します。
                                   1 = MATLABウィンドウに呈示イベント(ブロック、ボタン押しなどの時間、種類、トリガーなど)の全ての情報を表示します。
</pre>

このスクリプト中からいくつかのグローバル変数の値を参照することが可能です。詳細は[ImagesShowPTB.mの詳細](#Details)のNOTE 2をご参照ください。  

[メニューへ戻る](#Menu)


# <a name = "Logfiles"> **log filesについて** </a>

ImagesShowを実行すると、下記に示す2つのログファイルに実験に関する様々な情報が記録されます。  

**1. MATLABコンソール・ウィンドウに出力される情報のログ**  

MATLABコンソール・ウィンドウに出力される情報のログの例: [logfile.log](doc/markdowns/logfile.md)  

刺激呈示中、MATLABコンソール・ウィンドウに表示された情報は、次の場所  
*\~/ImagesShowPTB/Presentation/(subj)/results/(yymmdd(date))/*  
に下記の名前のテキストファイルで保存されます。  
*(subj)\_ImagesShowPTB_results_session_%02d_run_%02d.log*  

このログファイルには、MATLABの警告/エラー、Psychtoolboxの診断情報、刺激呈示プロトコルなどが記録されます。プログラム内部では、ごく簡単にMATLABのdiary()関数を使ってMATLABコンソール上への出力をリダイレクトしているだけです。ログファイルはsession_number、acquisition_numberごと(ImagesShowの"acq"と"session"の2つの入力引数に対応)に作成され、既存のファイルがある場合はそのファイルにログが追加されていきます。このログを確認することで、刺激呈示に問題はなかったか、Psychtoolboxは正常に動作していたか、などを実験後に追跡することができます。  

**2. イベントログ -- 刺激呈示タイミング、刺激タイプ、刺激トリガー、実験参加者の応答などの記録**  

イベントログの例: [eventlog.log](doc/markdowns/eventlog.md)  

刺激呈示中、画像呈示プロトコル、タイミング、呈示オプション、実験参加者の応答などのログが次の場所  
*\~/ImagesShowPTB/Presentation/(subj)/results/(yymmdd(date))/*  
に下記の名前のmatファイルで保存されます。  
*(subj)\_ImagesShowPTB_results_session_%02d_run_%02d.mat*  

ここで、ImagesShowの"overwrite_flg"を0に設定しておくと、同名のファイルが既に存在する場合(例えば、MATLABやPsychtoolboxのエラーで刺激呈示を中断した場合、同じsession_number、acquisition_numberのログファイルが残る場合があります)には、そのファイルに"_old"プレフィックスをつけ、下記のようなファイル名で  
*(subj)\_ImagesShowPTB_results_session_%02d_run_%02d.mat*  
バックアップします。このバックアップファイルを参照することで、刺激呈示中断時までのデータを参照・解析することが可能です。バックアップファイルが必要ない場合は、overwrite_flg=1とご指定ください。  

このmat形式のログファイルには、下記に示す9個の変数が保存されます。これらのログのうち、刺激呈示タイミングや実験参加者の応答を解析するためには"event"構造体が特に重要です。  

<pre>
1. subj        : 被験者名
2. acq         : ラン番号
3. prt         : 実験プロトコル (protocolfileで指定したblocks{n}を処理したもの)
4. vparam      : 視距離などの情報 (viewfileで指定したvparam)
5. dparam      : ディスプレイ・パラメータ (optionfileで指定したoptions構造体を処理したもの)
6. task        : タスクの種類、呈示タイミング、成績(正答、エラー、false alarm)、反応時間など
7. gamma_table : 使用したガンマ・テーブル (ImagesShowPTBのgamma_tableに空行列を指定した場合は、repmat(linspace(0.0,1.0,256),3,1))
8. event       : イベントログ。実験スタート時間、刺激のオンセット、被験者の応答、トリガーなどが記録されたセル構造体
                 event{n}={イベントの時間(sec単位、実験開始が0), イベントの名前(Stim ONなど), パラメータ};
                 が記録されています。
9. imgs        : imgdbfileで記述したimgsセル構造体
</pre>

[メニューへ戻る](#Menu)


# <a name = "Acknowledgments"> **謝辞** </a>

ImagesShowは、MATLAB言語と**Psychtoolbox**を用いて記述されています。この素晴らしいライブラリをフリーでご公開なさっている開発者、管理者のみなさまに深く御礼申し上げます。

**Psychtoolbox** : The individual Psychtoolbox core developers,  
            (c) 1996-2011, David Brainard  
            (c) 1996-2007, Denis Pelli, Allen Ingling  
            (c) 2005-2011, Mario Kleiner  
            Individual major contributors:  
            (c) 2006       Richard F. Murray  
            (c) 2008-2011  Diederick C. Niehorster  
            (c) 2008-2011  Tobias Wolf  
            [ref] [http://psychtoolbox.org/HomePage](http://psychtoolbox.org/HomePage)  

**ImagesShowソフトウェア・パッケージの開発経緯について**  
本***ImagesShow***ソフトウェア・パッケージは、京都大学の山本洋紀博士によってTcl/Tk言語を用いてUNIX(Sun Microsystems SolarisとSGI IRIX)上で開発されたPresentImageというソフトウェアをベースに開発されています。私は山本先生よりご指導・ご鞭撻を賜り、視知覚・認知の実験手法、視覚刺激呈示プログラム法の基礎を学ばせていただきました。山本先生との研究を続けるなか、実験環境の変化やUNIXの衰勢、Windowsの隆盛に伴う必要に迫られてPresetImageをC/C++言語にて書き換え、Windowsに対応させたものが初代ImagesShowです。その後、私は英国・バーミンガム大学のAndrew Welchman博士、Zoe Kourtzi博士の下へ留学し、そこで学んだ両眼立体視をはじめとする新しい研究テーマに対応させるため、C++版PresentImageをMATLABとPsychtoolboxを用いて書き換えるとともに、新たに大幅な機能アップデート(実際は入力ファイルの形式のみ前バージョンの仕様をできる限り踏襲しましたが、中身はフルスクラッチで書き換えております)を加えたものが現行のImagesShowとなります。山本先生、Welchman先生、Kourtzi先生のご指導がなければ、本ソフトウェアが世に出ることはありませんでした。この場をお借りして先生方に深く感謝申し上げます。  

[メニューへ戻る](#Menu)


# <a name = "License"> **ライセンス** </a>

<img src="https://img.shields.io/badge/LICENSE-BSD-red" /><br>

ライセンスの詳細は下記のとおりです。

ImagesShow --- A MATLAB-based "Digital Kamishibai" (Kamishibai, 紙芝居 in Japanese, means "picture-story show") package for flexible visual stimulus presentations in psychophysics and neuroimaging studies.  
Copyright (c) 2021, Hiroshi Ban. All rights reserved.  

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in
      the documentation and/or other materials provided with the distribution

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.  

The views and conclusions contained in the software and documentation are those of the authors and should not be interpreted as representing official policies, either expressed or implied, of the FreeBSD Project.  

[メニューへ戻る](#Menu)


# <a name = "Citation"> **ImagesShowの引用** </a>

みなさまのご研究に本ImagesShowソフトウェア・パッケージが役立ち、そのご研究論文の参考文献欄に余裕がございましたら、本ソフトウェア・パッケージを下記の通りに引用いただけましたら幸いです。  

**ImagesShow toolbox: https://github.com/hiroshiban/ImagesShow**  
**by Hiroshi Ban**  

ImagesShowをご利用いただき、ありがとうございます。本ソフトウェア・パッケージがみなさまのご研究のお役に立てましたら幸甚に存じます。

[メニューへ戻る](#Menu)


# <a name = "History"> **更新履歴** </a>

<pre>
初代PresentImage.tcl  tcl version         1999 H.Yamamoto
初代PresentImage.cpp  Cxx version         2002 H.Yamamoto
C++クラスによる記述                         Dec. 24 2003 H.Ban
CONTEC digital I/Oとの同期                 Dec. 24 2003 H.Ban
自動で注視点追加モード                       Dec. 25 2003 H.Ban
time.h --> Win32API multimedia timer      Jan. 20 2004 H.Ban
アニメーションパフォーマンス改善              Jan. 24 2004 H.Ban
Dynamic Storage Allocation
(読み込めるブロック、イメージ数がメモリの許す限り無限に)
                                          Jan. 24 2004 H.Ban
実行時にmultimedia timerを自動で初期化       Jan. 25 2004 H.Ban
PresentImages 改め ImagesShowへ            Mar. 06 2005 H.Ban
イメージシーケンスのランドマイズ機能           Mar. 06 2005 H.Ban
フルスクリーンレンダリング                   Mar. 10 2005 H.Ban
Keyence KV Controllerとの同期              Mar. 11 2005 H.Ban
vtk3.2 -> vtk4.2 static library           Mar. 12 2005 H.Ban
レンダーウィンドウの境界なくす                Mar. 12 2005 H.Ban
*.jpg, *.png, *.tiff形式に対応             Mar. 14 2005 H.Ban
レンダーウィドウ上でマウスクリックスタート     Mar. 14 2005 H.Ban
*.pnm形式に対応                            Mar. 15 2005 H.Ban
読み込みファイルの記述内容変更                Mar. 16 2005 H.Ban
ViewPort (xmin, ymin, xmax, ymax) -> IMAGE-CENTER (x,y)
                                          Mar. 16 2005 H.Ban
Interface GPC (General Pulse Counter)との連携
                                          Mar. 16 2007 H.Ban
ログファイルの出力 (PresentedLog*.txt)      Mar. 16 2005 H.Ban
ログファイルの出力 (KVSwitchLog*.txt)       Mar. 16 2005 H.Ban
最初に画像を呈示せず、メモリ上にのみレンダリング
                                          July 05 2007 H.Ban
x&y軸に沿って画像を反転                      July 05 2007 H.Ban
VC++6.0からVC++.NET 2003へコンパイラを変更   July 07 2007 H.Ban
vtk4.2 static library -> vtk5.0.3 static library
                                          July 07 2007 H.Ban
レンダーウィンドウ上からマウスカーソルを消去    July 07 2007 H.Ban
右マウスクリックで呈示スタート -> 左マウスクリック
                                          July 07 2007 H.Ban
ImagesShow.exeのアイコン変更                July 08 2007 H.Ban
呈示画像のbilinear補間による拡大/縮小が可能    July 09 2007 H.Ban
FFA(Fusiform Face Area) & PPA(Parahipocampal Place Area) &
EBA(Extrastriate Body Area)を同定するためのコンディションを
あらかじめ用意
                                          July 09 2007 H.Ban
呈示時間の誤差をリアルタイムで補正する機能を追加
                                          July 14 2007 H.Ban
Newバージョン：Interface GPC (General Pulse Counter)との連携
                                          July 16 2007 H.Ban
Newバージョン：Log file (GPCSwitchTriggerLog*.txt)の出力
                                          July 16 2007 H.Ban
Newバージョン: ImageDatabaseファイル        July 17 2007 H.Ban
画面端に刺激呈示のオンセットを知らせるパンチ刺激を呈示するモード
                                          July 17 2007 H.Ban
Interface GPCと連携して、ディスプレイの垂直同期信号を取得、
指定したフレーム数だけ呈示するモードの追加
                                          July 17 2007 H.Ban
VTK5.4.2ライブラリへアップデート
                                          June 05 2009 H.Ban
VC++.NET 2003からVC++.NET 2005へコンパイラを変更、実行速度アップ
                                          June 05 2009 H.Ban
Matlab_imageprocessingを追加、様々な画像処理が可能
                                          June 05 2009 H.Ban
vtk5.4.2をboost C++ 1.38を組み込んでコンパイル
                                          July 26 2009 H.Ban
RunTEST()をCONTEC digital I/O, KV digital I/O, GPC digital I/Oと連携可能に
                                          July 26 2009 H.Ban
*.displayファイルのSTART-METHODで0(RETURN Key start)を選んだ際、
コンソール上でなく、レンダーウィンドウ上でリターンキーを押すことで刺激呈示スタート
                                          July 26 2009 H.Ban
CONTEC digital I/Oと連携中にdigital I/Oへ刺激の種類のトリガーを送出可能に
                                          July 26 2009 H.Ban
C++ソースをもとに、MATLAB & Psychtoolboxバージョンを作成
内部の画像処理および呈示手続き新しいものに変更
両眼呈示に対応、タスクの自動追加モード
                                          Nov  15 2013 H.Ban
文字検出タスクの追加                         Nov  18 2013 H.Ban
左右眼画像に異なるパラメータを設定可能に
                                          Nov  21 2013 H.Ban
バグ修正、メモリを使いすぎないように内部処理を変更
                                          Nov  23 2013 H.Ban
バグ修正、バージョン1.0 最終版を作成
                                          Nov  25 2013 H.Ban
左右眼画像の処理を効率的にするため、変数の構造を変更
                                          Nov  28 2013 H.Ban
円形窓マスクを追加するオプション              Nov  29 2013 H.Ban
シーケンスに0番を指定することで、画像呈示を行わない(背景のみ呈示)
オプションを追加                            July 13 2015 H.Ban
入力パラメータに"session"を追加(日付の違いなどでファイルを区別する際に利用可能)
                                         July 14 1014 H.Ban
subj, acq, session, vparam, dparam, imgs, prt, imgsの8変数を
グローバル変数とした。変数へ外部からのアクセスを許可するのは
危険かもしれないが、より柔軟な条件ファイル作成のために変更を
決めた。グローバル変数の中身は、今のところ読み取りのみ可能で、
書き込みは不可。変数の中身を取得するためには、
~/ImagesShowPTB/Generation/getGlobalParameters.m
を使用する
                                          July 14 2014 H.Ban
四角形窓マスクを追加するオプション             July 14 2014 H.Ban
フレームの同期テストをスキップするオプションの追加
                                          Aug  29 2016 H.Ban
特定のフレームレートを指定して呈示を行うオプションの追加
                                          Aug  29 2016 H.Ban
単一背景、パッチ付き背景の選択が可能に         Aug  29 2016 H.Ban
protocolfile、imgdbfile、viewfile、optionfileの4つのファイル
を記述する際にスクリプト形式のみではなく、MATLAB関数形式にも
対応させた。より柔軟な制御が可能となった。      Aug  29 2016 H.Ban
MATLABコンソールウィンドウに表示する刺激呈示情報の種類を
オプションで選択可能に(簡易あるいは詳細モード)
                                          Oct  23 2016 H.Ban
カナダVPIXX社PROPixxプロジェクタ上への刺激呈示に対応(2D/3D呈示ともに可)
                                          June 03 2021 H.Ban
刺激を呈示するスクリーンのIDを選択するオプションの追加
                                          June 03 2021 H.Ban
新しいタイプの注視点を追加                Dec  01 2021 H.Ban
オンセットマーカーのON/OFF時の色を指定できるように
                                          Feb  18 2025 H.Ban
画像にマスクをかけるオプションのアップデート。
ディスプレイと画像のサイズによってはマスクが正常に適用されない問題を修正
                                          Feb  18 2025 H.Ban
</pre>

[メニューへ戻る](#Menu)

# <a name = "TODOs"> **TODOs** </a>

0. Python言語を用いて書き換え...  
1. MATLBコンパイラを使ってバイナリコード生成。MATLABなしでの実行を可能にする。  
2. 静止画像ファイルのみでなく、動画ファイル(\*.aviや\*.mp4)への対応  
3. *DONE* 画像マスクオプションの追加  
4. *DONE* 刺激開始同期のためのトリガー取得機能  
5. *DONE* シャッターゴーグルや偏光グラスを用いた両眼立体視刺激に呈示への対応  
6. *DONE* デュアル・ディスプレイ環境への対応  
7. *DONE* 刺激呈示プロトコルの遅延をリアルタイムに補正するオプションの追加  
8. *DONE* MEG/EEG実験用に、フォトダイオードセンサによる刺激オンセット取得のためのパンチ刺激呈示機能の追加  

[メニューへ戻る](#Menu)
