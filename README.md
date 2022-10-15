# Various-scripts

This repository contains some small scripts that could be (very) helpful in daily work, if you have the right (wrong) type of work. They automate things that could be rather tedious to do by hand.

Short description of the scripts included at the time of writing:

* Log file: A poor man's substitute for proper version control of files. Drop a file on the script and you'll be asked to describe latest changes. Then a time-stamped and user-stamped copy of the file is created and stowed away, as well as the log message added to a text file.
* Search words: Checks if any of a number of given words are present in text-file.txt. (Useful to check a large-ish number of words and you don't want to do repeated searches in Word or so.)
* docx to ml: Used to make Word file content ready to be added to GitHub (or similar), to allow some proper version control of text. Drop a Word document on the script and you'll get a Markdown copy of the document, and the content copied to clipboard for convenience. Also, line breaks are introduced after each sentence (to make git-style version control of natural text easier).

All of them are .bat files intended for Windows use. More details are found in each folder.
