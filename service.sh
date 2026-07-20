#!/system/bin/sh

# Wait till boot completes 
while [ -z "$(getprop sys.boot_completed)" ]; do
 sleep 10
done

# Simple GMS
cmd appops set com.google.android.gms RUN_IN_BACKGROUND deny
cmd appops set com.android.vending RUN_IN_BACKGROUND deny
cmd appops set com.google.android.inputmethod.latin RUN_IN_BACKGROUND deny

# Help Ram
settings put global cached_apps_freezer enabled 0
settings put global activity_manager_constants max_cached_processes=128
cmd device_config put activity_manager max_cached_processes 128
cmd device_config put activity_manager use_compaction false
cmd device_config put activity_manager max_phantom_processes 2147483647

# SuperMario-Tweaker Script
"${MODDIR}/SuperMario-Tweaker.sh" >/dev/null 2>&1

# Apply saved display color settings on boot.
# Small fixed delay so SurfaceFlinger has time to be ready.
sleep 8
sh "${MODDIR}/apply_display.sh" >/dev/null 2>&1
