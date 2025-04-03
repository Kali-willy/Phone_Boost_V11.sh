#!/system/bin/sh

# Advanced Phone Boost Optimization Script
echo "========================================================"
echo -e "\033[1;32m"
echo "                 ⚡ ANDROID PHONE BOOST ⚡"
echo "           🔥 ULTIMATE PERFORMANCE OPTIMIZER 🔥"
echo -e "\033[0m"
echo -e "\033[1;34m"
echo "                        /\               "
echo "                       ( \'              "
echo "                        \'\              "
echo "                        / )       ⚔️     "
echo "                       / /        ⚔️     "
echo "                      / /               "
echo "         ,^.         / /                "
echo "        {   \       / /                 "
echo "         \   \     / /                  "
echo "         /\ ', \__/ /|                  "
echo "        ( \  \____/ /                   "
echo "         \_      _/                     "
echo "           \    /                       "
echo "         ⚔️  \  /                        "
echo "            _||_                        "
echo "           /    \                       "
echo "          (      )                      "
echo "           \____/                       "
echo -e "\033[0m"
echo -e "\033[1;36m"
echo "========================================================"
echo "  👨‍💻 DEVELOPED BY: WILLY JR CARANSA GAILO 👨‍💻"
echo "========================================================"
echo -e "\033[0m"
sleep 1

# Check if running in Termux
if [ -d "/data/data/com.termux" ]; then
    echo -e "\033[1;33m🖥️ Running in Termux environment\033[0m"
    # Request storage permission for Termux - only if not already set up
    if [ ! -d "$HOME/storage" ]; then
        echo -e "\033[1;33m⚙️ Setting up Termux storage access...\033[0m"
        termux-setup-storage
        # Wait for user to approve permissions if needed
        sleep 5
    else
        echo -e "\033[1;32m✅ Termux storage already set up\033[0m"
    fi
fi

# Checking Device Information
echo -e "\033[1;36m📌 Checking Device Information...\033[0m"
DEVICE=$(getprop ro.product.device 2>/dev/null || echo "Unknown")
BRAND=$(getprop ro.product.brand 2>/dev/null || echo "Unknown")
MODEL=$(getprop ro.product.model 2>/dev/null || echo "Unknown")
ANDROID=$(getprop ro.build.version.release 2>/dev/null || echo "Unknown")
KERNEL=$(uname -r 2>/dev/null || echo "Unknown")
GPU_INFO=$(dumpsys SurfaceFlinger 2>/dev/null | grep -i 'GLES' | head -1 | awk '{print $NF}' || echo "Not Available")
CPU_INFO=$(cat /proc/cpuinfo 2>/dev/null | grep 'Hardware' | head -1 | awk -F ': ' '{print $2}' || echo "Not Available")
RAM_TOTAL=$(free -m 2>/dev/null | grep Mem | awk '{print $2}' || echo "Unknown")
RAM_USED=$(free -m 2>/dev/null | grep Mem | awk '{print $3}' || echo "Unknown")

echo -e "\033[1;36m📌 Device: \033[1;37m$DEVICE\033[0m"
echo -e "\033[1;36m🏷 Brand: \033[1;37m$BRAND\033[0m"
echo -e "\033[1;36m📱 Model: \033[1;37m$MODEL\033[0m"
echo -e "\033[1;36m🤖 Android: \033[1;37m$ANDROID\033[0m"
echo -e "\033[1;36m🛠 Kernel: \033[1;37m$KERNEL\033[0m"
echo -e "\033[1;36m🎮 GPU Info: \033[1;37m$GPU_INFO\033[0m"
echo -e "\033[1;36m⚙️ CPU Info: \033[1;37m$CPU_INFO\033[0m"
echo -e "\033[1;36m🧠 RAM: \033[1;37m${RAM_USED}MB used of ${RAM_TOTAL}MB\033[0m"
echo -e "\033[1;36m------------------------------------------------------\033[0m"
sleep 1

# Check for root access properly
echo -e "\033[1;36m🔍 Checking root access...\033[0m"
HAS_ROOT=false
if command -v su >/dev/null 2>&1; then
    if su -c "id" 2>/dev/null | grep -q "uid=0"; then
        echo -e "\033[1;32m✅ Root access available! Full optimization possible.\033[0m"
        HAS_ROOT=true
    else
        echo -e "\033[1;33m⚠️ Running in non-root mode. Limited optimization applied.\033[0m"
    fi
else
    echo -e "\033[1;33m⚠️ Running in non-root mode. Limited optimization applied.\033[0m"
fi
sleep 1

# Define a safe execute function that handles errors properly
safe_execute() {
    if [ "$HAS_ROOT" = true ]; then
        su -c "$1" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo -e "\033[1;31m⚠️ Command failed: $1\033[0m"
        fi
    fi
}

# Backup function to create restore point
create_backup() {
    echo -e "\033[1;36m📦 Creating backup of system settings...\033[0m"
    BACKUP_DIR="$HOME/storage/shared/Android/PhoneBoost/backup"
    mkdir -p "$BACKUP_DIR" 2>/dev/null
    
    # Save current settings
    if [ "$HAS_ROOT" = true ]; then
        safe_execute "cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor > $BACKUP_DIR/cpu_governor.bak"
        for queue in /sys/block/*/queue/scheduler; do
            if [ -f "$queue" ]; then
                safe_execute "cat $queue > $BACKUP_DIR/io_scheduler.bak"
                break
            fi
        done
    fi
    
    # Save date of backup
    echo "Backup created on: $(date)" > "$BACKUP_DIR/backup_info.txt"
    echo -e "\033[1;32m✅ Backup created at $BACKUP_DIR\033[0m"
}

# Cleanup temporary files (works on both rooted and non-rooted)
echo -e "\033[1;36m🧹 Cleaning temporary files...\033[0m"
# Safer approach to clean files
if [ -d "/data/local/tmp" ]; then
    rm -rf /data/local/tmp/* 2>/dev/null
fi

# Safely check if storage is accessible before attempting cleanup
if [ -d "$HOME/storage/shared" ]; then
    echo -e "\033[1;36m🧹 Cleaning cache directories in sdcard...\033[0m"
    find "$HOME/storage/shared/Android/data" -name "cache" -type d -exec rm -rf {} \; 2>/dev/null || true
    find "$HOME/storage/shared/Android/data" -name "tmp" -type d -exec rm -rf {} \; 2>/dev/null || true
    find "$HOME/storage/shared/Android/data" -name "logs" -type d -exec rm -rf {} \; 2>/dev/null || true
    find "$HOME/storage/shared" -name "log" -type f -delete 2>/dev/null || true
    find "$HOME/storage/shared" -name "*.log" -type f -delete 2>/dev/null || true
    find "$HOME/storage/shared" -name "*.tmp" -type f -delete 2>/dev/null || true
else
    echo -e "\033[1;33m⚠️ Storage not accessible. Skipping sdcard cleanup.\033[0m"
fi

echo -e "\033[1;32m✅ Temporary files cleaned!\033[0m"
sleep 1

# Applying Performance Optimizations
echo -e "\033[1;36m⚡ Applying Performance Optimizations...\033[0m"

# FIX: Use 'su -c' for settings command when root is available to ensure it has proper permissions
if [ "$HAS_ROOT" = true ]; then
    echo -e "\033[1;36m📱 Applying basic Android settings tweaks with root...\033[0m"
    safe_execute "settings put global animator_duration_scale 0.5"
    safe_execute "settings put global transition_animation_scale 0.5"
    safe_execute "settings put global window_animation_scale 0.5"
    safe_execute "settings put system accelerometer_rotation 0"
    safe_execute "settings put system screen_brightness_mode 0"
    echo -e "\033[1;32m✅ Applied settings with root privileges\033[0m"
else
    # Check if settings command is available for non-root
    if command -v settings >/dev/null 2>&1; then
        echo -e "\033[1;36m📱 Attempting basic Android settings tweaks without root...\033[0m"
        settings put global animator_duration_scale 0.5 2>/dev/null
        settings put global transition_animation_scale 0.5 2>/dev/null
        settings put global window_animation_scale 0.5 2>/dev/null
        
        # These might require additional permissions
        settings put system accelerometer_rotation 0 2>/dev/null
        settings put system screen_brightness_mode 0 2>/dev/null
        echo -e "\033[1;33m⚠️ Settings may not apply fully without root\033[0m"
    else
        echo -e "\033[1;33m⚠️ 'settings' command not available. Skipping basic Android tweaks.\033[0m"
    fi
fi

# Apply advanced tweaks if root is available
if [ "$HAS_ROOT" = true ]; then
    echo -e "\033[1;36m🔥 Applying advanced root-only tweaks...\033[0m"
    
    # Create backup first
    create_backup
    
    # GPU and rendering optimizations
    safe_execute "setprop debug.hwui.renderer opengl"
    safe_execute "setprop debug.hwui.overdraw false"
    safe_execute "setprop debug.hwui.disable_vsync true"
    safe_execute "setprop debug.performance.tuning 1"
    safe_execute "setprop debug.enabletr true"
    safe_execute "setprop debug.composition.type gpu"
    safe_execute "setprop debug.sf.latch_unsignaled 1"
    safe_execute "setprop debug.sf.disable_backpressure 1"
    
    # System UI performance
    safe_execute "setprop persist.sys.scrollingcache 0"
    safe_execute "setprop persist.sys.ui.hw 1"
    safe_execute "setprop persist.sys.purgeable_assets 1"
    safe_execute "setprop persist.sys.use_dithering 0"
    
    # Feature flags for performance
    safe_execute "setprop persist.sys.fflag.override.settings_dynamic_system 1"
    safe_execute "setprop persist.sys.fflag.override.settings_smart_battery 1"
    safe_execute "setprop persist.sys.fflag.override.settings_graphics_driver 1"
    safe_execute "setprop persist.sys.fflag.override.settings_audio_quality 1"
    safe_execute "setprop persist.sys.fflag.override.settings_network_speed 1"
    safe_execute "setprop persist.sys.fflag.override.settings_thermal_limit 0"
    
    # CPU governor tweaks - safer approach with verification
    echo -e "\033[1;36m⚙️ Optimizing CPU governors...\033[0m"
    if [ -d "/sys/devices/system/cpu" ]; then
        for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
            if [ -f "$cpu" ]; then
                current_governor=$(cat $cpu 2>/dev/null)
                echo -e "\033[1;36mCPU $(echo $cpu | grep -o 'cpu[0-9]*'): \033[1;37mCurrent governor: $current_governor\033[0m"
                safe_execute "echo performance > $cpu"
                new_governor=$(cat $cpu 2>/dev/null)
                echo -e "\033[1;32m  → Changed to: $new_governor\033[0m"
            fi
        done
    else
        echo -e "\033[1;33m⚠️ CPU governor paths not found.\033[0m"
    fi
    
    # VM tweaks for better memory management - safer approach
    echo -e "\033[1;36m⚙️ Optimizing memory management...\033[0m"
    if [ -f "/proc/sys/vm/swappiness" ]; then
        safe_execute "echo 10 > /proc/sys/vm/swappiness"
    fi
    if [ -f "/proc/sys/vm/vfs_cache_pressure" ]; then
        safe_execute "echo 50 > /proc/sys/vm/vfs_cache_pressure"
    fi
    if [ -f "/proc/sys/vm/dirty_ratio" ]; then
        safe_execute "echo 15 > /proc/sys/vm/dirty_ratio"
    fi
    
    # I/O scheduler optimization - safer approach with verification
    echo -e "\033[1;36m⚙️ Optimizing I/O scheduler...\033[0m"
    if [ -d "/sys/block" ]; then
        for queue in /sys/block/*/queue/scheduler; do
            if [ -f "$queue" ]; then
                current_scheduler=$(cat $queue 2>/dev/null)
                echo -e "\033[1;36mBlock device $(echo $queue | grep -o '/block/[^/]*'): \033[1;37mCurrent scheduler: $current_scheduler\033[0m"
                # Check if cfq is available in the list
                if grep -q "[cfq]" $queue; then
                    safe_execute "echo cfq > $queue"
                elif grep -q "cfq" $queue; then
                    safe_execute "echo cfq > $queue"
                else
                    # If cfq not available, try deadline
                    if grep -q "deadline" $queue; then
                        safe_execute "echo deadline > $queue"
                    fi
                fi
                new_scheduler=$(cat $queue 2>/dev/null)
                echo -e "\033[1;32m  → Changed to: $new_scheduler\033[0m"
            fi
        done
    else
        echo -e "\033[1;33m⚠️ Block device paths not found.\033[0m"
    fi
    
    # Gaming specific tweaks
    safe_execute "setprop persist.sys.NV_FPSLIMIT 60"
    safe_execute "setprop persist.sys.NV_POWERMODE 1"
    safe_execute "setprop persist.sys.NV_PROFVER 15"
    safe_execute "setprop persist.sys.NV_STEREOCTRL 0"
    safe_execute "setprop persist.sys.NV_STEREOSEPCHG 0"
    safe_execute "setprop persist.sys.NV_STEREOSEP 20"
    
    # DNS optimization for faster internet
    safe_execute "setprop net.dns1 8.8.8.8"
    safe_execute "setprop net.dns2 8.8.4.4"
    safe_execute "setprop net.rmnet0.dns1 8.8.8.8"
    safe_execute "setprop net.rmnet0.dns2 8.8.4.4"
    
    echo -e "\033[1;32m✅ Advanced root tweaks applied!\033[0m"
else
    echo -e "\033[1;33m⚠️ Skipping root-only tweaks.\033[0m"
fi

# Optimizing Storage
echo -e "\033[1;36m🛠 Optimizing Storage...\033[0m"
if [ "$HAS_ROOT" = true ]; then
    echo -e "\033[1;36m💾 Running advanced storage optimization...\033[0m"
    # Use safe_execute for these operations
    for partition in /data /cache /system /vendor; do
        if [ -d "$partition" ]; then
            echo -e "\033[1;36mTrimming $partition...\033[0m"
            safe_execute "fstrim -v $partition"
        fi
    done
    
    # Try to clear cache with a proper approach
    if [ -f "/proc/sys/vm/drop_caches" ]; then
        echo -e "\033[1;36mClearing memory caches...\033[0m"
        safe_execute "sync"
        safe_execute "echo 3 > /proc/sys/vm/drop_caches"
    fi
else
    echo -e "\033[1;33m⚠️ Limited storage optimization for non-root...\033[0m"
    # Check if pm command is available
    if command -v pm >/dev/null 2>&1; then
        pm trim-caches 1G >/dev/null 2>&1
        echo -e "\033[1;32m✅ App caches trimmed\033[0m"
    else
        echo -e "\033[1;33m⚠️ 'pm' command not available. Skipping app cache cleanup.\033[0m"
    fi
fi
echo -e "\033[1;32m✅ Storage Optimized!\033[0m"
sleep 1

# Killing unnecessary processes (works on both rooted and non-rooted)
echo -e "\033[1;36m🧹 Cleaning background processes...\033[0m"
if [ "$HAS_ROOT" = true ]; then
    # FIX: For root users, use su to execute am command for better permissions
    COMMON_APPS="com.facebook.katana com.facebook.orca com.instagram.android com.google.android.youtube com.snapchat.android"
    for app in $COMMON_APPS; do
        echo -e "\033[1;36mStopping $app...\033[0m"
        safe_execute "am force-stop $app"
    done
    echo -e "\033[1;32m✅ Background processes cleaned with root privileges!\033[0m"
else
    # For non-root, try the normal command
    if command -v am >/dev/null 2>&1; then
        COMMON_APPS="com.facebook.katana com.facebook.orca com.instagram.android com.google.android.youtube com.snapchat.android"
        for app in $COMMON_APPS; do
            echo -e "\033[1;36mStopping $app...\033[0m"
            am force-stop $app >/dev/null 2>&1
        done
        echo -e "\033[1;32m✅ Background processes cleaned!\033[0m"
    else
        echo -e "\033[1;33m⚠️ 'am' command not available. Skipping background process cleanup.\033[0m"
    fi
fi
sleep 1

# Apply thermal throttling control (root only)
if [ "$HAS_ROOT" = true ]; then
    echo -e "\033[1;36m🔥 Optimizing thermal throttling...\033[0m"
    # Try to find thermal engine paths
    THERMAL_PATHS_FOUND=false
    if [ -d "/sys/class/thermal" ]; then
        for thermal in /sys/class/thermal/thermal_zone*/mode; do
            if [ -f "$thermal" ]; then
                THERMAL_PATHS_FOUND=true
                echo -e "\033[1;36mModifying thermal zone: \033[1;37m$(echo $thermal | grep -o 'thermal_zone[0-9]*')\033[0m"
                current_mode=$(cat $thermal 2>/dev/null)
                echo -e "\033[1;37m  Current mode: $current_mode\033[0m"
                safe_execute "echo disabled > $thermal"
                new_mode=$(cat $thermal 2>/dev/null)
                echo -e "\033[1;32m  → Changed to: $new_mode\033[0m"
            fi
        done
    fi
    
    if [ "$THERMAL_PATHS_FOUND" = true ]; then
        # For safety: Reset thermal engine after 30 minutes
        echo -e "\033[1;36m⏰ Scheduling thermal reset after 30 minutes for safety...\033[0m"
        (
            sleep 1800
            echo -e "\033[1;33m⏰ Restoring thermal settings for safety\033[0m"
            for thermal in /sys/class/thermal/thermal_zone*/mode; do
                if [ -f "$thermal" ]; then
                    safe_execute "echo enabled > $thermal"
                fi
            done
        ) &
        echo -e "\033[1;32m✅ Thermal optimization applied! (Will reset after 30 minutes)\033[0m"
    else
        echo -e "\033[1;33m⚠️ No thermal control paths found.\033[0m"
    fi
fi

# Create persistent configuration
CONFIG_DIR="$HOME/storage/shared/Android/PhoneBoost"
echo -e "\033[1;36m📝 Creating persistent configuration...\033[0m"
mkdir -p "$CONFIG_DIR" 2>/dev/null

# Check if the directory was created successfully
if [ -d "$CONFIG_DIR" ]; then
    cat > "$CONFIG_DIR/config.txt" << EOF
# Phone Boost Configuration
# Applied on: $(date)
# Device: $MODEL ($DEVICE)
# Brand: $BRAND
# Android: $ANDROID
# Root Status: $HAS_ROOT

Optimizations applied:
- Performance tweaks
- Storage optimization
- Background process cleanup
- Animation speed reduction
EOF

    if [ "$HAS_ROOT" = true ]; then
        cat >> "$CONFIG_DIR/config.txt" << EOF
- CPU governor optimization
- I/O scheduler optimization
- VM tweaks
- Thermal control
- Gaming tweaks
- DNS optimization
EOF
    fi

    echo -e "\033[1;32m✅ Configuration saved to $CONFIG_DIR/config.txt\033[0m"
else
    echo -e "\033[1;33m⚠️ Could not create configuration directory.\033[0m"
fi

# Create and install auto-start script for automatic persistence
if [ "$HAS_ROOT" = true ] && [ -d "$CONFIG_DIR" ]; then
    echo -e "\033[1;36m📝 Creating auto-persistence system...\033[0m"
    
    # Create the reapply script
    cat > "$CONFIG_DIR/reapply.sh" << EOF
#!/system/bin/sh
# Auto-reapply Phone Boost Optimization
# This script runs automatically after each boot

echo "====================================="
echo "🔄 Auto-applying Phone Boost Optimization..."
echo "====================================="

# Animation settings
echo "📱 Applying animation settings..."
settings put global animator_duration_scale 0.5 2>/dev/null
settings put global transition_animation_scale 0.5 2>/dev/null
settings put global window_animation_scale 0.5 2>/dev/null

# Performance properties
echo "⚡ Applying performance properties..."
setprop debug.hwui.renderer opengl 2>/dev/null
setprop debug.performance.tuning 1 2>/dev/null
setprop persist.sys.ui.hw 1 2>/dev/null
setprop debug.hwui.disable_vsync true 2>/dev/null
setprop debug.composition.type gpu 2>/dev/null
setprop debug.sf.latch_unsignaled 1 2>/dev/null

# Network optimization
echo "🌐 Applying network optimizations..."
setprop net.dns1 8.8.8.8 2>/dev/null
setprop net.dns2 8.8.4.4 2>/dev/null
setprop net.rmnet0.dns1 8.8.8.8 2>/dev/null
setprop net.rmnet0.dns2 8.8.4.4 2>/dev/null

# CPU optimization
echo "⚙️ Applying CPU optimizations..."
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    if [ -f "\$cpu" ]; then
        echo performance > \$cpu 2>/dev/null
    fi
done

# I/O scheduler optimization
echo "💾 Applying I/O optimizations..."
for queue in /sys/block/*/queue/scheduler; do
    if [ -f "\$queue" ]; then
        if grep -q "cfq" \$queue; then
            echo cfq > \$queue 2>/dev/null
        elif grep -q "deadline" \$queue; then
            echo deadline > \$queue 2>/dev/null
        fi
    fi
done

# VM optimization
if [ -f "/proc/sys/vm/swappiness" ]; then
    echo "Optimizing memory swappiness..."
    echo 10 > /proc/sys/vm/swappiness 2>/dev/null
fi

if [ -f "/proc/sys/vm/vfs_cache_pressure" ]; then
    echo "Optimizing vfs cache pressure..."
    echo 50 > /proc/sys/vm/vfs_cache_pressure 2>/dev/null
fi

# Gaming optimizations
echo "🎮 Applying gaming optimizations..."
setprop persist.sys.NV_FPSLIMIT 60 2>/dev/null
setprop persist.sys.NV_POWERMODE 1 2>/dev/null

echo "====================================="
echo "✅ All optimizations have been auto-applied!"
echo "🎮 Enjoy your optimized device!"
echo "====================================="
EOF
    chmod +x "$CONFIG_DIR/reapply.sh"
    
    # Now automatically install the auto-start service
    echo -e "\033[1;36m🔄 Installing automatic startup service...\033[0m"
    
    # Try multiple auto-start methods for maximum compatibility
    
    # Method 1: init.d method (most common)
    if [ -d "/system/etc/init.d" ]; then
        safe_execute "cp $CONFIG_DIR/reapply.sh /system/etc/init.d/99phoneboost"
        safe_execute "chmod 755 /system/etc/init.d/99phoneboost"
        echo -e "\033[1;32m✅ Installed via init.d method\033[0m"
    fi
    
    # Method 2: Magisk module method
    if [ -d "/data/adb/modules" ]; then
        MAGISK_DIR="/data/adb/modules/phoneboost"
        safe_execute "mkdir -p $MAGISK_DIR/system/bin"
        safe_execute "cp $CONFIG_DIR/reapply.sh $MAGISK_DIR/system/bin/phoneboost"
        safe_execute "chmod 755 $MAGISK_DIR/system/bin/phoneboost"
        
        # Create module.prop
        safe_execute "cat > $MAGISK_DIR/module.prop << 'INNEREOF'
id=phoneboost
name=Phone Boost Optimizer
version=v1.0
versionCode=1
author=Willy Jr Caransa Gailo
description=Advanced Phone Boost Optimization
INNEREOF"
        
        # Create service.sh
        safe_execute "cat > $MAGISK_DIR/service.sh << 'INNEREOF'
#!/system/bin/sh
# Wait for boot to complete
until [ "$(getprop sys.boot_completed)" = "1" ]; do
  sleep 1
done
sleep 30
/system/bin/phoneboost &
INNEREOF"
        safe_execute "chmod 755 $MAGISK_DIR/service.sh"
        echo -e "\033[1;32m✅ Installed via Magisk module method\033[0m"
    fi
    
    # Method 3: Use Android built-in services (if available)
    JOB_SERVICE_SH="$CONFIG_DIR/job_service.sh"
    cat > "$JOB_SERVICE_SH" << 'EOF'
#!/system/bin/sh
# Auto-add this script to Android job scheduler
am broadcast -a android.intent.action.BOOT_COMPLETED -p com.termux >/dev/null 2>&1

# Create init script for Termux
if [ -d "/data/data/com.termux/files/usr/etc" ]; then
    mkdir -p /data/data/com.termux/files/usr/etc/init.d
    cat > /data/data/com.termux/files/usr/etc/init.d/99-phone-boost << 'INNEREOF'
#!/data/data/com.termux/files/usr/bin/sh
sleep 60
SCRIPT_PATH=$HOME/storage/shared/Android/PhoneBoost/reapply.sh
if [ -f "$SCRIPT_PATH" ]; then
    sh "$SCRIPT_PATH" &
fi
INNEREOF
    chmod 755 /data/data/com.termux/files/usr/etc/init.d/99-phone-boost
fi
EOF
    chmod +x "$JOB_SERVICE_SH"
    
    # Execute it now
    if [ -f "$JOB_SERVICE_SH" ]; then
        safe_execute "sh $JOB_SERVICE_SH"
        echo -e "\033[1;32m✅ Setup Termux auto-start method\033[0m"
    fi
    
    echo -e "\033[1;32m✅ Auto-persistence system successfully installed!\033[0m"
    echo -e "\033[1;36m🔄 Optimizations will automatically apply after each reboot\033[0m"
    
    # Additional: Create system property to auto-start on boot
    safe_execute "setprop persist.sys.phone.boost.autostart 1"
else
    echo -e "\033[1;33m⚠️ Could not create auto-persistence system.\033[0m"
fi

# Completion Message
echo -e "\033[1;34m========================================================\033[0m"
echo -e "\033[1;32m                  ✅ OPTIMIZATION COMPLETE ✅           \033[0m"
echo -e "\033[1;34m========================================================\033[0m"
echo ""
echo -e "\033[1;36m             🔥🔥🔥 DRAGON BOOST ACTIVATED 🔥🔥🔥        \033[0m"
echo ""
echo -e "\033[1;33m              ⚡ PERFORMANCE MODE ENGAGED ⚡          \033[0m"
echo -e "\033[1;33m                                                      \033[0m