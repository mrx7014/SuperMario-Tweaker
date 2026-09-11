#!/system/bin/sh

# Resolve the module directory ourselves. Some root managers do not export
# MODDIR when invoking a module service script.
MODDIR="${0%/*}"
[ -z "$MODDIR" ] && MODDIR="/data/adb/modules/SMTW"

# Wait until Android reports that boot is complete.
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 5
done

# Apply the regular SuperMario tweaks.
sh "$MODDIR/SuperMario-Tweaker.sh" >/dev/null 2>&1

# SurfaceFlinger and framework display services can be restarted or reset
# after boot. apply_display.sh rereads the persistent config and reapplies it.
sh "$MODDIR/apply_display.sh" >/dev/null 2>&1 &
