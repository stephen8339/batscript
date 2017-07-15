@ECHO OFF
CLS
:: =================== CONFIG ============================================
:: 仓库所在文件路径
SET repodir=D:\svndata\
:: 备份文件夹路径
SET repodirhot=D:\svnbk\
:: 备份日志文件夹路径
SET logdir=D:\svnbklog\
:: 备份压缩比文件夹路径
SET zipdir=D:\svnbkzip\
:: winrar可执行文件路径
SET rar=C:\progra~1\WinRAR\winrar.exe
:: 模式:1为交互、0为非交互
SET imode=0
:: =================== CONFIG ============================================

:: =================== SCRIPT ============================================

:: 时间戳
SET hh=%time:~0,2%
IF "%time:~0,1%"==" " set hh=0%hh:~1,1%
SET yyyymmddhhmmss=%date:~0,4%%date:~5,2%%hh%%time:~3,2%%time:~6,2%
SET repolog=%logdir%%yyyymmddhhmmss%svnbk.log

:: 日志开始记录
ECHO START %date% %time% >> %repolog%

:: 如果备份文件存在，先删除然后再开始备份
FOR /F %%G IN ('dir /b /ad %repodir%') DO ^
IF EXIST %repodirhot%%%G (rmdir /S /Q %repodirhot%%%G  >> %repolog% & ^
ECHO Starting SVN backup for %%G... >> %repolog% & ^
svnadmin hotcopy %repodir%%%G %repodirhot%%%G --clean-logs >> %repolog% & ^
IF %imode%== 1 ECHO FINISHED EXIST...%repodir%%%G...%repodirhot%%%G) ^
ELSE (ECHO Starting SVN backup for %%G... >> %repolog% & ^
svnadmin hotcopy %repodir%%%G %repodirhot%%%G --clean-logs >> %repolog% & ^
IF %imode%== 1 ECHO FINISHED...%repodir%%%G...%repodirhot%%%G)

:: 打包备份日志
ECHO Starting %rar% zip pack from repodirhot to %zipdir%%yyyymmddhhmmss%svnbk.zip >> %repolog% & ^
%rar% a -afzip -r -ibck -ep1 %zipdir%%yyyymmddhhmmss%svnbk.zip %repodirhot% >> %repolog% &


:: 日志结束
ECHO END %date% %time% >> %repolog%
:: 交互模式显示日志信息，否则退出
ECHO Done... Logs available here: %repolog% 
if %imode%== 1 pause
:: =================== SCRIPT ============================================
EXIT