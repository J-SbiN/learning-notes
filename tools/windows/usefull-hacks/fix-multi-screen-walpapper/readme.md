# Fix Multi Screen Walpapper
## Scope
While using Active Directory and Citrix, conecting multiple displays allways results in getting the wallpaper all messed up. This caused me some eyesore - specially when I had multiple windows opened at the same time.
### Simplest solution
Use the control pannel to set the background as a solid color!!
### The Issue
I needed to do this everytime I signed/logged - and I'm not really one for doing the same thing over and over the long way.
## Solution
I want a script I can easyly run to do this everytime I need.

\
\
\
.


# How to use
## Setup
1. Create a shortcut on your desktop
2. edit that shortcut 'Target' field to include ```powershell.exe -ExecutionPolicy Bypass "<path_to_the_file>\windows-walpaper-to-solid-color.ps1 [your_favorit_color]"```. You can use no *favorit color*. there is a default.
3. Use the shortcut *havoc*. You can edit the *favorit color* on the shortcut at any time.

\
\
\
.


# How it works
For the real thing read the code - its not evem 100 lines!
The script changes some regestry keys in order to set the wallpaper as a solid color instead of an image or the Ie deffault. Then a 'method' is created to change and update the color of that solid wallpaper.
There is a default color harcoded on the script but a parameter can be passed to overide the color set to the wallpaper.

Note that the color syntax is ```0xBBGGRR```. 

\
\
\
.


# Bonuses
## Some Cool Colors:
Here are some colours I enjoyed:
 - Hard red: ```0x3834D1```
 - Pure purple: ```0xAA00AA```
 - Hard Blue: ```0xD82525```
## Wat about the bat file?
It actually works! And it it would need no setup at all!!  ...well... you'd have to copy the file to some place or create a shortcut, but thats it.

The initial idea was to have a bat to make it more windows retrocompatible. But as I ended up finding no reliable solution without powershell, I simply created the script in powershell. The bat version is left behind as an history of attempts and learned lessons.