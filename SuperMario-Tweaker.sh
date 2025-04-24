#!/system/bin/sh
# SuperMario Tweaker Script - Optimized System Tweaks

# Enable device idle
dumpsys deviceidle enable all
dumpsys deviceidle whitelist +com.android.systemui >/dev/null 2>&1

# Battery & system settings
settings put global dropbox_max_files 1
settings put system anr_debugging_mechanism 0
settings put global adaptive_battery_management_enabled 1
settings put global aggressive_battery_saver 1
settings put global enable_freeform_support 1
settings put global allow_signature_fake 1
settings put system display_color_enhance 1

# Reset and apply device idle constants
settings delete global device_idle_constants >/dev/null 2>&1
settings put global device_idle_constants \
inactive_to=60000,sensing_to=0,locating_to=0,location_accuracy=2000,\
motion_inactive_to=0,idle_after_inactive_to=0,idle_pending_to=60000,\
max_idle_pending_to=120000,idle_pending_factor=2.0,idle_to=900000,\
max_idle_to=21600000,idle_factor=2.0,max_temp_app_whitelist_duration=60000,\
mms_temp_app_whitelist_duration=30000,sms_temp_app_whitelist_duration=20000,\
light_after_inactive_to=10000,light_pre_idle_to=60000,light_idle_to=180000,\
light_idle_factor=2.0,light_max_idle_to=900000,\
light_idle_maintenance_min_budget=30000,light_idle_maintenance_max_budget=60000

# Apply iorap if supported
if [[ "$(getprop ro.iorapd.enable)" != "true" ]] && [[ "$sdk" -gt "29" ]]; then
    sed -i '/ro.iorapd.enable/s/.*/ro.iorapd.enable=true/' "$MODPATH"/system.prop
fi

# Optimize HWUI based on total RAM
case "$total_ram" in
    2048)
        cat <<EOF >> "$MODPATH"/system.prop
ro.hwui.texture_cache_size=72
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
EOF
        ;;
    3072)
        cat <<EOF >> "$MODPATH"/system.prop
ro.hwui.texture_cache_size=96
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
EOF
        ;;
esac

# Dalvik VM Tuning based on RAM
if [[ "$total_ram" -lt "2048" ]]; then
    sed -i '/dalvik.vm.heaptargetutilization/s/.*/dalvik.vm.heaptargetutilization=0.9/' "$MODPATH"/system.prop
elif [[ "$total_ram" -ge "2048" && "$total_ram" -lt "3072" ]]; then
    sed -i '/dalvik.vm.heapstartsize/s/.*/dalvik.vm.heapstartsize=8m/' "$MODPATH"/system.prop
    sed -i '/dalvik.vm.heapgrowthlimit/s/.*/dalvik.vm.heapgrowthlimit=192m/' "$MODPATH"/system.prop
    sed -i '/dalvik.vm.heapsize/s/.*/dalvik.vm.heapsize=512m/' "$MODPATH"/system.prop
    sed -i '/dalvik.vm.heapminfree/s/.*/dalvik.vm.heapminfree=512k/' "$MODPATH"/system.prop
    sed -i '/dalvik.vm.heapmaxfree/s/.*/dalvik.vm.heapmaxfree=8m/' "$MODPATH"/system.prop
    sed -i '/dalvik.vm.heaptargetutilization/s/.*/dalvik.vm.heaptargetutilization=0.75/' "$MODPATH"/system.prop
elif [[ "$total_ram" -ge "3072" && "$total_ram" -lt "4096" ]]; then
    sed -i '/dalvik.vm.heapstartsize/s/.*/dalvik.vm.heapstartsize=8m/' "$MODPATH"/system.prop
    sed -i '/dalvik.vm.heapgrowthlimit/s/.*/dalvik.vm.heapgrowthlimit=256m/' "$MODPATH"/system.prop
    sed -i '/dalvik.vm.heapsize/s/.*/dalvik.vm.heapsize=512m/' "$MODPATH"/system.prop
    sed -i '/dalvik.vm.heapminfree/s/.*/dalvik.vm.heapminfree=2m/' "$MODPATH"/system.prop
    sed -i '/dalvik.vm.heapmaxfree/s/.*/dalvik.vm.heapmaxfree=8m/' "$MODPATH"/system.prop
    sed -i '/dalvik.vm.heaptargetutilization/s/.*/dalvik.vm.heaptargetutilization=0.75/' "$MODPATH"/system.prop
elif [[ "$total_ram" -ge "4096" && "$total_ram" -lt "5130" ]]; then
    sed -i '/dalvik.vm.heapstartsize/s/.*/dalvik.vm.heapstartsize=8m/' "$MODPATH"/system.prop
    sed -i '/dalvik.vm.heapgrowthlimit/s/.*/dalvik.vm.heapgrowthlimit=384m/' "$MODPATH"/system.prop
    sed -i '/dalvik.vm.heapsize/s/.*/dalvik.vm.heapsize=1024m/' "$MODPATH"/system.prop
    sed -i '/dalvik.vm.heapminfree/s/.*/dalvik.vm.heapminfree=4m/' "$MODPATH"/system.prop
    sed -i '/dalvik.vm.heapmaxfree/s/.*/dalvik.vm.heapmaxfree=16m/' "$MODPATH"/system.prop
    sed -i '/dalvik.vm.heaptargetutilization/s/.*/dalvik.vm.heaptargetutilization=0.75/' "$MODPATH"/system.prop
fi

# Extra tweaks
[[ "$(getprop ro.boot.hardware)" == "qcom" ]] && sed -i '/vendor.display.disable_rotator_downscale/s/.*/vendor.display.disable_rotator_downscale=1/' "$MODPATH"/system.prop
[[ "$IS64BIT" == "true" ]] && sed -i '/dalvik.vm.dex2oat64.enabled/s/.*/dalvik.vm.dex2oat64.enabled=true/' "$MODPATH"/system.prop

# Disable background access for specific packages
for pkg in \
  com.android.backupconfirm \
  com.google.android.setupwizard \
  com.android.printservice.recommendation \
  com.google.android.feedback \
  com.google.android.onetimeinitializer \
  com.xiaomi.joyose \
  com.android.traceur \
  org.codeaurora.gps.gpslogsave \
  com.qualcomm.qti.perfdump \
  com.google.android.gms \
  com.google.android.gsf \
  com.android.onetimeinitializer; do
  cmd appops set "$pkg" RUN_IN_BACKGROUND ignore 2>/dev/null
done

# Force-stop and disable traceur
am force-stop com.android.traceur 2>/dev/null
pm disable com.android.traceur 2>/dev/null

# Clean cache
sync
rm -rf /data/dalvik-cache /cache/dalvik-cache
