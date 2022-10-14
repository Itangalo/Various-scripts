@ECHO OFF
@CHCP 65001
TITLE Script for checking if any of some words are present in a text file.
CLS
ECHO Checking for words in text-document.txt...

SET File=text-document.txt

REM Running commands through PowerShell, to take care of UTF-8 format
powershell.exe -command ^
  $words="""word1""","""word2""","""word3""", """word4""", """word5""", """words with spaces""", """...""";^
  $output=,""" """;^
  foreach ($word in $words) {^
    $result = Select-String """%File%""" -Pattern \b$word\b ^;^
    if ($result) {^
      $output += """ """;^
      $output += """'""" + $word + """' was found in line """ + $result.LineNumber + """: """ + $result.Line;^
    }^
  }^
  $output;

REM Pausing the script to prevent the terminal window from closing
ECHO ·
PAUSE
