#!/system/bin/sh
# SuperMario Tweaker Script - Optimized System Tweaks

# Logging setup
LOG_DIR="/sdcard/SMTW"
LOG_FILE="$LOG_DIR/tweaks.log"
mkdir -p "$LOG_DIR"
echo "Tweaks Log - $(date)" > "$LOG_FILE"
total_tweaks=0
successful_tweaks=0

log_tweak() {
    local message="$1"
    local success="$2"
    total_tweaks=$((total_tweaks + 1))
    if [ "$success" -eq 1 ]; then
        echo "[SUCCESS] $message" >> "$LOG_FILE"
        successful_tweaks=$((successful_tweaks + 1))
    else
        echo "[FAILED] $message" >> "$LOG_FILE"
    fi
}

# Enable device idle
if dumpsys deviceidle enable all; then
    log_tweak "Enabled device idle" 1
else
    log_tweak "Failed to enable device idle" 0
fi

if dumpsys deviceidle whitelist +com.android.systemui >/dev/null 2>&1; then
    log_tweak "Whitelisted com.android.systemui" 1
else
    log_tweak "Failed to whitelist com.android.systemui" 0
fi

# Battery & system settings
if settings put global dropbox_max_files 1; then
    log_tweak "Set dropbox_max_files to 1" 1
else
    log_tweak "Failed to set dropbox_max_files" 0
fi

if settings put system anr_debugging_mechanism 0; then
    log_tweak "Disabled ANR debugging mechanism" 1
else
    log_tweak "Failed to disable ANR debugging mechanism" 0
fi

if settings put global adaptive_battery_management_enabled 1; then
    log_tweak "Enabled adaptive battery management" 1
else
    log_tweak "Failed to enable adaptive battery management" 0
fi

if settings put global aggressive_battery_saver 1; then
    log_tweak "Enabled aggressive battery saver" 1
else
    log_tweak "Failed to enable aggressive battery saver" 0
fi

if settings put global allow_signature_fake 1; then
    log_tweak "Allowed signature fake" 1
else
    log_tweak "Failed to allow signature fake" 0
fi

# Reset and apply device idle constants
if settings delete global device_idle_constants >/dev/null 2>&1; then
    log_tweak "Deleted global device_idle_constants" 1
else
    log_tweak "Failed to delete global device_idle_constants" 0
fi

if settings put global device_idle_constants \
inactive_to=60000,sensing_to=0,locating_to=0,location_accuracy=2000,\
motion_inactive_to=0,idle_after_inactive_to=0,idle_pending_to=60000,\
max_idle_pending_to=120000,idle_pending_factor=2.0,idle_to=900000,\
max_idle_to=21600000,idle_factor=2.0,max_temp_app_whitelist_duration=60000,\
mms_temp_app_whitelist_duration=30000,sms_temp_app_whitelist_duration=20000,\
light_after_inactive_to=10000,light_pre_idle_to=60000,light_idle_to=180000,\
light_idle_factor=2.0,light_max_idle_to=900000,\
light_idle_maintenance_min_budget=30000,light_idle_maintenance_max_budget=60000; then
    log_tweak "Set device idle constants" 1
else
    log_tweak "Failed to set device idle constants" 0
fi


# Apply iorap if supported
if [[ "$(getprop ro.iorapd.enable)" != "true" ]] && [[ "$sdk" -gt "29" ]]; then
    if sed -i '/ro.iorapd.enable/s/.*/ro.iorapd.enable=true/' "$MODPATH"/system.prop; then
        log_tweak "Enabled iorap" 1
    else
        log_tweak "Failed to enable iorap" 0
    fi
fi

# Dalvik VM Tuning based on RAM
if [[ "$total_ram" -lt "2048" ]]; then
    if sed -i '/dalvik.vm.heaptargetutilization/s/.*/dalvik.vm.heaptargetutilization=0.9/' "$MODPATH"/system.prop; then
        log_tweak "Tuned Dalvik VM for <2GB RAM" 1
    else
        log_tweak "Failed to tune Dalvik VM for <2GB RAM" 0
    fi
elif [[ "$total_ram" -ge "2048" && "$total_ram" -lt "3072" ]]; then
    if sed -i '/dalvik.vm.heapstartsize/s/.*/dalvik.vm.heapstartsize=8m/' "$MODPATH"/system.prop; then
        log_tweak "Tuned Dalvik VM for 2GB-3GB RAM" 1
    else
        log_tweak "Failed to tune Dalvik VM for 2GB-3GB RAM" 0
    fi
    if sed -i '/dalvik.vm.heapgrowthlimit/s/.*/dalvik.vm.heapgrowthlimit=192m/' "$MODPATH"/system.prop; then
        log_tweak "Set Dalvik VM heap growth limit for 2GB-3GB RAM" 1
    else
        log_tweak "Failed to set Dalvik VM heap growth limit for 2GB-3GB RAM" 0
    fi
    if sed -i '/dalvik.vm.heapsize/s/.*/dalvik.vm.heapsize=512m/' "$MODPATH"/system.prop; then
        log_tweak "Set Dalvik VM heap size for 2GB-3GB RAM" 1
    else
        log_tweak "Failed to set Dalvik VM heap size for 2GB-3GB RAM" 0
    fi
    if sed -i '/dalvik.vm.heapminfree/s/.*/dalvik.vm.heapminfree=512k/' "$MODPATH"/system.prop; then
        log_tweak "Set Dalvik VM heap min free for 2GB-3GB RAM" 1
    else
        log_tweak "Failed to set Dalvik VM heap min free for 2GB-3GB RAM" 0
    fi
    if sed -i '/dalvik.vm.heapmaxfree/s/.*/dalvik.vm.heapmaxfree=8m/' "$MODPATH"/system.prop; then
        log_tweak "Set Dalvik VM heap max free for 2GB-3GB RAM" 1
    else
        log_tweak "Failed to set Dalvik VM heap max free for 2GB-3GB RAM" 0
    fi
    if sed -i '/dalvik.vm.heaptargetutilization/s/.*/dalvik.vm.heaptargetutilization=0.75/' "$MODPATH"/system.prop; then
        log_tweak "Set Dalvik VM heap target utilization for 2GB-3GB RAM" 1
    else
        log_tweak "Failed to set Dalvik VM heap target utilization for 2GB-3GB RAM" 0
    fi
elif [[ "$total_ram" -ge "3072" && "$total_ram" -lt "4096" ]]; then
    if sed -i '/dalvik.vm.heapstartsize/s/.*/dalvik.vm.heapstartsize=8m/' "$MODPATH"/system.prop; then
        log_tweak "Tuned Dalvik VM for 3GB-4GB RAM" 1
    else
        log_tweak "Failed to tune Dalvik VM for 3GB-4GB RAM" 0
    fi
    if sed -i '/dalvik.vm.heapgrowthlimit/s/.*/dalvik.vm.heapgrowthlimit=256m/' "$MODPATH"/system.prop; then
        log_tweak "Set Dalvik VM heap growth limit for 3GB-4GB RAM" 1
    else
        log_tweak "Failed to set Dalvik VM heap growth limit for 3GB-4GB RAM" 0
    fi
    if sed -i '/dalvik.vm.heapsize/s/.*/dalvik.vm.heapsize=512m/' "$MODPATH"/system.prop; then
        log_tweak "Set Dalvik VM heap size for 3GB-4GB RAM" 1
    else
        log_tweak "Failed to set Dalvik VM heap size for 3GB-4GB RAM" 0
    fi
    if sed -i '/dalvik.vm.heapminfree/s/.*/dalvik.vm.heapminfree=2m/' "$MODPATH"/system.prop; then
        log_tweak "Set Dalvik VM heap min free for 3GB-4GB RAM" 1
    else
        log_tweak "Failed to set Dalvik VM heap min free for 3GB-4GB RAM" 0
    fi
    if sed -i '/dalvik.vm.heapmaxfree/s/.*/dalvik.vm.heapmaxfree=8m/' "$MODPATH"/system.prop; then
        log_tweak "Set Dalvik VM heap max free for 3GB-4GB RAM" 1
    else
        log_tweak "Failed to set Dalvik VM heap max free for 3GB-4GB RAM" 0
    fi
    if sed -i '/dalvik.vm.heaptargetutilization/s/.*/dalvik.vm.heaptargetutilization=0.75/' "$MODPATH"/system.prop; then
        log_tweak "Set Dalvik VM heap target utilization for 3GB-4GB RAM" 1
    else
        log_tweak "Failed to set Dalvik VM heap target utilization for 3GB-4GB RAM" 0
    fi
elif [[ "$total_ram" -ge "4096" && "$total_ram" -lt "5130" ]]; then
    if sed -i '/dalvik.vm.heapstartsize/s/.*/dalvik.vm.heapstartsize=8m/' "$MODPATH"/system.prop; then
        log_tweak "Tuned Dalvik VM for 4GB-5GB RAM" 1
    else
        log_tweak "Failed to tune Dalvik VM for 4GB-5GB RAM" 0
    fi
    if sed -i '/dalvik.vm.heapgrowthlimit/s/.*/dalvik.vm.heapgrowthlimit=384m/' "$MODPATH"/system.prop; then
        log_tweak "Set Dalvik VM heap growth limit for 4GB-5GB RAM" 1
    else
        log_tweak "Failed to set Dalvik VM heap growth limit for 4GB-5GB RAM" 0
    fi
    if sed -i '/dalvik.vm.heapsize/s/.*/dalvik.vm.heapsize=1024m/' "$MODPATH"/system.prop; then
        log_tweak "Set Dalvik VM heap size for 4GB-5GB RAM" 1
    else
        log_tweak "Failed to set Dalvik VM heap size for 4GB-5GB RAM" 0
    fi
    if sed -i '/dalvik.vm.heapminfree/s/.*/dalvik.vm.heapminfree=4m/' "$MODPATH"/system.prop; then
        log_tweak "Set Dalvik VM heap min free for 4GB-5GB RAM" 1
    else
        log_tweak "Failed to set Dalvik VM heap min free for 4GB-5GB RAM" 0
    fi
    if sed -i '/dalvik.vm.heapmaxfree/s/.*/dalvik.vm.heapmaxfree=16m/' "$MODPATH"/system.prop; then
        log_tweak "Set Dalvik VM heap max free for 4GB-5GB RAM" 1
    else
        log_tweak "Failed to set Dalvik VM heap max free for 4GB-5GB RAM" 0
    fi
    if sed -i '/dalvik.vm.heaptargetutilization/s/.*/dalvik.vm.heaptargetutilization=0.75/' "$MODPATH"/system.prop; then
        log_tweak "Set Dalvik VM heap target utilization for 4GB-5GB RAM" 1
    else
        log_tweak "Failed to set Dalvik VM heap target utilization for 4GB-5GB RAM" 0
    fi
fi

if [[ "$IS64BIT" == "true" ]]; then
    if sed -i '/dalvik.vm.dex2oat64.enabled/s/.*/dalvik.vm.dex2oat64.enabled=true/' "$MODPATH"/system.prop; then
        log_tweak "Enabled dex2oat64" 1
    else
        log_tweak "Failed to enable dex2oat64" 0
    fi
fi

# Disable background access for specific packages
for pkg in \
  com.google.android.gms \
  com.google.android.gsf \; do
  if cmd appops set "$pkg" RUN_IN_BACKGROUND ignore 2>/dev/null; then
      log_tweak "Disabled background access for $pkg" 1
  else
      log_tweak "Failed to disable background access for $pkg" 0
  fi
done

# EAS & power scheduling
if echo 1 > /proc/sys/kernel/sched_boost; then
    log_tweak "Enabled scheduler boost" 1
else
    log_tweak "Failed to enable scheduler boost" 0
fi

# Kernel Tweaks

if chmod 644 /sys/kernel/gpu/gpu_min_clock && echo 1260 > /sys/kernel/gpu/gpu_min_clock; then
    log_tweak "Set GPU min clock" 1
else
    log_tweak "Failed to set GPU min clock" 0
fi

if chmod 644 /sys/kernel/gpu/gpu_max_clock && echo 1260 > /sys/kernel/gpu/gpu_max_clock; then
    log_tweak "Set GPU max clock" 1
else
    log_tweak "Failed to set GPU max clock" 0
fi

# Ensure all cores online
for cpu in 0 1 2 3 4 5 6 7; do
    if echo 1 > /sys/devices/system/cpu/cpu$cpu/online; then
        log_tweak "Ensured CPU core $cpu is online" 1
    else
        log_tweak "Failed to ensure CPU core $cpu is online" 0
    fi
done

# CMD Tweaks
if cmd thermalservice override-status 0; then
    log_tweak "Overrode thermal service status" 1
else
    log_tweak "Failed to override thermal service status" 0
fi

if cmd power set-fixed-performance-mode-enabled true; then
    log_tweak "Set fixed performance mode enabled" 1
else
    log_tweak "Failed to set fixed performance mode enabled" 0
fi

if cmd power set-adaptive-power-saver-enabled false; then
    log_tweak "Disabled adaptive power saver" 1
else
    log_tweak "Failed to disable adaptive power saver" 0
fi

if cmd power set-mode 0; then
    log_tweak "Set power mode to 0" 1
else
    log_tweak "Failed to set power mode to 0" 0
fi

if cmd display set-match-content-frame-rate-pref 1; then
    log_tweak "Set match content fps to 1" 1
else
    log_tweak "Failed to set match content fps to 1" 0
fi

android_properties=
debug.sf.disable_backpressure=1
debug.sf.latch_unsignaled=1
debug.sf.enable_hwc_vds=0
debug.sf.early_phase_offset_ns=250000
debug.sf.early_app_phase_offset_ns=250000
debug.sf.early_gl_phase_offset_ns=1500000
debug.sf.early_gl_app_phase_offset_ns=7500000
debug.sf.high_fps_early_phase_offset_ns=3000000
debug.sf.high_fps_early_gl_phase_offset_ns=500000
debug.sf.high_fps_late_app_phase_offset_ns=50000
debug.sf.phase_offset_threshold_for_next_vsync_ns=3000000
debug.sf.show_updates=0
debug.sf.showcpu=0
debug.sf.showbackground=0
debug.sf.showfps=0
debug.sf.hw=1
debug.gralloc.gfx_ubwc_disable=0
persist.sys.composer.preferred_mode=performance


echo "$android_properties" | while IFS= read -r prop; do
    prop_name="${prop%%=*}"
    prop_value="${prop#*=}"
    if resetprop -n "$prop_name" "$prop_value"; then
        log_tweak "Set property $prop_name" 1
    else
        log_tweak "Failed to set property $prop_name" 0
    fi
done

# VM Settings 
if echo 100 > /proc/sys/vm/swappiness; then
    log_tweak "Set vm.swappiness to 100" 1
else
    log_tweak "Failed to set vm.swappiness" 0
fi

if echo 25 > /proc/sys/vm/dirty_ratio; then
    log_tweak "Set vm.dirty_ratio to 25" 1
else
    log_tweak "Failed to set vm.dirty_ratio" 0
fi

if echo 60 > /proc/sys/vm/overcommit_ratio; then
    log_tweak "Set vm.overcommit_ratio to 60" 1
else
    log_tweak "Failed to set vm.overcommit_ratio" 0
fi

if echo 90 > /proc/sys/vm/vfs_cache_pressure; then
    log_tweak "Set vm.vfs_cache_pressure to 90" 1
else
    log_tweak "Failed to set vm.vfs_cache_pressure" 0
fi

if echo 1 > /proc/sys/vm/swap_ratio_enable; then
    log_tweak "Enabled swap ratio" 1
else
    log_tweak "Failed to enable swap ratio" 0
fi

# Prop Tweak
resetprop -n logd.statistics false
resetprop -n persist.logd.statistics false
resetprop -n persist.sys.offlinelog.kernel 1
resetprop -n persist.sys.offlinelog.logcat 1
resetprop -n ro.logd.size 0
resetprop -n ro.compcache.default 0
resetprop -n ro.kernel.qemu.gles 0
resetprop -n ro.kernel.checkjni 0
resetprop -n ro.sf.battery_log 0
resetprop -n ro.sf.battery.log.enabled 0
resetprop -n profiler.debugmonitor false
resetprop -n debug.egl.swap_interval 0
resetprop -n persist.sys.use_dithering 1
resetprop -n debug.sf.enable_gl 1
resetprop -n ro.launcher.blur.appLaunch 0
resetprop -n ro.surface_flinger.supports_background_blur 0
resetprop -n ro.sf.blurs_are_expensive 0
resetprop -n ro.config.small_battery true
resetprop -n persist.service.lgospd.enable 0
resetprop -n persist.service.pcsync.enable 0
resetprop -n ro.sys.fw.bg_apps_limit 4
resetprop -n ro.vendor.qti.sys.fw.bg_apps_limit 4
resetprop -n ro.vendor.qti.sys.fw.bservice_enable true
resetprop -n ro.config.bg_apps_limit 4
resetprop -n debug.sf.disable_client_composition_cache 1
resetprop -n debug.renderengine.backend skiaglthreaded
resetprop -n debug.hwui.skia_atrace_enabled false
resetprop -n ro.surface_flinger.enable_frame_rate_override false

# TCP settings
if echo 'reno' > "/proc/sys/net/ipv4/tcp_congestion_control"; then
    log_tweak "Set TCP congestion control to reno" 1
else
    log_tweak "Failed to set TCP congestion control" 0
fi

# Kernel Tweaks
if echo 1 > /proc/sys/kernel/sched_tunable_scaling; then
    log_tweak "Enabled sched tunable scaling" 1
else
    log_tweak "Failed to enable sched tunable scaling" 0
fi

if echo 1 > /proc/sys/kernel/sched_boost; then
    log_tweak "Enabled sched boost" 1
else
    log_tweak "Failed to enable sched boost" 0
fi

if echo "0   0   0   0" > /proc/sys/kernel/printk; then
    log_tweak "Set printk to 0" 1
else
    log_tweak "Failed to set printk" 0
fi

if echo 0 > /proc/sys/kernel/printk_delay; then
    log_tweak "Set printk delay to 0" 1
else
    log_tweak "Failed to set printk delay" 0
fi

if echo 0 > /proc/sys/kernel/printk_ratelimit_burst; then
    log_tweak "Set printk ratelimit burst to 0" 1
else
    log_tweak "Failed to set printk ratelimit burst" 0
fi

if echo 0 > /proc/sys/kernel/printk_ratelimit; then
    log_tweak "Set printk ratelimit to 0" 1
else
    log_tweak "Failed to set printk ratelimit" 0
fi

if setprop debug.composition.type gpu; then
    log_tweak "Set composition type to GPU" 1
else
    log_tweak "Failed to set composition type" 0
fi

if setprop debug_hw_overdraw 0; then
    log_tweak "Disabled hardware overdraw" 1
else
    log_tweak "Failed to disable hardware overdraw" 0
fi

if setprop debug.sf.enable_hwc_vds 0; then
    log_tweak "Disabled HWC VDS" 1
else
    log_tweak "Failed to disable HWC VDS" 0
fi

if setprop debug.sf.late.sf.duration 27600000; then
    log_tweak "Set late SF duration to 27600000" 1
else
    log_tweak "Failed to set late SF duration" 0
fi

if setprop debug.sf.late.app.duration 20000000; then
    log_tweak "Set late app duration to 20000000" 1
else
    log_tweak "Failed to set late app duration" 0
fi

if setprop debug.sf.early.sf.duration 27600000; then
    log_tweak "Set early SF duration to 27600000" 1
else
    log_tweak "Failed to set early SF duration" 0
fi

if setprop debug.sf.early.app.duration 20000000; then
    log_tweak "Set early app duration to 20000000" 1
else
    log_tweak "Failed to set early app duration" 0
fi

if setprop debug.sf.earlyGl.sf.duration 27600000; then
    log_tweak "Set early GL SF duration to 27600000" 1
else
    log_tweak "Failed to set early GL SF duration" 0
fi

if setprop debug.sf.earlyGl.app.duration 20000000; then
    log_tweak "Set early GL app duration to 20000000" 1
else
    log_tweak "Failed to set early GL app duration" 0
fi

if echo 0 > /proc/sys/vm/oom_kill_allocating_task; then
    log_tweak "Set OOM kill allocating task to 0" 1
else
    log_tweak "Failed to set OOM kill allocating task" 0
fi

if echo 1 > /proc/sys/vm/overcommit_memory; then
    log_tweak "Enabled overcommit memory" 1
else
    log_tweak "Failed to enable overcommit memory" 0
fi

if echo 1 > /proc/sys/vm/oom_dump_tasks; then
    log_tweak "Enabled OOM dump tasks" 1
else
    log_tweak "Failed to enable OOM dump tasks" 0
fi

if echo 3 > /proc/sys/vm/drop_caches; then
    log_tweak "Dropped caches" 1
else
    log_tweak "Failed to drop caches" 0
fi

if echo 0 > /proc/sys/kernel/panic; then
    log_tweak "Set kernel panic to 0" 1
else
    log_tweak "Failed to set kernel panic" 0
fi

if echo 0 > /proc/sys/kernel/panic_on_oops; then
    log_tweak "Set panic on oops to 0" 1
else
    log_tweak "Failed to set panic on oops" 0
fi

if echo 0 > /proc/sys/kernel/panic_on_warn; then
    log_tweak "Set panic on warn to 0" 1
else
    log_tweak "Failed to set panic on warn" 0
fi

if echo 24 > /sys/block/ram0/queue/read_ahead_kb; then
    log_tweak "Set read ahead kb for ram0 to 24" 1
else
    log_tweak "Failed to set read ahead kb for ram0" 0
fi

# Final log summary
echo "Total Tweaks: $total_tweaks" >> "$LOG_FILE"
echo "Successful Tweaks: $successful_tweaks" >> "$LOG_FILE"
echo "Failed Tweaks: $((total_tweaks - successful_tweaks))" >> "$LOG_FILE"