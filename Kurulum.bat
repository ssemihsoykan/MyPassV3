@echo off
echo MyPass Kurulum Sihirbazi
echo -------------------------
echo.

set /p install_dir="Kurulum dizini (varsayilan: %USERPROFILE%\MyPass): "

if "%install_dir%"=="" set install_dir=%USERPROFILE%\MyPass

echo.
echo MyPass %install_dir% dizinine kurulacak.
echo.

set /p confirm="Devam etmek istiyor musunuz? (E/H): "
if /i "%confirm%"=="E" goto install
if /i "%confirm%"=="e" goto install
goto end

:install
echo.
echo Kurulum basliyor...
echo.

if not exist "%install_dir%" mkdir "%install_dir%"

echo Dosyalar kopyalaniyor...
xcopy "MyPass.exe" "%install_dir%\" /Y
echo logo.png dosyasi kopyalaniyor...
xcopy "logo.png" "%install_dir%\" /Y
echo README.md dosyasi kopyalaniyor...
xcopy "README.md" "%install_dir%\" /Y

echo.
echo Masaustu kisayolu olusturuluyor...
echo.

set shortcut="%USERPROFILE%\Desktop\MyPass.lnk"
echo Set oShellLink = WScript.CreateObject("WScript.Shell").CreateShortcut(%shortcut%) > CreateShortcut.vbs
echo oShellLink.TargetPath = "%install_dir%\MyPass.exe" >> CreateShortcut.vbs
echo oShellLink.WorkingDirectory = "%install_dir%" >> CreateShortcut.vbs
echo oShellLink.IconLocation = "%install_dir%\logo.png" >> CreateShortcut.vbs
echo oShellLink.Save >> CreateShortcut.vbs
cscript //nologo CreateShortcut.vbs
del CreateShortcut.vbs

echo.
echo Kurulum tamamlandi!
echo.
echo MyPass %install_dir% dizinine kuruldu.
echo Masaustunde bir kisayol olusturuldu.
echo.
echo Programi calistirmak icin masaustundeki MyPass kisayoluna tiklayabilirsiniz.
echo.
pause
goto end

:end
echo.
echo Kurulum sihirbazindan cikiliyor...
echo.
pause 