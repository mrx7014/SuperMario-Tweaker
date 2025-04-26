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

# Set small CPU cores (0-3) to performance mode
for cpu in 0 1 2 3; do
    chmod 644 /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor
    echo performance > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor
    chmod 444 /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor
    chmod 644 /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_min_freq
    echo 1900800 > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_min_freq
    chmod 444 /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_min_freq
    chmod 644 /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_max_freq
    echo 1900800 > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_max_freq
    chmod 444 /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_max_freq
done

# Set big CPU cores (4-7) to performance mode
for cpu in 4 5 6 7; do
    chmod 644 /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor
    echo performance > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor
    chmod 444 /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor
    chmod 644 /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_min_freq
    echo 2802300 > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_min_freq
    chmod 444 /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_min_freq
    chmod 644 /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_max_freq
    echo 2802300 > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_max_freq
    chmod 444 /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_max_freq
done

# GPU max power level
echo 1260000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
echo 1260000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
echo 1260000000 > /sys/class/kgsl/kgsl-3d0/devfreq/cur_freq
echo 1260000000 > /sys/class/kgsl/kgsl-3d0/devfreq/target_freq
echo 0 > /sys/class/kgsl/kgsl-3d0/min_pwrlevel
echo 0 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
echo 0 > /sys/class/kgsl/kgsl-3d0/default_pwrlevel
echo performance > /sys/class/kgsl/kgsl-3d0/devfreq/governor
echo 0 > /sys/class/kgsl/kgsl-3d0/thermal_pwrlevel
echo 0 > /sys/class/kgsl/kgsl-3d0/bus_split
echo 1260 > /sys/class/kgsl/kgsl-3d0/clock_mhz
echo 1260 > /sys/class/kgsl/kgsl-3d0/max_clock_mhz
echo 1260 > /sys/class/kgsl/kgsl-3d0/min_clock_mhz
echo 1260000000 > /sys/class/kgsl/kgsl-3d0/max_gpuclk
echo 0 > /sys/class/kgsl/kgsl-3d0/throttling
echo 1 > /sys/class/kgsl/kgsl-3d0/force_bus_on
echo 1 > /sys/class/kgsl/kgsl-3d0/force_rail_on
echo 1 > /sys/class/kgsl/kgsl-3d0/force_clk_on
echo 1 > /sys/class/kgsl/kgsl-3d0/force_no_nap
echo 0 > /sys/class/kgsl/kgsl-3d0/pwrscale

# CPU & kernel boost settings
echo 1 > /sys/devices/system/cpu/cpufreq/interactive/boost
echo 1 > /sys/module/cpu_boost/parameters/boost
echo 1 > /sys/module/cpu_boost/parameters/input_boost_enabled
echo 1 > /sys/module/cpu_boost/parameters/sched_boost
echo 1 > /sys/module/msm_performance/parameters/touchboost
echo 1 > /sys/module/msm_thermal/core_control/enabled

# EAS & power scheduling
echo 1 > /proc/sys/kernel/sched_boost
echo 0 > /sys/module/workqueue/parameters/power_efficient

# Kernel Tweaks
chmod 644 sys/kernel/fpscaps
echo 0 /sys/kernel/fpscaps
chmod 444 sys/kernel/fpscaps
chmod 644 /sys/kernel/gpu/gpu_clock
echo 1260 > /sys/kernel/gpu/gpu_clock
chmod 444 /sys/kernel/gpu/gpu_clock
chmod 644 /sys/kernel/gpu/gpu_min_clock
echo 1260 > /sys/kernel/gpu/gpu_min_clock
chmod 444 /sys/kernel/gpu/gpu_min_clock
chmod 644 /sys/kernel/gpu/gpu_max_clock
echo 1260 > /sys/kernel/gpu/gpu_max_clock
chmod 444 /sys/kernel/gpu/gpu_max_clock

# Ensure all cores online
for cpu in 0 1 2 3 4 5 6 7; do
    echo 1 > /sys/devices/system/cpu/cpu$cpu/online
done

# CMD Tweaks

cmd thermalservice override-status 0
cmd power set-fixed-performance-mode-enabled true
cmd power set-adaptive-power-saver-enabled false
cmd power set-mode 0
cmd display set-match-content-frame-rate-pref 1

# Game Performance & FPS Settings
packages=$(pm list packages -3 | awk -F':' '{print $2}')
for package in $packages; do
    cmd device_config put game_overlay $package mode=2,fps=120,resolution=high,antialiasing=2,cpu_level=high,gpu_level=high,thermal_mode=performance,refresh_rate=120:mode=3,fps=120,resolution=high,antialiasing=2,cpu_level=high,gpu_level=high,thermal_mode=performance,refresh_rate=120
    cmd game set --mode performance --fps 120 $package
done

sleep 15

android_properties="
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
debug.sf.showupdates=0
debug.sf.showcpu=0
debug.sf.showbackground=0
debug.sf.showfps=0
debug.sf.hw=1
debug.gralloc.gfx_ubwc_disable=0
debug.composition-type=hybrid
persist.sys.composer.preferred_mode=performance
"
echo "$android_properties" | while IFS= read -r prop; do
  prop_name="${prop%%=*}"
  prop_value="${prop#*=}"
  resetprop -n "$prop_name" "$prop_value"
done

# VM Settings 
echo 100 > /proc/sys/vm/swappiness
echo 25 > /proc/sys/vm/dirty_ratio
echo 60 > /proc/sys/vm/overcommit_ratio
echo 90 > /proc/sys/vm/vfs_cache_pressure
echo 1 > /proc/sys/vm/swap_ratio_enable

# Zram Settings
echo 2621440000 > /sys/block/zram0/disksize

# FS settings
echo 1024 > /sys/class/block/mmcblk0/queue/read_ahead_kb
echo noop > /sys/block/mmcblk0/queue/scheduler

# Prop Tweak
resetprop -n logd.statistics false
resetprop -n ro.logd.statistics false
resetprop -n persist.logd.statistics false
resetprop -n logd.kernel false
resetprop -n logcat.live disable
resetprop -n logcast.live disable
resetprop -n live.logcat disable
resetprop -n persist.sys.offlinelog.kernel 1
resetprop -n persist.sys.offlinelog.logcat 1
resetprop -n ro.logd.size 0
resetprop -n ro.compcache.default 0
resetprop -n ro.kernel.android.checkjni 0
resetprop -n ro.kernel.qemu.gles 0
resetprop -n ro.kernel.checkjni 0
resetprop -n ro.sf.battery_log 0
resetprop -n ro.sf.battery.log.enabled 0
resetprop -n profiler.debugmonitor false
resetprop -n debug.egl.swap_interval 0
resetprop -n persist.sys.use_dithering 1
resetprop -n debug.sf.enable_gl 1
resetprop -n debug.sf.show_updates 0
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
# Aggressive Ram Killer (Prop)
resetprop -n ro.config.dha_cached_max 8
resetprop -n ro.config.dha_empty_max 15
resetprop -n ro.config.dha_empty_init 8 
resetprop -n ro.config.dha_lmk_scale 0.7
resetprop -n ro.config.dha_th_rate 1.0
resetprop -n ro.config.sdha_apps_bg_max 6
resetprop -n ro.config.sdha_apps_bg_min 2
resetprop -n ro.surface_flinger.has_wide_color_display false    
resetprop -n ro.surface_flinger.use_color_management false
resetprop -n ro.surface_flinger.vsync_event_phase_offset_ns 3000000

# TCP
echo 'reno' > "/proc/sys/net/ipv4/tcp_congestion_control"

# Kernel Tweak
echo 1 > /proc/sys/kernel/sched_tunable_scaling
echo 1 > /proc/sys/kernel/sched_boost
echo N > /sys/module/msm_thermal/parameters/enabled
echo 0 > /sys/module/msm_thermal/core_control/enabled
echo 0 > /sys/kernel/msm_thermal/enabled
echo "0   0   0   0" > /proc/sys/kernel/printk
echo 0 > /proc/sys/kernel/printk_delay
echo 0 > /proc/sys/kernel/printk_ratelimit_burst
echo 0 > /proc/sys/kernel/printk_ratelimit

# Quick Boot
setprop ro.config.hw_quickpoweron true

setprop debug.composition.type gpu
setprop debug_hw_overdraw 0 

setprop debug.sf.enable_hwc_vds 0
setprop debug.sf.early_app_phase_offset_ns 500000
setprop debug.sf.early_gl_phase_offset_ns 3000000
setprop debug.sf.early_gl_app_phase_offset_ns 15000000
setprop debug.sf.early_phase_offset_ns 500000
setprop debug.sf.late.sf.duration 27600000
setprop debug.sf.late.app.duration 20000000
setprop debug.sf.early.sf.duration 27600000
setprop debug.sf.early.app.duration 20000000
setprop debug.sf.earlyGl.sf.duration 27600000
setprop debug.sf.earlyGl.app.duration 20000000

echo 0 > /proc/sys/vm/oom_kill_allocating_task
echo 1 > /proc/sys/vm/overcommit_memory
echo 1 > /proc/sys/vm/oom_dump_tasks
echo 3 > /proc/sys/vm/drop_caches
echo 0 > /proc/sys/kernel/panic
echo 0 > /proc/sys/kernel/panic_on_oops
echo 0 > /proc/sys/kernel/panic_on_warn
echo 24 > /sys/block/ram0/queue/read_ahead_kb