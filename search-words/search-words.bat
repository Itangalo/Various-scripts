@ECHO OFF
@CHCP 65001
TITLE Script for checking if any of some words are present in a text.
CLS
SET InputFromArgument=0
IF EXIST "%1" (
  SET InputFromArgument=1
  SET ThisDir=%~dp0
  CD %ThisDir%
  ECHO Checking for unwanted words in text file: %1
) ELSE (ECHO Checking for unwanted words in copied text.)
ECHO.

REM Running through PowerShell to be able to manage UTF-8 format
powershell.exe -command ^
  if (%InputFromArgument%) {^
    $textToCheck = Get-Content -encoding UTF8 """%1""";^
  }^
  else {^
    $textToCheck = Get-Clipboard;^
  }^
  $words = Get-Content forbidden-words.txt -encoding UTF8;^
  $allClean = 1;^
  foreach ($word in $words) {^
    $lineNumber = 0;^
    $clean = 1;^
    foreach($line in $textToCheck) {^
      $lineNumber += 1;^
      $result = Select-String -inputObject $line -Pattern \b$word\b ^;^
      if ($result) {^
        if ($clean) {^
          """`nFound '""" + $word + """' as below.""";^
        }^
        """* Line """ + $lineNumber + """: """ + $result.Line;^
        $clean=0;^
        $allClean=0;^
      }^
    }^
  }^
  if ($allClean) {^
    """None of the unwanted words were found.""";^
  }

REM Pause the script, so the terminal window remains open.
ECHO.
ECHO Finished check.
ECHO.
PAUSE
