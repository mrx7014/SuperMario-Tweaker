#!/system/bin/sh
# Apply the persisted display saturation through SurfaceFlinger.
# Safe to invoke repeatedly from the WebUI or the boot service.

CONFIG_DIR="/data/adb/display"
CONFIG_FILE="$CONFIG_DIR/customize.txt"
DEFAULT_SATURATION="1.0"

mkdir -p "$CONFIG_DIR"

SATURATION="$DEFAULT_SATURATION"
RESET="false"

if [ -f "$CONFIG_FILE" ]; then
    while IFS='=' read -r key val; do
        key=$(echo "$key" | tr -d '[:space:]')
        val=$(echo "$val" | tr -d '[:space:]')
        case "$key" in
            saturation)
                case "$val" in
                    ''|*[!0-9.]*) ;;
                    *) SATURATION="$val" ;;
                esac
                ;;
            reset)
                [ "$val" = "true" ] && RESET="true"
                ;;
        esac
    done < "$CONFIG_FILE"
else
    printf 'saturation=%s\nreset=false\n' "$DEFAULT_SATURATION" > "$CONFIG_FILE"
fi

# A reset request means apply the default once, then clear the request so the
# persisted value remains stable across future boots.
if [ "$RESET" = "true" ]; then
    SATURATION="$DEFAULT_SATURATION"
    tmp="${CONFIG_FILE}.tmp.$$"
    printf 'saturation=%s\nreset=false\n' "$SATURATION" > "$tmp" && mv -f "$tmp" "$CONFIG_FILE"
fi

# SurfaceFlinger may restart several times after sys.boot_completed. Reapply
# the saved value during the first minute so a later restart cannot erase it.
attempt=1
while [ "$attempt" -le 20 ]; do
    if service list 2>/dev/null | grep -iq surfaceflinger; then
        service call SurfaceFlinger 1022 f "$SATURATION" >/dev/null 2>&1
    fi
    sleep 3
    attempt=$((attempt + 1))
done

exit 0
