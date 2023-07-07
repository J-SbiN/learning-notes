:: An attemp that would work permanently on a persoal machine
::
::    Windows Registry Editor Version 5.00
::    
::    [HKEY_CURRENT_USER\Control Panel\Colors\Background]
::    @='255 0 0'
::    
::    [HKEY_CURRENT_USER\Control Panel\Desktop\Wallpaper]
::    @=''



::   :: This doesn't work
::   :: It updates the regestry currectly but the rundll32.exe command behaves temperamentally!!....   found this: https://superuser.com/questions/1074587/under-what-circumstances-can-i-use-rundll32-to-invoke-a-function-in-a-dll
::   
::   ::
::   ::  A batch to change the desktop background on the fly
::   ::   
::   
::   ::echo off
::   ::echo "Setting the descktop image as none"
::   reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "" /f
::   
::   ::echo "Define a windows background color (just for consistency sake)"
::   reg add "HKEY_CURRENT_USER\Control Panel\Colors" /v Background /t REG_SZ /d "100 100 110" /f
::   :: 209 52 56 (the previous color)
::   
::   ::echo "Defining the Descktop Background Color"
::   reg add "HKEY_CURRENT_USER\Control Panel\Desktop\Colors" /v Background /t REG_SZ /d "100 100 110" /f
::   
::   :: For some freaking reason explorer defines a walpapper!...  kill it!
::   reg delete "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General" /v WallpaperStyle /f
::   
::   ::echo "Setting Walpaper style to solid color"
::   reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v WallpaperStyle /t REG_SZ /d 2 /f
::   
::   Pause
::   
::   :: Reload the variables from the regestry to make them efective
::   RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters 1, True
::   Pause






::::::::::::::::::::::::::::::::::::::
::                                  ::
::      A usable solution!!!        ::
::                                  ::
::::::::::::::::::::::::::::::::::::::
echo off
SETLOCAL

:: getting input color
set color-code=0x3834D1


:: Setting the descktop image as none
echo "Seting Walpaper to 'none'..."
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "" /f
IF %ERRORLEVEL% NEQ 0 ( 
    echo Something FAILED!
    exit /b 1
)

:: Setting Walpaper style to solid color
echo "Setting Walpepar Style to solid color..."
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v WallpaperStyle /t REG_SZ /d 2 /f
IF %ERRORLEVEL% NEQ 0 ( 
    echo Something FAILED!
    exit /b 1
)


:: For some freaking reason explorer defines a walpapper!...  kill it!
echo "Removing IE Walpaper Style Override..."
reg query "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\WallpaperStyle" > nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo     It looks like it wasn't there already.
) ELSE (
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General" /v WallpaperStyle /f
    IF %ERRORLEVEL% NEQ 0 (
        echo Something FAILED!
        eexit /b 1
    )
)


:: Reload the variables from the regestry to make them efective
echo "Taking the former changes into effect..."
RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters 1, True
IF %ERRORLEVEL% NEQ 0 ( 
    echo Something FAILED!
    eexit /b 1
)


::  Some powershell magic that sets the desktop background solid color to that exadecinal ate the end of the line   (note that for the case being the color order is reversed!.....  0xBBGGRR intead of the usual 0xRRGGBB)
echo "Changing you Descktop Wallpaper to color %color-code%..."
powershell -command add-type -typedefinition """"using System;`n using System.Runtime.InteropServices;`n public class PInvoke { [DllImport(`"""user32.dll`""")] public static extern bool SetSysColors(int cElements, int[] lpaElements, int[] lpaRgbValues); }""""; [PInvoke]::SetSysColors(1, @(1), @(%color-code%))
:: https://superuser.com/questions/1214337/update-hkcu-control-panel-colors-background-via-cmd-and-apply-immediately/1215141#1215141
IF %ERRORLEVEL% NEQ 0 ( 
    echo Something FAILED!
    exit /b 1
)
echo It should be all done!

ENDLOCAL
Pause
