# ComputerCraft
**Ver1.17.1でのプログラム更新方法**
- - -
1. プログラムを更新したらgit push
2. マイクラ内のコンソールでgitpullコマンドを使う(ファイル指定ではなくフォルダごとコピーする)
    * User/Hoge/Test/のフォルダにあるファイルを更新した場合
    * `gitpull  User/Hoge/Test/` 
3. コンピュータにTestというフォルダがコピーされる

- - -  
注意,Computerのディレクトリが出来る条件がlabelが恐らくセットされていることと一度ディレクトリを操作することなので
label set hogehoge  
のようにコマンドを打ってテキトーなファイルを作成してください.

**サーバー内にあるComputer, Turtleに使うプログラムを送れます.**  
**2階のチェスト右側へ実験用のPCを置いてあります.**  
- - -
1. idとコマンドを打つとそのComputerのIDが表示されます(実験用PCで試す場合はおそらく3のはず)  
2. programs/Userに自分のディレクトリを作ってプログラムを作ります。  
3. config.csvに転送したいPCのidとプログラムの置いてあるディレクトリまでのPathを書いてcommit & push  
    * id3のPCにUser/Hoge/Test/test.luaを転送したい場合,  
    * `3, User/Hoge/Test/ `   
    * とProgramsより下からのディレクトリをconfig.csvに追記します。  
4. 10秒間隔でpollingしているので10秒位すればroot直下にTestというディレクトリが出来ているはず  
  
   
- - -  
注意,Computerのディレクトリが出来る条件がlabelが恐らくセットされていることと一度ディレクトリを操作することなので
label set hogehoge  
のようにコマンドを打ってテキトーなファイルを作成してください.

使用できるAPIは[公式Wiki](https://tweaked.cc/)に載ってます.  
[日本語の紹介サイト](https://w.atwiki.jp/minecraft/pages/483.html)にもコマンドとか載ってる
