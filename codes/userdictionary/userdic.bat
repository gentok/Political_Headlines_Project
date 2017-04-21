@echo off 
REM MeCab: 単語の追加方法 
REM http://mecab.sourceforge.net/dic.html 
REM 
REM     * 適当なディレクトリに移動 (例: /home/foo/bar) 
REM     * foo.csv というファイルを作成 
REM     * foo.csv に単語を追加 
REM     * 辞書のコンパイル# 
REM 
REM       % /usr/local/libexec/mecab/mecab-dict-index -d/usr/local/lib/mecab/dic/ipadic \ 
REM       -u foo.dic -f euc-jp -t euc-jp foo.csv 
REM 
REM           o -d DIR: システム辞書があるディレクトリ 
REM           o -u FILE: FILE というユーザファイルを作成 
REM           o -f charset: CSVの文字コード 
REM           o -t charset: バイナリ辞書の文字コード 
REM     * /home/foo/bar/foo.dic ができていることを確認 
REM     * /usr/local/lib/mecab/dic/ipadic/dicrc もしくは /usr/local/etc/mecabrc に以下を追加 
REM 
REM       userdic = /home/foo/bar/foo.dic 
REM 
REM     * /usr/local/etc/mecabrc を編集する権限が無い場合は /usr/local/etc/mecabrc を ~/.mecabrc にコピーし, 上記のエントリを追加 
REM     * userdic はCSVフォーマットデ複数指定可能 
REM 
REM        userdic = /home/foo/bar/foo.dic,/home/foo/bar2/usr.dic,/home/foo/bar3/bar.dic 
REM 
REM 
REM 
echo on 

"C:\Program Files (x86)\MeCab\bin\mecab-dict-index" -d "C:\Program Files (x86)\MeCab\dic\ipadic" -u user.dic -f shift-jis -t shift-jis user.csv 

pause