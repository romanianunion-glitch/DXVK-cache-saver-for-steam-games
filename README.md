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

## Setup

By default DXVK writes its state cache into `steamapps/shadercache/<APPID>/DXVK_state_cache/`. Steam's "Clear local shader cache" button (Settings → Downloads) wipes that folder for every game, and uninstalling or reinstalling a game deletes it too, since it lives inside Steam-managed folders. That's why the cache resets and the stutter comes back.

1. Download `dxvk-guard.sh` and save it to `~/.local/bin/dxvk-guard.sh`
2. Make it executable:
   ```bash
   chmod +x ~/.local/bin/dxvk-guard.sh
   ```
3. (Optional) Open the script and adjust `CACHE_DIR` / `BACKUP_DIR` if your Steam library isn't in the default location — it assumes `~/.local/share/Steam/steamapps/shadercache`
4. Set it as a Steam launch option for the game you want to protect (right-click the game → Properties → Launch Options):
   ```
   gamemoderun ~/.local/bin/dxvk-guard.sh %command%
   ```

That's it — the cache now survives Steam cache clears and reinstalls.

## Requirements

- bash
- A Linux system running games via Proton/DXVK (developed and tested on CachyOS)

## Related

Part of a broader [CachyOS + Hyprland performance guide](https://cachyosperformance.lovable.app) — see section "Shader Cache That Survives Reinstalls" for more context on why this matters.

## License

MIT
