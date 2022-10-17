@ECHO off
CHCP 65001
TITLE Skript för att kolla efter valda ord i en text
CLS
SET InputFromArgument=0
SET ThisDir=%~dp0
CD %ThisDir%
IF EXIST "%1" (
  SET InputFromArgument=1
  ECHO Kollar efter oönskade ord i angiven fil: %1
) ELSE (ECHO Kollar efter oönskade ord i kopierad text.)
ECHO.

REM Kör kommandon genom PowerShell, för att kunna ta hand om UTF-8-format
powershell.exe -command ^
  if (%InputFromArgument%) {^
    $textToCheck = Get-Content -encoding UTF8 """%1""";^
  }^
  else {^
    $textToCheck = Get-Clipboard;^
  }^
  $words = Get-Content """%ThisDir%forbidden-words.txt""" -encoding UTF8;^
  $allClean = 1;^
  foreach ($word in $words) {^
    $lineNumber = 0;^
    $clean = 1;^
    foreach($line in $textToCheck) {^
      $lineNumber += 1;^
      $result = Select-String -inputObject $line -Pattern \b$word\b ^;^
      if ($result) {^
        if ($clean) {^
          """`nHittade '""" + $word + """' enligt nedan.""";^
        }^
        """* Rad """ + $lineNumber + """: """ + $result.Line;^
        $clean=0;^
        $allClean=0;^
      }^
    }^
  }^
  if ($allClean) {^
    """Inga av orden påträffades.""";^
  }

REM Pausa skriptet, så att inte terminalfönstret bara stängs
ECHO.
ECHO Kontrollen är klar.
ECHO.
PAUSE
