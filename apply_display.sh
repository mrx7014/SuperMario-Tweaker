#!/system/bin/sh
# Standalone display saturation applier — called directly by the WebUI.
# Safe to invoke repeatedly; does not touch RAM/appops tweaks.
#
# NOTE: SurfaceFlinger service call 1023 does not provide a real
# graduated contrast control (it only toggles sRGB color management
# via an integer flag), so contrast adjustment was removed. Only
# saturation (service call 1022, a genuine float API) is applied.

CONFIG_DIR="/data/adb/display"
CONFIG_FILE="$CONFIG_DIR/customize.txt"
DEFAULT_SATURATION="1.0"
mkdir -p "$CONFIG_DIR"

SATURATION="$DEFAULT_SATURATION"
RESET="false"

if [ -f "$CONFIG_FILE" ]; then
    while IFS= read -r line; do
        key=$(echo "$line" | cut -d= -f1 | tr -d ' ')
        val=$(echo "$line" | cut -d= -f2 | tr -d ' ')
        case "$key" in
            saturation) case "$val" in ''|*[!0-9.]*) ;; *) SATURATION="$val" ;; esac ;;
            reset) [ "$val" = "true" ] && RESET="true" ;;
        esac
    done < "$CONFIG_FILE"
else
    printf "saturation=%s\nreset=false\n" "$DEFAULT_SATURATION" > "$CONFIG_FILE"
fi

if ! service list | grep -iq surfaceflinger; then
    exit 1
fi

if [ "$RESET" = "true" ]; then
    service call SurfaceFlinger 1022 f "$DEFAULT_SATURATION" >/dev/null 2>&1
else
    service call SurfaceFlinger 1022 f "$SATURATION" >/dev/null 2>&1
fi
