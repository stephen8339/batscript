@ECHO OFF
CLS
:: =================== CONFIG ============================================
:: �ֿ������ļ�·��
SET repodir=D:\svndata\
:: �����ļ���·��
SET repodirhot=D:\svnbk\
:: ������־�ļ���·��
SET logdir=D:\svnbklog\
:: ģʽ:1Ϊ������0Ϊ�ǽ���
SET imode=1
:: =================== CONFIG ============================================

:: =================== SCRIPT ============================================

:: ʱ���
SET hh=%time:~0,2%
ECHO %hh%

IF "%time:~0,1%"==" " set hh=0%hh:~1,1%
SET yyyymmddhhmmss=%date:~0,4%%date:~5,2%%hh%%time:~3,2%%time:~6,2%
ECHO %yyyymmddhhmmss%

SET repolog=%logdir%%yyyymmddhhmmss%svnbk.log
ECHO %repolog%
:: ��־��ʼ��¼
ECHO START %date% %time% >> %repolog%

:: ��������ļ����ڣ���ɾ��Ȼ���ٿ�ʼ����
FOR /F %%G IN ('dir /b /ad %repodir%') DO ^
IF EXIST %repodirhot%%%G (rmdir /S /Q %repodirhot%%%G & mkdir %repodirhot%%%G >> %repolog% & ^
ECHO Starting SVN backup for %%G... >> %repolog% & ^
svnadmin hotcopy %repodir%%%G %repodirhot%%%G --clean-logs >> %repolog% & ^
IF %imode%== 1 ECHO FINISHED...%repodir%%%G...%repodirhot%%%G) ^
ELSE (mkdir %repodirhot%%%G >> %repolog% & ^
ECHO Starting SVN backup for %%G... >> %repolog% & ^
svnadmin hotcopy %repodir%%%G %repodirhot%%%G --clean-logs >> %repolog% & ^
IF %imode%== 1 ECHO FINISHED...%repodir%%%G...%repodirhot%%%G)

:: ��־����
ECHO END %date% %time% >> %repolog%
:: ����ģʽ��ʾ��־��Ϣ�������˳�
ECHO Done... Logs available here: %repolog% 
if %imode%== 1 pause
:: =================== SCRIPT ============================================
EXIT