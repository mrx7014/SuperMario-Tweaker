#!/system/bin/sh
MODDIR=/data/adb/modules/SMTW
function abort() {
    echo "- $1"
    sleep 0.5
    exit 1
}
sh "$MODDIR/SuperMario-Tweaker.sh" &>/dev/null || abort "- Failed to apply tweaks"
