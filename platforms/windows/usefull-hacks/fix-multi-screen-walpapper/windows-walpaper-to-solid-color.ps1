# Setting a default color
$DEFAULT_COLOR_CODE='0x3834D1'
$COLOR_CODE=$DEFAULT_COLOR_CODE

# Getting input color
$INPUT_COLOR=$ARGS[0]


# Selecting the color to use
if ( -not ($INPUT_COLOR -eq $null) ) {
    if ($INPUT_COLOR -match '^0x[0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F][0-9A-F]$') {
        $COLOR_CODE=$INPUT_COLOR
    }else {
        echo "Your color didn't match the expected format: 0xBBGGRR"
        echo "Operation Aborted!"
        exit
    }
}
echo "Your color is: $COLOR_CODE"
# read-host -prompt "Press Enter to continue"


# Setting the descktop image as none
echo "Seting Walpaper to 'none'..."
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d " " /f
if ( -not $? ) { 
    echo "Something FAILED. --> Operation Aborted"
    exit
}

# Setting Walpaper style to solid color
echo "Setting Walpepar Style to solid color..."
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v WallpaperStyle /t REG_SZ /d 2 /f
if ( -not $? ) { 
    echo "Something FAILED. --> Operation Aborted!"
    exit
}


# For some freaking reason explorer defines a walpapper!...  kill it!
echo "Removing IE Walpaper Style Override..."
reg query "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General\WallpaperStyle" >$null 2>&1
if ( -not $? ) { 
    echo     "It looks like it wasn't there already."
}else {
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Desktop\General" /v WallpaperStyle /f
    iif ( -not $? ) { 
        echo "Something FAILED. --> Operation Aborted!"
        exit
    }
}


# Reload the variables from the regestry to make them efective
echo "Tacking the former changes into effect..."
RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters 1, True
if ( -not $? ) { 
    echo "Something FAILED. --> Operation Aborted!"
    exit
}


#  Some powershell magic that sets the desktop background solid color to that exadecinal ate the end of the line   (note that for the case being the color order is reversed!.....  0xBBGGRR intead of the usual 0xRRGGBB)
echo "Changing you Descktop Wallpaper to color %color-code%..."
#powershell -command add-type -typedefinition """"using System;`n using System.Runtime.InteropServices;`n public class PInvoke { [DllImport(`"""user32.dll`""")] public static extern bool SetSysColors(int cElements, int[] lpaElements, int[] lpaRgbValues); }""""; [PInvoke]::SetSysColors(1, @(1), @($COLOR_CoDE))

add-type -typedefinition "using System;`n using System.Runtime.InteropServices;`n public class PInvoke { [DllImport(`"user32.dll`")] public static extern bool SetSysColors(int cElements, int[] lpaElements, int[] lpaRgbValues); }"
[PInvoke]::SetSysColors(1, @(1), @($COLOR_CODE))
# https://superuser.com/questions/1214337/update-hkcu-control-panel-colors-background-via-cmd-and-apply-immediately/1215141#1215141
if ( -not $? ) { 
    echo "Something FAILED. --> Operation Aborted!"
    exit
}
echo "It should be all done!"
#read-host -prompt "Press Enter to exit"