#!/system/bin/sh

# Wait until Android reports that boot is complete.
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 5
done

# Apply the regular SuperMario tweaks.
"${MODDIR}/SuperMario-Tweaker.sh" >/dev/null 2>&1

# SurfaceFlinger can restart shortly after boot. apply_display.sh performs
# bounded retries, so the persisted saturation survives that restart as well.
sh "${MODDIR}/apply_display.sh" >/dev/null 2>&1 &
