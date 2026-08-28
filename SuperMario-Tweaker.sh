#!/system/bin/sh
# SuperMario Tweaker Script

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
fi


echo 4096 > /proc/sys/vm/min_free_kbytes
echo 4096 > /proc/sys/vm/extra_free_kbytes


echo 20 > /proc/sys/vm/swappiness


echo 80 > /proc/sys/vm/vfs_cache_pressure
echo 1  > /proc/sys/vm/overcommit_memory


sleep 3
if [ -d "/dev/freezer/frozen" ]; then
    echo 0 > /dev/freezer/frozen/freezer.killable 2>/dev/null
fi

# Graphics & Rendering (GPU & SurfaceFlinger)
resetprop debug.sf.hw 1
resetprop debug.egl.hw 1
resetprop ro.surface_flinger.max_frame_buffer_acquired_buffers 3

# UI Touch Responsiveness & Jitter Reduction
resetprop view.touch_slop 2
resetprop touch.deviceType touchScreen

# RAM Management & Low Memory Killer Override (Keep Apps Alive)
resetprop ro.config.fha_enable true
resetprop ro.sys.fw.use_trim_settings false

# Disable Heavy Telemetry & Logging (Free Up CPU Cycles)
resetprop persist.sys.jdwp.debug 0
resetprop logcat.live disable
resetprop ro.config.nocheck true

exit 0