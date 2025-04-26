#!/system/bin/sh
awk '{print}' "$MODPATH"/common/SuperMarioTweaker-Banner
sleep 2
ui_print ""
sleep 1
ui_print "Important: Android 14/13 (SDK 34/33) needed for full Vulkan support."
sleep 2
ui_print "Snapdragon Only"
sleep 2
ui_print "Uninstall DT Module before flashing SuperMario Tweaker."
sleep 2
ui_print "🔧 Applying System Enhancements (0/14)..."
sleep 2
ui_print "- [1/14] Accelerating boot time & reducing startup lag for faster access... 🚀"
sleep 2
ui_print "- [2/14] Improving touch responsiveness & delivering a smoother, more fluid UI... ⚡"
sleep 2
ui_print "- [3/14] Stabilizing FPS & enhancing gaming performance for an immersive experience... 🎮"
sleep 2
ui_print "- [4/14] Activating Vulkan 1.4 support via Mesa Turnip v25.0.3 for superior graphics rendering... 🎨"
sleep 2
ui_print "- [5/14] Optimizing RAM management for quicker app switching & multitasking... 🧠"
sleep 2
ui_print "- [6/14] Extending battery life with advanced Doze mode & optimized background processes... 🔋"
sleep 2
ui_print "- [7/14] Enhancing CPU & GPU performance for peak efficiency & smooth operation... ⚡"
sleep 2
ui_print "- [8/14] Activating Game Mode to lock display at 120Hz & maximize FPS during gaming... 🕹️"
sleep 2
ui_print "- [9/14] Enabling signature spoofing... 🔑"
sleep 2
ui_print "- [10/14] Removing Google bloatware & unnecessary logging for a cleaner, more efficient system... 📉"
sleep 2
ui_print "- [11/14] Tuning thermal profiles to prevent overheating & ensure stable performance... 🌡️"
sleep 2
ui_print "- [12/14] Enhancing SurfaceFlinger & HWUI for improved UI rendering & visual fluidity... 🎨"
sleep 2
ui_print "- [13/14] Dynamically adjusting CPU-GPU load to ensure seamless multitasking & gaming... 🔄"
sleep 2
ui_print "- [14/14] Applying final optimizations for peak system performance & responsiveness... ⚙️"
sleep 3
ui_print "Now Starting SuperMario-Tweaker Script"
"${MODDIR}/SuperMario-Tweaker.sh" > /dev/null
sleep 3
ui_print "✅ Tweaks Applied Successfully!"
sleep 2
ui_print "〽️ SuperMario-Tweaker v2.0.0"
ui_print "📢 Join Telegram: @MRX7014Cloud"
ui_print "💡 Reboot to activate changes"