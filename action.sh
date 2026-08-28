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
    echo "[$1/7] $2"
}

done_msg() {
    echo "      ✅ Done"
}

GPU_CACHE=0
SYSTEM_CACHE=0
DALVIK_CACHE=0
TOTAL=0

GPU_PATHS="/data/user_de /data/data /data_mirror"

echo ""
echo "🍄 SuperMario Cleaner"
echo "Powered by SuperMario Tweaker"

step 1 "Preparing cleaning environment..."
sync
done_msg


step 2 "Cleaning GPU shader caches..."

GPU_CACHE=$(
find $GPU_PATHS 2>/dev/null \
\( \
-iname "*shader*" \
-o -iname "*gpucache*" \
-o -iname "*rendercache*" \
-o -iname "*pipeline*" \
\) | wc -l
)

find $GPU_PATHS 2>/dev/null \
\( \
-iname "*shader*" \
-o -iname "*gpucache*" \
-o -iname "*rendercache*" \
-o -iname "*pipeline*" \
\) -exec rm -rf {} + || abort "Failed to clean GPU cache."

done_msg


step 3 "Cleaning system cache..."

SYSTEM_CACHE=$(
find \
/cache \
/data/cache \
/data/system/package_cache \
/data/system_ce \
/data/system_de \
/data/resource-cache \
2>/dev/null | wc -l
)

[ -d /cache ] && rm -rf /cache/*
[ -d /data/cache ] && rm -rf /data/cache/*
rm -rf /data/system/package_cache/* 2>/dev/null
rm -rf /data/system_ce/*/package_cache/* 2>/dev/null
rm -rf /data/system_de/*/package_cache/* 2>/dev/null
rm -rf /data/resource-cache/* 2>/dev/null

done_msg


step 4 "Cleaning Dalvik / ART cache..."

DALVIK_CACHE=$(find /data/dalvik-cache 2>/dev/null | wc -l)

[ -d /data/dalvik-cache ] && rm -rf /data/dalvik-cache/*

sync

done_msg


step 5 "Optimizing filesystem..."

sync

fstrim -v /data >/dev/null 2>&1
fstrim -v /cache >/dev/null 2>&1

sync

done_msg


step 6 "Generating report..."

TOTAL=$((GPU_CACHE + SYSTEM_CACHE + DALVIK_CACHE))

done_msg


step 7 "Finishing..."

sync

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
echo "⚡ Storage optimized using FSTRIM."

echo ""
echo "💡 Android will rebuild optimized"
echo "   cache automatically after reboot."

echo ""

if [ "$TOTAL" -ge 1000 ]; then
    echo "🏆 Excellent! A large amount of cache has been cleaned."
elif [ "$TOTAL" -ge 500 ]; then
    echo "⭐ Great! Your device has been significantly cleaned."
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

exit 0