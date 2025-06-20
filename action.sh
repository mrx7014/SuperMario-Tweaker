#!/system/bin/sh

MODDIR="/data/adb/modules/SMTW"

function abort() {
    echo "- $1"
    sleep 0.5
    exit 1
}

echo "[!] Your device is being cleaned 🧹💀👺👾👹😱"
sleep 1
echo "[•] Cleaning GPU-related caches..."
(
    find /data/user_de/*/*/*cache/* -iname "*shader*" -exec rm -rf {} +
    find /data/data/* -iname "*shader*" -exec rm -rf {} +
    find /data/data/* -iname "*graphitecache*" -exec rm -rf {} +
    find /data/data/* -iname "*gpucache*" -exec rm -rf {} +
    find /data_mirror/data*/*/*/*/* -iname "*shader*" -exec rm -rf {} +
    find /data_mirror/data*/*/*/*/* -iname "*graphitecache*" -exec rm -rf {} +
    find /data_mirror/data*/*/*/*/* -iname "*gpucache*" -exec rm -rf {} +
) || abort "- Failed to clean GPU caches"
echo "[✓] GPU Cache cleaned."
sleep 1
echo "[•] Cleaning system & dalvik caches..."
(
    rm -rf /cache/* 
    rm -rf /data/cache/*
    rm -rf /data/dalvik-cache/*
    rm -rf /data/system/package_cache/*
) || abort "- Failed to clean system caches"
echo "[✓] System Cache cleaned."
sleep 1
echo "[✔] Cleaning completed successfully!"