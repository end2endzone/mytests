@echo off
echo Forcing text files in repository to CRLF line ending...
cd ..\..
echo "* text=auto" >.gitattributes
git config --global core.autocrlf false
git rm --cached -r .
git reset --hard
