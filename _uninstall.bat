@echo off

%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

cd /d "%~dp0"

echo:
echo =============================
echo ��ӭ�´μ���ʹ�á����Ӻ��ӡ�
echo =============================
echo ��   ��:������ʦ
echo ���ں�:������ʦ
echo =============================

echo:
echo �����Ƴ�Officeע���...
echo:
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\Word\Addins\BKOffice2025.Word" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Word\Addins\BKOffice2025.Word" /f
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\Excel\Addins\BKOffice2025.Excel" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Excel\Addins\BKOffice2025.Excel" /f
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\PowerPoint\Addins\BKOffice2025.PPT" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\PowerPoint\Addins\BKOffice2025.PPT" /f

echo:
echo �����Ƴ�WPSע���...
echo:
reg delete HKEY_CURRENT_USER\Software\Kingsoft\Office\WPS\AddinsWL\  /v BKOffice2025.Word /f
reg delete HKEY_CURRENT_USER\Software\Kingsoft\Office\ET\AddinsWL\ /v BKOffice2025.Excel /f
reg delete HKEY_CURRENT_USER\Software\Kingsoft\Office\WPP\AddinsWL\ /v BKOffice2025.PPT /f
reg delete HKEY_LOCAL_MACHINE\Software\Kingsoft\Office\WPS\AddinsWL\  /v BKOffice2025.Word /f
reg delete HKEY_LOCAL_MACHINE\Software\Kingsoft\Office\ET\AddinsWL\ /v BKOffice2025.Excel /f
reg delete HKEY_LOCAL_MACHINE\Software\Kingsoft\Office\WPP\AddinsWL\ /v BKOffice2025.PPT /f
echo:
echo �Ƴ������б�...
echo:
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BKOffice2025" /f

echo ɾ��ݷ�ʽ...
echo:
del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\���Ӻ���˵����.exe"
del "%USERPROFILE%\Desktop\���Ӻ���˵����.exe"

echo ��ղ��Ŀ¼


:: ���嵱ǰĿ¼����
set "CurrentDir=%~dp0"

:: ��ʾ��ǰĿ¼
echo Current directory is: %CurrentDir%

:: ѭ��ɾ����ǰĿ¼�µ��������ļ���
for /d %%d in ("%CurrentDir%\*") do (
    rd /s /q "%%d"
)


:: ѭ��ɾ����ǰĿ¼�µ������ļ�
for /r "%CurrentDir%" %%f in (*) do (
    del /f /q "%%f"
)

echo ���ж�����,��ӭ�´�ʹ��...
echo:
pause>nul



