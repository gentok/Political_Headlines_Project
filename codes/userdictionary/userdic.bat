@echo off 
REM MeCab: �P��̒ǉ����@ 
REM http://mecab.sourceforge.net/dic.html 
REM 
REM     * �K���ȃf�B���N�g���Ɉړ� (��: /home/foo/bar) 
REM     * foo.csv �Ƃ����t�@�C�����쐬 
REM     * foo.csv �ɒP���ǉ� 
REM     * �����̃R���p�C��# 
REM 
REM       % /usr/local/libexec/mecab/mecab-dict-index -d/usr/local/lib/mecab/dic/ipadic \ 
REM       -u foo.dic -f euc-jp -t euc-jp foo.csv 
REM 
REM           o -d DIR: �V�X�e������������f�B���N�g�� 
REM           o -u FILE: FILE �Ƃ������[�U�t�@�C�����쐬 
REM           o -f charset: CSV�̕����R�[�h 
REM           o -t charset: �o�C�i�������̕����R�[�h 
REM     * /home/foo/bar/foo.dic ���ł��Ă��邱�Ƃ��m�F 
REM     * /usr/local/lib/mecab/dic/ipadic/dicrc �������� /usr/local/etc/mecabrc �Ɉȉ���ǉ� 
REM 
REM       userdic = /home/foo/bar/foo.dic 
REM 
REM     * /usr/local/etc/mecabrc ��ҏW���錠���������ꍇ�� /usr/local/etc/mecabrc �� ~/.mecabrc �ɃR�s�[��, ��L�̃G���g����ǉ� 
REM     * userdic ��CSV�t�H�[�}�b�g�f�����w��\ 
REM 
REM        userdic = /home/foo/bar/foo.dic,/home/foo/bar2/usr.dic,/home/foo/bar3/bar.dic 
REM 
REM 
REM 
echo on 

"C:\Program Files (x86)\MeCab\bin\mecab-dict-index" -d "C:\Program Files (x86)\MeCab\dic\ipadic" -u user.dic -f shift-jis -t shift-jis user.csv 

pause