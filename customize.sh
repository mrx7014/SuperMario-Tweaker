#!/system/bin/sh
awk '{print}' "$MODPATH"/common/SuperMarioTweaker-Banner
ui_print ""
if [ -d "/data/adb/modules/DT" ]; then
  ui_print "WARNING: DT module has been detected and it will be removed at the next reboot."
  touch /data/adb/modules/DT/remove
fi
ui_print "Important: Android 14/13 (SDK 34/33) needed for full Vulkan support."
sleep 1.5
ui_print "Snapdragon Only"
sleep 1.5
ui_print "🔧 Applying System Enhancements (0/14)..."
sleep 1.5
ui_print "- [1/14] Accelerating boot time & reducing startup lag for faster access... 🚀"
sleep 0.5
ui_print "- [2/14] Improving touch responsiveness & delivering a smoother, more fluid UI... ⚡"
sleep 0.5
ui_print "- [3/14] Stabilizing FPS & enhancing gaming performance for an immersive experience... 🎮"
sleep 0.5
ui_print "- [4/14] Activating Vulkan 1.4 support via Mesa Turnip v25.0.3 for superior graphics rendering... 🎨"
sleep 0.5
ui_print "- [5/14] Optimizing RAM management for quicker app switching & multitasking... 🧠"
sleep 0.5
ui_print "- [6/14] Extending battery life with advanced Doze mode & optimized background processes... 🔋"
sleep 0.5
ui_print "- [7/14] Enhancing CPU & GPU performance for peak efficiency & smooth operation... ⚡"
sleep 0.5
ui_print "- [8/14] Activating Game Mode to lock display at 120Hz & maximize FPS during gaming... 🕹️"
sleep 0.5
ui_print "- [9/14] Enabling signature spoofing... 🔑"
sleep 0.5
ui_print "- [10/14] Removing Google bloatware & unnecessary logging for a cleaner, more efficient system... 📉"
sleep 0.5
ui_print "- [11/14] Tuning thermal profiles to prevent overheating & ensure stable performance... 🌡️"
sleep 0.5
ui_print "- [12/14] Enhancing SurfaceFlinger & HWUI for improved UI rendering & visual fluidity... 🎨"
sleep 0.5
ui_print "- [13/14] Dynamically adjusting CPU-GPU load to ensure seamless multitasking & gaming... 🔄"
sleep 0.5
ui_print "- [14/14] Applying final optimizations for peak system performance & responsiveness... ⚙️"
sleep 0.5
ui_print "Now Starting SuperMario-Tweaker Script"
sh "${MODPATH}/SuperMario-Tweaker.sh" > /dev/null
set_perm_recursive $MODPATH/system 0 0 755 u:object_r:system_file:s0
set_perm_recursive $MODPATH/system/vendor 0 2000 755 u:object_r:vendor_file:s0
set_perm $MODPATH/system/vendor/lib64/hw/vulkan.adreno.so 0 0 0644 u:object_r:same_process_hal_file:s0
ui_print ""
sleep 1
ui_print "Done"
ui_print ""
ui_print "Cleaning GPU Cache ... Please wait!"
find /data/user_de/*/*/*cache/* -iname "*shader*" -exec rm -rf {} +
find /data/data/* -iname "*shader*" -exec rm -rf {} +
find /data/data/* -iname "*graphitecache*" -exec rm -rf {} +
find /data/data/* -iname "*gpucache*" -exec rm -rf {} +
find /data_mirror/data*/*/*/*/* -iname "*shader*" -exec rm -rf {} +
find /data_mirror/data*/*/*/*/* -iname "*graphitecache*" -exec rm -rf {} +
find /data_mirror/data*/*/*/*/* -iname "*gpucache*" -exec rm -rf {} +
ui_print ""
ui_print "GPU Cache Cleared ..."
sleep 2
ui_print "✅ Tweaks Applied Successfully!"
ui_print "〽️ SuperMario-Tweaker v3.0.0 - Beta"
ui_print "📢 Join Telegram: @MRX7014Cloud"
ui_print "💡 Reboot to activate changes"
