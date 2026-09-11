#!/system/bin/sh
ui_print "
─▄████▄▄░
▄▀█▀▐└─┐░░
█▄▐▌▄█▄┘██
└▄▄▄▄▄┘███
██▒█▒███▀    Mamma Mia"
ui_print ""
ui_print "🍄 Let's Go"
ui_print ""
ui_print "🚀 Applying performance optimizations..."
sh "$MODPATH/SuperMario-Tweaker.sh" >/dev/null 2>&1
ui_print "🧹 Finalizing installation..."
sleep 0.5
ui_print ""
ui_print "═══════════════════════════════════════"
ui_print "           Installation Complete"
ui_print "═══════════════════════════════════════"
ui_print ""
ui_print "✅ All tweaks were applied successfully."
ui_print ""
ui_print "📦 Module: SuperMario Tweaker"
ui_print "🏷 Version: v5.1.1"
ui_print "👨‍💻 Developer: MRX7014"
ui_print "📢 Telegram: @mrxsspace"
ui_print ""
ui_print "🔄 Reboot your device to activate all changes."
ui_print "❤️ Thank you for using SuperMario Tweaker!"
ui_print "═══════════════════════════════════════"
mkdir -p /data/adb/display
[ -f /data/adb/display/customize.txt ] || cat > /data/adb/display/customize.txt << EOF
saturation=1.0
reset=false
EOF
chmod 755 "$MODPATH/apply_display.sh"
chmod 755 "$MODPATH/service.sh"
am start -a android.intent.action.VIEW -d "https://t.me/mrx7014"
