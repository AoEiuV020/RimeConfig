@echo off

REM 获取脚本所在目录的完整路径
set "scriptPath=%~dp0"

REM 移除路径末尾的斜杠
if "%scriptPath:~-1%"=="\" set "scriptPath=%scriptPath:~0,-1%"

REM 获取脚本所在目录的上一级目录
set "parentDir="
for %%I in ("%scriptPath%") do set "parentDir=%%~dpI"

REM 移除上一级目录路径末尾的斜杠
if "%parentDir:~-1%"=="\" set "parentDir=%parentDir:~0,-1%"


set "repo=%parentDir%"
echo repo=%repo%
set "home=%APPDATA%\Rime"

REM 切换到 %repo% 目录
cd "%repo%"
rmdir /s /q "%repo%\Rime"
git clone --depth 1 https://github.com/iDvel/rime-ice "%repo%\Rime"

REM 删除 %home% 目录及其内容
rmdir /s /q "%home%"

REM 创建符号链接，将 %repo%\Rime 链接到 %home%
mklink /j "%home%" "%repo%\Rime"

REM 删除 %home%\default.custom.yaml
del "%home%\default.custom.yaml"

REM 创建符号链接，将 %repo%\default.custom.yaml 链接到 %home%
mklink /h "%home%\default.custom.yaml" "%repo%\default.custom.yaml"
:: copy "%repo%\default.custom.yaml" "%home%\default.custom.yaml"

echo 脚本执行完成