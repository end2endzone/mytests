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

echo =======================================================================
echo Uploading autocrlf artifacts to AppVeyor
echo =======================================================================
set TEST_RESULT_URL=https://ci.appveyor.com/api/testresults/junit/%APPVEYOR_JOB_ID%
set TEST_RESULT_FILE=c:\projects\veyortests\test_true\README_true.md
echo TEST_RESULT_URL=%TEST_RESULT_URL%
echo TEST_RESULT_FILE=%TEST_RESULT_FILE%
powershell "(New-Object 'System.Net.WebClient').UploadFile($($env:TEST_RESULT_URL), $($env:TEST_RESULT_FILE))"
set TEST_RESULT_FILE=c:\projects\veyortests\test_true\README_input.md
echo TEST_RESULT_URL=%TEST_RESULT_URL%
echo TEST_RESULT_FILE=%TEST_RESULT_FILE%
powershell "(New-Object 'System.Net.WebClient').UploadFile($($env:TEST_RESULT_URL), $($env:TEST_RESULT_FILE))"
set TEST_RESULT_FILE=c:\projects\veyortests\test_true\README_false.md
echo TEST_RESULT_URL=%TEST_RESULT_URL%
echo TEST_RESULT_FILE=%TEST_RESULT_FILE%
powershell "(New-Object 'System.Net.WebClient').UploadFile($($env:TEST_RESULT_URL), $($env:TEST_RESULT_FILE))"
