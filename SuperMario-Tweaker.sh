#!/system/bin/sh
# SuperMario Tweaker Script

until [ "$(getprop sys.boot_completed)" -eq 1 ]; do
  sleep 5
done

RESETPROP=$(which resetprop 2>/dev/null || echo "/data/adb/magisk/resetprop")

sleep 2
if [ -d "/dev/freezer/frozen" ]; then
    chmod 777 /dev/freezer/frozen/freezer.killable 2>/dev/null
    echo 0 > /dev/freezer/frozen/freezer.killable 2>/dev/null
    chmod 444 /dev/freezer/frozen/freezer.killable 2>/dev/null
    chmod 777 /dev/freezer/frozen/freezer.state 2>/dev/null
    echo THAWED > /dev/freezer/frozen/freezer.state 2>/dev/null
    chmod 444 /dev/freezer/frozen/freezer.state 2>/dev/null
fi
if [ -d "/sys/fs/cgroup/freezer/frozen" ]; then
    echo THAWED > /sys/fs/cgroup/freezer/frozen/freezer.state 2>/dev/null
fi

if [ -f "$RESETPROP" ]; then

    $RESETPROP ro.lmk.enable_adaptive_lmk false


    $RESETPROP ro.lmk.low 1001
    $RESETPROP ro.lmk.medium 1001
    $RESETPROP ro.lmk.critical 900
    $RESETPROP ro.lmk.critical_upgrade false
    $RESETPROP ro.lmk.kill_heaviest_task false
    $RESETPROP ro.lmk.kill_timeout_ms 100
    $RESETPROP ro.lmk.swap_util_max 100
    $RESETPROP ro.lmk.swap_free_low_percentage 5
    $RESETPROP ro.lmk.thrashing_limit 100
    $RESETPROP ro.lmk.thrashing_limit_decay 10
    $RESETPROP ro.lmk.psi_partial_stall_ms 200
    $RESETPROP ro.lmk.psi_complete_stall_ms 700


    stop lmkd 2>/dev/null
    sleep 2
    $RESETPROP sys.lmk.minfree_levels "0:0,0:0,0:0,0:0,0:0,0:0"
    start lmkd 2>/dev/null
fi


echo 4096 > /proc/sys/vm/min_free_kbytes
echo 4096 > /proc/sys/vm/extra_free_kbytes


echo 80 > /proc/sys/vm/swappiness


echo 80 > /proc/sys/vm/vfs_cache_pressure
echo 1  > /proc/sys/vm/overcommit_memory


sleep 3
if [ -d "/dev/freezer/frozen" ]; then
    echo 0 > /dev/freezer/frozen/freezer.killable 2>/dev/null
fi


# High Performance Mode & Hardware Acceleration
resetprop ro.config.hw_high_performance true
resetprop ro.config.high_perf_mod true
resetprop debug.performance.tuning 1
resetprop ro.vendor.qti.core_ctl_skip_core_bounce 1

# Graphics & Rendering (GPU & SurfaceFlinger)
resetprop debug.sf.hw 1
resetprop debug.egl.hw 1
resetprop debug.sf.latch_unsignaled 1
resetprop debug.gr.numframebuffers 3
resetprop debug.sf.disable_client_composition_cache 1
resetprop ro.surface_flinger.max_frame_buffer_acquired_buffers 3

# UI Touch Responsiveness & Jitter Reduction
resetprop view.touch_slop 2
resetprop view.scroll_friction 0.005
resetprop touch.deviceType touchScreen
resetprop touch.pressure.scale 0.001

# RAM Management & Low Memory Killer Override (Keep Apps Alive)
resetprop ro.vendor.qti.sys.fw.bg_apps_limit 32
resetprop ro.config.fha_enable true
resetprop ro.sys.fw.use_trim_settings false
resetprop ro.vendor.qti.sys.fw.bservice_enable true

# Disable Heavy Telemetry & Logging (Free Up CPU Cycles)
resetprop persist.sys.jdwp.debug 0
resetprop logcat.live disable
resetprop ro.config.nocheck true

exit 0