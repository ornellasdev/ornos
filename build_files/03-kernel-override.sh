#!/usr/bin/env bash
set -ouex pipefail

echo ":: [OrnOS] Configurando boot kargs para baixa latência e NVIDIA ::"

mkdir -p /usr/lib/bootc/kargs.d
cat << 'EOF' > /usr/lib/bootc/kargs.d/10-ornos-gaming.toml
kargs = [
    "nvidia-drm.modeset=1",
    "nvidia-drm.fbdev=1",
    "split_lock_detect=off"
]
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="OrnOS"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
# Habilita a detecção automática do Windows Boot Manager
GRUB_DISABLE_OS_PROBER=false
GRUB_CMDLINE_LINUX="quiet splash nvidia-drm.modeset=1 split_lock_detect=off"

EOF