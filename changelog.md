# SuperMario Tweaker  
v1.0.0

## Changelog

### Supporting SnapDragon only (Until Now)

### System Tweaks
- Limited Dropbox logs to save space.
- Turned off ANR (App Not Responding) debugging.
- Enabled Freeform window support.
- Enabled color enhancement for display.
- Enabled signature spoofing (for apps that need it).
- **Modified call properties** such as the ringtone delay and the number of ringtone repetitions to improve call stability.
- **Increased GPU buffer count** to enhance graphics performance.
- **Enabled HW composition for SurfaceFlinger** to improve UI performance.
- **Disabled SurfaceFlinger back pressure** for smoother interaction with the system UI.
- **Enabled OpenGL ES 3D hardware acceleration** to improve graphics.
- **Disabled recompute crop change in SurfaceFlinger** to improve graphics performance.
- **Disabled buffer age** in the GPU for increased efficiency.
- **Enabled latch unsignaled buffers** even if the fences haven't signaled yet.
- **Disabled LTE RAM dump** to free up more available memory.
- **Disabled additional RAM dumps** for better memory management.
- **Disabled kill reports for processes** to improve memory performance.
- **Disabled dirty regions in graphics rendering** for smoother UI.
- **Disabled V-Sync** to improve responsiveness.
- **Configured dynamic composition** (between CPU and GPU) for better performance.

### Thermal Tweaks
- Reconfigured thermal engine policies for better balance between performance and heat control.
- Disabled over-aggressive CPU core hotplugging at moderate temperatures to reduce unnecessary throttling.
- Increased CPU thermal thresholds to delay throttling and maintain smoother performance under load.
- Optimized thermal response for gaming (PUBG, SGame) by adjusting thermal configuration files to prevent early performance drops.
- Tweaked LCD thermal monitoring to reduce aggressive brightness dimming.
- Adjusted battery charging thermal limits to avoid slow charging from minor temperature rises.
- Reduced CPU frequency capping for thermal sensors that previously limited performance too early.
- Maintained emergency shutdown protection at 65°C to ensure hardware safety.

### Mesa Turnip Vulkan Driver

- Update to verison 25.0.3

### Battery Tweaks
- Turned on full Doze mode to save more battery.
- Added `SystemUI` to Doze whitelist so it doesn’t get paused.
- Enabled Adaptive Battery and Aggressive Battery Saver.

### App Launch Speed
- Enabled `iorapd` to make apps open faster (Android 10+ only).

### Graphics Boost (Based on RAM)
- Adjusted graphic cache sizes to make the UI smoother.

### Memory Settings (Dalvik/ART)
- Tuned memory settings depending on how much RAM the phone has.
- Helps apps run better and reduces lag.

### Display Tweak (Qualcomm only)
- Disabled rotator downscale for better display performance.

### 64-bit Optimization
- Enabled 64-bit dex2oat to speed up app installation and performance.

### Background App Restrictions
- Blocked background activity for unneeded system apps like:
  - Traceur, Setup Wizard, Feedback, Joyose, etc.
- Force-stopped and disabled some of them to save resources.
