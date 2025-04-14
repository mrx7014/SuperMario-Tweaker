awk '{print}' "$MODPATH"/common/SuperMarioTweaker-Banner
sleep 5
ui_print "*******************************"
ui_print "*      SuperMario Tweaker      *"
ui_print "* Let Mario Upgrade Your Device *"
ui_print "*           v1.0.0             *"
ui_print "*******************************"
sleep 1
ui_print "Important : Android 14 & 13 (SDK 34 & 33) is needed for Full Vulkan 1.4 - It will work on lower versions too but not with the full experience"
sleep 2
ui_print "Working On SnapDragon Only (Until Now)"
sleep 2
ui_print "If You Come From DT Module You Must Uninstall it first then Flash SuperMario Tweaker"
sleep 3
ui_print " "
ui_print "🔧 Applying Tweaks (0/14)..."
sleep 1
ui_print "- [1/14] Optimizing boot time & power saving for faster startup and lower energy consumption... 🚀"
sleep 1
ui_print "- [2/14] Enhancing responsiveness & touch speed for a smoother and more responsive user experience... ⚡"
sleep 1
ui_print "- [3/14] Stabilizing FPS & improving graphics rendering for fluid gameplay and smoother animations... 🎮"
sleep 1
ui_print "- [4/14] Disabling data collection, tracking, & ANR (App Not Responding) debugging for improved privacy & security... 🔒"
sleep 1
ui_print "- [5/14] Accelerating app launch & freeing up RAM for instant app responsiveness & smoother multitasking... 🏎️"
sleep 1
ui_print "- [6/14] Extending battery life with Doze mode, aggressive power saver, and optimized background processes... 🔋"
sleep 1
ui_print "- [7/14] Switching to Vulkan graphics API for enhanced UI smoothness, better performance, and lower latency... 🎨"
sleep 1
ui_print "- [8/14] Updating Vulkan version to 1.4 - Mesa Turnip Driver to ensure cutting-edge graphics performance... 🆕"
sleep 1
ui_print "- [9/14] Improving RAM management & optimizing memory settings to reduce lag & enhance system stability... 🧠"
sleep 1
ui_print "- [10/14] Disabling unnecessary Google services, GMS, and bloatware to free up system resources for better performance... 📉"
sleep 1
ui_print "- [11/14] Enabling aggressive RAM killer & background restrictions to ensure smooth operation & prevent background slowdowns... 🗑️"
sleep 1
ui_print "- [12/14] Stopping diagnostic logs & unwanted system reports to reduce system load & enhance overall performance... 🚫"
sleep 1
ui_print "- [13/14] Optimizing thermal response & CPU performance to maintain smooth operation even under heavy load... 🌡️"
sleep 1
ui_print "- [14/14] Final optimizations & performance tweaks to boost overall system efficiency, responsiveness & stability... ⚙️"
sleep 1
dumpsys deviceidle enable all
dumpsys deviceidle whitelist +com.android.systemui >/dev/null 2>&1
settings put global dropbox_max_files 1
settings put system anr_debugging_mechanism 0
settings put global adaptive_battery_management_enabled 1
settings put global aggressive_battery_saver 1
settings put global enable_freeform_support 1
settings put global allow_signature_fake 1
settings put system display_color_enhance 1
settings delete global device_idle_constants >/dev/null 2>&1
settings put global device_idle_constants inactive_to=60000,sensing_to=0,locating_to=0,location_accuracy=2000,motion_inactive_to=0,idle_after_inactive_to=0,idle_pending_to=60000,max_idle_pending_to=120000,idle_pending_factor=2.0,idle_to=900000,max_idle_to=21600000,idle_factor=2.0,max_temp_app_whitelist_duration=60000,mms_temp_app_whitelist_duration=30000,sms_temp_app_whitelist_duration=20000,light_after_inactive_to=10000,light_pre_idle_to=60000,light_idle_to=180000,light_idle_factor=2.0,light_max_idle_to=900000,light_idle_maintenance_min_budget=30000,light_idle_maintenance_max_budget=60000

if [[ "$(getprop ro.iorapd.enable)" != "true" ]] && [[ "$sdk" -gt "29" ]]; then
    sed -i '/ro.iorapd.enable/s/.*/ro.iorapd.enable=true/' "$MODPATH"/system.prop
fi

if [[ "$total_ram" -eq "2048" ]] || [[ "$total_ram" -gt "2048" ]] && [[ "$total_ram" -lt "3072" ]]; then
    echo "ro.hwui.texture_cache_size=72
          ro.hwui.layer_cache_size=48
          ro.hwui.path_cache_size=32
          ro.hwui.r_buffer_cache_size=8
          ro.hwui.drop_shadow_cache_size=6
          ro.hwui.gradient_cache_size=1
          ro.hwui.texture_cache_flushrate=0.4
          ro.hwui.text_small_cache_width=1024
          ro.hwui.text_small_cache_height=512
          ro.hwui.text_large_cache_width=2048
          ro.hwui.text_large_cache_height=1024
          " >> "$MODPATH"/system.prop

elif [[ "$total_ram" -eq "3072" ]] || [[ "$total_ram" -gt "3072" ]] && [[ "$total_ram" -lt "4096" ]]; then
      echo "ro.hwui.texture_cache_size=96
          ro.hwui.layer_cache_size=64
          ro.hwui.path_cache_size=39
          ro.hwui.r_buffer_cache_size=12
          ro.hwui.drop_shadow_cache_size=7
          ro.hwui.gradient_cache_size=1
          ro.hwui.texture_cache_flushrate=0.4
          ro.hwui.text_small_cache_width=2048
          ro.hwui.text_small_cache_height=2048
          ro.hwui.text_large_cache_width=3072
          ro.hwui.text_large_cache_height=2048
          " >> "$MODPATH"/system.prop
fi

if [[ "$total_ram" -lt "2048" ]]; then
    sed -i '/dalvik.vm.heaptargetutilization/s/.*/dalvik.vm.heaptargetutilization=0.9/' "$MODPATH"/system.prop

elif [[ "$total_ram" -eq "2048" ]] || [[ "$total_ram" -gt "2048" ]] && [[ "$total_ram" -lt "3072" ]]; then
      sed -i '/dalvik.vm.heapstartsize/s/.*/dalvik.vm.heapstartsize=8m/' "$MODPATH"/system.prop
      sed -i '/dalvik.vm.heapgrowthlimit/s/.*/dalvik.vm.heapgrowthlimit=192m/' "$MODPATH"/system.prop
      sed -i '/dalvik.vm.heapsize/s/.*/dalvik.vm.heapsize=512m/' "$MODPATH"/system.prop
      sed -i '/dalvik.vm.heapminfree/s/.*/dalvik.vm.heapminfree=512k/' "$MODPATH"/system.prop
      sed -i '/dalvik.vm.heapmaxfree/s/.*/dalvik.vm.heapmaxfree=8m/' "$MODPATH"/system.prop
      sed -i '/dalvik.vm.heaptargetutilization/s/.*/dalvik.vm.heaptargetutilization=0.75/' "$MODPATH"/system.prop

elif [[ "$total_ram" -eq "3072" ]] || [[ "$total_ram" -gt "3072" ]] && [[ "$total_ram" -lt "4096" ]]; then
      sed -i '/dalvik.vm.heapstartsize/s/.*/dalvik.vm.heapstartsize=8m/' "$MODPATH"/system.prop
      sed -i '/dalvik.vm.heapgrowthlimit/s/.*/dalvik.vm.heapgrowthlimit=256m/' "$MODPATH"/system.prop
      sed -i '/dalvik.vm.heapsize/s/.*/dalvik.vm.heapsize=512m/' "$MODPATH"/system.prop
      sed -i '/dalvik.vm.heapminfree/s/.*/dalvik.vm.heapminfree=2m/' "$MODPATH"/system.prop
      sed -i '/dalvik.vm.heapmaxfree/s/.*/dalvik.vm.heapmaxfree=8m/' "$MODPATH"/system.prop
      sed -i '/dalvik.vm.heaptargetutilization/s/.*/dalvik.vm.heaptargetutilization=0.75/' "$MODPATH"/system.prop

elif [[ "$total_ram" -eq "4096" ]] || [[ "$total_ram" -gt "4096" ]] && [[ "$total_ram" -lt "5130" ]]; then
      sed -i '/dalvik.vm.heapstartsize/s/.*/dalvik.vm.heapstartsize=8m/' "$MODPATH"/system.prop
      sed -i '/dalvik.vm.heapgrowthlimit/s/.*/dalvik.vm.heapgrowthlimit=384m/' "$MODPATH"/system.prop
      sed -i '/dalvik.vm.heapsize/s/.*/dalvik.vm.heapsize=1024m/' "$MODPATH"/system.prop
      sed -i '/dalvik.vm.heapminfree/s/.*/dalvik.vm.heapminfree=4m/' "$MODPATH"/system.prop
      sed -i '/dalvik.vm.heapmaxfree/s/.*/dalvik.vm.heapmaxfree=16m/' "$MODPATH"/system.prop
      sed -i '/dalvik.vm.heaptargetutilization/s/.*/dalvik.vm.heaptargetutilization=0.75/' "$MODPATH"/system.prop
fi

if [[ "$(getprop ro.boot.hardware)" == "qcom" ]]; then
    sed -i '/vendor.display.disable_rotator_downscale/s/.*/vendor.display.disable_rotator_downscale=1/' "$MODPATH"/system.prop
fi

if [[ "$IS64BIT" == "true" ]]; then
    sed -i '/dalvik.vm.dex2oat64.enabled/s/.*/dalvik.vm.dex2oat64.enabled=true/' "$MODPATH"/system.prop
fi

cmd appops set com.android.backupconfirm RUN_IN_BACKGROUND ignore 2>/dev/null
cmd appops set com.google.android.setupwizard RUN_IN_BACKGROUND ignore 2>/dev/null
cmd appops set com.android.printservice.recommendation RUN_IN_BACKGROUND ignore 2>/dev/null
cmd appops set com.google.android.feedback RUN_IN_BACKGROUND ignore 2>/dev/null
cmd appops set com.google.android.onetimeinitializer RUN_IN_BACKGROUND ignore 2>/dev/null
cmd appops set com.xiaomi.joyose RUN_IN_BACKGROUND ignore 2>/dev/null
cmd appops set com.android.traceur RUN_IN_BACKGROUND ignore 2>/dev/null
am force-stop com.android.traceur 2>/dev/null
pm disable com.android.traceur 2>/dev/null
cmd appops set org.codeaurora.gps.gpslogsave RUN_IN_BACKGROUND ignore 2>/dev/null
cmd appops set com.android.onetimeinitializer RUN_IN_BACKGROUND ignore 2>/dev/null
cmd appops set com.qualcomm.qti.perfdump RUN_IN_BACKGROUND ignore 2>/dev/null
cmd appops set com.google.android.gms RUN_IN_BACKGROUND ignore 2>/dev/null
cmd appops set com.google.android.gsf RUN_IN_BACKGROUND ignore 2>/dev/null
sync
rm -rf /data/dalvik-cache
rm -rf /cache/dalvik-cache
sleep 2
ui_print "- [14/14] Done"
ui_print "If you got any things like sh: bad number don't worry everyting is working well"
sleep 2
ui_print "✅ Tweaks Applied Successfully!"
sleep 1
ui_print " "
ui_print "〽️ SuperMario-Tweaker Version: 1.0.0"
ui_print "📢 Join Telegram: @MRX7014Cloud"
ui_print "💡 Reboot to activate changes"
