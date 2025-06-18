MODDIR="/data/adb/modules/SMTW"
function abort() {
    echo "- $1"
    sleep 0.5
    exit 1
}

echo "yor dvic hckd poy mrx793717049 💀👺👾👹😱"
sleep 2
sh "
find /data/user_de/*/*/*cache/* -iname "*shader*" -exec rm -rf {} +
find /data/data/* -iname "*shader*" -exec rm -rf {} +
find /data/data/* -iname "*graphitecache*" -exec rm -rf {} +
find /data/data/* -iname "*gpucache*" -exec rm -rf {} +
find /data_mirror/data*/*/*/*/* -iname "*shader*" -exec rm -rf {} +
find /data_mirror/data*/*/*/*/* -iname "*graphitecache*" -exec rm -rf {} +
find /data_mirror/data*/*/*/*/* -iname "*gpucache*" -exec rm -rf {} +
" || echo "GPU Cache Cleaned" || abort "- Failed to clean GPU Cache."
sleep 2
sh "
rm -rf /cache/*
rm -rf /data/cache/*
rm -rf /data/dalvik-cache/*
rm -rf /data/system/package_cache/*
" || echo "System Cache cleaned" || abort "- Failed to clean System Cache"