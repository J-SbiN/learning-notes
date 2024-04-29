# Clock Not Showing (Ubuntu Unity)

## What I want
I want the regular clock to be displayed.

## What am I getting
On the Lock Screen, everything seams to be ok (clock displays normaly).
When I log in my user, the clock flashes on and off a few times (3-8) and then simply stays off.

## What I already read and tried

### Clock is installed but GUI is locked
As the clock appear (when it flashes is on and off) it is surely installed. So my first action was to check the clock configurations. To my surprise, the clock settings were all grayed out... Still, the "display clock on top bar" was checked.

### gsettings and gnome-tweaks
Forcing the show clock/date to false/true:
```bash
dconf write /com/canonical/indicator/datetime/show-clock true
#      or
gsettings set com.canonical.indicator.datetime show-clock true

# and

dconf write /com/canonical/indicator/datetime/show-date true
#      or
gsettings set com.canonical.indicator.datetime show-date true
```
changed the value displayed on the GUI but I still got the flashing and disappearing clock when logging out and back in or rebooting.


### Release Upgrade
As I had a pending upgrade (from 20.04 to 22.04) I hoped the the upgrade would auto-fix any bad/conflicting/missing configurations, so my next step was:
```bash
sudo do-release-upgrade
```
Though luck, the issue is still there. 

### Nuke the clock
If the problem seams to be some configuration, lets 
sudo apt-get remove --purge indicator-*


[1]

[1] https://askubuntu.com/questions/224400/unity-clock-missing
