## 🪆 Client Setup (intertotem/totembase) 🪆

Steps to set up a totem device:

1. **User and Machine Setup**:
   - `totem@totem` user and machine setup is standard.

2. **Install SuperCollider**:
   - Install [SuperCollider](https://supercollider.github.io/download) on each "totem" device.

3. for **runtime**, in a terminal: `git pull https://github.com/heseltime/it-u-intertotem-totembase` into a intertotem directory on desktop
     - cd into the totembase directory 
     - `qjackctl`, hit START in Audio Control Kit window, then start SuperCollider (load file) and run code - the routing should be visible in the graph view if you hit GRAPH in the control kit.
  
   
```

     +-------------------+                         +-------------------+
     |    Raspberry Pi   |                         |    Raspberry Pi   |
     |  "totem" (machine)|                         | "raspberrypi"     |
     |      Debian       |                         |     (machine)     |
     +-------------------+                         |      Debian       |
     |  User: totem      |                         +-------------------+
     | Repo: it-u-       |  🔄  SSH for file transfer  |  User: lab03      |
     | intertotem-       +<----------------------->| Repo: it-u-       |
     | totembase         |                         | intertotem        |
     +--------+----------+                         +--------+----------+
              |                                             |  
              |                                             |
              |                                             |  
   +----------+-----------+                     +-----------+------------+
   |  📂  Code Repo: it-u- |                     | 📂 Code Repo: it-u-     |
   | intertotem-totembase  |                     | intertotem             |
   +-----------------------+                     +------------------------+
        🗝️ GitHub Access: Pull                           🗝️ GitHub Access: Push/Pull

```

The above is the minimal setup: this can then be expanded with multiple "totem" machines. Repo connections: both lab03 and the first totem machine have ssh keys for heseltime github saved so can do a git push as well. Further totems should only need to pull (no ssh setup required). 

The final setup steps are to connect speakers to the totems. (Last Check: one totem/multiple speakers vs one totem/one speaker setup approach. `<-- TODO`)

## Setup on Local Pi

* cronjob
* to run /home/totem/Desktop/intertotem/it-u-intertotem-totembase/autostart.bash on reboot
* accesses startup.scd in same directory

> [!TIP]
> For this reason **this repo is best put in a Desktop directory intertotem** (if you want to follow along).
> So, in a nutshell, for setup required dependency for totembase (this project): SuperCollider installation (so setup is literally install that software on to a debian formatted pi sd-card (typically, using pi-imager or similar), install SuperCollider, clone into this repo in a Desktop folder `intertotem`.

```
@reboot bash /home/totem/Desktop/intertotem/it-u-intertotembase
```
