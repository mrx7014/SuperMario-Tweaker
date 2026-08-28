#!/system/bin/sh

# Wait till boot completes 
while [ -z "$(getprop sys.boot_completed)" ]; do
 sleep 10
done

# SuperMario-Tweaker Script
"${MODDIR}/SuperMario-Tweaker.sh" >/dev/null 2>&1

# Apply saved display color settings on boot.
# Small fixed delay so SurfaceFlinger has time to be ready.
sleep 8
sh "${MODDIR}/apply_display.sh" >/dev/null 2>&1
