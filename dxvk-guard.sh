# DXVK Cache Saver for Steam Games
# Copyright (c) 2026 RomanianUnion-Glitch
# Licensed under the MIT License.
#!/bin/bash

CACHE_DIR="$HOME/.local/share/Steam/steamapps/shadercache"
BACKUP_DIR="$HOME/.dxvk-cache-backup"

mkdir -p "$BACKUP_DIR"

# --- RESTORE: bring back any backup that's bigger than what's currently in the cache ---
find "$BACKUP_DIR" -name "*.dxvk-cache" | while read -r BACKUP; do
    REL="${BACKUP#$BACKUP_DIR/}"
    ORIGINAL="$CACHE_DIR/$REL"
    if [ ! -f "$ORIGINAL" ] || [ "$(stat -c%s "$BACKUP")" -gt "$(stat -c%s "$ORIGINAL" 2>/dev/null || echo 0)" ]; then
        echo "[dxvk-guard] Restoring $REL from backup..."
        mkdir -p "$(dirname "$ORIGINAL")"
        cp "$BACKUP" "$ORIGINAL"
    fi
done

# --- LAUNCH GAME ---
"$@"

# --- BACKUP: after game closes, update backup with the latest (larger) cache ---
find "$CACHE_DIR" -name "*.dxvk-cache" | while read -r CACHE; do
    REL="${CACHE#$CACHE_DIR/}"
    BACKUP="$BACKUP_DIR/$REL"
    if [ ! -f "$BACKUP" ] || [ "$(stat -c%s "$CACHE")" -gt "$(stat -c%s "$BACKUP")" ]; then
        echo "[dxvk-guard] Backing up $REL..."
        mkdir -p "$(dirname "$BACKUP")"
        cp "$CACHE" "$BACKUP"
    fi
done
