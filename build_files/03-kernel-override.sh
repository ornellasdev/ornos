#!/usr/bin/env bash
set -ouex pipefail

echo ":: [OrnOS] Configurando boot kargs para baixa latência e NVIDIA ::"

# 1. Parâmetros nativos do bootc (TOML)
mkdir -p /usr/lib/bootc/kargs.d
cat << 'EOF' > /usr/lib/bootc/kargs.d/10-ornos-gaming.toml
kargs = [
    "quiet",
    "splash",
    "nvidia-drm.modeset=1",
    "nvidia-drm.fbdev=1",
    "split_lock_detect=off",
    "nowatchdog",
    "nmi_watchdog=0",
    "transparent_hugepage=madvise",
    "nvme_core.default_ps_max_latency_us=0",
    "pcie_aspm=off"
]
EOF

echo ":: [OrnOS] Configurando GRUB e suporte a Dual Boot com Windows ::"

# 2. Configuração do GRUB (/etc/default/grub)
mkdir -p /etc/default
cat << 'EOF' > /etc/default/grub
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="OrnOS"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
# Habilita a detecção automática do Windows Boot Manager
GRUB_DISABLE_OS_PROBER=false
GRUB_CMDLINE_LINUX="quiet splash nvidia-drm.modeset=1 nvidia-drm.fbdev=1 split_lock_detect=off nowatchdog nmi_watchdog=0 transparent_hugepage=madvise nvme_core.default_ps_max_latency_us=0 pcie_aspm=off"
GRUB_DISABLE_RECOVERY="true"
GRUB_ENABLE_BLSCFG=true
EOF