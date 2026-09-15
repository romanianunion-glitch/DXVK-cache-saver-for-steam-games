# dxvk-guard

A lightweight bash script wrapper that protects your DXVK shader cache from being wiped by Steam's "Clear local shader cache" option or by reinstalling a game.

## The problem

Steam's "Clear local shader cache" and game reinstalls wipe the DXVK state cache folder. That means your shader cache rebuilds from scratch, and you eat stutters all over again the next time you play.

## How it works

`dxvk-guard` wraps your game launch in three steps:

1. **Before launch** — restores the DXVK shader cache from a backup folder, if the backup is larger than the current cache
2. **Launches the game**
3. **After exit** — backs up the cache again, if it has grown since the restore

Your shader cache effectively survives cache clears and reinstalls, since the backup lives outside the folders Steam touches.

## Installation

1. Clone this repo or download `dxvk-guard.sh`
2. Make it executable:
   ```bash
   chmod +x dxvk-guard.sh
   ```
3. Open the script and set `CACHE_DIR` and `BACKUP_DIR` to match your DXVK cache location and where you want backups stored
4. Add it as a Steam launch option for the game you want to protect:
   ```
   gamemoderun /path/to/dxvk-guard.sh %command%
   ```

## Requirements

- bash
- A Linux system running games via Proton/DXVK (developed and tested on CachyOS)

## Related

Part of a broader [CachyOS + Hyprland performance guide](https://cachyosperformance.lovable.app) — see section "Shader Cache That Survives Reinstalls" for more context on why this matters.(website made by me also)
## License

MIT
