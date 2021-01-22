# ComputerCraft
**サーバー内にあるComputer, Turtleに使うプログラムを送れます.**  
**2階のチェスト右側へ実験用のPCを置いてあります.**  
- - -
1. idとコマンドを打つとそのComputerのIDが表示されます(この場合はおそらく3のはず)  
2. programs/Userに自分のディレクトリを作ってプログラムを作ります。  
3. config.csvに転送したいPCのidとプログラムの置いてあるディレクトリまでのPathを書いてcommit & push  
    * id3のPCにUser/Hoge/Test/test.luaを転送したい場合,  
    * `3, User/Hoge/Test/ `   
    * とconfig.csvに追記します。  
4. 1分間隔でpollingしているので1分位すればroot直下にTestというディレクトリが出来ているはず  
  
- - -  
注意,Computerのディレクトリが出来る条件がlabelが恐らくセットされていることと一度ディレクトリを操作することなので
label set hogehoge  
のようにコマンドを打ってテキトーなファイルを作成してください.

使用できるAPIは[公式Wiki](https://tweaked.cc/)に載ってます.  
[日本語の紹介サイト](https://w.atwiki.jp/minecraft/pages/483.html)にもコマンドとか載ってる
