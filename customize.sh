#!/system/bin/sh
awk '{print}' "$MODPATH"/assets/SMTW-Banner
ui_print ""
if [ -d "/data/adb/modules/DT" ]; then
  ui_print "WARNING: DT module has been detected and it will be removed at the next reboot."
  touch /data/adb/modules/DT/remove
fi
ui_print "MTK Version"
sleep 0.5
ui_print "LET'S GO WITH SUPER MARIO"
sleep 2
ui_print ""
ui_print "Now Starting SuperMario-Tweaker Script"
sh "${MODPATH}/SuperMario-Tweaker.sh" > /dev/null
set_perm_recursive $MODPATH/system 0 0 755 u:object_r:system_file:s0
set_perm_recursive $MODPATH/system/vendor 0 2000 755 u:object_r:vendor_file:s0
set_perm $MODPATH/system/vendor/lib64/hw/vulkan.adreno.so 0 0 0644 u:object_r:same_process_hal_file:s0
ui_print ""
sleep 2
ui_print "Done"
ui_print ""
ui_print "✅ Tweaks Applied Successfully!"
ui_print "〽️ SuperMario-Tweaker v3.0.0 - MTK"
ui_print "📢 Join Telegram: @MRX7014Cloud"
ui_print "💡 Reboot to activate changes"