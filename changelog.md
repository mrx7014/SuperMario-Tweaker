# SuperMario Tweaker V2.1.0 - Changelog
- Delete unnecessary tweaks to fix bootloop for some devices
- Delete thermel controller and powerhint (Not needed anymore)
- Turnip (Vulkan driver) upgraded to Mesa 25.1.1, synced with latest upstream changes.
- Delete CPU & GPU spoofing to prevent bugs "especially with camera"
- Fixes here and there
- New Banner :)

# SuperMario Tweaker V2.0.1 - Changelog
- Delete wrong " from customize.sh to fix installation process

# SuperMario Tweaker V2.0.0 - Changelog

### Fixes & Updates
- Delete duplicated lines in system.prop
- Clean code (thanks to @ZG089)
- Delete DT module automatically if detected (thanks to @ZG089)
- Improved installation UI (thanks to @ZG089)
- Delete unnecessary audio, Dalvik, logging, and network tweaks
- Removed duplicate `build.prop` entries
- Reorganized tweaks for better structure
- Update update.json (to update module from root manager in next updates)
- Update Mesa Turnip to v25.1.0


## New Additions

### SuperMario-Tweaker.sh Script
- Full device idle mode and aggressive battery optimizations.
- System settings tuning (freeform windows, color enhancements).
- Dynamic Dalvik VM & HWUI adjustments based on RAM.
- App background restriction for bloatware and telemetry apps.
- System clean-up on execution (Dalvik cache wipe).

### Powerhint.xml Configurations
(This file is used to control CPU and memory performance for specific tasks, like using the camera or recording videos at different frame rates. It tells the system when to boost CPU speed, keep performance high, or optimize memory, to make sure everything runs smoothly.)

- Optimizations for 30FPS, 60FPS, and HFR video modes.
- CPU core scheduling and frequency boosting.
- Bandwidth and memory access optimizations.
- Target-specific tuning (bengal, scuba, khaje).

## Gaming Performance Enhancements
- CPU bandwidth control and high CPU frequency locking.
- Game Mode activation for boosted performance.
- Dynamic CPU, RAM, GPU frequency adjustments.
- Stable 120 FPS support and game rendering prioritization.
- Ultra and Balanced Performance Modes selectable.

## Performance Improvements
- Enabled high-performance CPU/GPU modes.
- App launch acceleration with usap_pool.

## Battery Optimizations
- Fine-tuned power-saving features.
- Sleep mode enhancements for radios and sensors.

## Display and Graphics Enhancements
- Forced GPU rendering and SurfaceFlinger tuning.
- Improved FPS, animation smoothness, and graphics acceleration.

## Game Mode and High FPS
- Locked display to 120Hz refresh for games.
- Disabled dynamic FPS scaling for stability.

## Touch and Input Optimizations
- Faster touch response and increased fling velocity.
- Improved calibration for touch accuracy.

## RAM and Memory Management
- Enabled zRAM compression.
- Adjusted cached apps limit for better multitasking.

## System Tweaks
- Faster app launches via IORAPD prefetching.
- Optimized background process handling.

## Snapdragon-Specific Enhancements
- Qualcomm display and rendering optimizations.
- Forced hardware acceleration.

## UI and Visual Smoothness
- OLED panel optimizations.
- Reduced frame drops and smoother animations.

## Hardware Composition Changes
- Enabled dynamic CPU-GPU composition.

## Stability and Performance Improvements
- Removed redundant logs and services.
- Improved RAM usage and responsiveness.
