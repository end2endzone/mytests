@echo off
echo Running test_autocrlf.bat...

cd /d c:\projects\veyortests
git config --global core.autocrlf true
git clone https://github.com/end2endzone/veyortests.git test_true
git config --global core.autocrlf input
git clone https://github.com/end2endzone/veyortests.git test_input
git config --global core.autocrlf false
git clone https://github.com/end2endzone/veyortests.git test_false

ren c:\projects\veyortests\test_true\README.md README_true.md
ren c:\projects\veyortests\test_input\README.md README_input.md
ren c:\projects\veyortests\test_false\README.md README_false.md
