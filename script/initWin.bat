@echo off

REM ��ȡ�ű�����Ŀ¼������·��
set "scriptPath=%~dp0"

REM �Ƴ�·��ĩβ��б��
if "%scriptPath:~-1%"=="\" set "scriptPath=%scriptPath:~0,-1%"

REM ��ȡ�ű�����Ŀ¼����һ��Ŀ¼
set "parentDir="
for %%I in ("%scriptPath%") do set "parentDir=%%~dpI"

REM �Ƴ���һ��Ŀ¼·��ĩβ��б��
if "%parentDir:~-1%"=="\" set "parentDir=%parentDir:~0,-1%"


set "repo=%parentDir%"
echo repo=%repo%
set "home=%APPDATA%\Rime"

REM �л��� %repo% Ŀ¼
cd "%repo%"
rmdir /s /q "%repo%\Rime"
git clone --depth 1 https://github.com/iDvel/rime-ice "%repo%\Rime"

REM ɾ�� %home% Ŀ¼��������
rmdir /s /q "%home%"

REM �����������ӣ��� %repo%\Rime ���ӵ� %home%
mklink /j "%home%" "%repo%\Rime"

REM ɾ�� %home%\default.custom.yaml
del "%home%\default.custom.yaml"

REM �����������ӣ��� %repo%\default.custom.yaml ���ӵ� %home%
mklink /h "%home%\default.custom.yaml" "%repo%\default.custom.yaml"
:: copy "%repo%\default.custom.yaml" "%home%\default.custom.yaml"

echo �ű�ִ�����