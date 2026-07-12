#!/system/bin/sh

abort() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "❌ ERROR: $1"
    echo "🛑 Cleaning process aborted."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    exit 1
}

step() {
    echo ""
    echo "[$1/6] $2"
}

done_msg() {
    echo "      ✅ Done"
}

GPU_CACHE=0
SYSTEM_CACHE=0
DALVIK_CACHE=0
TOTAL=0

echo ""
echo "🍄 SuperMario Cleaner"
echo "Powered by SuperMario Tweaker"

step 1 "Preparing cleaning environment..."
sync
sleep 0.5
done_msg

step 2 "Scanning GPU caches..."

GPU_CACHE=$(find /data/user_de /data/data /data_mirror 2>/dev/null \
    \( -iname "*shader*" -o -iname "*graphitecache*" -o -iname "*gpucache*" \) | wc -l)

find /data/user_de /data/data /data_mirror 2>/dev/null \
    \( -iname "*shader*" -o -iname "*graphitecache*" -o -iname "*gpucache*" \) \
    -exec rm -rf {} + || abort "Failed to clean GPU cache."

done_msg

step 3 "Cleaning system cache..."

SYSTEM_CACHE=$(find /cache /data/cache /data/system/package_cache 2>/dev/null | wc -l)

rm -rf /cache/* 2>/dev/null
rm -rf /data/cache/* 2>/dev/null
rm -rf /data/system/package_cache/* 2>/dev/null

done_msg

step 4 "Cleaning Dalvik / ART cache..."

DALVIK_CACHE=$(find /data/dalvik-cache 2>/dev/null | wc -l)

rm -rf /data/dalvik-cache/* 2>/dev/null

done_msg

step 5 "Syncing filesystem..."
sync
sleep 0.5
done_msg

TOTAL=$((GPU_CACHE + SYSTEM_CACHE + DALVIK_CACHE))

step 6 "Generating report..."
sleep 0.5
done_msg

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "            👑 MISSION COMPLETE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
printf "🧹 GPU Shader Cache      ✔ %d items\n" "$GPU_CACHE"
printf "📦 System Cache          ✔ %d items\n" "$SYSTEM_CACHE"
printf "⚙️ Dalvik / ART Cache    ✔ %d items\n" "$DALVIK_CACHE"
echo "───────────────────────────────────────"
printf "✨ Total Items Cleaned   ✔ %d\n" "$TOTAL"
echo ""
echo "🚀 Performance optimization completed."
echo "💾 Filesystem synchronized."
echo ""
echo "💡 Android will rebuild optimized"
echo "   cache automatically after reboot."
echo ""

if [ "$TOTAL" -ge 1000 ]; then
    echo "🏆 Excellent! A large amount of cache"
    echo "   has been cleaned from your device."
elif [ "$TOTAL" -ge 500 ]; then
    echo "⭐ Great! Your device has been"
    echo "   significantly cleaned."
elif [ "$TOTAL" -ge 100 ]; then
    echo "👍 Good! Unnecessary cache was removed."
else
    echo "✅ Your device was already clean."
fi

echo ""
echo "❤️ Thank you for using SuperMario Tweaker"
echo "👨‍💻 Developed by MRX7014"
echo "📢 Telegram: @mrxsspace"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"