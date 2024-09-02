## Client Setup (intertotem/totembase)

Steps to set up a totem device:

1. **User and Machine Setup**:
   - `totem@totem` user and machine setup is standard.

2. **Install SuperCollider**:
   - Install [SuperCollider](https://supercollider.github.io/download) on each "totem" device.

3. for **runtime**, in a terminal: `git pull https://github.com/heseltime/it-u-intertotem-totembase` into a intertotem directory on desktop
     - cd into the totembase directory and `python3 main.py` (and SuperCollider setup)
  
   
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
