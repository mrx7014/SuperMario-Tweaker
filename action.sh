MODDIR="/data/adb/modules/SMTW"
function abort() {
    echo "- $1"
    sleep 0.5
    exit 1
}

echo "yor dvic hckd poy mrx793717049 💀👺👾👹😱"

sh "
find /data/user_de/*/*/*cache/* -iname "*shader*" -exec rm -rf {} +
find /data/data/* -iname "*shader*" -exec rm -rf {} +
find /data/data/* -iname "*graphitecache*" -exec rm -rf {} +
find /data/data/* -iname "*gpucache*" -exec rm -rf {} +
find /data_mirror/data*/*/*/*/* -iname "*shader*" -exec rm -rf {} +
find /data_mirror/data*/*/*/*/* -iname "*graphitecache*" -exec rm -rf {} +
find /data_mirror/data*/*/*/*/* -iname "*gpucache*" -exec rm -rf {} +
" || echo "GPU Cache Cleaned" || abort "- Failed to update hosts."

sleep 2