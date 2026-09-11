#!/system/bin/sh

# Start a background retry loop as soon as /data is available. This covers
# devices where the late_start service hook runs after display initialization.
MODDIR="${0%/*}"
[ -z "$MODDIR" ] && MODDIR="/data/adb/modules/SMTW"

(
    sleep 10
    sh "$MODDIR/apply_display.sh" >/dev/null 2>&1
) &
