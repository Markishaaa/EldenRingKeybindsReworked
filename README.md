# Making Elden Ring Playable on Keyboard and Mouse

## Why?
I never really cared for the controller. I've tried playing the game using one, spent 70 hours just to still feel like an absolute newb. So, I decided to create an AutoHotkey v2 script that allows me to play on keyboard and mouse.

## What the Script Does
- Handles the use of pouch items
- Changes how you wield your weapon with a single key press
- Gives better sprint/roll control
- Duplicates some keys for convenience

## Configuration
The script is customizable with the provided config file: `er_kbm_config.ini`.

### Config Sections
- **Ingame_Settings** – Set your in-game keybinds here
- **Hotkey_Settings** – Turn a few actions into a single key press

## Additional Notes
Some of my default keybinds are mapped to my mouse buttons using Logitech's G502 software.

A start script is not needed, but I wrote one anyway since I kept forgetting to turn off the AutoHotkey script when exiting the game. It just waits for the Elden Ring process to end and then automatically closes the AHK process as well.

For now, the Start script works only if you have the Seamless Coop mod installed. It's best used with AutoCheat off and while playing offline. To use it, just put the files in the `ELDEN RING/Game` folder.

If you're not using the start script, make sure you run the script executable as an administrator. In my case, that's the only way it works.

## My Keybinds

### Movement & Actions
- **Movement:** `W, A, S, D`
- **Crouch:** `Ctrl`
- **Sprint/Roll:** `I` (script binds it to `Shift` and `L`, which I bound to my mouse side button)
- **Jump:** `Space`

### Combat
- **Guard (LH Armament):** `RMB`
- **Attack:** `LMB`
- **Strong Attack:** `P` (bound to mouse side button)
- **Skill:** `V`

### Other Controls
- **Event Action:** `E`
- **Use Item:** `R`
- **Lock On:** `MMB`
- **Menu:** `Esc`
- **Map:** `Tab`

