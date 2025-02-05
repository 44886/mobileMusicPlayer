@echo off

%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

cd /d "%~dp0"

echo:
echo =============================
echo 欢迎下次继续使用“不坑盒子”
echo =============================
echo 作   者:不坑老师
echo 公众号:不坑老师
echo =============================

echo:
echo 正在移除Office注册表...
echo:
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\Word\Addins\BKOffice2025.Word" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Word\Addins\BKOffice2025.Word" /f
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\Excel\Addins\BKOffice2025.Excel" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Excel\Addins\BKOffice2025.Excel" /f
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\PowerPoint\Addins\BKOffice2025.PPT" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\PowerPoint\Addins\BKOffice2025.PPT" /f

echo:
echo 正在移除WPS注册表...
echo:
reg delete HKEY_CURRENT_USER\Software\Kingsoft\Office\WPS\AddinsWL\  /v BKOffice2025.Word /f
reg delete HKEY_CURRENT_USER\Software\Kingsoft\Office\ET\AddinsWL\ /v BKOffice2025.Excel /f
reg delete HKEY_CURRENT_USER\Software\Kingsoft\Office\WPP\AddinsWL\ /v BKOffice2025.PPT /f
reg delete HKEY_LOCAL_MACHINE\Software\Kingsoft\Office\WPS\AddinsWL\  /v BKOffice2025.Word /f
reg delete HKEY_LOCAL_MACHINE\Software\Kingsoft\Office\ET\AddinsWL\ /v BKOffice2025.Excel /f
reg delete HKEY_LOCAL_MACHINE\Software\Kingsoft\Office\WPP\AddinsWL\ /v BKOffice2025.PPT /f
echo:
echo 移除程序列表...
echo:
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BKOffice2025" /f

echo 删快捷方式...
echo:
del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\不坑盒子说明书.exe"
del "%USERPROFILE%\Desktop\不坑盒子说明书.exe"

echo 清空插件目录


:: 定义当前目录变量
set "CurrentDir=%~dp0"

:: 显示当前目录
echo Current directory is: %CurrentDir%

:: 循环删除当前目录下的所有子文件夹
for /d %%d in ("%CurrentDir%\*") do (
    rd /s /q "%%d"
)


:: 循环删除当前目录下的所有文件
for /r "%CurrentDir%" %%f in (*) do (
    del /f /q "%%f"
)

echo 插件卸载完毕,欢迎下次使用...
echo:
pause>nul



