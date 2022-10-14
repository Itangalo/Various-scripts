@ECHO OFF
CHCP 65001
TITLE Script for saving time-stamped versions of a file

SET ArchiveName=x^ -^ logged^ versions

SET FileDate=%~t1
SET FileDate=%FileDate::=.%
SET FilePath=%~dp1
SET FileName=%~n1
SET FileExt=%~x1
SET LogFile="%FilePath%%FileName% (log).txt"

IF "%FileExt%" == "" (
  ECHO Only files may be archived.
  PAUSE
  EXIT
)

ECHO Archiving a version of %FileName%%FileExt%.
ECHO.

SET /P Log=Enter a summary of the last edit:
ECHO %FileDate% (%username%): %Log%>>%LogFile%
ECHO Log updated.
ECHO.

SET NewFileName=%FilePath%%ArchiveName%\%FileName% (%username% %FileDate%)%FileExt%

IF EXIST "%NewFileName%" (
  ECHO File version already archived.
  PAUSE
  EXIT
)

IF NOT EXIST "%FilePath%%ArchiveName%" (
  ECHO Creating archive folder.
  MKDIR "%FilePath%%ArchiveName%"
)

COPY "%~f1" "%NewFileName%"
IF ERRORLEVEL 1 (
  ECHO Could not copy. Please save a copy of this file manually:
  ECHO "%~f1"
  ECHO File name to use for archiving:
  ECHO "%NewFileName%"
  PAUSE
  EXIT
)

ECHO Copy of the file saved:
ECHO "%NewFileName%"

PAUSE
