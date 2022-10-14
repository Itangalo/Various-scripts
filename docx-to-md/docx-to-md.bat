ECHO OFF
CHCP 65001
TITLE Script for converting docx to Markdown
CLS

SET ThisDir=%~dp0
SET FilePath=%~dp1
SET FileName=%~n1
SET FileExt=%~x1
SET MdFile="%FilePath%%FileName%.md"

ECHO Converting %FileName%...
ECHO.

IF NOT "%FileExt%" == ".docx" (
  ECHO Only docx files can be converted with this script.
  PAUSE
  EXIT
)

REM Run Pandoc to convert to markdown, then once again to compactify lists.
REM Note that conversion also takes care of trailing whitespace.
CD %ThisDir%
pandoc -f docx -t gfm %1 -o %MdFile% --wrap=none --lua-filter list-formatting.lua
pandoc -f markdown -t markdown %MdFile% -o %MdFile% --wrap=none --lua-filter list-formatting.lua

REM Insert line breaks after each sentence to increase readability in version control.
powershell.exe -command ^
  $content=Get-Content ""%MdFile%"" -Raw -Encoding UTF8;^
  $breakCharacters=""".""","""?""","""!""",""":""";^
  foreach ($char in $breakCharacters) {^
    $content=$content.replace($char+' ',$char+"""`r`n""");^
  }^
  out-file -encoding UTF8 -NoNewline ""%MdFile%"" -InputObject $content;^
  $content ^| Set-Clipboard;

ECHO Document converted. The result is stored in %FileName%.md and the content was added to the clipboard.
PAUSE
