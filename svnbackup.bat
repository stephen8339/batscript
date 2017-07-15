@ECHO OFF
CLS
:: =================== CONFIG ============================================
:: �ֿ������ļ�·��
SET repodir=D:\svndata\
:: �����ļ���·��
SET repodirhot=D:\svnbk\
:: ������־�ļ���·��
SET logdir=D:\svnbklog\
:: ����ѹ�����ļ���·��
SET zipdir=D:\svnbkzip\
:: winrar��ִ���ļ�·��
SET rar=C:\progra~1\WinRAR\winrar.exe
:: ģʽ:1Ϊ������0Ϊ�ǽ���
SET imode=0
:: =================== CONFIG ============================================

:: =================== SCRIPT ============================================

:: ʱ���
SET hh=%time:~0,2%
IF "%time:~0,1%"==" " set hh=0%hh:~1,1%
SET yyyymmddhhmmss=%date:~0,4%%date:~5,2%%hh%%time:~3,2%%time:~6,2%
SET repolog=%logdir%%yyyymmddhhmmss%svnbk.log

:: ��־��ʼ��¼
ECHO START %date% %time% >> %repolog%

:: ��������ļ����ڣ���ɾ��Ȼ���ٿ�ʼ����
FOR /F %%G IN ('dir /b /ad %repodir%') DO ^
IF EXIST %repodirhot%%%G (rmdir /S /Q %repodirhot%%%G  >> %repolog% & ^
ECHO Starting SVN backup for %%G... >> %repolog% & ^
svnadmin hotcopy %repodir%%%G %repodirhot%%%G --clean-logs >> %repolog% & ^
IF %imode%== 1 ECHO FINISHED EXIST...%repodir%%%G...%repodirhot%%%G) ^
ELSE (ECHO Starting SVN backup for %%G... >> %repolog% & ^
svnadmin hotcopy %repodir%%%G %repodirhot%%%G --clean-logs >> %repolog% & ^
IF %imode%== 1 ECHO FINISHED...%repodir%%%G...%repodirhot%%%G)

:: ���������־
ECHO Starting %rar% zip pack from repodirhot to %zipdir%%yyyymmddhhmmss%svnbk.zip >> %repolog% & ^
%rar% a -afzip -r -ibck -ep1 %zipdir%%yyyymmddhhmmss%svnbk.zip %repodirhot% >> %repolog% &


:: ��־����
ECHO END %date% %time% >> %repolog%
:: ����ģʽ��ʾ��־��Ϣ�������˳�
ECHO Done... Logs available here: %repolog% 
if %imode%== 1 pause
:: =================== SCRIPT ============================================
EXIT