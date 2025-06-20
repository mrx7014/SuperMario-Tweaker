#!/system/bin/sh
awk '{print}' "$MODPATH"/assets/SMTW-Banner
ui_print ""
if [ -d "/data/adb/modules/DT" ]; then
  ui_print "WARNING: DT module has been detected and it will be removed at the next reboot."
  touch /data/adb/modules/DT/remove
fi
sleep 0.5
ui_print "Exynos Version"
sleep 0.5
ui_print "LET'S GO WITH SUPER MARIO"
sleep 2
ui_print ""
ui_print "Now Starting SuperMario-Tweaker Script"
sh "${MODPATH}/SuperMario-Tweaker.sh" > /dev/null 2>&1
ui_print ""
sleep 2
ui_print "Done"
ui_print ""
ui_print "✅ Tweaks Applied Successfully!"
ui_print "〽️ SuperMario-Tweaker v3.0.1 - Exynos"
ui_print "📢 Join Telegram: @MRX7014Cloud"
ui_print "💡 Reboot to activate changes"
