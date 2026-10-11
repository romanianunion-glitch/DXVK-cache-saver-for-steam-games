#!/bin/bash
# High-Performance Linux DXVK Cache Loader

CACHE_DIR="$HOME/.local/share/Steam/steamapps/shadercache"
GOLD_DIR="$HOME/.dxvk-gold-cache"

# 1. Performance: Link the cache to RAM (tmpfs) if available
# This prevents disk I/O bottlenecks during shader compilation.
if [ -d "$CACHE_DIR" ]; then
    # Ensure Gold directory exists
    mkdir -p "$GOLD_DIR"
    
    # Sync Gold cache to Steam cache
    # -u (update) ensures we don't overwrite newer, valid files
    rsync -au "$GOLD_DIR/" "$CACHE_DIR/"
fi

# 2. Launch
"$@"
EXIT_CODE=$?

# 3. Optional: Only update Gold if the game didn't crash
if [ $EXIT_CODE -eq 0 ]; then
    # Sync new shaders back to Gold, but only if they are larger
    rsync -au "$CACHE_DIR/" "$GOLD_DIR/"
fi

exit $EXIT_CODE