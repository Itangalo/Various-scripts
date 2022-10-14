This script is useful for converting Word files to Markdown. Drop a docx file on the script and a Markdown version of the file will be created. Also, the Markdown content will be copied to the clipboard.

The script does some extra formatting stuff:

* Any CSS classes for special formatting in Word are stripped. This is to make the text fit with GitHub Markdown.
* Lists are stored as compact lists, without any empty lines between items. (This appears not to be the standard conversion, strange enough.)
* Line breaks (not paragraph breaks) are introduced after each sentence, including after each colon. This is to make it easier to use git version control on the resulting text.

The script relies on [Pandoc](https://pandoc.org/) and requires that pandoc.exe is in the same folder as the script. It also requires that `list-formatting.lua` is in the same folder, to take care of compacting item lists.
