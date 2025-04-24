# SuperMario Tweaker V2.0.0 - Changelog

## New Additions – SuperMario-Tweaker.sh Script

### 1. Battery & Device Idle Tweaks:
- Enabled full device idle mode for better deep sleep.
- Whitelisted essential system UI to prevent interference.
- Tuned `device_idle_constants` for aggressive battery saving without sacrificing usability.
- Enabled aggressive battery saver and adaptive battery features.

### 2. System Settings Optimizations:
- Disabled unnecessary debugging and ANR mechanisms.
- Enabled freeform window support and fake signature allowance.
- Enabled display color enhancement for better visuals.

### 3. Dalvik VM & HWUI Adjustments:
- Applied dynamic Dalvik heap settings based on total RAM (2GB–5GB).
- Enhanced HWUI texture and cache configurations according to RAM size.
- Enabled 64-bit dex2oat compilation if system supports it.

### 4. Display & Graphics Enhancements:
- Enabled `iorapd` for faster app launching (Android 10+).
- Applied `vendor.display.disable_rotator_downscale` for Qualcomm devices.

### 5. App Background Restriction:
- Disabled background access and forced stop for bloatware, logging, and telemetry apps (e.g., Traceur, GMS, Google feedback, SetupWizard).

### 6. System Clean-up:
- Cleaned Dalvik caches on execution to ensure a fresh performance state.

---

## New Features of the Module

### 1. Improve installation UI
 - Improved UI Clarity
 - Added Clear Separation Between Sections:
 - Improved Progress Bar Display:
 - Enhanced Completion Message:.
 - Simplified Instructions:
 - Optimized Sleep Times Between Messages:

### 2. GPU & Vulkan Boost:
- Switched from OpenGL to Vulkan rendering for:
  - `debug.sf.renderer`
  - `debug.renderengine.backend`
  - `ro.hwui.hardware.vulkan`
  - `ro.hwui.use_vulkan`
- Improved rendering performance, reduced latency, and better utilization of modern GPU features.

### 3. Hardware Composition:
- Changed `debug.composition.type` to `dyn` (dynamic), allowing CPU and GPU co-processing for smoother UI/UX.

### 4. Stability & Performance Improvements:
- Removed redundant logging and background services settings:
  - `profiler.force_disable_err_rpt`
  - `logcat.live`
  - `ro.vendor.qti.sys.fw.bservice_limit`
- Improved responsiveness and decreased RAM load.

---

## Removed Configurations

### 1. Audio Tweaks:
- Removed all fluency and dualmic-related properties.
- Example:
  - `persist.audio.fluence.voicecall`
  - `audio.deep_buffer.media`

**Reason:** Minimal benefit and resource overhead.

### 2. Dalvik & Heap Tuning:
- Outdated or redundant Dalvik properties were removed or replaced with RAM-based dynamic values.
- Removed:
  - `dalvik.vm.heapstartsize`
  - `dalvik.vm.heaptargetutilization`

### 3. Logging & Ramdump:
- Removed debug settings that generate unnecessary logs or memory dumps:
  - `persist.radio.ramdump`
  - `persist.vendor.ssr.enable_ramdumps`

### 4. Network & Telephony:
- Removed Google location features and unused telephony tweaks:
  - `ro.com.google.networklocation`
  - `ro.telephony.call_ring.multiple`

---

**Overall Goals:**
- Maximize battery life through deep sleep and adaptive management.
- Boost graphics with Vulkan and better cache handling.
- Eliminate bloat and logging for a cleaner, faster system.
- Offer smart tweaks based on RAM for wider device compatibility.